-- カーソル行の URL をブラウザで開く。
local M = {}

local function open_url(url)
  if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    url = url:gsub('%%', '%%25')
    if url:find(' ') then
      url = url:gsub(' ', '%%20')
      url = url:gsub('^file://', 'file:/')
    end
    url = url:gsub('([%%#])', '\\%1')
    if vim.fn.has('win95') == 0 and not url:find('[&!]') then
      vim.cmd('silent! !start /min cmd /c start ' .. vim.fn.shellescape(url))
    else
      vim.cmd('silent! !start rundll32 url.dll,FileProtocolHandler ' .. vim.fn.shellescape(url))
    end
  elseif vim.fn.has('macunix') == 1 or vim.fn.has('mac') == 1 then
    vim.fn.jobstart({'open', url}, {detach = true})
  else
    vim.fn.jobstart({'xdg-open', url}, {detach = true})
  end
end

function M.browser()
  local line0 = vim.fn.getline('.')
  local line = line0:match('http[^ ]*') or line0:match('ftp[^ ]*') or line0:match('file[^ ]*') or ''
  open_url(line)
end

vim.keymap.set('n', '<Leader>o', M.browser, { silent = true })

return M
