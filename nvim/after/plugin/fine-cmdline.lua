local status_ok, plugin = pcall(require, "fine-cmdline")
if not status_ok then
    return
end

vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })

local setup = {
    cmdline = {
        enable_keymaps = true,
        smart_history = true,
        prompt = "> ",
    },
    popup = {
        position = {
            row = "10%",
            col = "50%",
        },
        size = {
            width = "50%",
        },
        border = {
            style = "rounded",
        },
        win_options = {
            winhighlight = "Normal:Title,FloatBorder:FloatBorder",
        },
    },
}

plugin.setup(setup)
