-- FILE: ~/.config/nvim/lua/plugins/extras/editor/docs/obsidian.lua
-- UPDATED: Sunday, January 12, 2025

--[[
  This file configures ObsidianMD-specific functionality in Neovim.
  It is designed to be used with the plugin manager `lazy.nvim`
  and sets up keybindings and options for interacting with Obsidian vaults.
  The plugin configuration includes settings for `workspaces` (vaults), 
  note organization, daily notes, custom mappings, templates, URL handling
  and attachments.
--]]

-- Define a local variable 'prefix' which will hold the leader key combination
-- for Obsidian commands. Here, it's set to "<leader>o".
local prefix = "<leader>o"

--[[
  The file `return`s a Lua table, which is the standard way
  to configure plugins using `lazy.nvim`. Each element in this table
  represents a plugin and its associated settings.
--]]
return {
  --[[
    First plugin configuration: `plugins.extras.lang.markdown-extended`.
    This imports another configuration file as a module, that adds general 
    markdown enhancements. The `import` keyword within a `lazy.nvim`      
    configuration denotes that this is not a standalone plugin and will 
    merge its settings and configurations.
  --]]
  { import = "plugins.extras.lang.markdown-extended" },
  --[[
    Second plugin configuration: "MeanderingProgrammer/render-markdown.nvim".
    This plugin is used for rendering Markdown content.
    The `opts` table specifies configurations for this plugin.
  --]]
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      preset = "obsidian",  -- Set the `preset`(?) to "obsidian"
      -- which likely means it will style the rendered Markdown
      -- in a way that's consistent with Obsidian.
    },
  },
  --[[
    Third plugin configuration: "epwalsh/obsidian.nvim".
    This is the core Obsidian integration plugin.
    `ft = "markdown"`: sets the filetype to Markdown
    so that the plugin only activates on Markdown files.
  --]]
  {
    "epwalsh/obsidian.nvim",
    ft = "markdown",
    --[[
      In the following, `keys` defines keybindings for Obsidian-specific functions.
      Each keybinding is an entry in this table. The `prefix` is used in all of 
      these so they all share a common leader key.
    --]]
    keys = {
      -- Open the current note in the Obsidian app.
      { prefix .. "o", "<cmd>ObsidianOpen<CR>", desc = "Open on App" },
      -- Open the Obsidian search interface.
      { prefix .. "g", "<cmd>ObsidianSearch<CR>", desc = "Grep" },
      -- Another way to open the Obsidian search interface.
      { "<leader>sO", "<cmd>ObsidianSearch<CR>", desc = "Obsidian Grep" },
      -- Create a new note.
      { prefix .. "n", "<cmd>ObsidianNew<CR>", desc = "New Note" },
      -- Open the quick-switch interface for finding files in Obsidian.
      { prefix .. "<space>", "<cmd>ObsidianQuickSwitch<CR>", desc = "Find Files" },
      -- Open the backlinks panel for the current note.
      { prefix .. "b", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
      -- Open the tags panel for the current note.
      { prefix .. "t", "<cmd>ObsidianTags<CR>", desc = "Tags" },
      -- Open the template selector
      { prefix .. "t", "<cmd>ObsidianTemplate<CR>", desc = "Template" },
      -- Create a link to the current visual selection.
      { prefix .. "l", "<cmd>ObsidianLink<CR>", mode = "v", desc = "Link" },
      -- Another way to create a link to the current visual selection.
      { prefix .. "L", "<cmd>ObsidianLinks<CR>", desc = "Links" },
      -- Create a new link from the current visual selection.
      { prefix .. "N", "<cmd>ObsidianLinkNew<CR>", mode = "v", desc = "New Link" },
      -- Extract the current visual selection to a new note.
      { prefix .. "e", "<cmd>ObsidianExtractNote<CR>", mode = "v", desc = "Extract Note" },
      -- Open the Obsidian workspace selector.
      { prefix .. "w", "<cmd>ObsidianWorkspace<CR>", desc = "Workspace" },
      -- Rename the current note.
      { prefix .. "r", "<cmd>ObsidianRename<CR>", desc = "Rename" },
      -- Paste an image to the Obsidian vault.
      { prefix .. "i", "<cmd>ObsidianPasteImg<CR>", desc = "Paste Image" },
      -- Open daily notes.
      { prefix .. "d", "<cmd>ObsidianDailies<CR>", desc = "Daily Notes" },
    },
    --[[
      The keywork `opts` defines the configuration options for the Obsidian plugin itself.
    -- ]]
    opts = {
      --[[
        `workspaces`: Defines the Obsidian vaults that this plugin should interact with.
        Each vault is a table with a `name` and `path` key.
      --]]
      workspaces = {
        {
          name = "personal",
          path = "~/documents/obsidian-vaults/personal/",
        },
        {
          name = "personal-brain",
          path = "~/documents/obsidian-vaults/personal-brain/",
        },
      },
      
      --[[
        `notes_subdir`: Specifies the subdirectory within each vault to store notes.
        In this, context, they are quick notes or fleeting notes. Notes placed directly 
	in vault will not be recognized.
      --]]
      notes_subdir = "Notes",
      
      --[[
        `daily_notes`: Configuration for daily note functionality.
      --]]
      daily_notes = {
        folder = "Journal/Entries/Daily",
        date_format = "%Y-%m-%d",
        alias_format = "%B %-d, %Y",
        template = "_data_/templates/journal/daily_entry.md",
      },
      
      --[[
        `mappings`: Custom action mappings. This section is used to define what
         happens when the associated key is pressed. So, it defines keybindings.
      --]]
      mappings = {
	-- Mapping for jumping to a link or resolving a wikilink      
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
	-- Mapping to toggle a checkbox.
        ["<C-c>"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
	-- Mapping for a smart action which depends on the context.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      
      --[[
       `templates`: Configuration for Obsidian note templates.
      --]]
      templates = {
        subdir = "_data_/templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },
      
      --[[
         `follow_url_func`: A function to open URLs. Here it uses
         `xdg-open`, which should work on most desktop environments.
      --]]
      follow_url_func = function(url)
        vim.fn.jobstart({ "xdg-open", url })
      end,
      
      --[[
        `attachments`: Configuration for attachments, such as images.
      --]]
      attachments = {
        img_folder = "_data_/media", -- Folder to store images.
      },
    },
  },
  
  --[[
    Fourth Plugin: "folke/which-key.nvim"
    This plugin helps visualize the keybindings so that the user can explore them
  --]]
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { prefix, group = "obsidian", icon = " " },
      },
    },
  },
}
