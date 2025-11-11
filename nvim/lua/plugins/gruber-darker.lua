function TransparentPencils()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

vim.pack.add({"https://github.com/thimc/gruber-darker.nvim"})
vim.cmd[[colorscheme gruber-darker]]

vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffdd33' })
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'white' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'white' })
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, 'Comment', { fg = '#db9342' })

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- vim.pack.add({"https://github.com/sainnhe/sonokai"})
-- vim.cmd[[colorscheme sonokai]]
