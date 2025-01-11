-- lua/plugins/extras/coding/codecompanion.lua

local prefix = "<leader>a"
local user = vim.env.USER or "User"

-- Function to retrieve the Ollama API URL from the environment
local function get_ollama_api_url()
  return "http://" .. (vim.fn.getenv("OLLAMA_HOST") or "127.0.0.1") .. ":" .. (vim.fn.getenv("OLLAMA_PORT") or "11434")
end

vim.api.nvim_create_autocmd("User", {
  pattern = "CodeCompanionChatAdapter",
  callback = function(args)
    if args.data.adapter == nil or vim.tbl_isempty(args.data) then
      return
    end
    vim.g.llm_name = args.data.adapter.name
  end,
})

return {
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionToggle", "CodeCompanionAdd", "CodeCompanionChat" },
    opts = {
      adapters = {
        ["qwen2.5-coder"] = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "qwen2.5-coder",
	    api_url = get_ollama_api_url(),  -- Dynamically use the API URL
            schema = {
              model = {
                default = "qwen2.5-coder:1.5b",
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "qwen2.5-coder",
          roles = {
            llm = "  CodeCompanion",
            user = " " .. user:sub(1, 1):upper() .. user:sub(2),
          },
          keymaps = {
            close = { modes = { n = "q", i = "<C-c>" } },
            stop = { modes = { n = "<C-c>" } },
          },
        },
        inline = { adapter = "qwen2.5-coder" },
        agent = { adapter = "qwen2.5-coder" },
      },
      display = {
        chat = {
          show_settings = true,
        },
      },
    },
    keys = {
      { prefix .. "a", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Action Palette" },
      { prefix .. "c", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "New Chat" },
      { prefix .. "A", "<cmd>CodeCompanionAdd<cr>", mode = "v", desc = "Add Code" },
      { prefix .. "i", "<cmd>CodeCompanion<cr>", mode = "n", desc = "Inline Prompt" },
      { prefix .. "C", "<cmd>CodeCompanionToggle<cr>", mode = "n", desc = "Toggle Chat" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { prefix, group = "ai", icon = "󱚦 " },
      },
    },
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "codecompanion",
        title = "CodeCompanion",
        size = { width = 70 },
      })
    end,
  },
}
