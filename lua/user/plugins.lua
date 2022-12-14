local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
)

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use { "ellisonleao/gruvbox.nvim" }
  
  use {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup()
    end,
  }

  use {
	  "nvim-neo-tree/neo-tree.nvim",
	  branch = "v2.x",
	  requires = { 
		  "nvim-lua/plenary.nvim",
		  "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
		  "MunifTanjim/nui.nvim",
	  }
  }

  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
  require("toggleterm").setup()
  end,
  }

  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use("petertriho/nvim-scrollbar")
  use 'simrat39/rust-tools.nvim'
  use 'mfussenegger/nvim-dap'
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
	  require('packer').sync()
  end
end)
