vim.pack.add({
    "https://www.github.com/norcalli/nvim-colorizer.lua"
})

local colorizer = require("colorizer")
-- REQUIRED
colorizer.setup({
    'css';
    'qml';
    'javascript';
    'conf';
    'scss';
    'lua';
    'json';
    html = { mode = 'background' };
}, { mode = 'background' })
