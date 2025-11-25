-- lua/plugins/supermaven.lua
return {
  "supermaven-inc/supermaven-nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Supermaven provides AI-powered code completion
    -- The plugin works out of the box with reasonable defaults
    require("supermaven-nvim").setup({
      -- Use default configuration for now
      -- You can customize it later if needed
    })
  end,
}