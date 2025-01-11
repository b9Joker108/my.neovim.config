### Neovim distribution README.md for the AI Coding Plugins 

```zsh 
ollama serve &
ollama run qwen2.5-coder:1.5b
```

Worked like a charm! I have the model running locally. I am using a distribution of Neovim 
with the following AI coding plugins: 

```zsh
.rw-r--r--. u0_a820 100 435 B  Tue Nov  5 23:48:42 2024  avante.lua
.rw-r--r--. u0_a820 100 2.2 KB Tue Nov  5 23:48:42 2024  codecompanion.lua
.rw-r--r--. u0_a820 100 1.7 KB Tue Nov  5 23:48:42 2024  codeium.lua
.rw-r--r--. u0_a820 100 543 B  Tue Nov  5 23:48:42 2024  copilot.lua
.rw-r--r--. u0_a820 100 2.6 KB Tue Nov  5 23:48:42 2024  gen.lua
.rw-r--r--. u0_a820 100 3.7 KB Tue Nov  5 23:48:42 2024  gpt.lua
.rw-r--r--. u0_a820 100 996 B  Tue Nov  5 23:48:42 2024  neocodeium.lua
.rw-r--r--. u0_a820 100 1.1 KB Thu Nov 14 20:31:48 2024  ollama.lua
```

Now, I have paid for GitHub Copilot, I am using an OpenAI API and now, am serving 
qwen2.5-coder:1.5b locally. What is the best way to start and stop serving Qwen in 
a background shell on starting or exiting from Neovim, which I have bound to the 
alias: `bnvim`. I am using the Lazy package manager...

To start and stop serving Qwen2.5-Coder:1.5b in a background shell when starting or 
exiting Neovim, you can use Neovim's autocmd functionality along with the Lazy 
package manager. Here's how you can set this up:

1. Create a new file for the Ollama plugin configuration:

```bash
touch ~/.config/nvim/lua/plugins/ollama.lua
```

2. Edit the `ollama.lua` file with the following content:

```lua
return {
  "nomnivore/ollama.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
  keys = {
    { "<leader>oo", ":Ollama<CR>", desc = "Open Ollama" },
    { "<leader>om", ":OllamaModel qwen2.5-coder:1.5b<CR>", desc = "Set Ollama Model" },
  },
  opts = {
    model = "qwen2.5-coder:1.5b",
  },
  config = function(_, opts)
    require("ollama").setup(opts)

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        vim.fn.jobstart("ollama serve &", {detach = true})
        vim.notify("Ollama server started")
      end,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        vim.fn.jobstart("pkill ollama")
        vim.notify("Ollama server stopped")
      end,
    })
  end,
}
```

This configuration does the following:

- It uses the `ollama.nvim` plugin, which provides integration with Ollama.
- It sets up keymaps to open Ollama and set the model.
- It creates autocmds to start the Ollama server when Neovim starts and stop 
  it when Neovim exits.

3. Update your Neovim alias (`bnvim`) to ensure it starts Neovim with a 
single instance:

```bash
alias bnvim='nvim --listen /tmp/nvim-server.pipe'
```

This ensures that only one instance of Neovim is running, which is important 
for managing the Ollama server.

4. Restart Neovim or run `:Lazy sync` to install and configure the Ollama plugin.

With this setup:

- When you start Neovim using your `bnvim` alias, it will automatically start the 
  Ollama server in the background.
- When you exit Neovim, it will automatically stop the Ollama server.
- You can use `<leader>oo` to open Ollama and `<leader>om` to set the model to 
  qwen2.5-coder:1.5b.

This configuration allows you to seamlessly use Qwen2.5-Coder:1.5b alongside your 
other AI coding plugins like GitHub Copilot and OpenAI API. The Ollama server will 
be managed automatically, starting when you open Neovim and stopping when you 
close it.

Remember to adjust the paths and commands if your Neovim configuration directory 
is different or if you need to modify the Ollama server start/stop commands based 
on your specific setup.

Citations:
[1] How to Run and Control Background Processes on Linux: 
https://www.howtogeek.com/440848/how-to-run-and-control-background-processes-on-linux/
[2] Command mode keybindings? : r/neovim - Reddit: 
https://www.reddit.com/r/neovim/comments/sdozdw/command_mode_keybindings/
[3] [lazy] How to run a shell command every time a plugin updates: 
https://www.reddit.com/r/neovim/comments/1acjhbn/lazy_how_to_run_a_shell_command_every_time_a/
[4] Ultimate Neovim Setup Guide: lazy.nvim Plugin Manager: 
https://dev.to/slydragonn/ultimate-neovim-setup-guide-lazynvim-plugin-manager-23b7
[5] folke/lazy.nvim: A modern plugin manager for Neovim - GitHub: 
https://github.com/folke/lazy.nvim

