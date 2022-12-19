vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim"

  -- performance
  use "lewis6991/impatient.nvim"
  use "dstein64/vim-startuptime"
  use "nathom/filetype.nvim"

  -- lsp
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "glepnir/lspsaga.nvim",
    "b0o/SchemaStore.nvim",
    "neovim/nvim-lspconfig",
    { "folke/lua-dev.nvim", commit = "8f94b49b982ec4e7644f1e5004ec33c98903d32a" }
  }

  -- snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- completions
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-calc"
  use "onsails/lspkind.nvim"
  use "ray-x/cmp-treesitter"
  use "saadparwaiz1/cmp_luasnip"

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', commit = 'ba752cee137986882e4f0faa0cc81e810ab28371' }
  use { 'nvim-treesitter/nvim-treesitter-refactor', commit = '75f5895cc662d61eb919da8050b7a0124400d589' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', commit = 'e63c2ff8e38fad77299dd74e14c7c9360e1b3181' }
  use { 'nvim-treesitter/nvim-treesitter-context', commit = '3148205c72a535af0493fec7c90a12344ac2f90d' }
  use { 'nvim-treesitter/playground', commit = 'bcfab84f98a33f2ad34dda6c842046dca70aabf6' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', commit = '4d3a68c41a53add8804f471fcc49bb398fe8de08' }
  use { 'windwp/nvim-ts-autotag', commit = 'fdefe46c6807441460f11f11a167a2baf8e4534b' }
  use { 'p00f/nvim-ts-rainbow', commit = 'fad8badcd9baa4deb2cf2a5376ab412a1ba41797' }

  -- status
  use "nvim-lualine/lualine.nvim"

  -- telescope
  use "nvim-telescope/telescope.nvim"
  use "lewis6991/gitsigns.nvim"
  use "SmiteshP/nvim-navic"

  -- formatter
  use "jose-elias-alvarez/null-ls.nvim"

  -- utility
  use "junegunn/vim-easy-align"
  use "windwp/nvim-autopairs"
  use "numToStr/Comment.nvim"
  use "moll/vim-bbye"
  use "mbbill/undotree"

  -- motion
  use "tpope/vim-surround"
  use "tpope/vim-repeat"
  use "tpope/vim-sleuth"

  -- colorscheme
  use { 'AlphaTechnolog/pywal.nvim', as = 'pywal' }
  use "shaunsingh/nord.nvim"
end)
