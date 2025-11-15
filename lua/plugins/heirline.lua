-- lua/plugins/heirline.lua
return {
  "rebelot/heirline.nvim",
  event = "VimEnter", -- Load on startup
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local heirline = require("heirline")
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    -- Heuristically get colors from the current colorscheme.
    -- This should work well with onedark, catppuccin, etc.
    local colors = {
      red = utils.get_highlight("DiagnosticError").fg,
      green = utils.get_highlight("String").fg,
      blue = utils.get_highlight("Function").fg,
      gray = utils.get_highlight("Comment").fg,
      bg = utils.get_highlight("StatusLine").bg,
      fg = utils.get_highlight("StatusLine").fg,
    }

    local ViMode = {
      init = function(self)
        self.mode = vim.fn.mode(1)
      end,
      provider = function(self)
        local mode_map = {
          n = "NORMAL",
          i = "INSERT",
          v = "VISUAL",
          V = "V-LINE",
          ["\22"] = "V-BLOCK",
          c = "COMMAND",
          s = "SELECT",
          S = "S-LINE",
          R = "REPLACE",
          t = "TERMINAL",
        }
        return " " .. (mode_map[self.mode] or self.mode):upper() .. " "
      end,
      hl = function(self)
        local mode_color_map = {
          n = colors.blue,
          i = colors.green,
          v = colors.red,
          V = colors.red,
          ["\22"] = colors.red,
          c = colors.gray,
          R = colors.red,
          t = colors.green,
        }
        return { bg = mode_color_map[self.mode] or colors.blue, fg = colors.bg, bold = true }
      end,
      -- Only show when the buffer is active
      condition = conditions.is_active,
    }

    local GitBranch = {
      condition = conditions.is_git_repo,
      provider = function()
        return " " .. require("heirline.providers.git_branch")()
      end,
      hl = { fg = colors.blue, bold = true },
    }

    local FileName = {
      init = function(self)
        self.filename = vim.fn.fnamemodify(self.filename, ":t")
      end,
      provider = function(self)
        if self.filename == "" then
          return "[No Name]"
        end
        -- You can add logic here to shorten the filename if it's too long
        return self.filename
      end,
      hl = { fg = colors.fg, bold = true },
    }

    local FileIcon = {
      condition = conditions.buffer_has_file_extension,
      provider = function(self)
        local icon, _ = require("nvim-web-devicons").get_icon_color(self.filename)
        return icon and (icon .. " ")
      end,
      hl = function(self)
        local _, color = require("nvim-web-devicons").get_icon_color(self.filename)
        return { fg = color }
      end,
    }

    local Diagnostics = {
      condition = conditions.has_diagnostics,
      provider = function()
        local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        local parts = {}
        if errors > 0 then table.insert(parts, " " .. errors) end
        if warnings > 0 then table.insert(parts, " " .. warnings) end
        return #parts > 0 and (table.concat(parts, " ") .. " ")
      end,
      hl = { fg = colors.red },
    }

    local Cwd = {
      provider = function()
        local cwd = vim.fn.getcwd()
        local current_dir_name = vim.fn.fnamemodify(cwd, ":t")

        -- Handle root directory case, e.g., "/"
        if current_dir_name == "" then
          return " / "
        end

        local parent_path = vim.fn.fnamemodify(cwd, ":h")
        local parent_dir_name = vim.fn.fnamemodify(parent_path, ":t")

        -- If parent is root or we are at a drive root (Windows)
        if parent_dir_name == "" or parent_path == cwd then
          return " " .. current_dir_name .. " "
        end

        return " " .. parent_dir_name .. "/" .. current_dir_name .. " "
      end,
      hl = { fg = colors.gray },
    }

    local Position = {
      provider = function()
        return " %l:%c "
      end,
      hl = { bg = colors.blue, fg = colors.bg, bold = true },
    }

    local Spacer = { provider = " " }
    local RightAlign = { provider = "%=" }

    -- Assemble the statusline
    heirline.setup({
      statusline = {
        ViMode, Spacer, GitBranch, Spacer, Cwd,
        RightAlign, -- Pushes remaining components to the right
        Diagnostics, FileIcon, FileName, Spacer,
        Position,
      },
      -- To keep it minimal and not conflict with tabby.nvim, we'll disable
      -- heirline's winbar and tabline. You can configure them later if you want.
      winbar = nil,
      tabline = nil,
    })
  end,
}