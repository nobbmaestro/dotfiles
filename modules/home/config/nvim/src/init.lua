require("config.autocmds")
require("config.commands")
require("config.keymaps")
require("config.options")
require("core.lazy")
require("core.lsp")

-- reference:
-- https://github.com/benlubas/molten-nvim/blob/ebf2bda74e8b903222ad0378ffda57c9afb5cc84/docs/Virtual-Environments.md?plain=1#L50
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
