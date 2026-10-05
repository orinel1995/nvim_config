local modes = {
  n = { cursor = "#7e9cd8", line = "#282e45" },
  i = { cursor = "#98bb6c", line = "#263a35" },
  v = { cursor = "#957fb8", line = "#332d42" },
  V = { cursor = "#957fb8", line = "#332d42" },
  ["\22"] = { cursor = "#957fb8", line = "#332d42" },
  R = { cursor = "#e46876", line = "#422b35" },
  c = { cursor = "#7fb4ca", line = "#263842" },
  t = { cursor = "#957fb8", line = "#322c40" },
}

local function update_mode_colors()
  local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
  local colors = modes[mode] or modes.n
  local line_number = vim.api.nvim_get_hl(0, { name = "LineNr", link = false })
  local current_number = { bg = colors.cursor }
  local visual_number = { bg = modes.v.cursor }

  if line_number.fg then
    current_number.fg = line_number.fg
    visual_number.fg = line_number.fg
  end

  vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.line })
  vim.api.nvim_set_hl(0, "CursorLineNr", current_number)
  vim.api.nvim_set_hl(0, "ModeCursor", { fg = "#1f1f28", bg = colors.cursor })
  vim.api.nvim_set_hl(0, "VisualLineNr", visual_number)
  vim.api.nvim_set_hl(0, "Visual", { fg = "#dcd7ba", bg = "#4b3f63" })
end

local function visual_range()
  local mode = vim.fn.mode(1)
  if mode:sub(1, 1) ~= "v" and mode ~= "\22" then
    return nil
  end

  local anchor = vim.fn.getpos("v")[2]
  local cursor = vim.fn.line(".")
  return math.min(anchor, cursor), math.max(anchor, cursor)
end

function _G.ModeColorsStatusColumn()
  if vim.v.virtnum ~= 0 or not vim.wo.number then
    return ""
  end

  local first, last = visual_range()
  local selected = first and vim.v.lnum >= first and vim.v.lnum <= last
  local current = vim.v.relnum == 0
  local number = vim.wo.relativenumber and not current and vim.v.relnum or vim.v.lnum
  local highlight = selected and "VisualLineNr" or current and "CursorLineNr" or "LineNr"
  local text = tostring(number)
  local padding = string.rep(" ", math.max(0, vim.wo.numberwidth - #text))

  return string.format("%%#%s#%s%s ", highlight, padding, text)
end

vim.o.guicursor = table.concat({
  "n-v-ve-o:block-ModeCursor",
  "i-ci:ver25-ModeCursor",
  "r-cr:hor20-ModeCursor",
  "c:ver25-ModeCursor",
  "sm:block-ModeCursor",
}, ",")
vim.o.statuscolumn = "%s%C%=%{%v:lua.ModeColorsStatusColumn()%}"

local group = vim.api.nvim_create_augroup("mode_colors", { clear = true })
vim.api.nvim_create_autocmd({ "ModeChanged", "ColorScheme" }, {
  group = group,
  callback = update_mode_colors,
})

update_mode_colors()
