-- lua/plugins/mini-ai.lua
return {
  "echasnovski/mini.ai",
  -- Load on startup, or change to `event = "VeryLazy"` to load on first use
  event = "VimEnter",
  config = function()
    -- mini.ai provides powerful text-objects for 'a' (around) and 'i' (inside)
    -- It's designed to be a modern and more capable replacement for older text-object plugins.
    require("mini.ai").setup({
      -- No specific configuration is needed to get started.
      -- The plugin provides text-objects for arguments, function calls,
      -- classes, and more, out of the box.
      --
      -- For example, with your cursor inside a function's parentheses:
      --  - `va,` will select 'around' the current argument.
      --  - `vi,` will select 'inside' the current argument.
      --  - `daf` will delete the entire function call.
      --  - `ci'` will change the text inside single quotes.
    })
  end,
}