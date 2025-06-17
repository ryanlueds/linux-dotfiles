return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        vim.api.nvim_set_hl(0, "IndentBlanklineInactive", { fg = "#444444" })
        vim.api.nvim_set_hl(0, "IndentBlanklineActive", { fg = "#888888" })

        require("ibl").setup({
            indent = {
                char = "▏",  -- NOTE: this is very left-aligned on meslo nerd font. different fonts may mess this up
                highlight = {
                    "IndentBlanklineInactive",
                },
            },
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
                highlight = {
                    "IndentBlanklineActive",
                },
            },
        })
    end
}
