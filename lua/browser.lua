-- カーソル行の URL をブラウザで開く。
local M = {}

local function open_url_win32(url)
  url = url:gsub('%%', '%%25')
  if url:find(' ') then
    url = url:gsub(' ', '%%20')
    url = url:gsub('^file://', 'file:/')
  end
  url = url:gsub('([%%#])', '\\%1')
  if not vim.fn.has('win95') and not url:find('[&!]') then
    vim.cmd('silent! !start /min cmd /c start ' .. url)
  else
    vim.cmd('silent! !start rundll32 url.dll,FileProtocolHandler ' .. url)
  end
end

function M.browser()
  local line0 = vim.fn.getline('.')
  local line = line0:match('http[^ ]*') or line0:match('ftp[^ ]*') or line0:match('file[^ ]*') or ''
  open_url_win32(line)
end

vim.keymap.set('n', '<Leader>w', M.browser, { silent = true })

return M
