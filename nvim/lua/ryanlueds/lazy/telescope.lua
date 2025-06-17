return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.8",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
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
            builtin.grep_string({ search = vim.fn.input("It's grepping time: ") })
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



        vim.keymap.set('n', '<leader>ra', function()
            vim.ui.input({ prompt = "Search for: " }, function(string_one)
                if not string_one or string_one == "" then
                    return
                end
                vim.ui.input({ prompt = "Replace with: " }, function(string_two)
                    if not string_two then
                        return
                    end
                    local command = 'cfdo %s/' .. string_one .. '/' .. string_two .. '/ge | update | bd'
                    vim.cmd(command)
                    print("Executed: " .. command)
                end)
            end)
        end, {})





    end
}

