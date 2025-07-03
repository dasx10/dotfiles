local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local n = function (index)
  return f(function(args) return args[1][1] end, { index })
end

return {
  s("import from", {
    t("import "), i(1), t(" from "), i(2), t(";")
  }),

  s("e", {
    t("export ")
  }),

  s("d", {
    t("default ")
  }),

  s("ed", {
    t("export default "), i(1), t(";")
  }),

  s("r", {
    t("return "), i(1), t(";")
  }),

  s("c", {
    t("const "), i(1), t(" = "), i(2)
  }),

  s("a", {
    t("async ")
  }),

  s("w", {
    t("await ")
  }),

  s("f", {
    t("function "), i(1), t("("), i(2), t(") {"), t({ "", "  " }), i(0), t({ "", "}" })
  }),

  s("g", {
    t("function*"), i(1), t("("), i(2), t(") {"), t({ "", "  " }), i(0), t({ "", "}" })
  }),

  s("_", {
    t("("), i(1), t(") => "), i(2)
  }),
  s("__", {
    t("("), i(1, "x"), t(") => ("), i(2, "y"), t(") => "), i(3)
  }),

  s("pd", {
    t(".then( // THIS IS DEBUG - REMOVE THIS IF YOU DONT WANT TO NEED THIS"),
    t({ "", " (" }), i(1, "value"), t(") => (console.dir({ "), n(1), t(" }, { depth: 10 }), "), n(1), t("),"),
    t({ "", " (" }), i(2, "error"), t(") => (console.dir({ "), n(2), t(" }, { depth: 10 }), Promise.reject("), n(2), t("))"),
    t({ "", ")" })
  }),

  s("cz", {
    t("const "), i(1, "VALUE"), t({ " = Object.freeze({", "  " }), i(2), t({ "", "});" })
  }),

  s("cd", {
    t("console.dir({ "), i(1), t(" }, { depth: 10 })")
  }),

  s("z", {
    t("Object.freeze("), i(1), t(")")
  }),

  s("**", {
    t("/**"), t({ "", " * " }), i(1), t({ "", " */" })
  }),

  s("now", {
    t("Date.now()")
  }),

  s("if!", {
    t("if (!("), i(1), t(")) {"), t({ "", "  " }), i(2), t({ "", "}" })
  })
}
