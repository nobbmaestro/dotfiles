local function get_commit_hash_at_cursor()
    local buffer = vim.api.nvim_buf_get_name(0)
    local linenr = vim.api.nvim_win_get_cursor(0)[1]

    local hash = vim.fn
        .systemlist({
            "git",
            "blame",
            "-L",
            string.format("%d,%d", linenr, linenr),
            "--line-porcelain",
            buffer,
        })[1]
        :match("^(%S+)")

    if hash:match("^0+$") then
        return nil
    end

    return hash
end

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

-- run lazygit and focus git log for commit hash at cursor
vim.api.nvim_create_user_command("LazyGitHashFilter", function()
    local buff = vim.api.nvim_buf_get_name(0)
    local hash = get_commit_hash_at_cursor()
    if hash ~= nil then
        vim.fn.system({ "topen", "--force", "--keys", "/", hash, "ENTER", "ENTER", "--", "lazygit", "--filter", buff })
    else
        vim.notify("LazyGitHashFilter failed: No commit hash at cursor", vim.log.levels.ERROR)
    end
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

-- run rsyncer
vim.api.nvim_create_user_command("RemoteSync", function()
    local output = vim.fn.system("rsyncer")
    local exit_code = vim.v.shell_error

    if exit_code == 0 then
        vim.notify("RemoteSync success" .. output, vim.log.levels.INFO)
    else
        vim.notify("RemoteSync failed with exit code " .. exit_code .. ":\n" .. output, vim.log.levels.ERROR)
    end
end, { nargs = 0 })
