-- lua/plugins/tabby.lua
return {
  "nanozuki/tabby.nvim",
  event = "VimEnter", -- Load tabby when Neovim starts
  dependencies = "nvim-tree/nvim-web-devicons", -- Recommended for file type icons
  config = function()
    require("tabby").setup({
      -- You can add custom components and layouts here for future extensibility.
      -- For now, we'll use the default setup which is clean and functional.
      -- To see all available components, run `:h tabby-components`
      tabs = {
        -- This component shows the tab name (e.g., 1, 2, 3).
        {
          type = "tab_name",
          hl = "TabLineSel", -- Highlight group for the active tab
        },
        -- This component shows a close button for the tab.
        {
          type = "close_button",
          hl = "TabLine", -- Highlight group for inactive tabs
        },
      },
      windows = {
        -- This component shows the file icon and name for the active window in a tab.
        { type = "win" },
      },
    })
  end,
}