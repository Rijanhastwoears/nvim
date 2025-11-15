-- /home/rijan/.config/nvim/lua/snippets/typst.lua

-- Import snippet-defining functions from LuaSnip
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

-- This table will be exported and loaded by LuaSnip
return {
  -- Defines a snippet triggered by "pad"
  s("pad", {
    t("#pad(left: "),
    i(1, "10%"), -- First placeholder with default text "10%"
    t(", right: "),
    i(2, "10%"), -- Second placeholder
    t({")[", "  "}), -- Ends the line, adds a newline and two spaces for indentation
    i(0), -- Final cursor position, now on an indented new line
    t({"", "]"}), -- Adds a newline before the closing bracket
  }),

  -- Defines a snippet for a figure, triggered by "fig"
  s("fig", fmt(
[[#figure(
  image("{}", width: 70%),
  caption: [
    {}
  ]
) <fig:{}>{}
]],
    {
      i(1, "path/to/image.png"),
      i(2, "Caption text"),
      i(3, "label"),
      i(0),
    }
  )),

  -- Defines a snippet for alignment, triggered by "align"
  s("align", {
    t("#align("),
    i(1, "center"), -- First placeholder, defaults to "center"
    t({")[", "  "}), -- Ends the line, adds a newline and two spaces for indentation
    i(0), -- Second placeholder for the content, and the final cursor position
    t({"", "]"}), -- Adds a newline before the closing bracket
  }),
}