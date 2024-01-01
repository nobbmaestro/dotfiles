return {
    "mbbill/undotree",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree: Toggle tree" })
    end,
}
