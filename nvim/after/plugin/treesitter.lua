require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "json", "c", "lua", "vim", "vimdoc", "query", "markdown" },
  sync_install = false,
  auto_install = true,  -- <- eurned off until parsers install successfully

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
