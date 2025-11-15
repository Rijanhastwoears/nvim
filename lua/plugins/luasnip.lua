-- lua/plugins/luasnip.lua
return {
  "L3MON4D3/LuaSnip",
  -- Follow the latest release.
  version = "v2.*",
  -- Build step is required for regex support in snippets.
  build = "make install_jsregexp",
  dependencies = {
    -- friendly-snippets contains a lot of useful snippets for many languages.
    "rafamadriz/friendly-snippets",
  },
  config = function()
    -- See :help luasnip-config-setup for more details.
    require("luasnip").setup({
      -- You can add custom configuration here. For example:
      -- history = true, -- Keep around last used snippet.
      -- updateevents = "TextChanged,TextChangedI", -- Update changes as you type.
    })

    -- This line will add all the snippets from friendly-snippets to luasnip.
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Load our custom snippets from the lua/snippets directory
    require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets" })
  end,
}