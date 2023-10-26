-- place this in one of your configuration file(s)
local hop = require('hop')
local directions = require('hop.hint').HintDirection
local position = require('hop.hint').HintPosition

vim.keymap.set('', '<leader><leader>w', function()
  hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})

vim.keymap.set('', '<leader><leader>e', function()
  hop.hint_words({ hint_position = position.END, direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})

vim.keymap.set('', '<leader><leader>E', function()
  hop.hint_words({ hint_position = position.END, direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})

vim.keymap.set('', '<leader><leader>b', function()
  hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})

vim.keymap.set('', '<leader><leader>f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, {remap=true})

vim.keymap.set('', '<leader><leader>F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, {remap=true})

vim.keymap.set('', '<leader><leader>l', function()
  hop.hint_lines()
end, {remap=true})

--vim.keymap.set('', 'F', function()
--  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
--end, {remap=true})
--vim.keymap.set('', 't', function()
--  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
--end, {remap=true})
--vim.keymap.set('', 'T', function()
--  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
--end, {remap=true})

require'hop'.setup()

