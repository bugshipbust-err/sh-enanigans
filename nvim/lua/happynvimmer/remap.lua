vim.g.mapleader = " "
vim.keymap.set("n", "<leader>d", vim.cmd.Ex)

vim.keymap.set("n", "j", "k", { noremap = true, silent = true })
vim.keymap.set("n", "k", "j", { noremap = true, silent = true })
vim.keymap.set("v", "j", "k", { noremap = true, silent = true })
vim.keymap.set("v", "k", "j", { noremap = true, silent = true })

vim.keymap.set("i", "jk", "<C-c>", { noremap = true, silent = true })
