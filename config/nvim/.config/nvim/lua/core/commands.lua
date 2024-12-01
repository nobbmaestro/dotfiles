-- run lazygit
vim.api.nvim_create_user_command("LazyGit", function()
    os.execute("topen -- lazygit")
end, { nargs = 0 })

-- run lazygit and focus git log
vim.api.nvim_create_user_command("LazyGitLog", function()
    os.execute("topen --force -- lazygit log")
end, { nargs = 0 })

-- run lazygit and focus git log for current buffer
vim.api.nvim_create_user_command("LazyGitFilter", function()
    local buff = vim.api.nvim_buf_get_name(0)
    os.execute("topen --force -- lazygit --filter " .. buff)
end, { nargs = 0 })
