-- Automatically install packer.
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
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
vim.cmd([[
augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

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
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("rafamadriz/friendly-snippets")
    use("wbthomason/packer.nvim")
    use({ "L3MON4D3/LuaSnip", requires = { "saadparwaiz1/cmp_luasnip" } })
    use({ "hrsh7th/nvim-cmp", requires = { "hrsh7th/cmp-buffer" }, { "hrsh7th/cmp-cmdline" }, { "hrsh7th/cmp-path" } })

    -- Automatically set up your configuration after cloning packer.nvim.
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)