-- lua/plugins/lazy-nvim.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({"git", "clone", "--depth=1", "https://github.com/folke/lazy.nvim", lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Load plugin configurations from the 'plugins' directory
  spec = {
    { import = "plugins/treesitter" },
    { import = "plugins/catppuccin" },
    { import = "plugins/lspconfig" },
    { import = "plugins/cmp" }, -- Add this line to load your new cmp config
    { import = "plugins/luasnip" },
    { import = "plugins/onedark"},
    { import = "plugins/gruvbox-material" },
    { import = "plugins/neo-tree" },
    { import = "plugins/tabby" },
    { import = "plugins/heirline" },
    { import = "plugins/mini-ai" },
    { import = "plugins/telescope" },
    { import = "plugins/alpha" },
    { import = "plugins/supermaven" },
    { import = "plugins/which-key"}
  }
})
