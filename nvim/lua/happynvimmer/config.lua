-- GENERAL --
vim.opt.compatible = false              -- lets vim use all of its features
vim.cmd("syntax on")                    -- syntax highlighting based on filetype

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.showcmd = true                  -- show commands (eg: d3b)
vim.opt.wildmenu = true
vim.opt.encoding = "utf-8"
vim.opt.clipboard = "unnamedplus"       -- uses sytem clipboard

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.showmode = true
vim.opt.showmatch = true
vim.opt.hlsearch = false                -- search hilighting
vim.opt.background = "dark"


-- FILE MANAGEMENT --

vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  command = "checktime",
})                                      -- auto reload file if changed outside neovim


-- TERMINAL --

local function open_iterm()
  vim.cmd("botright terminal")
  vim.cmd("resize 15")
end

vim.api.nvim_create_user_command("Iterm", open_iterm, {})
