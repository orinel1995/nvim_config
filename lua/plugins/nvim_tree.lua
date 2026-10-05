return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<Cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
  },
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    view = {
      side = "left",
      width = 30,
      preserve_window_proportions = true,
    },
    renderer = {
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          git = {
            unstaged = "M",
            staged = "S",
            unmerged = "!",
            renamed = "R",
            untracked = "U",
            deleted = "D",
            ignored = "I",
          },
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_root = false,
    },
  actions = {
      open_file = {
        quit_on_open = false,
        resize_window = true,
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    local group = vim.api.nvim_create_augroup("close_nvim_tree_on_exit", { clear = true })
    vim.api.nvim_create_autocmd("QuitPre", {
      group = group,
      callback = function()
        local api = require("nvim-tree.api")
        if api.tree.is_visible() then
          pcall(api.tree.close)
        end
      end,
    })
  end,
}
