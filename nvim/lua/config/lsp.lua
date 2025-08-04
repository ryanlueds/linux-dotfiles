vim.pack.add {
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    -- { src = 'https://github.com/stevearc/conform.nvim' },
    { src = "https://github.com/williamboman/mason.nvim" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
    -- { src = "hrsh7th/cmp-nvim-lsp" },
    -- { src = "hrsh7th/cmp-buffer" },
    -- { src = "hrsh7th/cmp-path" },
    -- { src = "hrsh7th/cmp-cmdline" },
    -- { src = "hrsh7th/nvim-cmp" },
    -- { src = "L3MON4D3/LuaSnip" },
    -- { src = "saadparwaiz1/cmp_luasnip" },
    { src = "https://github.com/j-hui/fidget.nvim" },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "ts_ls",
        "pyright",
        "clangd",
    },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
            })
        end,

        ["ts_ls"] = function()
            require("lspconfig").ts_ls.setup({
                capabilities = capabilities,
                root_dir = require("lspconfig").util.root_pattern("tsconfig.json", ".git"),
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                },
            })
        end,

        ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
                settings = {
                    Lua = {
                        format = {
                            enable = true,
                            defaultConfig = {
                                indent_style = "space",
                                indent_size = "4",
                            },
                        },
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
        end,
    },
})


require("lspconfig").qmlls.setup({
    capabilities = capabilities,
    cmd = {
        "qmlls6",
        "-E",
        "-d", "/usr/share/doc/qt6"
    },
    root_dir = require("lspconfig.util").root_pattern(".git", "*.pro", ".qmlls.ini"),
})


-- LSP THINGY MABOBS --


vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
            vim.keymap.set('i', '<C-Space>', function()
                vim.lsp.completion.get()
            end)
        end
    end,
})

vim.diagnostic.config({
    virtual_lines = {
        current_line = true,
    },
})

vim.lsp.enable({ 'lua_ls' })
