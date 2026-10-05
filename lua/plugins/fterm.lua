return {
  "numtostr/fterm.nvim",
  opts = function()
    local bash = vim.fn.exepath("bash.exe")
    if bash == "" then
      bash = vim.o.shell
    end

    return {
      cmd = { bash },
    }
  end,
  keys = {
    {
      "<C-t>",
      function()
        require("FTerm").toggle()
      end,
      mode = { "n", "t" },
      desc = "Toggle terminal",
    },
  },
}
