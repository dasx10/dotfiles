local function is_spec(word)
  return word ~= ""
     and word:match("^[$_%a][$%w_]*$")
     and word ~= "Infinity"
     and word ~= "NaN"
     and word ~= "async"
     and word ~= "await"
     and word ~= "break"
     and word ~= "case"
     and word ~= "catch"
     and word ~= "class"
     and word ~= "const"
     and word ~= "continue"
     and word ~= "debugger"
     and word ~= "default"
     and word ~= "delete"
     and word ~= "do"
     and word ~= "else"
     and word ~= "export"
     and word ~= "false"
     and word ~= "finally"
     and word ~= "for"
     and word ~= "function"
     and word ~= "if"
     and word ~= "import"
     and word ~= "in"
     and word ~= "instanceof"
     and word ~= "let"
     and word ~= "null"
     and word ~= "of"
     and word ~= "return"
     and word ~= "switch"
     and word ~= "this"
     and word ~= "throw"
     and word ~= "true"
     and word ~= "try"
     and word ~= "typeof"
     and word ~= "undefined"
     and word ~= "var"
     and word ~= "void"
     and word ~= "while"
     and word ~= "yield"
end

vim.api.nvim_create_autocmd(
  {"BufRead", "BufNewFile"},
  {
    pattern = {"*.js", "*.ts", "*.tsx", "*.jsx"},
    callback = function(args)
      local bufnr = args.buf
      local sn = { silent = true, noremap = true }

      local function map(mode, lhs, rhs)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, sn)
      end

      local function macro (lhs, rhs, mode)
        if mode == nil then
          mode = "n"
        end
        vim.api.nvim_buf_set_keymap(bufnr, mode, "<space><space>"..lhs, rhs, sn)
      end

      local v = function (lhs, rhs)
        macro(lhs, rhs, "v")
      end

      local n = function (lhs, rhs)
        macro(lhs, rhs, "n")
      end

      n("oz", "ca{(Object.freeze()<esc><left>p<left>%a)<esc><right>");

      vim.keymap.set("n", "<space><space>d", function()
      
        local total_lines = vim.fn.line("$")
      
        while true do
          local word = vim.fn.expand("<cword>")
          if is_spec(word) then
            vim.cmd("normal! \"0yiw")
            local copied = vim.fn.getreg("0")
            vim.fn.append(vim.fn.line("."), "console.dir({ " .. copied .. " }, { depth: 10 })")
            vim.cmd("normal! j^v$")
            break
          end
      
          local prev_pos = vim.api.nvim_win_get_cursor(0)
          vim.cmd("normal! W")
          local new_pos = vim.api.nvim_win_get_cursor(0)
      
          if prev_pos[1] == new_pos[1] and prev_pos[2] == new_pos[2] then
            vim.notify("No valid word found (cursor stuck)")
            break
          end
      
          if new_pos[1] > total_lines then
            vim.notify("No valid word found (EOF)")
            break
          end
        end
      end, { noremap = true })

      n("j", "0/throw<cr>cwreturn Promise.reject(<esc>lxA)<esc>")
_G.smart_import_handler = function()
  local word = vim.fn.expand("<cword>")
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir = vim.fn.fnamemodify(current_file, ":p:h")

  vim.cmd("normal! m0")
  vim.api.nvim_buf_set_lines(0, 0, 0, false, { "import " .. word .. " from " })

  require('fzf-lua').files({
    fzf_opts = { ['--query'] = word },
    actions = {
      ['default'] = function(selected)
        local path_tools = require('fzf-lua').path
        local target_path = path_tools.entry_to_file(selected[1]).path
        target_path = vim.fn.fnamemodify(target_path, ":p")

        -- Функція для розрахунку відносного шляху
        local function get_relative_path(source, dest)
          local function split(path)
            local t = {}
            for str in path:gmatch("[^/]+") do table.insert(t, str) end
            return t
          end

          local s = split(source)
          local d = split(dest)
          local i = 1
          while s[i] and d[i] and s[i] == d[i] do
            i = i + 1
          end

          local rel = {}
          for j = i, #s do table.insert(rel, "..") end
          for j = i, #d do table.insert(rel, d[j]) end
          
          local res = table.concat(rel, "/")
          -- Якщо файл у тій же папці, додаємо ./
          if not res:match("^%.%.") then res = "./" .. res end
          return res
        end

        local rel = get_relative_path(current_dir, target_path)

        -- РЯДОК З ОБРІЗКОЮ ВИДАЛЕНО, щоб зберегти розширення (.ts, .tsx тощо)
        
        local final_text = '"' .. rel .. '";'
        local line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
        vim.api.nvim_buf_set_lines(0, 0, 1, false, { line .. final_text })
        
        vim.cmd('normal! `0')
      end,
      ['esc'] = function()
        vim.api.nvim_buf_set_lines(0, 0, 1, false, {})
        vim.cmd('normal! `0')
      end
    }
  })
end

-- map <space><space>ed to add export default
vim.keymap.set("n", "<space><space>ed", function()
  local word = vim.fn.expand("<cword>")

  if not word:match("^[A-Za-z][A-Za-z0-9_]*$") then return end
  if not is_spec(word) then return end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local export_line_idx = nil
  for i, l in ipairs(lines) do
    if l:match("^export default ") then
      export_line_idx = i - 1
      break
    end
  end

  local new_export = "export default " .. word .. ";"

  if export_line_idx then
    vim.api.nvim_buf_set_lines(0, export_line_idx, export_line_idx + 1, false, { new_export })
  else
    local last = #lines
    -- skip trailing empty lines
    while last > 0 and lines[last]:match("^%s*$") do last = last - 1 end
    vim.api.nvim_buf_set_lines(0, last, last, false, { new_export })
  end
end, { buffer = bufnr, silent = true })

n("i", "<cmd>lua _G.smart_import_handler()<cr>")
      v("i",  "\"0cif (<esc>m0a) {<cr>}<esc><up>\"0pvi{=`0a")
      -- v("_",  "\"0c() => {<esc>m0a<cr>}<esc><up>\"0pvi{=`0vi{o<esc>3bi")
      v("_",  "m0\"0c() => {<cr><C-R>0}<esc>kvi{=vi{o<esc>3b")
      v("a_", "m0\"0casync () => {<cr><C-R>0}<esc>kvi{=vi{o<esc>4b")
      v("f",  "\"0cfunction <esc>m0a() {<cr>}<esc><up>\"0pvi{=`0a")
      v("af", "\"0casync function <esc>m0a() {<cr>}<esc><up>\"0pvi{=`0a")
      v("g",  "m0\"0cfunction*() {<cr>}<esc><up>\"0p`0")
      v("ag", "m0\"0casync function*() {<cr>}<esc><up>\"0p`0")
      v('tc', "\"0ctry {<cr>}<esc>k\"0pvi{=vi{<esc>ja catch (error) {<cr><cr>}<esc>ka  ")
      v('tf', "\"0ctry {<cr>}<esc>k\"0pvi{=vi{<esc>ja finally {<cr><cr>}<esc>ka  ")
      v('tcf', "\"0ctry {}<esc>m0a catch (error) {<cr><cr>} finally {<cr><cr>}<esc>`0i<cr><C-R>0<esc>`0jvi{=vi{")

      map("n", "=l", ":!npx eslint --fix %<cr>")
      map("v", "<space>gr", ":AvanteEdit Resolve merge conflict if the data is identical.  If the data is not identical but shares a common origin — move it up if possible,  or place it below with the corrected data and create a Git conflict next to it that I should resolve manually.  It's allowed to split into multiple separate Git conflicts if that helps clarify the context.  If the content is unclear or the data has no common origin — do nothing.<cr>")
    end
  }
)

