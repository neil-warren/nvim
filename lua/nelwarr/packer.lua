local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use("wbthomason/packer.nvim")
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.5",
        requires = {
            {"nvim-lua/plenary.nvim"},
            {"BurntSushi/ripgrep"}
        }
    }

    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
    })

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    use({
        "windwp/nvim-ts-autotag",
        config = function()
            require('nvim-ts-autotag').setup()
        end
    })
    use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
    use("ellisonleao/gruvbox.nvim")
    use("sainnhe/gruvbox-material")
    use("folke/tokyonight.nvim")
	use("neovim/nvim-lspconfig")
    use("dstein64/vim-startuptime")
    use("tpope/vim-fugitive")
    use("hsanson/vim-android")
    use("liaohui5/vite-server.nvim")
    use("Civitasv/cmake-tools.nvim")
    use("tweekmonster/django-plus.vim")
    --use("cdelledonne/vim-cmake")
    use{
        "theprimeagen/harpoon",
        branch = "harpoon2",
        requires = {{"nvim-lua/plenary.nvim"}}
    }
    use { 'kikito/inspect.lua', commit="8686162bce74913c4d3a577e7324642ddc4e21c0"}
    use {
        requires = { "nvim-treesitter/nvim-treesitter"},
        "Badhi/nvim-treesitter-cpp-tools",
    }
    use("nvim-lualine/lualine.nvim", {
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
    })

    use { "ggandor/leap.nvim" }

    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'mason-org/mason.nvim'},
            {'mason-org/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-cmdline'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},

            -- Linting
            {'mfussenegger/nvim-lint'},

            -- Autoindent
            {'Vimjas/vim-python-pep8-indent'},
        }
    }


    if packer_bootstrap then
        require('packer').sync()
    end
end)
