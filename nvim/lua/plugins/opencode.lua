return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  config = function()
    local opencode_bin = vim.fn.expand("~/.opencode/bin/opencode")
    local ask_in_progress = false

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        port = nil,
        start = function()
          require("opencode.terminal").open(opencode_bin .. " --port", {
            split = "right",
            width = math.floor(vim.o.columns * 0.45),
          })
        end,
        stop = function()
          require("opencode.terminal").close()
        end,
        toggle = function()
          require("opencode.terminal").toggle(opencode_bin .. " --port", {
            split = "right",
            width = math.floor(vim.o.columns * 0.45),
          })
        end,
      },
    }

    vim.o.autoread = true

    vim.api.nvim_create_autocmd("User", {
      pattern = "OpencodeEvent:*",
      callback = function(args)
        local event = args.data.event
        if event.type == "message.updated" and not ask_in_progress then
          ask_in_progress = true
          vim.notify("opencode: thinking...", vim.log.levels.INFO, { title = "opencode" })
        elseif event.type == "session.idle" and ask_in_progress then
          ask_in_progress = false
          vim.notify("opencode: done", vim.log.levels.INFO, { title = "opencode" })
        end
      end,
    })

    vim.keymap.set({ "n", "x" }, "<leader>ao", function()
      ask_in_progress = false
      require("opencode").ask()
    end, { desc = "Ask opencode" })
    vim.keymap.set({ "n", "x" }, "<leader>as", function() require("opencode").select() end, { desc = "Select opencode action" })
    vim.keymap.set({ "n", "t" }, "<leader>at", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "<leader>go", function() return require("opencode").operator("@this ") end, { desc = "Add range to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })
  end,
}
