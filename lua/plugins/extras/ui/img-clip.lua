-- File: /lua/plugins/extras/ui/img-clip.lua

return {
  -- **Plugin Declaration**
  -- This entry specifies the GitHub repository of the `img-clip.nvim` plugin.
  -- Lazy.nvim uses this to fetch and manage the plugin.
  "HakonHarnes/img-clip.nvim",

  -- **Dependencies**
  -- Lists other plugins that `img-clip.nvim` depends on to function correctly.
  dependencies = {
    "nvim-lua/plenary.nvim", -- Plenary is a Lua utility library providing essential functions for Neovim plugins.
  },

  -- **Options (`opts`)**
  -- Configuration settings that define how `img-clip.nvim` behaves.
  opts = {
    -- **Default Settings**
    -- These settings apply globally unless overridden by filetype-specific configurations.
    default = {
      -- ***File and Directory Options***
      -- Configure where and how images are stored.

      dir_path = "/home/hummingbird108/pictures/assets", -- **Absolute Path:** Specifies the directory where images will be saved.
      extension = "png", -- **File Extension:** Sets the default image format (e.g., 'png', 'jpg').
      file_name = "%Y-%m-%d-%H-%M-%S", -- **File Naming Format:** Uses date and time to generate unique file names.
      use_absolute_path = false, -- **Absolute Path Usage:** Determines if absolute paths are used in templates. Set to `false` to use relative paths.
      relative_to_current_file = false, -- **Relative Path Reference:** If `true`, image paths are relative to the current file's location.

      -- ***Template Options***
      -- Define how image paths are embedded within your documents.

      template = "$FILE_PATH", -- **Template String:** Specifies the placeholder for the image path in your documents.
      url_encode_path = false, -- **URL Encode Path:** If `true`, the image path is URL-encoded to ensure compatibility.
      relative_template_path = true, -- **Relative Template Path:** Uses relative paths in the template if set to `true`.
      use_cursor_in_template = true, -- **Cursor Integration:** Inserts the cursor's current position into the template for context-aware placements.
      insert_mode_after_paste = true, -- **Auto Insert Mode:** Automatically switches to insert mode after pasting an image.

      -- ***Prompt Options***
      -- Configure user prompts related to image handling.

      prompt_for_file_name = true, -- **File Name Prompt:** If `true`, prompts the user to enter a name for the image file when saving.
      show_dir_path_in_prompt = false, -- **Show Directory Path:** Displays the directory path in the prompt if set to `true`.

      -- ***Base64 Options***
      -- Control embedding images as Base64 strings within documents.

      max_base64_size = 10, -- **Max Base64 Size (MB):** Sets the maximum size for embedding images as Base64. Images larger than this won't be embedded.
      embed_image_as_base64 = false, -- **Embed as Base64:** If `true`, embeds the image directly as a Base64 string instead of linking to its path.

      -- ***Image Options***
      -- Additional settings for image processing and handling.

      process_cmd = "", -- **Processing Command:** Specify a custom shell command to process images after saving (e.g., resizing).
      copy_images = false, -- **Copy Images:** If `true`, copies images to `dir_path` instead of moving them, preserving the original.
      download_images = true, -- **Download Images:** Enables downloading images from URLs automatically when set to `true`.

      -- ***Drag and Drop Options***
      -- Manage how images are handled when dragged and dropped into Neovim.

      drag_and_drop = {
        enabled = true, -- **Enable Drag and Drop:** Activates the drag-and-drop functionality for images.
        insert_mode = false, -- **Insert Mode on Drop:** If `true`, automatically enters insert mode after an image is dropped.
      },
    },

    -- **Filetype Specific Settings**
    -- Customize how images are embedded based on the type of file you're editing.
    filetypes = {
      -- ***Markdown Configuration***
      markdown = {
        url_encode_path = true, -- **URL Encode Path:** Encodes the image path to ensure compatibility in Markdown.
        template = "![$CURSOR]($FILE_PATH)", -- **Markdown Image Syntax:** Embeds the image using Markdown's image syntax with cursor position as alt text.
        download_images = false, -- **Disable Image Downloading:** Prevents automatic downloading of images when editing Markdown files.
      },

      -- ***Vimwiki Configuration***
      vimwiki = {
        url_encode_path = true, -- **URL Encode Path:** Encodes the image path for Vimwiki compatibility.
        template = "![$CURSOR]($FILE_PATH)", -- **Vimwiki Image Syntax:** Uses Vimwiki's image embedding syntax with cursor position as alt text.
        download_images = false, -- **Disable Image Downloading:** Prevents automatic downloading of images in Vimwiki files.
      },

      -- ***HTML Configuration***
      html = {
        template = '<img src="$FILE_PATH" alt="$CURSOR">', -- **HTML Image Tag:** Embeds the image using an HTML `<img>` tag with `src` and `alt` attributes.
      },

      -- ***LaTeX (`tex`) Configuration***
      tex = {
        relative_template_path = false, -- **Absolute Template Path:** Uses absolute paths when embedding images in LaTeX files.
        template = [[
\begin{figure}[h]
  \centering
  \includegraphics[width=0.8\textwidth]{$FILE_PATH}
  \caption{$CURSOR}
  \label{fig:$LABEL}
\end{figure}
        ]], -- **LaTeX Figure Environment:** Embeds the image within a LaTeX figure environment, including caption and label placeholders.
      },

      -- ***Typst Configuration***
      typst = {
        template = [[
#figure(
  image("$FILE_PATH", width: 80%),
  caption: [$CURSOR],
) <fig-$LABEL>
        ]], -- **Typst Figure Syntax:** Uses Typst's figure syntax to embed the image with specified width and caption.
      },

      -- ***reStructuredText (`rst`) Configuration***
      rst = {
        template = [[
.. image:: $FILE_PATH
   :alt: $CURSOR
   :width: 80%
        ]], -- **RST Image Directive:** Embeds the image using reStructuredText's image directive with alt text and width attributes.
      },

      -- ***AsciiDoc Configuration***
      asciidoc = {
        template = 'image::$FILE_PATH[width=80%, alt="$CURSOR"]', -- **AsciiDoc Image Macro:** Uses AsciiDoc's image macro to embed the image with specified width and alt text.
      },

      -- ***Org-mode (`org`) Configuration***
      org = {
        template = [=[
#+BEGIN_FIGURE
[[file:$FILE_PATH]]
#+CAPTION: $CURSOR
#+NAME: fig:$LABEL
#+END_FIGURE
        ]=], -- **Org-mode Figure Block:** Embeds the image within an Org-mode figure block, including file path, caption, and figure name.
      },
    },

    -- **Override Health Check (Workaround)**
    -- Addresses the issue where `img-clip.nvim` does not recognize the current operating system.
    -- This section is a placeholder for disabling or bypassing the plugin's health check.
    -- **Note:** This requires the plugin to support an `override_health_check` option.
    -- If the plugin does not support this, you may consider contributing to its repository to add such support.
    --
    -- Example (Assuming the plugin supports an 'override_health_check' flag):
    -- override_health_check = true,
  },

  -- **Keybindings (`keys`)**
  -- Defines custom keyboard shortcuts to trigger plugin commands.
  keys = {
    { "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste Clipboard Image" }, -- **<leader>P:** Pressing the leader key followed by 'P' will execute the `PasteImage` command to paste an image from the clipboard.
  },

  -- **Configuration Function (`config`)**
  -- Initializes the plugin with the specified options and handles potential errors gracefully.
  config = function()
    -- **Protected Call (`pcall`)**
    -- Attempts to require and set up the `img-clip.nvim` plugin.
    -- If the plugin fails to load (e.g., due to unsupported OS), it catches the error and notifies the user without crashing Neovim.
    local status, img_clip = pcall(require, "img-clip")
    if status then
      -- **Setup Plugin:**
      -- Initializes `img-clip.nvim` with the options defined above.
      img_clip.setup(require("plugins.extras.ui.img-clip").opts)
    else
      -- **Error Notification:**
      -- Informs the user that `img-clip.nvim` failed to load and provides the error message.
      vim.notify("img-clip.nvim failed to load: " .. img_clip, vim.log.levels.ERROR)
    end
  end,
}
