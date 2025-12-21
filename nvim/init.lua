-- =========================
-- Core settings
-- =========================
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.g.mapleader = " "

-- "MacOS native" keymaps
-- Option + Left/Right to move by word (stay in insert mode)
vim.keymap.set('i', '<M-Left>', '<C-o>b', { noremap = true })
vim.keymap.set('i', '<M-Right>', '<C-o>w', { noremap = true })

-- In normal/visual mode, just move by word
vim.keymap.set({'n', 'v'}, '<M-Left>', 'b', { noremap = true })
vim.keymap.set({'n', 'v'}, '<M-Right>', 'w', { noremap = true })

-- Option + Delete to delete word backward
vim.keymap.set('i', '<M-BS>', '<C-w>', { noremap = true })

-- Shift + Option + Arrow keys to select by word (enter select mode)
vim.keymap.set('i', '<M-S-Left>', '<C-o>vb<C-g>', { noremap = true })
vim.keymap.set('i', '<M-S-Right>', '<C-o>ve<C-g>', { noremap = true })

-- Shift + Arrow keys to select character by character (enter select mode)
vim.keymap.set('i', '<S-Left>', '<C-o>v<Left><C-g>', { noremap = true })
vim.keymap.set('i', '<S-Right>', '<C-o>v<C-g>', { noremap = true })
vim.keymap.set('i', '<S-Up>', '<C-o>v<Up><C-g>', { noremap = true })
vim.keymap.set('i', '<S-Down>', '<C-o>v<Down><C-g>', { noremap = true })

-- Extend selection by word in select mode
vim.keymap.set('s', '<M-S-Left>', '<C-o>b', { noremap = true })
vim.keymap.set('s', '<M-S-Right>', '<C-o>e', { noremap = true })


-- =========================
-- Manual plugin installation
-- =========================
local plugin_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start/"

-- Function to clone plugin if it doesn't exist
local function ensure_plugin(url, name)
    local install_path = plugin_path .. name
    if vim.fn.isdirectory(install_path) == 0 then
        print("Installing " .. name .. "...")
        vim.fn.system({
            "git", "clone", "--depth=1",
            url,
            install_path
        })
        vim.cmd("packloadall!")
    end
end

-- Install plugins
ensure_plugin("https://github.com/ellisonleao/gruvbox.nvim", "gruvbox.nvim")
ensure_plugin("https://github.com/neovim/nvim-lspconfig", "nvim-lspconfig")
ensure_plugin("https://github.com/williamboman/mason.nvim", "mason.nvim")
ensure_plugin("https://github.com/williamboman/mason-lspconfig.nvim", "mason-lspconfig.nvim")
ensure_plugin("https://github.com/hrsh7th/nvim-cmp", "nvim-cmp")
ensure_plugin("https://github.com/hrsh7th/cmp-nvim-lsp", "cmp-nvim-lsp")
ensure_plugin("https://github.com/hrsh7th/cmp-buffer", "cmp-buffer")
ensure_plugin("https://github.com/nvim-lua/plenary.nvim", "plenary.nvim")
ensure_plugin("https://github.com/nvim-telescope/telescope.nvim", "telescope.nvim")
ensure_plugin("https://github.com/windwp/nvim-autopairs", "nvim-autopairs")

-- Install Treesitter from master branch
local ts_path = plugin_path .. "nvim-treesitter"
if vim.fn.isdirectory(ts_path) == 0 then
    print("Installing nvim-treesitter (master branch)...")
    vim.fn.system({
        "git", "clone", "--depth=1",
        "--branch=master",
        "https://github.com/nvim-treesitter/nvim-treesitter",
        ts_path
    })
    vim.cmd("packloadall!")
end

-- =========================
-- Gruvbox setup
-- =========================
require("gruvbox").setup({
    terminal_colors = true,
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    inverse = true,
    contrast = "", -- "hard", "soft" or "" (normal)
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- Fix diagnostic signs to be less intrusive
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.WARN] = "●",
            [vim.diagnostic.severity.HINT] = "●",
            [vim.diagnostic.severity.INFO] = "●",
        }
    },
    virtual_text = {
        prefix = "●",
    },
})

-- Fix statusline colors for better readability
vim.api.nvim_set_hl(0, "StatusLine", { fg = "White", bg = "DarkGray", bold = true })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "Gray", bg = "Black" })

-- =========================
-- Autopairs setup
-- =========================
require("nvim-autopairs").setup({
    check_ts = true, -- use treesitter
    ts_config = {
        lua = {'string'}, -- don't add pairs in lua string treesitter nodes
        javascript = {'template_string'},
    },
    fast_wrap = {}, -- enable fast wrap with Alt+e
})

-- =========================
-- Telescope setup
-- =========================
local telescope = require("telescope")
telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous",
            },
        },
    },
})

-- Telescope keymaps
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Document symbols' })
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'LSP references' })

-- =========================
-- Treesitter setup
-- =========================
require("nvim-treesitter.configs").setup({
    ensure_installed = { "rust", "c", "cpp", "go", "python" },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = { enable = true },
})

-- =========================
-- LSP setup
-- =========================
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "rust_analyzer", "gopls", "pyright" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local servers = { "clangd", "rust_analyzer", "gopls", "pyright" }

for _, name in ipairs(servers) do
    require("lspconfig")[name].setup({
        capabilities = capabilities
    })
end

-- =========================
-- Completion setup
-- =========================
local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
    }, {
        { name = "buffer" },
    }),
})

-- Integrate autopairs with cmp (moved from autopairs section to avoid double require)
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
