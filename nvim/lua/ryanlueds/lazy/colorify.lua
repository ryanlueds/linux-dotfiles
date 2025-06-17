return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        local colorizer = require("colorizer")
        -- REQUIRED
        colorizer.setup({
            'css';
            'qml';
            'javascript';
            'conf';
            'scss';
            'lua';
            html = { mode = 'background' };
        }, { mode = 'background' })
    end
}
