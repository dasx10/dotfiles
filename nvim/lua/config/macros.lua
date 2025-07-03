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
        local function is_valid_word(word)
          return word ~= ""
             and word:match("^[$_%a][$%w_]*$")
             and word ~= "if"
             and word ~= "const"
             and word ~= "let"
             and word ~= "var"
             and word ~= "function"
             and word ~= "class"
             and word ~= "return"
             and word ~= "yield"
             and word ~= "import"
             and word ~= "export"
             and word ~= "delete"
             and word ~= "in"
             and word ~= "instanceof"
             and word ~= "typeof"
             and word ~= "void"
             and word ~= "null"
             and word ~= "undefined"
             and word ~= "true"
             and word ~= "false"
             and word ~= "NaN"
             and word ~= "Infinity"
             and word ~= "this"
        end
      
        local total_lines = vim.fn.line("$")
      
        while true do
          local word = vim.fn.expand("<cword>")
          if is_valid_word(word) then
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
