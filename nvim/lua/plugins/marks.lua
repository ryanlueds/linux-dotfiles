vim.pack.add({ "https://github.com/chentoast/marks.nvim" })

vim.api.nvim_set_hl(0, "MarkSignNumHL", { fg = "none" })

require('marks').setup({
    builtin_marks = { "'", "<", ">", "." }
})
