vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- nvim-telescope
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.8',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- tree-sitter
  use {
	  "nvim-treesitter/nvim-treesitter",
	  run = ":TSUpdate"
  }
  use {
	  "nvim-treesitter/playground"
  }
  use { "ellisonleao/gruvbox.nvim" }
end)

