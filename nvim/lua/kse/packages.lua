return {
  -- Motion

  { 'smoka7/hop.nvim' },

  'junegunn/vim-easy-align',
  'peterrincker/vim-argumentative',

  -- Syntax
  'nvim-treesitter/nvim-treesitter',
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  },

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
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    }
  },

  { "rafaelsq/nvim-goc.lua" },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-go"
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
                diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
    end,
    keys = {
      {
        "<leader>tf",
        function()
          require("neotest").run.run()
        end,
        desc = "Run the nearest test"
      },
      {
        "<leader>tt",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run latest test"
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run tests the current file"
      },
      --{
      --  "<leader>;d",
      --  function()
      --    require("neotest").run.run({ strategy = "dap" })
      --  end,
      --  desc = "Debug the nearest test (requires nvim-dap and adapter support)"
      --},
      --{
      --  "<leader>tS",
      --  function()
      --    require("neotest").run.stop()
      --  end,
      --  desc = "Stop the nearest test"
      --},
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Summary of tests"
      },
      --{
      --  "<leader>tw",
      --  function()
      --    require("neotest").watch()
      --  end,
      --  desc = "Watch tests"
      --},
      --{
      --  "<leader>to",
      --  function()
      --    require("neotest").output_panel().toggle()
      --  end,
      --  desc = "Output panel"
      --},
    },
  },


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

  { "folke/neodev.nvim",    opts = {} },

  'jpalardy/vim-slime',

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

  {
    'MunifTanjim/prettier.nvim'
  },

  { 'folke/zen-mode.nvim' },

  { 'rebelot/kanagawa.nvim' },

  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    --version = false, -- set this if you want to always pull the latest change

    opts = {
      -- add any opts here
    },

    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",

    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",

      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },

            -- required for Windows users
            --use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
  },
}
