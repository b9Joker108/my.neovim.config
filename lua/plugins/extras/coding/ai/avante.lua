-- File: /lua/plugins/extras/coding/ai/avante.lua

-- Configured to use Copilot API endpoints while retaining Ollama model and endpoint

---@class AvanteProvider
---@field local boolean
---@field endpoint string
---@field model string

---@class AvanteConflictHighlights
return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- set this if you want to always pull the latest changes
        opts = {
            provider = "copilot", -- Changed from "openai" to "copilot"
            use_absolute_path = true,
            vendors = {
                ---@type AvanteProvider
                copilot = { -- Changed key from "openai" to "copilot"
                    ["local"] = true,
                    endpoint = "http://127.0.0.1:11434", -- Retained Ollama's endpoint
                    model = "qwen2.5-coder:1.5b", -- Retained Ollama's model
                    parse_curl_args = function(opts, code_opts)
                        return {
                            url = opts.endpoint .. "/chat/completions",
                            headers = {
                                ["Accept"] = "application/json",
                                ["Content-Type"] = "application/json",
                            },
                            body = {
                                model = opts.model,
                                messages = require("avante.providers").copilot.parse_messages(code_opts), -- Updated to use copilot parser
                                max_tokens = 4096, -- Adjust as needed
                                temperature = 0.6, -- Proper scaling
                                stream = true,
                            },
                        }
                    end,
                    parse_response_data = function(data_stream, event_state, opts)
                        require("avante.providers").copilot.parse_response(data_stream, event_state, opts) -- Updated to use copilot parser
                    end,
                },
            },
            behaviour = {
                auto_suggestions = true, -- Experimental stage
                auto_set_highlight_group = true,
                auto_set_keymaps = true,
                auto_apply_diff_after_generation = true,
                support_paste_from_clipboard = true,
            },
            mappings = {
                --- @class AvanteConflictMappings
                diff = {
                    ours = "co",
                    theirs = "ct",
                    all_theirs = "ca",
                    both = "cb",
                    cursor = "cc",
                    next = "]x",
                    prev = "[x",
                },
                suggestion = {
                    accept = "<M-l>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
                jump = {
                    next = "]]",
                    prev = "[[",
                },
                submit = {
                    normal = "<CR>",
                    insert = "<C-s>",
                },
            },
            hints = { enabled = true },
            windows = {
                ---@type "right" | "left" | "top" | "bottom"
                position = "right", -- the position of the sidebar
                wrap = true, -- similar to vim.o.wrap
                width = 30, -- default % based on available width
                sidebar_header = {
                    align = "center", -- left, center, right for title
                    rounded = true,
                },
            },
            highlights = {
                ---@type AvanteConflictHighlights
                diff = {
                    current = "DiffText",
                    incoming = "DiffAdd",
                },
            },
            --- @class AvanteConflictUserConfig
            diff = {
                autojump = true,
                ---@type string | fun(): any
                list_opener = "copen",
            },
        },
        -- Build from source if necessary
        -- build = function()
            -- Build from source and reapply custom patches
            -- vim.fn.system(
                -- "make BUILD_FROM_SOURCE=true && sh $HOME/.config/b9Joker108/my.neovim.config/patches/avante.lua/apply_patches.sh"
                -- "make BUILD_FROM_SOURCE=true"
           --  )
        -- end,
        -- Dependencies required for full functionality
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- Optional dependencies
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Markdown rendering support
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
        -- Keybindings for Avante
        keys = {
            {
                "<leader>aa",
                function()
                    require("avante.api").ask()
                end,
                desc = "avante: ask",
                mode = { "n", "v" },
            },
            {
                "<leader>ar",
                function()
                    require("avante.api").refresh()
                end,
                desc = "avante: refresh",
            },
            {
                "<leader>ae",
                function()
                    require("avante.api").edit()
                end,
                desc = "avante: edit",
                mode = "v",
            },
        },
    }
}
