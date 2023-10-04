local status_ok = pcall(require, "harpoon")
if not status_ok then
	return
end

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: Add file" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: Toggle explorer" })

-- vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end, { desc = "Harpoon: Navigate to 1st file" })
-- vim.keymap.set("n", "<C-h>", function() ui.nav_file(2) end, { desc = "Harpoon: Navigate to 2nd file" })
-- vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = "Harpoon: Navigate to 3rd file" })
-- vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = "Harpoon: Navigate to 4th file" })
vim.keymap.set("n", "<Tab>", function() ui.nav_next() end, { desc = "Harpoon: Navigate to next mark" })
vim.keymap.set("n", "<S-Tab>", function() ui.nav_prev() end, { desc = "Harpoon: Navigate to previous mark" })

require("harpoon").setup({
    tabline = false,
    menu = {
        width = 80,
        height = 10,
    }
})
