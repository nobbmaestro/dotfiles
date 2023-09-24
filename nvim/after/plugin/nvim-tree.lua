local status_ok, plugin = pcall(require, "nvim-tree")
if not status_ok then
    return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netwnPlugin = 1

local setup = {
    view = {
        width = 50,
    },
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
}

vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>", { desc = "Open project explorer" })

plugin.setup(setup)
