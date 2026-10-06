local function format_current_buffer()
  if vim.bo.filetype == "json" then
    require("config.json").format_buffer()
    return
  end

  require("conform").format({ async = true })
end

local function mssql_command(self, context)
  local executable = vim.fn.has("win32") == 1 and "sql-formatter.cmd" or "sql-formatter"
  return require("conform.util").from_node_modules(executable)(self, context)
end

return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  ft = { "lua", "python", "sql", "javascript", "typescript" },
  opts = {
    formatters = {
      mssql = {
        command = mssql_command,
        args = { "-c", vim.fn.stdpath("config") .. "/sql-formatter.json" },
        stdin = true,
      },
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      sql = { "mssql" },
    },
    format_on_save = function(buffer)
      if vim.bo[buffer].filetype == "json" then
        return nil
      end
      return {}
    end,
  },
  keys = {
    {
      "gf",
      format_current_buffer,
      desc = "Format buffer",
    },
  },
}
