-- lua/plugins/lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- Ensure cmp-nvim-lsp is listed as a dependency here
    -- so its capabilities are available when this config runs.
    "hrsh7th/cmp-nvim-lsp",
    -- Add any other LSP-related plugins like linters/formatters (e.g., none-ls or nvim-lint)
    -- or UI enhancers (e.g., lspsaga, lspkind) here if you use them.
  },
  config = function()
    -- Get capabilities from the cmp-nvim-lsp plugin
    -- This now works because cmp-nvim-lsp is listed as a direct dependency above.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Your existing on_attach function remains the same
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      print("LSP attached to buffer:", bufnr)
    end

    -- *** Setup servers using the new vim.lsp.config API (Neovim 0.11+) ***
    
    -- Define server configurations
    local servers = {
      pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
      },
      lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = {'vim'} },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      },
      nim_langserver = {
        cmd = { "nimlangserver" },
        filetypes = { "nim" },
        root_markers = { "*.nimble", ".git" },
      },
      tinymist = {
        cmd = { "tinymist" },
        filetypes = { "typst" },
        root_markers = { ".git" },
      },
    }

    -- Register and enable each server
    for name, config in pairs(servers) do
      -- Add common settings to each server config
      config.capabilities = capabilities
      config.on_attach = on_attach
      
      -- Register the server configuration
      vim.lsp.config(name, config)
      
      -- Enable the server for its filetypes
      vim.lsp.enable(name)
    end

  end,
}
