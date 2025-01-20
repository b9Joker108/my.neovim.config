-- FILE: ~/.config/nvim/lua/plugins/extras/lang/markdown-extended.lua
-- UPDATED: Sunday, January 12, 2025

--[[
    This Lua file acts as a configuration hub for enhancing markdown editing in Neovim.
    It orchestrates several plugins to provide a more robust and streamlined experience
    for working with Markdown files, extending beyond the standard Markdown support.
    It's designed to be used with the `lazy.nvim` package manager.
--]]

return {
  --[[
      The first plugin configuration uses the `import` keyword, which signifies
      that instead of adding a standalone plugin, we are merging the plugin settings
      from "lazyvim.plugins.extras.lang.markdown" as a module. This allows building 
      upon and customizing an existing base configuration.
  --]]
  { import = "lazyvim.plugins.extras.lang.markdown" },
  --[[
      Here, we configure the "gaoDean/autolist.nvim" plugin, which provides powerful
      list management functionalities that go far beyond basic Markdown. It helps in 
      automatically adjusting the numbering, indentation and creating lists.
    ]]
  {
    "gaoDean/autolist.nvim",
    --[[
        The `ft` option specifies that this plugin should be active for certain filetypes.
        This makes the plugin functions only active for the selected filetypes.
    --]]
    ft = {
      "markdown",   -- Activate for markdown files.
      "text",       -- Activate for generic text files.
      "tex",        -- Activate for LaTeX files.
      "plaintex",   -- Activate for plain LaTeX files.
      "norg",       -- Activate for Norg files.
    },
    opts = {}, -- This plugin doesn't require any custom options and the configuration
               -- has not specified any as yet.
    --[[
        The `keys` section maps specific key combinations to plugin commands. This
        allows the user to call autolist functionality with easy-to-remember keybindings.
    --]]
    keys = {
      -- Map <Tab> to AutolistTab for indenting list items in insert mode.
      { "<tab>", "<cmd>AutolistTab<cr>", mode = { "i" } },
      -- Map <Shift-Tab> to AutolistShiftTab for unindenting list items in insert mode.
      { "<s-tab>", "<cmd>AutolistShiftTab<cr>", mode = { "i" } },
      -- Map <CR> to AutolistNewBullet for creating a new list item in insert mode.
      { "<CR>", "<CR><cmd>AutolistNewBullet<cr>", mode = { "i" } },
      { "o", "o<cmd>AutolistNewBullet<cr>", mode = { "n" } },
      { "O", "O<cmd>AutolistNewBulletBefore<cr>", mode = { "n" } },
      { "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>", mode = { "n" } },
      { "<C-r>", "<cmd>AutolistRecalculate<cr>", mode = { "n" } },

      { "].", "<cmd>AutolistCycleNext<cr>", mode = { "n" }, desc = "Next List Type" },
      { "[.", "<cmd>AutolistCyclePrev<cr>", mode = { "n" }, desc = "Prev List Type" },

      { ">>", ">><cmd>AutolistRecalculate<cr>", mode = { "n" } },
      { "<<", "<<<cmd>AutolistRecalculate<cr>", mode = { "n" } },
      { "dd", "dd<cmd>AutolistRecalculate<cr>", mode = { "n" } },
      { "d", "d<cmd>AutolistRecalculate<cr>", mode = { "v" } },
    },
  },
  {
    "antonk52/markdowny.nvim",
    ft = { "markdown", "txt" },
    opts = {
      filetypes = { "markdown", "txt" },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      preset = "lazy",
    },
  },
  {
    "luckasRanarison/nvim-devdocs",
    optional = true,
    opts = {
      ensure_installed = {
        "markdown",
      },
    },
  },
}
