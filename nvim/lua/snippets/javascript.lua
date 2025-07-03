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
  s("@param", {
    t("@param {"), i(1), t("} "), i(2)
  }),
}

return vim.tbl_extend("force", shared, extra)
