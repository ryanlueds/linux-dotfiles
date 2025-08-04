vim.pack.add({
    {
        src = "https://github.com/nvim-telescope/telescope.nvim",
    },
    {
        src = "https://github.com/nvim-lua/plenary.nvim",
    }
})

require('telescope').setup({})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({
        layout_strategy = 'vertical',
        layout_config = {
            width = 0.5,
        },
    })
end)
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pws', function()
    local word = vim.fn.expand("<cword>")
    builtin.grep_string({ search = word })
end)
vim.keymap.set('n', '<leader>pWs', function()
    local word = vim.fn.expand("<cWORD>")
    builtin.grep_string({ search = word })
end)
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({
        search = vim.fn.input("It's grepping time: "),
        layout_strategy = 'horizontal',
        layout_config = {
            width = 0.9,
            preview_width = 0.8,
        },
    })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

vim.keymap.set('n', '<C-F>', function()
    local current_word = ""
    local search_str = vim.fn.input("Search for: ", current_word, "file")
    local replace_str = vim.fn.input("Replace with: ")

    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

    for i, line in ipairs(lines) do
        lines[i] = string.gsub(line, search_str, replace_str)
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    print("Replaced occurrences of '" .. search_str .. "' with '" .. replace_str .. "' in the current buffer.")
end, {})
