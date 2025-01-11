-- ~/.config/b9Joker108/my.neovim.config/lua/plugins/extras/editor/docs/vimwiki.lua

return {
  "vimwiki/vimwiki",
  ft = { "markdown" }, -- Load Vimwiki when a Markdown file is opened
  config = function()
    -- Determine the current vault; default to 'primary' if not set
    local current_vault = vim.g.current_vault or "primary"

    -- Vimwiki List Configuration
    vim.g.vimwiki_list = {
      {
        -- Primary Vault Configuration
        path = "~/obsidian/primary_vault/",
        syntax = "markdown",
        ext = ".md",
        name = "Primary",
        -- Optional: Unique index file for the primary vault
        index = "index_primary",
      },
      {
        -- Development Vault Configuration
        path = "~/obsidian/dev_vault/",
        syntax = "markdown",
        ext = ".md",
        name = "Development",
        -- Optional: Unique index file for the development vault
        index = "index_dev",
      },
    }

    -- File extension to syntax mapping
    vim.g.vimwiki_ext2syntax = {
      [".md"] = "markdown",
      [".markdown"] = "markdown",
      [".mdown"] = "markdown",
    }

    -- Enable mouse support in Vimwiki
    vim.g.vimwiki_use_mouse = 1

    -- Enable markdown link extensions
    vim.g.vimwiki_markdown_link_ext = 1

    -- Set up different keybindings based on the current vault
    if current_vault == "primary" then
      -- Keybindings for Primary Vault
      vim.api.nvim_set_keymap("n", "<Leader>wp", ":VimwikiIndex<CR>", { noremap = true, silent = true })
    elseif current_vault == "dev" then
      -- Keybindings for Development Vault
      vim.api.nvim_set_keymap("n", "<Leader>wd", ":VimwikiDiaryIndex<CR>", { noremap = true, silent = true })
    else
      -- Uncomment the following line to notify about unknown vaults
      -- vim.notify("Unknown vault: " .. current_vault, vim.log.levels.WARN)
    end

    -- Optional: Highlight the current wiki in the statusline or dashboard
    -- You can integrate this with your statusline setup if desired
    -- Example:
    -- vim.cmd [[
    --   autocmd BufEnter *.md setlocal statusline=%F
    -- ]]
  end,

  -- Conditional Plugin Loading Example
  --     dependencies = {
  -- Example: A plugin only for dev_vault
  --         {
  --             "yourname/experimental-plugin",
  --             ft = { "markdown" },  -- Adjust conditions as needed
  --             config = function()
  --                 -- Plugin-specific configurations
  --                 -- Add your plugin configurations here
  --             end,
  --         },
  --  },
}
