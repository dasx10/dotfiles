return {
    "Wansmer/treesj",
    keys = { "=t", "=j", "=s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("treesj").setup({})
        local set = vim.keymap.set

        set("n", "=t", require("treesj").toggle)
        set("n", "=T", function()
            require("treesj").toggle({ split = { recursive = true } })
        end)
        set("n", "=j", require("treesj").join)
        set("n", "=J", function()
            require("treesj").join({ split = { recursive = true } })
        end)
        set("n", "=s", require("treesj").split)
        set("n", "=J", function()
            require("treesj").split({ split = { recursive = true } })
        end)
    end,
    lazy = true,
}
