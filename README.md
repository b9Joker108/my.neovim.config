# my.neovim.config

This is a dedicated repository for my Neovim configuration. I decided to place it in its own 
dedicated repository, rather than in my generic and inclusive Dotfiles repository, for ease 
of discovery and visibility.

I am new to scripting, coding and programming. I have specifically chosen Android hand-held 
devices for my scripting, programming and digital endeavours, due to their global ubiquity, 
affordability, extreme ease of portability, customisability and functionality. Termux is the 
most widely used terminal emulator for Android, and is well documented, well supported, and has an 
active development and help community, supporting its use and uptake. For these reasons, Termux 
is central to most, if not all, of my digital and online endeavours.

I have been aware of vi for a long time, as well as Vim, but only in late 2023, became aware of 
Neovim through researching Android IDEs and in my opinion, the more functional and powerful, 
personalised IDEs possible directly in an augmented Termux commandline environment. It was due 
to YouTube, that my interest in Neovim was initially set and sealed.

My aspiration, is to create an excellent, intelligent and personalised IDE environment in Termux 
on Android for shell scripting (Bash, Zsh, Sh, Fish, Nushell) and Python programming (initially), 
using Neovim and Lua plugins. I require a combination of plugins for various functionalities such 
as syntax highlighting, linting, autocompletion, git control, etcetera.

I initially started my foray into the world of Lua plugins for Neovim, with the Neovim 
configuration kickstarter tool, called Kickstart, and hosted on GitHub, specifically created 
and named, due to its purpose and ain, in providing users new to Neovim, a curated list of Lua 
plugins deemed centeal and primary, to a beginner's journey on starting to use Neovim. I initially
discovered Kickstart on YouTube, and had some problems with it, as one of the plugins in the 
configuration file were not compatible with Android. There were also syntax errors in the 
configuration file. The Neovim subreddit was a readily available and accessible community that 
provided support and assistance in repairing the syntax errors in my Lua plugin Neovim 
configuration file: init.lua.

I discovered this website, that is sourced in a GitHub repository, and it is excellent for 
finding and comparing Neovim plugins, as well as referencing, resourcing and comparing other 
peoples Neovim configuration files: 
https://dotfyle.com


 **The following are some additional plugins that may enhance my Neovim bespoke IDE experience 
 in Termux for shell scripting and Python development:**

**Shell Scripting-Specific:**

- **shfmt.nvim:** Formatter for various shell scripting languages (Bash, Zsh, Sh, Fish, Nushell) using `shfmt`.
- **vim-shellcheck:** Integrates ShellCheck for linting shell scripts.
- **vim-choosewin:** Easily switch between open windows/splits for multi-file editing.

**Python-Specific:**

- **nvim-dap:** Debug Python code directly within Neovim.
- **isort.nvim:** Integrates isort for Python import sorting.
- **black.nvim:** Integrates black for Python code formatting.

**General Productivity and UI:**

- **vim-sneak:** Fast navigation by jumping to any character in the current buffer.
- **lightspeed.nvim:** Speed up motions and text object selection for efficient editing.
- **which-key.nvim:** Displays a visual guide for available keybindings.
- **neoscroll.nvim:** Smoother scrolling experience.
- **barbar.nvim:** Tab bar for managing multiple buffers.

**Customization and Theming:**

- **alpha-nvim:** Beautiful start screen for Neovim.
- **nvim-colorizer.lua:** Highlights color codes in code.
- **format.nvim:** Automatically formats code on save using external formatters.
- **vim-bbye:** Close buffers without closing windows.

**Experiment and Explore:**

As the Neovim plugin ecosystem is vast and continuously growing and refining, I aim to 
explore and experiment with different plugins in order to find the ones that perfectly suit 
my  workflow and preferences. I aim to document my journey both here, and in my Hashnode 
developer weblog.

 **Here's a concise summary of the purpose and functionality of prospective Lua plugins I may explore and experiment with:**

**File Navigation and Search:**

- **telescope.nvim:** Versatile fuzzy finder for files, buffers, grep results, etc.
- **telescope-fzf-native.nvim:** Integrates FZF for faster fuzzy search performance.
- **nvim-tree.lua:** File explorer with visual tree view.

**Statusline and Information Display:**

- **lualine.nvim:** Customizable statusline at the bottom of the screen.
- **nvim-bufferline.lua:** Enhanced buffer tabs for managing multiple buffers.
- **nvim-web-devicons:** Displays file icons in buffers and file trees.

**Syntax Highlighting and Code Understanding:**

- **nvim-treesitter:** Advanced syntax highlighting, code navigation, and refactoring.

**Project Management and Dashboards:**

- **dashboard-nvim:** Customizable start screen with widgets.

**Git Integration:**

- **gitsigns.nvim:** Displays Git status and changes inline within the code.

**Visual Enhancements:**

- **neoscroll.nvim:** Smoother scrolling experience.
- **nvim-colorizer.lua:** Highlights color codes in various file types.

**Productivity Boosters:**

- **nvim-autopairs:** Automatically pairs brackets, quotes, and other characters.
- **vim.highlight.on_yank:** Highlights yanked text (usually for a brief moment).
- **cheatsheet.nvim:** Displays interactive cheatsheets for various commands.

**Plugin Management and Core Utilities:**

- **wbthomason/packer.nvim:** Plugin manager for installing and managing other plugins.
- **nvim-lua/plenary.nvim:** Utility library providing essential functions for many plugins.

**Language Server Protocol (LSP) Support:**

- **neovim/nvim-lspconfig:** Configures language servers for enhanced code features.

**Completion and Linting:**

- **hrsh7th/nvim-cmp:** Completion engine for code, snippets, and more.
- **jose-elias-alvarez/null-ls.nvim:** Integrates external linters and formatters.

**Project Management and Theme:**

- **ahmedkhalf/project.nvim:** Manages project-specific settings and remembers open files.
- **folke/tokyonight.nvim:** Popular color theme.

**Code Editing and Navigation:**

- **nvim-lualine/lualine.nvim:** Statusline for displaying information at the bottom of the screen.
- **lukas-reineke/indent-blankline.nvim:** Visualizes indentation levels for better code readability.
- **tpope/vim-commentary:** Streamlines commenting/uncommenting code blocks.
- **tpope/vim-surround:** Efficiently manipulates surrounding characters (parentheses, quotes, etc.).
- **windwp/nvim-autopairs:** Automatically pairs brackets, quotes, and other characters.

**Git Integration:**

- **tpope/vim-fugitive:** Git integration within Neovim.
