-- This fixes some very annoying behavior: Whenever I start up nvim with 
-- a directory in the command line (i.e. "nvim src/"), there are TWO buffers.
-- The first one is neo-tree (intended behavior) and the second one is just
-- an empty buffer (not intended). This script deletes the empty buffer in 
-- this case.
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    vim.defer_fn(function()
      local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
      local empty_buffers_to_close = {}

      for _, buf in ipairs(listed_buffers) do
        if buf.name == "" then
          table.insert(empty_buffers_to_close, buf.bufnr)
        end
      end

      if #empty_buffers_to_close > 0 and #vim.fn.getbufinfo() > #empty_buffers_to_close then
        for _, bufnr in ipairs(empty_buffers_to_close) do
          vim.cmd("bdelete! " .. bufnr)
        end
      end
    end, 10)
  end,
})
