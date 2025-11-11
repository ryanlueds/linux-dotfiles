vim.pack.add({
    -- { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = 'https://github.com/folke/snacks.nvim' },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})

vim.api.nvim_set_hl(0, "IndentBlanklineInactive", { fg = "#444444" })
vim.api.nvim_set_hl(0, "IndentBlanklineActive", { fg = "#888888" })

require("snacks").setup({
    dim = {
        scope = { min_size = 5, max_size = 20 },
    },
    indent = {
        indent = {
            enabled = true,
            char = "▏",
            hl = "IndentBlanklineInactive"
        },
        scope = {
            enabled = true,
            char = "▏",
            hl = "IndentBlanklineActive"
        },
        animate = { enabled = false, },
    },
    picker = {
        enabled = true,
        layouts = {
            telescope = {
                reverse = true,
                layout = {
                    box = "horizontal",
                    backdrop = false,
                    width = 0.99,
                    height = 0.99,
                    border = "none",
                    {
                        box = "vertical",
                        { win = "list",  title = "", title_pos = "center", border = "single" },
                        { win = "input", height = 1, border = "single",    title = "",       title_pos = "center" },
                    },
                    {
                        win = "preview",
                        title = "{preview:Preview}",
                        width = 0.70,
                        border = "single",
                        title_pos = "center",
                    },
                },
            },
        },
        layout = "telescope",
    },
})

local thunk = require("snacks")
vim.keymap.set("n", "<leader>pf", function()
    thunk.picker.smart({
        hidden = true,
        filter = { cwd = true },
    })
end, { desc = "Smart Find Files" })

vim.keymap.set("n", "<leader>ps", function()
    thunk.picker.grep({
        hidden = true,
        filter = { cwd = true },
    })
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>:", function()
    thunk.picker.command_history({
        layout = { -- okay folke. what is this
            layout = {
                backdrop = false,
                box = "vertical",
                width = 0.4,
                height = 0.7,
                border = "none", -- why doesnt this work... no biggie
                {
                    box = "vertical",
                    border = "single",
                    title_pos = "center",
                    { win = "input", height = 0.1, border = "bottom" },
                    { win = "list",  border = "none" },
                },
            },
            preview = false,
        },
    })
end, { desc = "Command History" })

vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Definitions" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References" })
