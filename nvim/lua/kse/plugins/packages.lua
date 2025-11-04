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

  -- { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
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

  'jpalardy/vim-slime',

  -- {
  --   'nvim-telescope/telescope.nvim',
  --   tag = '0.1.4',
  --   dependencies = {
  --     { 'nvim-lua/plenary.nvim' }
  --   }
  -- },

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

  { 'rebelot/kanagawa.nvim' },

  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      -- provider = "openai",
      -- providers = {
      --   openai = {
      --     endpoint = "https://api.openai.com/v1",
      --     model = "gpt-4o",               -- your desired model (or use gpt-4o, etc.)
      --     extra_request_body = {
      --       timeout = 30000,              -- Timeout in milliseconds, increase this for reasoning models
      --       temperature = 0.75,
      --       max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --       --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      --     },
      --   },
      -- },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick",       -- for file_selector provider mini.pick
      -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
      "folke/snacks.nvim",           -- for input provider snacks
      "ibhagwan/fzf-lua",            -- for file_selector provider fzf
      "stevearc/dressing.nvim",      -- for input provider dressing
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",      -- for providers='copilot'
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
            use_absolute_path = true,
          },
        },
      },
      -- {
      --   -- Make sure to set this up properly if you have lazy=true
      --   'MeanderingProgrammer/render-markdown.nvim',
      --   opts = {
      --     file_types = { "markdown", "Avante" },
      --   },
      --   ft = { "markdown", "Avante" },
      -- },
    },
  },

  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --   ft = { "markdown", "Avante" },
  -- },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
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

  --{
  --  "epwalsh/obsidian.nvim",
  --  version = "*", -- recommended, use latest release instead of latest commit
  --  lazy = true,
  --  ft = "markdown",
  --  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  --  -- event = {
  --  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --  --   -- refer to `:h file-pattern` for more examples
  --  --   "BufReadPre path/to/my-vault/*.md",
  --  --   "BufNewFile path/to/my-vault/*.md",
  --  -- },
  --  dependencies = {
  --    -- Required.
  --    "nvim-lua/plenary.nvim",

  --    -- see below for full list of optional dependencies 👇
  --  },
  --},


  -- 'ghassan0/telescope-glyph.nvim',

  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1,  -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false,   -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0,               -- turn off the statusline in zen mode
        },
        twilight = { enabled = true },  -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false },     -- disables the tmux statusline
        todo = { enabled = true },      -- if set to "true", todo-comments.nvim highlights will be disabled
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = false,
          font = "+4", -- font size increment
        },
        -- this will change the font size on alacritty when in zen mode
        -- requires  Alacritty Version 0.10.0 or higher
        -- uses `alacritty msg` subcommand to change font size
        alacritty = {
          enabled = true,
          font = "13", -- font size
        },
        -- this will change the font size on wezterm when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        wezterm = {
          enabled = false,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
        -- this will change the scale factor in Neovide when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        neovide = {
          enabled = false,
          -- Will multiply the current scale factor by this number
          scale = 1.2,
          -- disable the Neovide animations while in Zen mode
          disable_animations = {
            neovide_animation_length = 0,
            neovide_cursor_animate_command_line = false,
            neovide_scroll_animation_length = 0,
            neovide_position_animation_length = 0,
            neovide_cursor_animation_length = 0,
            neovide_cursor_vfx_mode = "",
          }
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
      end,
    }
  },

  {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      -- 'nvim-telescope/telescope.nvim',
      -- OR 'ibhagwan/fzf-lua',
      'folke/snacks.nvim',
      'nvim-tree/nvim-web-devicons',
    },
  },


  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
