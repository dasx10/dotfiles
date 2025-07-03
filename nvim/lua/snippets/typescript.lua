local shared = require("shared-snippets.js")

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local n = function (index)
  return f(function(args) return args[1][1] end, { index })
end

local extra = {
  s("pv", {
    t("private "), n(1)
  }),

  s("ro", {
    t("readonly "), n(1)
  }),

  s("pvr", {
    t("private readonly "), n(1)
  }),

  s("pb", {
    t("public "), n(1)
  }),

  s("pbr", {
    t("public readonly "), n(1)
  }),

  s("pt", {
    t("protected "), n(1)
  }),

  s("ptr", {
    t("protected "), n(1)
  }),

  s("it", {
    t("interface "), i(1), t({ " {", "" }), t("  "), i(2), t({ "", "}" })
  }),
}

return vim.tbl_extend("force", shared, extra)
