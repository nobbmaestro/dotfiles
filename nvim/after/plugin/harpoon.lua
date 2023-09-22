local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: Add file" })
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: Toggle explorer" })

vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end, { desc = "Harpoon: Navigate to 1st file" })
vim.keymap.set("n", "<C-h>", function() ui.nav_file(2) end, { desc = "Harpoon: Navigate to 2nd file" })
vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = "Harpoon: Navigate to 3rd file" })
vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = "Harpoon: Navigate to 4th file" })
