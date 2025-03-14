-- lua/config/options.lua

local go = vim.g
local o = vim.opt

-- Initialize lazyvim_statuscolumn if it doesn't exist
go.lazyvim_statuscolumn = go.lazyvim_statuscolumn or {}

-- Personal Config and LazyVim global options
go.lualine_info_extras = false
go.lazyvim_statuscolumn.folds_open = true
go.lazyvim_statuscolumn.folds_githl = true
go.lazygit_config = false

-- Define leader key
go.mapleader = " "
go.maplocalleader = "\\"

-- Autoformat on save (Global)
go.autoformat = true

-- Font
if vim.fn.has('gui_running') == 1 then
  go.gui_font_default_size = 10
  go.gui_font_size = go.gui_font_default_size
  go.gui_font_face = "JetBrainsMono Nerd Font"
end

-- Enable EditorConfig integration
go.editorconfig = true

-- Root dir detection
go.root_spec = {
  "lsp",
  { ".git", "lua", ".obsidian", "package.json", "Makefile", "go.mod", "cargo.toml", "pyproject.toml", "src" },
  "cwd",
}

-- Terminal
o.termguicolors = true -- Added to see if it resolves errors

-- Disable annoying cmd line stuff
o.showcmd = false
o.laststatus = 3
o.cmdheight = 0

-- Enable spell checking
o.spell = true
o.spelllang:append("es")

-- Backspacing and indentation when wrapping
o.backspace = { "start", "eol", "indent" }
o.breakindent = true

-- Smoothscroll
if vim.fn.has("nvim-0.10") == 1 then
  o.smoothscroll = true
end

o.conceallevel = 2
