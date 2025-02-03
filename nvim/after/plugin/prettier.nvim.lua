local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
  filetypes = {
    "sql",
    "css",
    "html",
    -- "graphql",
    -- "javascript",
    -- "javascriptreact",
    -- "json",
    -- "less",
    -- "markdown",
    -- "scss",
    -- "typescript",
    -- "typescriptreact",
    -- "yaml",
  },
})
