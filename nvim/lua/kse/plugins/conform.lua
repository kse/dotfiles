return {
  "stevearc/conform.nvim",
  event = { "LspAttach", "BufReadPost", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      python = { "isort", "black", "pyupgrade" },
      vue = { "prettier" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 3500,
    },
  },
  config = function(_, opts)
    local conform = require("conform")
    local util = require("conform.util")

    -- Setup "conform.nvim" to work
    conform.setup(opts)

    conform.formatters.isort = {
      meta = {
        url = "https://github.com/PyCQA/isort",
        description =
        "Python utility / library to sort imports alphabetically and automatically separate them into sections and by type.",
      },
      command = "isort",
      args = function(_, ctx)
        return {
          "--dont-order-by-type",
          "--stdout",
          "--line-ending",
          util.buf_line_ending(ctx.buf),
          "--filename",
          "$FILENAME",
          "-",
        }
      end,
      cwd = util.root_file({
        -- https://pycqa.github.io/isort/docs/configuration/config_files.html
        ".isort.cfg",
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "tox.ini",
        ".editorconfig",
      }),
    }
  end,
}
