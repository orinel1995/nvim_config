return {
  "nvim-mini/mini.tabline",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("mini.tabline").setup({
      show_icons = false,
      tabpage_section = "right",
    })
  end,
}
