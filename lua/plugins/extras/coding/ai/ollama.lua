-- lua/plugins/extras/coding/ollama.lua

return {
  -- Plugin repository
  "nomnivore/ollama.nvim",
  -- Specify dependencies
  dependencies = { "nvim-lua/plenary.nvim" },
  -- All the user commands added by the plugin
  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
  -- Keybindings
  keys = {
    -- Sample keybind for prompt menu. Note that the <c-u> is important for selections
    -- to work properly.
    {
      "<leader>oo",
      ":<c-u>lua require('ollama').prompt()<CR>",
      desc = "Ollama Prompt",
      mode = { "n", "v" },
    },

    -- Sample keybind for direct prompting. Note that the <c-u> is important for
    -- selections to work properly.
    {
      "<leader>oG",
      ":<c-u>lua require('ollama').prompt('Generate_Code')<CR>",
      desc = "Ollama Generate Code",
      mode = { "n", "v" },
    },
  },

  -- Customization: Configure the plugin after it's loaded
  config = function()
    require("ollama").setup({
      url = "http://127.0.0.1:11434",
      model = "qwen2.5-coder:1.5b",
      -- api_key = "YOUR_API_KEY", -- Replace with your actual API key
      -- Add any additional settings or overrides here
    })
  end,
}
