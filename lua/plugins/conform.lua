return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  ft = { "lua", "python", "sql", "javascript", "typescript", "json" },
  opts = {
    formatters = {
      mssql = {
        command = vim.fn.has("win32") == 1 and "sql-formatter.cmd" or "sql-formatter",
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
    format_on_save = true,
  },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true })
      end,
      desc = "Format buffer",
    },
  },
}
