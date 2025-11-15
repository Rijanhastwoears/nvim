-- lua/plugins/neo-tree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Recommended for icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- If you want icons for file types, you'll need to install a nerd font.
    -- See: https://www.nerdfonts.com/

    require("neo-tree").setup({
      -- The 'filesystem' source is the file explorer.
      -- You can also add 'buffers' and 'git_status' to this list.
      sources = { "filesystem", "buffers", "git_status" },
      -- Configuration for the window itself
      window = {
        -- Use a floating window for the file explorer
        position = "float",
        width = 40, -- The width of the floating window
        -- You can add more floating window options from nui.nvim if needed.
        -- For example, to slightly dim the editor background when neo-tree is open:
        -- win_options = {
        --   winblend = 10,
        -- },
      },
      -- Add git status indicators to files and directories
      git_status = {
        symbols = {
          added = "✚",
          modified = "",
          deleted = "✖",
          renamed = "➜",
          untracked = "U",
          ignored = "i",
          unstaged = "",
          staged = "✓",
          conflict = "",
        },
      },
      -- Default options for all sources
      default_config = {
        -- Use git status colors on file names
        use_git_status_colors = true,
      },
      -- These handlers will be called for all sources
      event_handlers = {
        {
          -- Automatically close neo-tree when a file is opened
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    })

    -- Keymap to toggle the file explorer
    -- <leader> is typically the backslash key '\'
    vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle<CR>", {
      desc = "Toggle Neo-tree (filesystem)",
      noremap = true,
      silent = true,
    })
  end,
}