-- lua/config/lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  -- Bootstrap lazy.nvim
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Setup lazy.nvim
local status_lazy, err_lazy = pcall(function()
  require("lazy").setup({
    spec = {
      {
        "LazyVim/LazyVim",
        import = "lazyvim.plugins",
        opts = {
          colorscheme = "catppuccin",
        },
      },
      {
        import = "plugins",
      },
    },
    ui = {
      backdrop = 100,
    },
    defaults = {
      lazy = true,
      version = false, -- always use the latest git commit
    },
    log = { -- Logging configuration
      level = "debug",
      path = vim.fn.stdpath("cache") .. "/lazy.log",
    },
    local_spec = true,
    checker = { enabled = true },
    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        disabled_plugins = {
          "gzip",
          "tarPlugin",
          "tohtml",
          "tutor",
          "netrwPlugin",
          "zipPlugin",
        },
      },
    },
  })
end)

if not status_lazy then
  vim.notify("Error setting up lazy.nvim: " .. err_lazy, vim.log.levels.ERROR)
end

-- Now require your configuration files
local status_opts, err_opts = pcall(require, "config.options")
if not status_opts then
  vim.notify("Error loading config.options: " .. err_opts, vim.log.levels.ERROR)
end

local status_kmaps, err_kmaps = pcall(require, "config.keymaps")
if not status_kmaps then
  vim.notify("Error loading config.keymaps: " .. err_kmaps, vim.log.levels.ERROR)
end
