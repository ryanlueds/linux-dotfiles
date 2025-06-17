return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module "neo-tree"
    ---@type neotree.Config?
    opts = {
        -- fill any relevant options here
    },
    config = function()
        vim.keymap.set('n', '<leader>pv', ':Neotree toggle position=current<CR>', { desc = 'Toggle Neo-tree' })

        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "",
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function(file_path)
                        -- This will automatically close neo-tree after you open a file
                        vim.cmd("Neotree close")
                    end,
                },
            },
        })
    end

}
