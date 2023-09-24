local status_ok = pcall(require, "undotree")
if not status_ok then
	return
end

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undo-tree" })
