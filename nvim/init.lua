-- =======================
-- Core settings
-- ==========================
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 3
vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.termguicolors = true
vim.g.mapleader = " "
vim.opt.selectmode = "mouse,key"
vim.opt.keymodel = "startsel,stopsel"
vim.opt.selection = "inclusive"
vim.opt.mousemodel = "popup_setpos"
vim.o.mouse = "a"
vim.opt.wrap = false

-- ==========================
-- macOS-style keymaps
-- ==========================

-- Use system clipboard by default
vim.opt.clipboard = "unnamedplus"

-- Enable smart line wrapping for left/right arrows
vim.opt.whichwrap = "b,s,<,>,[,]"

-- 1. SELECT ALL (Cmd+A -> <M-a>)
-- Logic: Exit mode -> Go to start -> Visual Select All -> Switch to Select Mode
vim.keymap.set({ 'n', 'i', 'v', 's' }, '<M-a>', '<Esc>ggVG<C-g>', { desc = 'Select All' })

-- 2. COPY (Cmd+C -> <M-c>)
-- Logic: 
-- In Visual: Yank to + register
-- In Select: Switch to Visual (<C-g>), then Yank
vim.keymap.set('v', '<M-c>', '"+y', { desc = 'Copy' })
vim.keymap.set('s', '<M-c>', '<C-g>"+y', { desc = 'Copy' })

-- 3. CUT (Cmd+X -> <M-x>)
-- Logic:
-- In Visual: Cut to + register
-- In Select: Switch to Visual (<C-g>), then Cut
vim.keymap.set('v', '<M-x>', '"+x', { desc = 'Cut' })
vim.keymap.set('s', '<M-x>', '<C-g>"+x', { desc = 'Cut' })

-- 4. PASTE (Cmd+V -> <M-v>)
-- Logic:
-- Insert Mode: Paste from + register using <C-r>
vim.keymap.set('i', '<M-v>', '<C-r>+', { desc = 'Paste' })
-- Normal Mode: Paste from + register
vim.keymap.set('n', '<M-v>', '"+p', { desc = 'Paste' })
-- Visual Mode: Paste over selection
vim.keymap.set('v', '<M-v>', '"+p', { desc = 'Paste' })
-- Select Mode: Switch to Visual (<C-g>), then Paste
vim.keymap.set('s', '<M-v>', '<C-g>"+p', { desc = 'Paste' })

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

-- Option+Arrow for word navigation
-- Insert mode: use <C-o> to execute normal mode command
vim.keymap.set('i', '<M-Right>', '<C-o>w', { desc = 'Move forward one word' })
vim.keymap.set('i', '<M-Left>', '<C-o>b', { desc = 'Move backward one word' })

-- Normal mode: just use the motions directly
vim.keymap.set('n', '<M-Right>', 'w', { desc = 'Move forward one word' })
vim.keymap.set('n', '<M-Left>', 'b', { desc = 'Move backward one word' })

-- Visual/Select mode: use <C-o> to execute without leaving mode
vim.keymap.set('v', '<M-Right>', '<C-o>w', { desc = 'Move forward one word' })
vim.keymap.set('v', '<M-Left>', '<C-o>b', { desc = 'Move backward one word' })
vim.keymap.set('s', '<M-Right>', '<C-o>w', { desc = 'Move forward one word' })
vim.keymap.set('s', '<M-Left>', '<C-o>b', { desc = 'Move backward one word' })

-- Option+Delete to delete word backward (in insert mode)
vim.keymap.set('i', '<M-BS>', '<C-w>', { desc = 'Delete word backward' })

-- In select mode, arrow keys extend selection (via keymodel)
-- No need to map shift+arrows in select mode - keymodel handles it

-- Backspace in select mode deletes selection and enters insert
vim.keymap.set('s', '<BS>', '<BS>i', { desc = 'Delete selection' })

-- Cmd+Left/Right: Start/End of line
vim.keymap.set('i', '<M-l>', '<C-o>0', { desc = 'Go to start of line' })
vim.keymap.set('n', '<M-l>', '0', { desc = 'Go to start of line' })
vim.keymap.set('v', '<M-l>', '0', { desc = 'Go to start of line' })
vim.keymap.set('s', '<M-l>', '<C-o>0', { desc = 'Go to start of line' })

