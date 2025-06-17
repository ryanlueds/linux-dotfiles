function TransparentPencils()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
end

return {
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     priority = 1000,
    --     config = function()
    --         require("catppuccin").setup({
    --             flavour = "macchiato",
    --             transparent_background = true,
    --             term_colors = true,
    --             no_italic = true,
    --             no_bold = true,
    --             no_underline = true,
    --             integrations = {
    --                 treesitter = true,
    --             },
    --         })

    --         vim.cmd.colorscheme('catppuccin')
    --     end,
    -- }
    {
        'thimc/gruber-darker.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('gruber-darker').setup({ })
            vim.cmd.colorscheme('gruber-darker')
            vim.cmd('lua TransparentPencils()')


            vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffdd33' })
            vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'white' })
            vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'white' })
	        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })


            -- vim.api.nvim_set_hl(0, 'Type', { fg = '#c4c9c3' })
            vim.api.nvim_set_hl(0, 'Comment', { fg = '#db9342' })
            -- vim.api.nvim_set_hl(0, 'Function', { fg = '#a5b0c7' })
            -- vim.api.nvim_set_hl(0, 'Constant', { fg = '#ffffff' })
            
            -- vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#373737' })
            -- '#db9342'
            -- '#cc8c3c' this is the cool brown color
            -- '#ffdd33'  this is the cool yellow color
        end,
    },
}
