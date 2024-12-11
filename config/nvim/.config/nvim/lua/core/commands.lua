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

-- toggle virtual text diagnostics
vim.api.nvim_create_user_command("ToggleDiagnostics", function()
    local current_config = vim.diagnostic.config()
    local enabled = not current_config.virtual_text
    vim.diagnostic.config({ virtual_text = enabled })

    if enabled then
        print("Diagnostics enabled")
    else
        print("Diagnostics disabled")
    end
end, { nargs = 0 })

-- run remote-sync
vim.api.nvim_create_user_command("RemoteSync", function()
    local output = vim.fn.system("remote-sync")
    local exit_code = vim.v.shell_error

    if exit_code == 0 then
        vim.notify("RemoteSync success." .. output, vim.log.levels.INFO)
    else
        vim.notify("RemoteSync failed with exit code " .. exit_code .. ":\n" .. output, vim.log.levels.ERROR)
    end
end, { nargs = 0 })
