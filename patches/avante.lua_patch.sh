#!/bin/bash

# Apply changes to Cargo.toml
sed -i '/\[dependencies\]/a mlua = { version = "0.10.1", features = ["lua54", "module"] }' /home/hummingbird108/.local/share/b9Joker108/my.neovim.config/lazy/avante.nvim/Cargo.toml

# Apply changes to lib.rs
cat <<EOL > /home/hummingbird108/.local/share/b9Joker108/my.neovim.config/lazy/avante.nvim/crates/avante-templates/src/lib.rs
use minijinja::{context, path_loader, Environment};
use mlua::prelude::*;
use serde::{Deserialize, Serialize};
use std::sync::{Arc, Mutex};

struct State<'a> {
    environment: Mutex<Option<Environment<'a>>>,
}

impl<'a> State<'a> {
    fn new() -> Self {
        State {
            environment: Mutex::new(None),
        }
    }
}

#[derive(Debug, Serialize, Deserialize)]
struct TemplateContext {
    use_xml_format: bool,
    ask: bool,
    code_lang: String,
    filepath: String,
    file_content: String,
    selected_code: Option<String>,
    project_context: Option<String>,
}

// Given the file name registered after add, the context table in Lua, resulted in a formatted
// Lua string
#[allow(clippy::needless_pass_by_value)]
fn render(state: &State, template: &str, context: TemplateContext) -> LuaResult<String> {
    let environment = state.environment.lock().unwrap();
    match environment.as_ref() {
        Some(environment) => {
            let jinja_template = environment
                .get_template(template)
                .map_err(LuaError::external)
                .unwrap();

            Ok(jinja_template
                .render(context! {
                  use_xml_format => context.use_xml_format,
                  ask => context.ask,
                  code_lang => context.code_lang,
                  filepath => context.filepath,
                  file_content => context.file_content,
                  selected_code => context.selected_code,
                  project_context => context.project_context,
                })
                .map_err(LuaError::external)
                .unwrap())
        }
        None => Err(LuaError::RuntimeError(
            "Environment not initialized".to_string(),
        )),
    }
}

fn initialize(state: &State, directory: String) {
    let mut environment_mutex = state.environment.lock().unwrap();
    // add directory as a base path for base directory template path
    let mut env = Environment::new();
    env.set_loader(path_loader(directory));
    *environment_mutex = Some(env);
}

#[mlua::lua_module]
fn avante_templates(lua: &Lua) -> LuaResult<LuaTable> {
    let core = State::new();
    let state = Arc::new(core);
    let state_clone = Arc::clone(&state);

    let exports = lua.create_table()?;
    exports.set(
        "initialize",
        lua.create_function(move |_, model: String| {
            initialize(&state, model);
            Ok(())
        })?,
    )?;
    exports.set(
        "render",
        lua.create_function_mut(move |lua, (template, context): (String, LuaValue)| {
            let ctx = from_value(&lua, context)?;
            render(&state_clone, template.as_str(), ctx)
        })?,
    )?;
    Ok(exports)
}

use mlua::{Lua, Value, Result};

fn from_value(_lua: &Lua, value: Value) -> Result<TemplateContext> {
    match value {
        Value::Table(table) => {
            let use_xml_format: bool = table.get("use_xml_format")?;
            let ask: bool = table.get("ask")?;
            let code_lang: String = table.get("code_lang")?;
            let filepath: String = table.get("filepath")?;
            let file_content: String = table.get("file_content")?;
            let selected_code: Option<String> = table.get("selected_code")?;
            let project_context: Option<String> = table.get("project_context")?;

            Ok(TemplateContext {
                use_xml_format,
                ask,
                code_lang,
                filepath,
                file_content,
                selected_code,
                project_context,
            })
        },
        _ => Err(LuaError::RuntimeError("Invalid context type".to_string())),
    }
}

#[allow(dead_code)]
fn process_context(lua: &Lua, context: Value) -> Result<()> {
    let _ctx = from_value(&lua, context)?;
    // Further processing with ctx
    Ok(())
}
EOL

# Rebuild the plugin
cd /home/hummingbird108/.local/share/b9Joker108/my.neovim.config/lazy/avante.nvim
cargo build --release