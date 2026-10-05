return {
  "numtostr/fterm.nvim",
  keys = {
    {
      "<leader>z",
      function()
        require("FTerm").toggle()
      end,
      desc = "Toggle terminal",
    },
  },
}
