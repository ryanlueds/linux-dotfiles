return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local colors = {
          red       = '#ff0a36',
          green     = '#41dc00',
          black     = '#181818',
          white     = '#f5f5f5',
          yellow    = '#ffdb00',
          orange    = '#cc8c3c',
          grey      = '#303030',
        }

        local gruber_darker_theme = {
          normal = {
            a = { fg = colors.black, bg = colors.orange },
            b = { fg = colors.white, bg = colors.grey },
            c = { fg = colors.white },
          },

          insert = { a = { fg = colors.black, bg = colors.green } },
          visual = { a = { fg = colors.black, bg = colors.red } },
          replace = { a = { fg = colors.black, bg = colors.yellow } },

          inactive = {
            a = { fg = colors.white, bg = colors.black },
            b = { fg = colors.white, bg = colors.black },
            c = { fg = colors.white },
          },
        }

        require('lualine').setup {
          options = {
            icons_enabled = false,
            theme = gruber_darker_theme,
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
              statusline = {},
              winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
              statusline = 100,
              tabline = 100,
              winbar = 100,
            }
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff'},
            lualine_c = { "%f" },
            lualine_x = {},
            lualine_y = {},
            lualine_z = {'location'}
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
          },
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = {}
        }
    end
}
