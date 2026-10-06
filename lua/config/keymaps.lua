vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus lower split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus upper split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right split" })

vim.keymap.set("n", "<leader>h", "<Cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>l", "<Cmd>bnext<CR>", { desc = "Next buffer" })

vim.keymap.set("n", "go", function()
  local path = vim.fn.expand("<cfile>")
  if path ~= "" then
    vim.cmd.edit(vim.fn.fnameescape(path))
  end
end, { desc = "Open file under cursor" })
