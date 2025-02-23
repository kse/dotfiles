local ok, legendary = pcall(require, "legendary")
if not ok then return end

local vg = vim.g
vg.maplocalleader = " "

return legendary.keymaps({
  -- Editing words
  { "<LocalLeader>,", "<cmd>norm A,<CR>",   hide = true, description = "Append comma" },
  { "<LocalLeader>;", "<cmd>norm A;<CR>",   hide = true, description = "Append semicolon" },

  -- Clear search
  { "<Leader>/",      "<cmd>nohlsearch<CR>" },


  -- Trouble
  {
    "<leader>xx",
    function() require("trouble").toggle({ new = false, mode = "diagnostics" }) end,
    hide = true,
    description = "Open Trouble window"
  },
  {
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    hide = true,
    description = "Open Trouble document_diagnostics window"
  },
  {
    "<leader>xq",
    "<cmd>Trouble qflist toggle<cr>",
    hide = true,
    description = "Populate quickfix window with trouble diagnostics"
  },
  {
    "<leader>xl",
    "<cmd>Trouble loclist toggle<cr>",
    hide = true,
    description = "Populate loclist window with trouble diagnostics"
  },
  {
    "gR",
    "<cmd>Trouble lsp_references toggle<cr>",
    hide = true,
    description = "Open Trouble with LSP references for the word under the cursor"
  },

  -- Moving lines
  {
    "<A-k>",
    {
      n = ":m .-2<CR>==",
      v = ":m '<-2<CR>gv=gv",
    },
    hide = true,
    description = "Move selection up",
    opts = { silent = true },
  },
  {
    "<A-j>",
    hide = true,
    {
      n = ":m .+1<CR>==",
      v = ":m '>+1<CR>gv=gv",
    },
    description = "Move selection down",
    opts = { silent = true },
  },

  --{response
  --  '<LocalLeader>c',
  --  function()
  --    vim.cmd(':GoCoverage -p')
  --  end,
  --  hide = true,
  --  opts = { silent = true },
  --  filters = {
  --    ft = 'go'
  --  }
  --},
  --{
  --  '<LocalLeader>C',
  --  function()
  --    vim.cmd(':GoCoverage -R')
  --  end,
  --  hide = true,
  --  filters = {
  --    ft = 'go'
  --  }
  --},
  {
    '<LocalLeader>F',
    function()
      vim.cmd(':GoFillStruct')
    end,
    hide = true,
    filters = {
      ft = 'go'
    }
  },

  -- Go Callers
  --{ -- TODO: Use gr for referrers
  --  '<LocalLeader>C',
  --  '<Plug>(go-callers)',
  --  hide = true,
  --  filters = {
  --    ft = 'go'
  --  }
  --},

  -- Edit alternate file
  {
    '<LocalLeader>a',
    function()
      vim.cmd(':GoAlt')
    end,
    hide = true,
    filters = {
      ft = 'go'
    }
  },

  -- Edit alternate file, create if it doesn't exist
  {
    '<LocalLeader>A',
    function()
      vim.cmd(':GoAlt!')
    end,
    hide = true,
    filters = {
      ft = 'go'
    }
  },
  --{
  --  '<LocalLeader>i',
  --  '<Plug>(go-info)',
  --  hide = true,
  --  filters = {
  --    ft = 'go'
  --  }
  --},
  --{ -- TODO: Forward to trouble instead
  --  '<LocalLeader>I',
  --  '<Plug>(go-implements)',
  --  hide = true,
  --  filters = {
  --    ft = 'go'
  --  }
  --},
  {
    '<C-e>',
    function()
      vim.cmd(':GoIfErr')
    end,
    mode = { 'i' },
    hide = true,
    filters = {
      ft = 'go'
    }
  },
  --{ -- TODO: Probably just use gd
  --  '<LocalLeader>d',
  --  '<Plug>(go-def)',
  --  hide = true,
  --  filters = {
  --    ft = 'go'
  --  }
  --},
  --{ -- TODO: Can we replace this?
  --  '<LocalLeader>D',
  --  '<Plug>(go-def-type)',
  --  hide = true,
  --  filters = {
  --    ft = 'go'
  --  }
  --},
  {
    '<LocalLeader>tf',
    function()
      vim.cmd(':GoTestFunc')
    end,
    hide = true,
    filters = {
      ft = 'go'
    }
  },

  {
    '<F14>',
    function()
      vim.lsp.util.rename(nil, nil, {
        default = '',
      })
    end,
    hide = true,
    filters = {
      ft = 'go'
    }
  },

  {
    "<CR>",
    function()
      -- Save the current cursor position
      local saved_view = vim.fn.winsaveview()

      -- Perform the copy action for visual selection to clipboard
      vim.cmd('normal! "+y')

      vim.fn.winrestview(saved_view)
      vim.notify("Copied to clipboard", vim.log.levels.INFO)
    end,
    mode = "v",
    hide = false,
    description = "Copy visual selection to clipboard",
    opts = { silent = false },
  },

  {
    '<Leader>vd',
    '<Cmd>vsplit | lua vim.lsp.buf.definition()<CR>',
    mode        = 'n',
    hide        = true,
    description = "Open definition in vsplit",
    opts        = { silent = true, noremap = true },
  }
})

