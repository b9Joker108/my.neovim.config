### my.neovim.config NOTES.md

I currently do not have a "git blame" functionality in this distro/config currently, as it was 
formerly provided by a function in the Lazyvim.lazygit module (which I never utilized) which 
has been deprecated circa Tuesday, November, 2024, by the principal developwr of LazyVim in favour 
of Snacks.lazygit. This distro/config has a presence of 'gitsigns' already, and gitsigns provides 
a git blame functionality. So, in future, if and when needed, adaping the 'gitsigns' presence to 
utilise its git blame functionality may be fruitful and useful.

Note:

```zsh
(/home/hummingbird108/python_home) {24-11-19 23:53}localhost:~/.config/b9Joker108/my.neovim.config@main✗✗✗✗✗✗ hummingbird108% grep -r "gitsigns" ./
./.github/README.md:+ [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
./.github/README.md:7. lewis6991/gitsigns.nvim - Git integration
./.github/README.md:- **`gitsigns-extended.lua`**, **`neo-tree-extended.lua`**, **`telescope/`**:
./.github/README.md:│       │   │   ├── gitsigns-extended.lua
./README.md:+ [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
./README.md:            ├── gitsigns.lua
./README.md:+ [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)
./README.md:- **gitsigns.nvim:** Displays Git status and changes inline within the code.
./README.md:- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
./dotfyle.json:    "lewis6991/gitsigns.nvim",
./kickstart.init.lua:    'lewis6991/gitsigns.nvim',
./kickstart.init.lua:      -- See `:help gitsigns.txt`
./kickstart.init.lua:        local gs = package.loaded.gitsigns
./lazy-lock.json:  "gitsigns-yadm.nvim": { "branch": "main", "commit": "2bab6ae8c6582a90ae58cc80eb69e35a27586ac2" },
./lazy-lock.json:  "gitsigns.nvim": { "branch": "main", "commit": "ac5aba6dce8c06ea22bea2c9016f51a2dbf90dc7" },
./lazyvim.json:    "plugins.extras.editor.gitsigns-extended",
./lua/plugins/extras/editor/gitsigns-extended.lua:  "lewis6991/gitsigns.nvim",
./lua/plugins/extras/ui/colorschemes/catppuccin.lua:        gitsigns = true,
./lua/plugins/extras/ui/colorschemes/horizon.lua:      gitsigns = true,
./lua/plugins/extras/ui/minimap.lua:        map.gen_integration.gitsigns(),
./lua/plugins/extras/ui/status-column.lua:    "lewis6991/gitsigns.nvim",
./lua/plugins/extras/util/yadm.lua:  { "seanbreckenridge/gitsigns-yadm.nvim" },
./lua/plugins/extras/util/yadm.lua:    "lewis6991/gitsigns.nvim",
./lua/plugins/extras/util/yadm.lua:        require("gitsigns-yadm").yadm_signs(callback)
```

As I finally have got this distro/config to startup with no errors, I do not want to initiate any 
further substantive changes until I normalise and habituate a git push regimen remotely to GitHub.



