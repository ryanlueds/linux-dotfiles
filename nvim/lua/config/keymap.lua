-- Temporarily changing Netrw garbo with neo-tree
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.keymap.set("n", "<leader>td", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })

vim.keymap.set("n", "<leader>E", "<cmd>lua vim.diagnostic.open_float()<cr>")
vim.keymap.set("n", "<leader>o", 'o<Esc>0"_D')
vim.keymap.set("n", "<leader>O", 'O<Esc>0"_D')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<left>", "")
vim.keymap.set("n", "<right>", "")
vim.keymap.set("n", "<up>", "")
vim.keymap.set("n", "<down>", "")

vim.keymap.set("i", "<left>", "")
vim.keymap.set("i", "<right>", "")
vim.keymap.set("i", "<up>", "")
vim.keymap.set("i", "<down>", "")

-- vim.keymap.set("n", "<leader>vwm", function()
--     require("vim-with-me").StartVimWithMe()
-- end)
-- vim.keymap.set("n", "<leader>svwm", function()
--     require("vim-with-me").StopVimWithMe()
-- end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

-- vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])   look up what this do

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>")
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

-- TODO: I should really do descriptions for which-key...
vim.keymap.set('n', '<leader>h', ':bprevious<CR>', { desc = 'Go to previous buffer' })
vim.keymap.set('n', '<leader>l', ':bnext<CR>', { desc = 'Go to next buffer' })
vim.keymap.set("n", "<leader>x", ":bdelete<CR>")

-- I NEED TO FORMAT C CODE TODO TODO TODO TODO UGLY UGLY UHLY
-- vim.keymap.set("n", '<leader>f', ":!clang-format -i %<CR>", { desc = "Format file in place" })
-- vim.keymap.set('v', '<leader>f', ":'<,'>!clang-format<CR>", { noremap = true, silent = true })

vim.api.nvim_create_user_command("RunCmd", function(opts)
    local raw_cmd = opts.args
    if raw_cmd == "" then return end

    -- color [Process exited $code]
    local wrapped_cmd = table.concat({
        "bash", "-c",
        string.format([[
            '%s; code=$?;
            if [ $code -eq 0 ]; then
                echo -e "\e[32m";
            else
                echo -e "\e[31m";
            fi;'
        ]], raw_cmd)
    }, " ")

    vim.cmd("rightbelow vsplit")
    local term_win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_win_set_buf(term_win, buf)
    vim.fn.termopen(wrapped_cmd)

    vim.bo[buf].filetype = "terminal"
    vim.bo[buf].buflisted = false
    vim.bo[buf].bufhidden = "hide"

    vim.api.nvim_set_current_win(term_win)
    vim.cmd("stopinsert")
end, {
    nargs = "*",
    complete = "shellcmd"
})
vim.keymap.set('n', '<leader>r', function()
    vim.ui.input({ prompt = '[exec] ' }, function(input)
        if input and #input > 0 then
            vim.cmd('silent! RunCmd ' .. input)
        end
    end)
end, { noremap = true })

vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })
