vim.pack.add {
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/j-hui/fidget.nvim" },
}

require("mason").setup()

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set('i', '<C-Space>', function()
                vim.lsp.completion.get()
            end)
            vim.keymap.set('n', '<C-Space>', function()
                vim.lsp.completion.get()
            end)
        end
    end,
})

vim.diagnostic.config({
    -- virtual_lines = {
    --     current_line = true,
    -- },
})

vim.lsp.enable({ 'lua_ls', 'pyright', 'ts_ls', 'clangd', 'tinymist', 'zls' })


-- require("lspconfig").qmlls.setup({
--     capabilities = capabilities,
--     cmd = {
--         "qmlls6",
--         "-E",
--         "-d", "/usr/share/doc/qt6"
--     },
--     root_dir = require("lspconfig.util").root_pattern(".git", "*.pro", ".qmlls.ini"),
-- })
