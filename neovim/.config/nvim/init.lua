-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

-- stylua: ignore start
require('packer').startup(function(use)
    use { 'AckslD/nvim-neoclip.lua', config = function() require('neoclip').setup() end }
    use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } } -- Snippet engine and snippet expansion
    use { 'Mofiqul/dracula.nvim' } -- Dracula theme
    use { 'RRethy/vim-eunuch' }
    use { 'RRethy/vim-illuminate' }
    use { 'TimUntersberger/neogit', requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' } }
    use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path' } } -- Autocompletion
    use { 'jose-elias-alvarez/null-ls.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Add git related info in the signs columns and popups
    use { 'lukas-reineke/indent-blankline.nvim' } -- Add indentation guides even on blank lines
    use { 'monaqa/dial.nvim' }
    use { 'neovim/nvim-lspconfig' } -- Collection of configurations for built-in LSP client
    use { 'numToStr/Comment.nvim' } -- "gc" to comment visual regions/lines
    use { 'nvim-lualine/lualine.nvim' } -- Fancier statusline
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 } -- Fuzzy finder algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy finder (files, lsp, etc.)
    use { 'nvim-treesitter/nvim-treesitter' } -- Highlight, edit, and navigate code
    use { 'nvim-treesitter/nvim-treesitter-textobjects' } -- Additional textobjects for treesitter
    use { 'onsails/lspkind-nvim' }
    use { 'rcarriga/nvim-notify' }
    use { 'rhysd/committia.vim' }
    use { 'romainl/vim-cool' }
    use { 'romainl/vim-qf' }
    use { 'tpope/vim-sleuth' } -- Detect tabstop and shiftwidth automatically
    use { 'tpope/vim-surround' }
    use { 'wbthomason/packer.nvim' } -- Package manager
    use { 'williamboman/mason-lspconfig.nvim' } -- Automatically install language servers to stdpath
    use { 'williamboman/mason.nvim' } -- Manage external editor tooling i.e LSP servers
    use { 'windwp/nvim-autopairs' }
    use { 'wsdjeg/vim-fetch' }
    use { 'yamatsum/nvim-web-nonicons' }

    if is_bootstrap then
        require('packer').sync()
    end
end)
-- stylua: ignore end

-- When we are bootstrapping a configuration, it doesn't make sense to execute the rest of init.lua.
-- You'll need to restart neovim, and then it will work.
if is_bootstrap then
    print 'Plugins are being installed. Wait until Packer completes, then restart neovim.'
    return
end

-- Automatically source and re-compile packer whenever you save this file
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})

-- [[ Setting options ]]
-- See `:help vim.o`
if vim.fn.has('vim_starting') then
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.foldlevel = 999
end

vim.opt.backup = true
vim.opt.backupdir = vim.fn.expand('~/.local/share/nvim/backup')
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.cpoptions:append('>')
vim.opt.diffopt:append('hiddenoff')
vim.opt.fillchars = 'diff: '
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldmethod = 'expr'
vim.opt.foldnestmax = 4
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --smart-case --vimgrep $*'
vim.opt.ignorecase = true
vim.opt.iskeyword:append('-')
vim.opt.laststatus = 3
vim.opt.lazyredraw = true
vim.opt.modelines = 0
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.pumheight = 10
vim.opt.ruler = false
vim.opt.scrolloff = 8
vim.opt.sessionoptions:remove('folds')
vim.opt.shiftround = true
vim.opt.shortmess:append('Ic')
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.sidescrolloff = 10
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 250
vim.opt.ttimeoutlen = -1
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.whichwrap = '<,>,[,],h,l'
vim.opt.wrap = false

vim.fn.mkdir(vim.fn.stdpath('data') .. '/backup/', 'p')

