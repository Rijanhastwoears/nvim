return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    vim.api.nvim_create_user_command("WhichKeyToggle", function()
      if vim.o.timeoutlen == 300 then
        vim.o.timeoutlen = 10000
        print("WhichKey disabled (timeoutlen=10000)")
      else
        vim.o.timeoutlen = 300
        print("WhichKey enabled (timeoutlen=300)")
      end
    end, {})
  end,
}
