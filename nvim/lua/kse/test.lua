-- local bufnr = 105
-- vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, {
--   "Hello", " world"
-- })

-- vim.fn.jobstart({ "pg_format", "-L" }, {
--   stdout_buffered = true,
--   on_stdout = function(_, data)
--     if data then
--     end
--   end,
-- })

local function format_pg_code()
  -- Save the current cursor position
  local original_cursor = vim.fn.getpos(".") -- Save the original cursor position
  print(original_cursor[0])

  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Get the visual selection
  local lines = vim.fn.getline(start_pos[2], end_pos[2])
  if type(lines) ~= "table" or #lines == 0 then return end

  -- Join the lines into a single string with newline characters
  local selected_text = table.concat(lines, "\n")

  -- Container to capture job output
  local output = {}

  -- Function to handle the output from the job
  local function on_stdout(_, data, _)
    if data then
      for _, line in ipairs(data) do
        table.insert(output, line)
      end
    end
  end

  -- Function to handle job exit
  local function on_exit(_, _, _)
    -- Trim trailing empty lines or newlines
    while #output > 0 and (output[#output] == "" or output[#output] == "\n") do
      table.remove(output, #output)
    end

    -- Replace the visual selection with the formatted text
    vim.api.nvim_buf_set_lines(0, start_pos[2] - 1, end_pos[2], false, output)

    -- Restore the original cursor position
    vim.fn.setpos('.', original_cursor)
    vim.cmd('normal! zvzz')
  end

  -- Start the job
  local job_id = vim.fn.jobstart({ "pg_format", "-L" }, {
    on_stdout = on_stdout,
    on_stderr = on_stdout,
    on_exit = on_exit,
    stdout_buffered = true,
    stderr_buffered = true,
  })

  -- Send the selected text to the job's stdin
  vim.fn.chansend(job_id, selected_text .. "\n")
  vim.fn.chanclose(job_id, "stdin")
end

-- Map the function to a key combination
vim.api.nvim_set_keymap('v', '<localleader>f', ':<C-u> FormatSQL<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<localleader>f', 'vip:<C-u> FormatSQL<CR>', { noremap = true, silent = true })

-- FIXME: Only define if in SQL file?
vim.api.nvim_create_user_command("FormatSQL", function()
  --print(vim.treesitter.get_node():range())
  format_pg_code()
end, {})


---- name: SoftDeleteSubscription :exec
--
---- Map the function to a key combination in visual mode
--vim.api.nvim_set_keymap('v', '<leader>pf', [[:<C-u>lua format_pg_code()<CR>]], { noremap = true, silent = true })
--
