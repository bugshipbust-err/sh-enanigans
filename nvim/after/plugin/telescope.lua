local builtin = require('telescope.builtin')
local utils = require("telescope.utils")


-- searching at different depths
vim.keymap.set('n', '<leader>f1', function()
    local parent_dir = vim.fn.fnamemodify(utils.buffer_dir(), ":h:h")
    builtin.find_files({ cwd = parent_dir })
end, { desc = "Telescope: find files in current working directory" })

vim.keymap.set('n', '<leader>f2', function()
    local parent_dir = vim.fn.fnamemodify(utils.buffer_dir(), ":h:h:h")
    builtin.find_files({ cwd = parent_dir })
end, { desc = "Telescope: find files in current working directory" })

vim.keymap.set('n', '<leader>ff', function()
    local parent_dir = vim.fn.fnamemodify(utils.buffer_dir(), ":h:h:h:h")
    builtin.find_files({ cwd = parent_dir })
end, { desc = "Telescope: find files in current working directory" })


-- search entire file system
vim.keymap.set('n', '<leader>fa', builtin.find_files, { desc = "Telescope: find files in home directory" })


-- search using grep string
vim.keymap.set('n', '<leader>gf', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Telescope: grep string in cwd" })