vim.keymap.set('i', '<M-r>', '<C-o>$', { desc = 'Go to end of line' })
vim.keymap.set('n', '<M-r>', '$', { desc = 'Go to end of line' })
vim.keymap.set('v', '<M-r>', '$', { desc = 'Go to end of line' })
vim.keymap.set('s', '<M-r>', '<C-o>$', { desc = 'Go to end of line' })

-- Cmd+Up/Down: Start/End of buffer
vim.keymap.set('i', '<M-u>', '<C-o>gg', { desc = 'Go to start of buffer' })
vim.keymap.set('n', '<M-u>', 'gg', { desc = 'Go to start of buffer' })
vim.keymap.set('v', '<M-u>', 'gg', { desc = 'Go to start of buffer' })
vim.keymap.set('s', '<M-u>', '<C-o>gg', { desc = 'Go to start of buffer' })

vim.keymap.set('i', '<M-d>', '<C-o>G', { desc = 'Go to end of buffer' })
vim.keymap.set('n', '<M-d>', 'G', { desc = 'Go to end of buffer' })
vim.keymap.set('v', '<M-d>', 'G', { desc = 'Go to end of buffer' })
vim.keymap.set('s', '<M-d>', '<C-o>G', { desc = 'Go to end of buffer' })

-- Cmd+Shift+Left/Right: Select to start/end of line
vim.keymap.set('i', '<M-L>', '<C-o>gh<C-o>0', { desc = 'Select to start of line' })
vim.keymap.set('n', '<M-L>', 'v0', { desc = 'Select to start of line' })
vim.keymap.set('s', '<M-L>', '<C-o>0', { desc = 'Extend selection to start of line' })

vim.keymap.set('i', '<M-R>', '<C-o>gh<C-o>$', { desc = 'Select to end of line' })
vim.keymap.set('n', '<M-R>', 'v$', { desc = 'Select to end of line' })
vim.keymap.set('s', '<M-R>', '<C-o>$', { desc = 'Extend selection to end of line' })

-- Cmd+Shift+Up/Down: Select to start/end of buffer
vim.keymap.set('i', '<M-U>', '<C-o>gh<C-o>gg', { desc = 'Select to start of buffer' })
vim.keymap.set('n', '<M-U>', 'vgg', { desc = 'Select to start of buffer' })
vim.keymap.set('s', '<M-U>', '<C-o>gg', { desc = 'Extend selection to start of buffer' })

vim.keymap.set('i', '<M-D>', '<C-o>gh<C-o>G', { desc = 'Select to end of buffer' })
vim.keymap.set('n', '<M-D>', 'vG', { desc = 'Select to end of buffer' })
vim.keymap.set('s', '<M-D>', '<C-o>G', { desc = 'Extend selection to end of buffer' })

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

-- Install plugins from default branches
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
ensure_plugin("https://github.com/nvim-tree/nvim-web-devicons", "nvim-web-devicons")
ensure_plugin("https://github.com/MunifTanjim/nui.nvim", "nui.nvim")
ensure_plugin("https://github.com/lewis6991/gitsigns.nvim", "gitsigns")

-- Install neo-tree from v3.x branch
local neotree_path = plugin_path .. "neo-tree.nvim"
if vim.fn.isdirectory(neotree_path) == 0 then
  print("Installing neo-tree.nvim (v3.x branch)...")
  vim.fn.system({ "git", "clone", "--depth=1", "--branch=v3.x", "https://github.com/nvim-neo-tree/neo-tree.nvim", neotree_path })
  vim.cmd("packloadall!")
end

-- Install Treesitter from master branch
local ts_path = plugin_path .. "nvim-treesitter"
if vim.fn.isdirectory(ts_path) == 0 then
  print("Installing nvim-treesitter (master branch)...")
  vim.fn.system({ "git", "clone", "--depth=1", "--branch=master", "https://github.com/nvim-treesitter/nvim-treesitter", ts_path })
  vim.cmd("packloadall!")
end

-- ==========================
-- Neo-tree setup
-- ==========================
require("nvim-web-devicons").setup({
  default = true,
})

