local candidates = { "C:/im-select/im-select.exe", "im-select.exe" }

if vim.env.IM_SELECT_PATH and vim.env.IM_SELECT_PATH ~= "" then
  table.insert(candidates, 1, vim.env.IM_SELECT_PATH)
end

local function switch_to_english_layout()
  for _, path in ipairs(candidates) do
    if vim.fn.executable(path) == 1 then
      vim.fn.system({ path, "1033" })
      return
    end
  end
end

if vim.g.vscode then
  local last_switch = 0
  vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "WinEnter", "CursorMoved" }, {
    callback = function()
      local now = vim.uv.hrtime() / 1e6
      local mode = vim.api.nvim_get_mode().mode
      if mode ~= "i" and mode ~= "c" and now - last_switch >= 300 then
        last_switch = now
        switch_to_english_layout()
      end
    end,
  })
  return
end

vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
  callback = switch_to_english_layout,
})

switch_to_english_layout()
