if vim.g.vscode or vim.env.TERM == "dumb" then
  return
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    vim.api.nvim_out_write("\27[?1049l")
  end,
})
