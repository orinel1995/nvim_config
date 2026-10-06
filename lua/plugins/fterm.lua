return {
  "numtostr/fterm.nvim",
  cmd = "CodexToggle",
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
    { "<leader>ac", "<Cmd>CodexToggle<CR>", desc = "Toggle Codex" },
  },
  config = function(_, opts)
    local FTerm = require("FTerm")
    FTerm.setup(opts)

    local candidates = vim.fn.has("win32") == 1 and { "codex.cmd", "codex.exe", "codex" } or { "codex" }
    local function codex_path()
      for _, candidate in ipairs(candidates) do
        local path = vim.fn.exepath(candidate)
        if path ~= "" then
          return path
        end
      end
    end

    local codex = FTerm:new({
      ft = "fterm_codex",
      cmd = function()
        return { codex_path() or candidates[1] }
      end,
      border = "rounded",
      dimensions = { height = 0.9, width = 0.9 },
    })

    local function toggle_codex()
      if not codex_path() then
        vim.notify("Codex CLI is not installed or not in PATH", vim.log.levels.ERROR)
        return
      end
      codex:toggle()
    end

    pcall(vim.api.nvim_del_user_command, "CodexToggle")
    vim.api.nvim_create_user_command("CodexToggle", toggle_codex, {})

    local group = vim.api.nvim_create_augroup("fterm_codex_keymaps", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "fterm_codex",
      callback = function(event)
        vim.keymap.set("t", "<leader>ac", toggle_codex, {
          buffer = event.buf,
          desc = "Hide Codex",
        })
      end,
    })
  end,
}
