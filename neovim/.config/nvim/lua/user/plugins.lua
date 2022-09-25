-- Automatically install packer.
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })

    print("Installing packer. Close and reopen neovim.")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file.
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile> | PackerCompile",
    group = packer_group,
    pattern = vim.fn.expand("$MYVIMRC"),
})

-- Use a protected call so we don't error out on first use.
local status_ok, packer = pcall(require, "packer")

if not status_ok then
    return
end

-- Have packer use a popup window.
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

-- Install plugins.
return packer.startup(function(use)
    use("Mofiqul/dracula.nvim")
    use("lukas-reineke/indent-blankline.nvim")
    use("neovim/nvim-lspconfig")
    use("numToStr/Comment.nvim")
    use("wbthomason/packer.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("williamboman/mason.nvim")
    use({ "L3MON4D3/LuaSnip", requires = "saadparwaiz1/cmp_luasnip" })
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
        },
    })
    use({ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" })
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    })
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = "nvim-lua/plenary.nvim" })
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = "nvim-treesitter/nvim-treesitter-textobjects",
    })

    -- Automatically set up your configuration after cloning packer.nvim.
    if is_bootstrap then
        require("packer").sync()
    end
end)
