-- FILE: ~/.config/nvim/lua/plugins/extras/coding
-- UPDATED: Saturday, January 11, 2025

return {
  -- Define the plugin 'nvim-cmp'
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",  -- LSP source for nvim-cmp
    "hrsh7th/cmp-buffer",    -- Buffer source for nvim-cmp
    "hrsh7th/cmp-path",      -- Path source for nvim-cmp
  },
  keys = {
    { "<leader>ciC", "<cmd>CmpStatus<CR>", desc = "Cmp Status" }, -- Define a key mapping for CmpStatus
  },
  opts = function(_, opts)
    -- Move 'require("cmp")' inside the configuration function
    local cmp = require("cmp")

    -- Customize the key mappings for 'nvim-cmp'
    opts.mapping = cmp.mapping.preset.insert({
      ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- Select next item
      ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- Select previous item
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), -- Another mapping for next item
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), -- Another mapping for previous item
      ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
      ["<C-f>"] = cmp.mapping.scroll_docs(4),  -- Scroll documentation down
      ["<C-Space>"] = cmp.mapping.complete(),  -- Trigger completion
      ["<C-e>"] = cmp.mapping.abort(),         -- Abort completion
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Enter key
      ["<S-CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }), -- Confirm selection with Shift+Enter, replacing existing text
      ["<C-CR>"] = function(fallback)
        cmp.abort() -- Abort completion
        fallback()  -- Fall back to the default behavior
      end,
    })

    -- Customize the appearance of the completion and documentation windows
    opts.window = {
      completion = {
        border = "rounded",  -- Rounded borders for the completion window
        winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None", -- Window highlights
        scrollbar = false,  -- Disable scrollbar
        col_offset = -3,    -- Column offset
        side_padding = 1,   -- Side padding
      },
      documentation = {
        border = "rounded",  -- Rounded borders for the documentation window
        winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Visual,Search:None", -- Window highlights
        scrollbar = false,  -- Disable scrollbar
      },
    }

    -- Performance optimizations for 'nvim-cmp'
    opts.performance = {
      debounce = 0,                 -- Debounce time
      throttle = 0,                 -- Throttle time
      fetching_timeout = 20,        -- Timeout for fetching completion items
      confirm_resolve_timeout = 20, -- Timeout for resolving completion
      async_budget = 1,             -- Budget for asynchronous operations
      max_view_entries = 50,        -- Maximum number of entries to display
    }

    -- Customize the completion settings for command-line mode
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline({
        ["<C-j>"] = {
          c = function(fallback)
            if cmp.visible() then
              cmp.select_next_item() -- Select next item in cmdline mode
            else
              fallback()  -- Fall back to the default behavior
            end
          end,
        },
        ["<C-k>"] = {
          c = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item() -- Select previous item in cmdline mode
            else
              fallback()  -- Fall back to the default behavior
            end
          end,
        },
      }),
      sources = {
        { name = "buffer" }, -- Use buffer source for command-line completion
      },
    })
  end,
}