-- Cursorline highlighting control
-- Only have it on in the active buffer
vim.opt.cursorline = true
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
    vim.api.nvim_create_autocmd(event, {
        group = group,
        pattern = pattern,
        callback = function()
            vim.opt_local.cursorline = value
        end,
    })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- [[ Basic keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '

local init_lua_augroup = 'init_lua_augroup'

local function on_ft(ft, cb)
    vim.api.nvim_create_autocmd('FileType', {
        group = init_lua_augroup,
        pattern = ft,
        callback = cb,
    })
end

vim.api.nvim_create_augroup(init_lua_augroup, { clear = true })
on_ft({ 'c', 'cpp' }, function()
    vim.bo.commentstring = '// %s'
end)

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<c-l>', '<c-w>l')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-h>', '<c-w>h')

vim.keymap.set('i', 'jk', '<esc>')

-- Set colorscheme
require('dracula').setup({
    transparent_bg = true,
    italic_comment = true,
})

vim.cmd [[colorscheme dracula]]

-- Turn off builtin plugins I do not use.
require "oo.disable_builtin"

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank({ timeout = 250 })
    end,
    group = highlight_group,
    pattern = '*',
})

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'dracula-nvim',
        component_separators = '|',
        section_separators = '',
    },
}

local ERROR_ICON = ''
local WARN_ICON  = ''
local INFO_ICON  = ''
local HINT_ICON  = ''
vim.cmd(string.format('sign define DiagnosticSignError text=%s texthl=DiagnosticSignError linehl= numhl=', ERROR_ICON))
vim.cmd(string.format('sign define DiagnosticSignWarn  text=%s texthl=DiagnosticSignWarn  linehl= numhl=', WARN_ICON))
vim.cmd(string.format('sign define DiagnosticSignInfo  text=%s texthl=DiagnosticSignInfo  linehl= numhl=', INFO_ICON))
vim.cmd(string.format('sign define DiagnosticSignHint  text=%s texthl=DiagnosticSignHint  linehl= numhl=', HINT_ICON))

vim.diagnostic.config({
    virtual_text = {
        prefix = '',
        format = function(diagnostic)
            local icon = diagnostic.severity == vim.diagnostic.severity.ERROR and ERROR_ICON
                or diagnostic.severity == vim.diagnostic.severity.WARN and WARN_ICON
                or diagnostic.severity == vim.diagnostic.severity.INFO and INFO_ICON
                or diagnostic.severity == vim.diagnostic.severity.HINT and HINT_ICON
            return string.format("%s %s", icon, diagnostic.message)
        end,
    },
})

-- vim.notify
local notify = require('notify')
vim.keymap.set('n', '<leader>n', notify.dismiss)
notify.setup({
    icons = {
        ERROR = ERROR_ICON,
        WARN = WARN_ICON,
        INFO = INFO_ICON,
        DEBUG = HINT_ICON,
        TRACE = HINT_ICON,
    }
})

-- Enable Comment.nvim
require('Comment').setup()

require('nvim-autopairs').setup({ check_ts = true })

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
    show_current_context = true,
    char = '│',
    indent_blankline_use_treesitter = true,
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
}

-- [[ Configure telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
    defaults = {
        prompt_prefix = " ",
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure treesitter]]
-- See `help: nvim-treesitter`
require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'lua' },

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            -- TODO: I'm not sure about this one.
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- Whether to set jumps in the jumpsplit
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings
-- This function runs when a LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible to define small helper and
    -- utility functions so you don't have to repeat yourself many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific for LSP related items. It
    -- sets the mdoe, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('gr', require('telescope.builtin').lsp_references)
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        if vim.lsp.buf.format then
            vim.lsp.buf.format()
        elseif vim.lsp.buf.formatting then
            vim.lsp.buf.formatting()
        end
    end, { desc = 'Format current buffer with LSP' })
end

-- nvim-cmp supportes additional completion capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Enable the following language servers
local servers = { 'clangd', 'sumneko_lua' }

-- Ensure the servers above are installed
require('mason-lspconfig').setup {
    ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = { library = vim.api.nvim_get_runtime_file('', true) },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false, },
        },
    },
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 5 },
    },
}

require('illuminate')
vim.keymap.set('n', '<a-n>', function()
    require('illuminate').next_reference({ wrap = true })
end)
vim.keymap.set('n', '<a-p>', function()
    require('illuminate').next_reference({ reverse = true, wrap = true })
end)
vim.keymap.set('n', '<a-i>', require('illuminate').toggle_pause)

vim.g.Illuminate_delay = 100
vim.g.Illuminate_ftwhitelist = { 'vim' }
vim.g.qf_disable_statusline = true

require('null-ls').setup({
  sources = {
    require('null-ls').builtins.formatting.stylua,
    require('null-ls').builtins.completion.spell,
  },
})

-- vim: ts=2 sts=2 sw=2 et