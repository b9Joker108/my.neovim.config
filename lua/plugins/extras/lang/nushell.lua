-- lua/plugins/extras/lang/nushell.lua

-- Print statement for debugging purposes to confirm that this configuration file is being loaded
print("Loading Treesitter configuration for Nushell")

return {
  -- Specify the primary plugin: nvim-treesitter
  "nvim-treesitter/nvim-treesitter",

  -- Configuration for nvim-treesitter
  config = function()
    -- Setup Treesitter with specific configurations
    require("nvim-treesitter.configs").setup({
      -- Ensure that the Nushell parser is installed
      ensure_installed = { "nu" },

      -- Enable syntax highlighting
      highlight = {
        enable = true, -- Toggle Treesitter-based highlighting
        additional_vim_regex_highlighting = false, -- Disable Vim's regex-based highlighting to prevent conflicts
      },

      -- Additional required fields with default values
      modules = {}, -- Placeholder for Treesitter modules (empty by default)
      sync_install = false, -- Do not synchronously install parsers
      ignore_install = {}, -- Do not ignore any parsers by default
      auto_install = true, -- Automatically install missing parsers when entering buffer
    })

    -- Function to download the highlights.scm file for Nushell
    local function download_highlights_scm()
      -- Define the remote URL of the highlights.scm file in the tree-sitter-nu repository
      local remote_url = "https://raw.githubusercontent.com/nushell/tree-sitter-nu/main/queries/nu/highlights.scm"

      -- Define the local directory where the highlights.scm file should reside
      -- This path follows the standard Treesitter queries directory structure
      local local_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/queries/nu/"

      -- Full path to the highlights.scm file
      local local_path = local_dir .. "highlights.scm"

      -- Check if vim.loop.fs_stat exists to prevent undefined field error
      if vim.loop and vim.loop.fs_stat then
        -- Check if the highlights.scm file already exists to avoid redundant downloads
        if not vim.loop.fs_stat(local_path) then
          -- Create the local directory if it doesn't exist
          vim.fn.mkdir(local_dir, "p") -- 'p' ensures that parent directories are created as needed

          -- Use curl to download the highlights.scm file
          -- -f: Fail silently on server errors
          -- -L: Follow redirects
          -- -o: Output to specified file
          local download_cmd = string.format('curl -fLo "%s" "%s"', local_path, remote_url)

          -- Execute the download command
          local result = vim.fn.system(download_cmd)

          -- Check if the download was successful by examining the shell error code
          if vim.v.shell_error == 0 then
            -- Notify the user of a successful download
            vim.notify("Successfully downloaded highlights.scm for Nushell.", vim.log.levels.INFO)
          else
            -- Notify the user of a failed download
            vim.notify("Failed to download highlights.scm for Nushell.", vim.log.levels.ERROR)
          end
        else
          -- Notify the user that the highlights.scm file already exists
          vim.notify("highlights.scm for Nushell already exists. Skipping download.", vim.log.levels.INFO)
        end
      else
        -- Fallback if vim.loop.fs_stat is undefined
        -- This should rarely happen in standard Neovim installations
        -- You can optionally handle this case or notify the user
        vim.notify("vim.loop.fs_stat is undefined. Cannot check for highlights.scm existence.", vim.log.levels.WARN)
      end
    end

    -- Call the function to ensure highlights.scm is present
    download_highlights_scm()
  end,

  -- Specify plugin dependencies
  dependencies = {
    -- Nushell Treesitter parser
    {
      "nushell/tree-sitter-nu", -- GitHub repository for the Nushell Treesitter grammar
      build = ":TSUpdate nu", -- Command to run after installation, ensuring the 'nu' parser is updated
    },
  },

  -- Additional build step to update Treesitter parsers after installing nvim-treesitter
  build = ":TSUpdate",
}
