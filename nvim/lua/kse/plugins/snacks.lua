return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {
        enabled = true,
        jump = {
          jumplist = true,   -- save the current position in the jumplist
          tagstack = false,  -- save the current position in the tagstack
          reuse_win = false, -- reuse an existing window if the buffer is already open
          close = true,      -- close the picker when jumping/editing to a location (defaults to true)
          match = false,     -- jump to the first match position. (useful for `lines`)
        },
        sources = {
          lsp_definitions = {
            format = "file",
            include_current = false,
            auto_confirm = true,
            jump = { tagstack = true, reuse_win = false },
          },
          lsp_references = {
            format = "file",
            include_declaration = true,
            include_current = false,
            auto_confirm = true,
            jump = {
              tagstack = true,
              reuse_win = false
            },
          },
        },
        ---@class snacks.picker.formatters.Config
        formatters = {
          file = {
            filename_first = false, -- display filename before the file path
            --- * left: truncate the beginning of the path
            --- * center: truncate the middle of the path
            --- * right: truncate the end of the path
            ---@type "left"|"center"|"right"
            --truncate = "left",
            min_width = 40,        -- minimum length of the truncated path
            filename_only = false, -- only show the filename
            icon_width = 2,        -- width of the icon (in characters)
            git_status_hl = true,  -- use the git status highlight group for the filename
          },
          selected = {
            show_always = false, -- only show the selected column when there are multiple selections
            unselected = true,   -- use the unselected icon for unselected items
          },
          severity = {
            icons = true,  -- show severity icons
            level = false, -- show severity level
            ---@type "left"|"right"
            pos = "left",  -- position of the diagnostics
          },
        },
      },
      gitbrowse = {
        -- your gitbrowse configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        --
        notify = true, -- show notification on open

        -- Handler to open the url in a browser
        ---@param url string
        open = function(url)
          if vim.fn.has("nvim-0.10") == 0 then
            require("lazy.util").open(url, { system = true })
            return
          end
          vim.ui.open(url)
        end,

        ---@type "repo" | "branch" | "file" | "commit" | "permalink"
        what = "file", -- what to open. not all remotes support all types
        commit = nil, ---@type string?
        branch = nil, ---@type string?
        line_start = nil, ---@type number?
        line_end = nil, ---@type number?

        url_patterns = {
          ["bits.linode.com"] = {
            branch = "/tree/{branch}",
            file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
            permalink = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
            commit = "/commit/{commit}",
          },
        },
      }
    },

    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
      { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
      --{ "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
      { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
      -- find
      { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
      { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
      -- git
      { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
      { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
      { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
      { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
      { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
      { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
      { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
      -- Grep
      { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
      { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
      { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
      { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
      { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
      { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
      { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
      { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
      { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
      { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
      { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
      { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
      { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
      { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
      { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
      -- LSP
      { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
      { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
      { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
      { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
      { "gt",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
      { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
      { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
    },
  },
}
