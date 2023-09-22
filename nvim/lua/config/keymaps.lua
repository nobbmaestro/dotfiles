vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open project explorer" })

-- allow movement of multiple lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down the selected text" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up the selected text" })

-- keep courser on start of the line on movement
vim.keymap.set("n", "J", "mzJ`z")

-- keep courser in the middle while jumping up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up" })

-- keep search term in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- replace highlighted with current yank preserved
vim.keymap.set("x", "<leader>p", '"_dP')

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank selected to the system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to the system clipboard" })

-- multiline replace on highlighted
vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Multiline string replace on highlighted" }
)

-- other
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open tmux-sessionizer" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format" })
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end, { desc = "Source file" })