require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "",
    },
  },
  filesystem = {
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
  },
  window = {
    position = "left",
    width = 30,
  },
})

-- Neo-tree keymap
vim.keymap.set('n', '<leader>ft', ':Neotree toggle<CR>', { desc = 'Toggle Neo-tree', silent = true })

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
    theme = 'gruvbox_dark',
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
         [vim.diagnostic.severity.ERROR] = " ",
         [vim.diagnostic.severity.WARN] = " ",
         [vim.diagnostic.severity.HINT] = " ",
         [vim.diagnostic.severity.INFO] = " ",
      },
   },
   virtual_text = {
      prefix = " ",
   },
   update_in_insert = true, -- Update diagnostics while typing
   underline = true,
   severity_sort = true, -- Errors take precedence over warnings
   float = {
      border = "rounded", -- Rounded borders for floating windows
      source = "always",
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

vim.keymap.set("n", "ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "ag", builtin.live_grep, { desc = "Grep all files" })
vim.keymap.set("n", "fb", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
vim.keymap.set("n", "fr", builtin.lsp_references, { desc = "LSP references" })

vim.keymap.set("n", "fg", builtin.current_buffer_fuzzy_find, {
  desc = "Grep on current buffer",
})

-- ==========================
-- Treesitter setup
-- ==========================
require("nvim-treesitter.configs").setup({
  ensure_installed = { "rust", "c", "cpp", "go", "python" },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
})

require('gitsigns').setup {
     signs = {
       add          = { text = '┃' },
       change       = { text = '┃' },
       delete       = { text = '_' },
       topdelete    = { text = '‾' },
       changedelete = { text = '~' },
       untracked    = { text = '┆' },
     },
     signs_staged = {
       add          = { text = '┃' },
       change       = { text = '┃' },
       delete       = { text = '_' },
       topdelete    = { text = '‾' },
       changedelete = { text = '~' },
       untracked    = { text = '┆' },
     },
     signs_staged_enable = true,
     signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
     numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
     linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
     word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
     watch_gitdir = {
       follow_files = true
        },
     auto_attach = true,
     attach_to_untracked = false,
     current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
     current_line_blame_opts = {
       virt_text = true,
       virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
       delay = 1000,
       ignore_whitespace = false,
       virt_text_priority = 100,
       use_focus = true,
     },
     current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
     sign_priority = 6,
     update_debounce = 100,
     status_formatter = nil, -- Use default
     max_file_length = 40000, -- Disable if file is longer than this (in lines)
     preview_config = {
      -- Options passed to nvim_open_win
         style = 'minimal',
         relative = 'cursor',
         row = 0,
         col = 1
   },
}

-- ==========================
-- LSP setup
-- ==========================
require("mason").setup()

-- Capabilities for nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Mason ↔ LSP bridge
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "rust_analyzer",
    "gopls",
    "pyright",
  },

  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
      })
    end,
  },
})

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


--[[

    Notes / non-nvim configs:

    - A nerd font is needed for icons, JetBrains Mono nerd font (light) is what I'm using by default
    
    - Allow application keypad mode in iterm2
    - Allow GPU rendering even when disconnected from power in iterm2
    
    - iterm2 hex code sequences to make copy/cut/paste work (settings -> profiles -> keys -> key bindings)
      cmd+a -> 0x1b 0x61
      cmd+c -> 0x1b 0x63
      cmd+v -> 0x1b 0x76
      cmd+x -> 0x1b 0x78

   - iterm2 hex code sequences to make cmd+[arrow] jumping/selection work
      Cmd+Left: 0x1b 0x6c (Esc + l for "left")
      Cmd+Right: 0x1b 0x72 (Esc + r for "right")
      Cmd+Up: 0x1b 0x75 (Esc + u for "up")
      Cmd+Down: 0x1b 0x64 (Esc + d for "down")
      Cmd+Shift+Left: 0x1b 0x4c (Esc + L)
      Cmd+Shift+Right: 0x1b 0x52 (Esc + R)
      Cmd+Shift+Up: 0x1b 0x55 (Esc + U)
      Cmd+Shift+Down: 0x1b 0x44 (Esc + D)

--]]