-- return legendary.keymaps({
--   { "<C-y>", "<cmd>%y+<CR>", hide = true, description = "Copy buffer" },
--
--   {
--     "<C-s>",
--     "<cmd>silent! write<CR>",
--     hide = true,
--     description = "Save buffer",
--     mode = { "n", "i" },
--   },
--
--   -- Editing words
--   { "<LocalLeader>,", "<cmd>norm A,<CR>", hide = true, description = "Append comma" },
--   { "<LocalLeader>;", "<cmd>norm A;<CR>", hide = true, description = "Append semicolon" },
--
--   {
--     itemgroup = "Wrap text",
--     icon = "",
--     description = "Wrapping text functionality",
--     keymaps = {
--       {
--         "<LocalLeader>(",
--         { n = [[ciw(<c-r>")<esc>]], v = [[c(<c-r>")<esc>]] },
--         description = "Wrap text in brackets ()",
--       },
--       {
--         "<LocalLeader>[",
--         { n = [[ciw[<c-r>"]<esc>]], v = [[c[<c-r>"]<esc>]] },
--         description = "Wrap text in square braces []",
--       },
--       {
--         "<LocalLeader>{",
--         { n = [[ciw{<c-r>"}<esc>]], v = [[c{<c-r>"}<esc>]] },
--         description = "Wrap text in curly braces {}",
--       },
--       {
--         '<LocalLeader>"',
--         { n = [[ciw"<c-r>""<esc>]], v = [[c"<c-r>""<esc>]] },
--         description = 'Wrap text in quotes ""',
--       },
--     },
--   },
--
--   {
--     itemgroup = "Find and Replace",
--     icon = "",
--     description = "Find and replace within the buffer",
--     keymaps = {
--       {
--         "<LocalLeader>fw",
--         [[:%s/\<<C-r>=expand("<cword>")<CR>\>/]],
--         description = "Replace cursor words in buffer",
--       },
--       { "<LocalLeader>fl", [[:s/\<<C-r>=expand("<cword>")<CR>\>/]], description = "Replace cursor words in line" },
--       -- {
--       --   "<LocalLeader>f",
--       --   ":s/{search}/{replace}/g",
--       --   description = "Find and Replace (buffer)",
--       --   mode = { "n", "v" },
--       --   opts = { silent = false },
--       -- },
--     },
--   },
--
--   -- Working with lines
--   { "B", "^", hide = true, description = "Beginning of a line", mode = { "n", "v" } },
--   { "E", "$", hide = true, description = "End of a line", mode = { "n", "v" } },
--   { "<CR>", "o<Esc>", hide = true, description = "Insert blank line below" },
--   { "<S-CR>", "O<Esc>", hide = true, description = "Insert blank line above" },
--
--   -- Moving lines
--   {
--     "<A-k>",
--     {
--       n = ":m .-2<CR>==",
--       v = ":m '<-2<CR>gv=gv",
--     },
--     hide = true,
--     description = "Move selection up",
--     opts = { silent = true },
--   },
--   {
--     "<A-j>",
--     hide = true,
--     {
--       n = ":m .+1<CR>==",
--       v = ":m '>+1<CR>gv=gv",
--     },
--     description = "Move selection down",
--     opts = { silent = true },
--   },
--
--   -- Splits
--   { "<LocalLeader>sv", "<C-w>v", description = "Split: Vertical" },
--   { "<LocalLeader>sh", "<C-w>h", description = "Split: Horizontal" },
--   { "<LocalLeader>sc", "<C-w>q", description = "Split: Close" },
--   { "<LocalLeader>so", "<C-w>o", description = "Split: Close all but current" },
--
--   -- Misc
--   { "<Esc>", "<cmd>:noh<CR>", description = "Clear searches" },
--   { "<S-w>", "<cmd>set winbar=<CR>", description = "Hide WinBar" },
--   { "<LocalLeader>U", "gUiw`", description = "Capitalize word" },
--   { ">", ">gv", hide = true, description = "Indent", mode = { "v" } },
--   { "<", "<gv", hide = true, description = "Outdent", mode = { "v" } },
--
--   -- Multiple Cursors
--   -- http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
--   -- https://github.com/akinsho/dotfiles/blob/45c4c17084d0aa572e52cc177ac5b9d6db1585ae/.config/nvim/plugin/mappings.lua#L298
--
--   -- 1. Position the cursor anywhere in the word you wish to change;
--   -- 2. Or, visually make a selection;
--   -- 3. Hit cn, type the new word, then go back to Normal mode;
--   -- 4. Hit `.` n-1 times, where n is the number of replacements.
--   {
--     itemgroup = "Multiple Cursors",
--     icon = "",
--     description = "Working with multiple cursors",
--     keymaps = {
--       {
--         "cn",
--         {
--           n = { "*``cgn" },
--           x = { [[g:mc . "``cgn"]], opts = { expr = true } },
--         },
--         description = "Inititiate",
--       },
--       {
--         "cN",
--         {
--           n = { "*``cgN" },
--           x = { [[g:mc . "``cgN"]], opts = { expr = true } },
--         },
--         description = "Inititiate (in backwards direction)",
--       },
--
--       -- 1. Position the cursor over a word; alternatively, make a selection.
--       -- 2. Hit cq to start recording the macro.
--       -- 3. Once you are done with the macro, go back to normal mode.
--       -- 4. Hit Enter to repeat the macro over search matches.
--       {
--         "cq",
--         {
--           n = { [[:\<C-u>call v:lua.SetupMultipleCursors()<CR>*``qz]] },
--           x = { [[":\<C-u>call v:lua.SetupMultipleCursors()<CR>gv" . g:mc . "``qz"]], opts = { expr = true } },
--         },
--         description = "Inititiate with macros",
--       },
--       {
--         "cQ",
--         {
--           n = { [[:\<C-u>call v:lua.SetupMultipleCursors()<CR>#``qz]] },
--           x = {
--             [[":\<C-u>call v:lua.SetupMultipleCursors()<CR>gv" . substitute(g:mc, '/', '?', 'g') . "``qz"]],
--             opts = { expr = true },
--           },
--         },
--         description = "Inititiate with macros (in backwards direction)",
--       },
--     },
--   },
-- })
