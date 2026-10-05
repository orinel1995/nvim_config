return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    commentstyle = { italic = false },
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    overrides = function(colors)
      return {
        ["@variable"] = { fg = colors.palette.fujiwhite },
        ["@constant"] = { fg = colors.palette.wavered },
        ["@attribute"] = { fg = colors.palette.samuraiblue },
        ["@comment"] = { fg = "#ff9e3b", italic = false },
      }
    end,
  },
  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd.colorscheme("kanagawa")
  end,
}
