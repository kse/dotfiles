return {
  -- Motion

  {
    'smoka7/hop.nvim',
  },

  --'easymotion/vim-easymotion',
  'junegunn/vim-easy-align',
  'peterrincker/vim-argumentative',

  -- Syntax
  'nvim-treesitter/nvim-treesitter',
  'mechatroner/rainbow_csv',
  'majutsushi/tagbar',

  -- LSP Setup

  --- Uncomment these if you want to manage LSP servers from neovim
  -- {'williamboman/mason.nvim'},
  -- {'williamboman/mason-lspconfig.nvim'},

  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },

  -- Go
  { "rcarriga/nvim-dap-ui",      dependencies = { "mfussenegger/nvim-dap" } },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap",
    },
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  -- Oh Tim...
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  'tpope/vim-commentary',
  'tpope/vim-repeat',
  'tpope/vim-unimpaired',
  'tpope/vim-abolish',

  'folke/todo-comments.nvim',
  'folke/lazy.nvim',

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = {
      { 'nvim-lua/plenary.nvim' }
    }
  },

  {
    -- Render Markdown documents in a separate browser window on the fly.
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast'
    -- TODO: Only load in certain files
  },

  {
    'sainnhe/gruvbox-material'
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', lazy = true
    }
  },

  {
    'lewis6991/gitsigns.nvim',
    --config = function()
    --  require('gitsigns').setup()
    --end
  },

  {
    'mrjones2014/legendary.nvim',
    -- sqlite is only needed if you want to use frequency sorting
    dependencies = { 'kkharji/sqlite.lua' }
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons', lazy = true,
    },
  },

  {
    'nvim-tree/nvim-tree.lua'
  },
}
