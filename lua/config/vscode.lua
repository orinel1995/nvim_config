if not vim.g.vscode then
  return
end

local function notify(command)
  return function()
    vim.fn.VSCodeNotify(command)
  end
end

vim.keymap.set("n", "<leader>e", notify("workbench.view.explorer"), { silent = true })
vim.keymap.set("n", "<leader>ml", notify("workbench.action.moveEditorToNextGroup"), { silent = true })
vim.keymap.set("n", "<leader>mh", notify("workbench.action.moveEditorToPreviousGroup"), { silent = true })
vim.keymap.set({ "n", "v", "i" }, "<C-h>", notify("workbench.action.focusLeftGroup"), { silent = true })
vim.keymap.set({ "n", "v", "i" }, "<C-l>", notify("workbench.action.focusRightGroup"), { silent = true })
vim.keymap.set("n", "<leader>l", notify("workbench.action.nextEditor"), { silent = true })
vim.keymap.set("n", "<leader>h", notify("workbench.action.previousEditor"), { silent = true })
