-- bootstrap plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("config.autocmds")
require("config.keymaps")
require("config.options")

require("lazy").setup("plugins")

-- reference:
-- https://github.com/benlubas/molten-nvim/blob/ebf2bda74e8b903222ad0378ffda57c9afb5cc84/docs/Virtual-Environments.md?plain=1#L50
vim.g.python3_host_prog=vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
