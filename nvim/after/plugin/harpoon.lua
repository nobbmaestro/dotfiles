local status_ok = pcall(require, "harpoon")
if not status_ok then
	return
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: Add file" })
vim.keymap.set("n", "<leader><leader>", ui.toggle_quick_menu, { desc = "Harpoon: Toggle explorer" })

vim.keymap.set("n", "<C-q>", function() ui.nav_file(1) end, { desc = "Harpoon: Navigate to 1st file" })
vim.keymap.set("n", "<C-w>", function() ui.nav_file(2) end, { desc = "Harpoon: Navigate to 2nd file" })
vim.keymap.set("n", "<C-e>", function() ui.nav_file(3) end, { desc = "Harpoon: Navigate to 3rd file" })

require("harpoon").setup({
    tabline = false,
    menu = {
        width = 80,
        height = 10,
    }
})
