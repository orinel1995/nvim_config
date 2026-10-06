local M = {}

local function indent(level)
  return string.rep("  ", level)
end

local function pretty_print(input)
  local output = {}
  local depth = 0
  local in_string = false
  local escaped = false

  for index = 1, #input do
    local char = input:sub(index, index)

    if in_string then
      table.insert(output, char)
      if escaped then
        escaped = false
      elseif char == "\\" then
        escaped = true
      elseif char == '"' then
        in_string = false
      end
    elseif char == '"' then
      in_string = true
      table.insert(output, char)
    elseif char == "{" or char == "[" then
      depth = depth + 1
      table.insert(output, char .. "\n" .. indent(depth))
    elseif char == "}" or char == "]" then
      depth = depth - 1
      table.insert(output, "\n" .. indent(depth) .. char)
    elseif char == "," then
      table.insert(output, ",\n" .. indent(depth))
    elseif char == ":" then
      table.insert(output, ": ")
    elseif not char:match("%s") then
      table.insert(output, char)
    end
  end

  return table.concat(output)
end

function M.format_buffer(buffer)
  buffer = buffer or 0
  local input = table.concat(vim.api.nvim_buf_get_lines(buffer, 0, -1, false), "\n")
  if input == "" then
    return true
  end

  local ok, err = pcall(vim.json.decode, input)
  if not ok then
    vim.notify("Invalid JSON: " .. err, vim.log.levels.ERROR)
    return false
  end

  local lines = vim.split(pretty_print(input), "\n", { plain = true })
  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
  return true
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.json",
  callback = function(event)
    M.format_buffer(event.buf)
  end,
})

return M
