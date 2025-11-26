return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6", -- Pin to a specific version for stability
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    -- Custom function to copy the path of the selected file
    local function copy_path(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      if selection then
        local path = selection.path or selection.filename
        vim.fn.setreg("+", path) -- Copy to system clipboard
        print("Copied path: " .. path)
        actions.close(prompt_bufnr) -- Close Telescope after copying
      end
    end

    telescope.setup({
      defaults = {
        -- Default configuration for Telescope
        mappings = {
          i = {
            -- Map 'ESC' to close Telescope, a common preference
            ["<esc>"] = actions.close,
            -- Map '<C-y>' to copy path
            ["<C-y>"] = copy_path,
          },
          n = {
            ["<C-y>"] = copy_path,
          },
        },
      },
    })

    -- Define keymaps for common Telescope actions
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep for text" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find open buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find recent files" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })
  end,
}