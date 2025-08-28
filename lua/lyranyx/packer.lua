-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
   -- Quality of Life

   -- Packer can manage itself
   use 'wbthomason/packer.nvim'

   use {
      'nvim-telescope/telescope.nvim', tag = '0.1.8',
      -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
   }
   
   -- Color Themes
   use "EdenEast/nightfox.nvim"

   require("nightfox").setup({
      options = {
         transparent = false
      }
   })

   vim.cmd("colorscheme carbonfox")

   use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
   }
   use 'nvim-treesitter/playground'
   use "nvim-lua/plenary.nvim" -- don't forget to add this 
                              -- one if you don't have it yet!
   --Commenting out harpoon it's breaking shit
   use {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      requires = { {"nvim-lua/plenary.nvim"} }
   }
   use ('mbbill/undotree') --literally let's you do an undo tree
   use ('tpope/vim-fugitive') -- greatest git interface for neovim

   -- LSP Stuff
   use { 'neovim/nvim-lspconfig' }
   use { 'hrsh7th/nvim-cmp' }
   use { 'hrsh7th/cmp-nvim-lsp' }
   use { 'L3MON4D3/LuaSnip' }
   use { 'saadparwaiz1/cmp_luasnip' }
   use { 'williamboman/mason.nvim' }
   use { 'williamboman/mason-lspconfig.nvim' }

   require('mason').setup()
   require('mason-lspconfig').setup({
      automatic_installation = true,
      automatic_enable = true
   })
   require('luasnip.loaders.from_vscode').lazy_load()
   
   -- Code Snippets
   local cmp = require('cmp')
   cmp.setup({
      snippet = {
	    expand = function(args)
	      require('luasnip').lsp_expand(args.body)
	    end
	  },

	  mapping = { 
	    ['<Tab>'] = cmp.mapping.select_next_item(),
	    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
	    ['<CR>'] = cmp.mapping.confirm({select = false}),
	  },

	  sources = {
	    { name = 'nvim_lsp' },
	    { name = 'luasnip' },
	    { name = 'buffer' },
	  }
	})

   -- Oil a file navigator
   use("stevearc/oil.nvim")
   
end)
