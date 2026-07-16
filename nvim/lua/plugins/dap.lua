return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")

    -- ── DAP UI ─────────────────────────────────────────
    local dapui = require("dapui")
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "⏪",
          run_last = "↺",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      },
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- ── Virtual text ───────────────────────────────────
    require("nvim-dap-virtual-text").setup({
      commented = true,
    })

    -- ── Keymaps ────────────────────────────────────────
    vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "DAP: Continue" })
    vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "DAP: Step Over" })
    vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "DAP: Step Into" })
    vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "DAP: Step Out" })
    vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "DAP: Toggle Breakpoint" })
    vim.keymap.set(
      "n",
      "<leader>dB",
      function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
      { desc = "DAP: Conditional Breakpoint" }
    )
    vim.keymap.set(
      "n",
      "<leader>dl",
      function() dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
      { desc = "DAP: Log Point" }
    )
    vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end, { desc = "DAP: Open REPL" })
    vim.keymap.set("n", "<leader>dL", function() dap.run_last() end, { desc = "DAP: Run Last" })
    vim.keymap.set("v", "<leader>de", function() dapui.eval() end, { desc = "DAP: Evaluate" })

    -- ── Mason DAP adapters ─────────────────────────────
    require("mason-nvim-dap").setup({
      ensure_installed = { "js-debug-adapter" },
      automatic_installation = false,
      handlers = {},
    })

    -- ── Adapters ───────────────────────────────────────
    local function get_js_debug_path()
      return require("mason-registry").get_package("js-debug-adapter"):get_install_path()
        .. "/js-debug/src/dapDebugServer.js"
    end

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { get_js_debug_path(), "${port}" },
      },
    }

    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { get_js_debug_path(), "${port}" },
      },
    }

    -- ── Configurations ─────────────────────────────────
    local js_configs = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file (Node)",
        program = "${file}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch via ts-node",
        runtimeExecutable = "ts-node",
        runtimeArgs = { "--transpile-only" },
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch npm script",
        runtimeExecutable = "npm",
        runtimeArgs = { "run", "dev" },
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to Node process",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to port (Docker/Remote)",
        port = function()
          return tonumber(vim.fn.input("Port: ", "9229")) or 9229
        end,
        address = "localhost",
        localRoot = "${workspaceFolder}",
        remoteRoot = function()
          return vim.fn.input("Remote root: ", "/app")
        end,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch Chrome",
        url = "http://localhost:3000",
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        runtimeExecutable = "/usr/bin/google-chrome-stable",
        runtimeArgs = { "--remote-debugging-port=9222" },
      },
    }

    dap.configurations.javascript = js_configs
    dap.configurations.typescript = js_configs
    dap.configurations.javascriptreact = js_configs
    dap.configurations.typescriptreact = js_configs
  end,
}
