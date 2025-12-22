-- ==========================
-- Core settings
-- ==========================
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.opt.selectmode = "key"
vim.opt.keymodel = "startsel,stopsel"
vim.opt.selection = "exclusive"

-- Use system clipboard by default
vim.opt.clipboard = "unnamedplus"

-- Copy entire buffer to clipboard
vim.keymap.set('n', 'ya', ':%y+<CR>', { desc = 'Yank all to clipboard' })

-- Yank selection to system clipboard
vim.keymap.set('v', 'y', '"+y', { desc = 'Yank to clipboard' })

-- ==========================
-- macOS-style shift+arrow selection in insert mode
-- ==========================
-- Start selection from insert mode - exit insert, start select, move
vim.keymap.set('i', '<S-Right>', '<C-o>gh<C-o>l', { desc = 'Select right' })
vim.keymap.set('i', '<S-Left>', '<C-o>gh<C-o>h', { desc = 'Select left' })
vim.keymap.set('i', '<S-Down>', '<C-o>gh<C-o>j', { desc = 'Select down' })
vim.keymap.set('i', '<S-Up>', '<C-o>gh<C-o>k', { desc = 'Select up' })

-- Shift+Option+Arrow for word-based selection
vim.keymap.set('i', '<S-M-Right>', '<C-o>gh<C-o>w', { desc = 'Select word right' })
vim.keymap.set('i', '<S-M-Left>', '<C-o>gh<C-o>b', { desc = 'Select word left' })

-- In select mode, extend by word with Shift+Option+Arrow
vim.keymap.set('s', '<S-M-Right>', '<C-o>w', { desc = 'Extend selection word right' })
vim.keymap.set('s', '<S-M-Left>', '<C-o>b', { desc = 'Extend selection word left' })

-- In select mode, arrow keys extend selection (via keymodel)
-- No need to map shift+arrows in select mode - keymodel handles it

-- Backspace in select mode deletes selection and enters insert
vim.keymap.set('s', '<BS>', '<BS>i', { desc = 'Delete selection' })

-- ==========================
-- Manual plugin installation
-- ==========================
local plugin_path = vim.fn.stdpath("data") .. "/site/pack/plugins/start/"

-- Function to clone plugin if it doesn't exist
local function ensure_plugin(url, name)
  local install_path = plugin_path .. name
  if vim.fn.isdirectory(install_path) == 0 then
    print("Installing " .. name .. "...")
    vim.fn.system({ "git", "clone", "--depth=1", url, install_path })
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
ensure_plugin("https://github.com/nvim-lualine/lualine.nvim", "lualine.nvim")

-- Install Treesitter from master branch
local ts_path = plugin_path .. "nvim-treesitter"
if vim.fn.isdirectory(ts_path) == 0 then
  print("Installing nvim-treesitter (master branch)...")
  vim.fn.system({ "git", "clone", "--depth=1", "--branch=master", "https://github.com/nvim-treesitter/nvim-treesitter", ts_path })
  vim.cmd("packloadall!")
end

-- ==========================
-- Gruvbox setup
-- ==========================
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
  contrast = "hard",
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])

-- ==========================
-- Lualine setup
-- ==========================
require('lualine').setup({
  options = {
    theme = 'gruvbox',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})

-- ==========================
-- Diagnostic signs
-- ==========================
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

-- ==========================
-- Autopairs setup
-- ==========================
require("nvim-autopairs").setup({
  check_ts = true,
  ts_config = {
    lua = {'string'},
    javascript = {'template_string'},
  },
  fast_wrap = {},
})

-- ==========================
-- Telescope setup
-- ==========================
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
vim.keymap.set('n', 'ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', 'fg', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', 'fb', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', 'fh', builtin.help_tags, { desc = 'Help tags' })
vim.keymap.set('n', 'fs', builtin.lsp_document_symbols, { desc = 'Document symbols' })
vim.keymap.set('n', 'fr', builtin.lsp_references, { desc = 'LSP references' })

-- ==========================
-- Treesitter setup
-- ==========================
require("nvim-treesitter.configs").setup({
  ensure_installed = { "rust", "c", "cpp", "go", "python" },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
})

-- ==========================
-- LSP setup
-- ==========================
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

-- ==========================
-- Completion setup
-- ==========================
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  }),
})

-- Integrate autopairs with cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
