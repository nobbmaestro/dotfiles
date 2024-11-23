-- run lazygit
vim.api.nvim_create_user_command("LazyGit", function()
    os.execute("tmux-toggle-lazygit")
end, { nargs = 0 })

-- run lazygit and focus git log
vim.api.nvim_create_user_command("LazyGitLog", function()
    os.execute("tmux-toggle-lazygit" .. " " .. "-lf")
end, { nargs = 0 })

-- run lazygit and focus git log for current buffer
vim.api.nvim_create_user_command("LazyGitFilter", function()
    local buff = vim.api.nvim_buf_get_name(0)
    os.execute("tmux-toggle-lazygit" .. " " .. "-lf" .. " " .. buff)
end, { nargs = 0 })
