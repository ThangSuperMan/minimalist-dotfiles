local ls = require("luasnip") --{{{
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Css Snippets", { clear = true })
local file_pattern = "*.xml"

local dependency = s(
  "dependency",
  fmt([[
    <dependency>
      <groupId>{}</groupId>
      <artifactId>{}</artifactId>
    </dependency>
  ]],
  {
    i(1, ""),
    i(2, ""),
  }
 )
)

table.insert(snippets, dependency)

-- End Refactoring --

return snippets, autosnippets
