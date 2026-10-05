local function file_size()
  local bytes = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
  if bytes < 0 then
    return ""
  end

  if bytes < 1024 then
    return string.format("%d B", bytes)
  end

  local units = { "KiB", "MiB", "GiB" }
  local size = bytes
  local index = 0
  repeat
    size = size / 1024
    index = index + 1
  until size < 1024 or index == #units

  return string.format("%.1f %s", size, units[index])
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { "filename" },
      lualine_x = { "diagnostics", "diff" },
      lualine_y = { file_size, "filetype" },
      lualine_z = { "location", "progress" },
    },
  },
  config = function(_, opts)
    require("lualine").setup(opts)
  end,
}
