return {
  "stevearc/conform.nvim",
  cmd = { "Conform", "Format" },
  ft = { "lua", "python", "sql", "javascript", "typescript", "json" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      sql = { "sqlformat" },
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
