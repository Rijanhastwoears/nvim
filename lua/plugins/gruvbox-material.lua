-- lua/plugins/gruvbox-material.lua
return {
  "sainnhe/gruvbox-material",
  name = "gruvbox-material",
  event = "VimEnter", -- Load the theme on startup
  config = function()
    -- Set a background variant. Other options: 'hard', 'soft'
    vim.g.gruvbox_material_background = "medium"

    -- Set a foreground variant. Other options: 'mix', 'original'
    vim.g.gruvbox_material_foreground = "material"

    -- For better performance
    vim.g.gruvbox_material_better_performance = 1

    -- Load the colorscheme
    vim.cmd.colorscheme "gruvbox-material"
  end,
}