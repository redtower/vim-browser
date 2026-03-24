function! s:bw_open_url_win32(url)
  let url = substitute(a:url, '%', '%25', 'g')
  if url =~# ' '
    let url = substitute(url, ' ', '%20', 'g')
    let url = substitute(url, '^file://', 'file:/', '')
  endif
  let url = escape(url, '%#')
  if !has('win95') && url !~ '[&!]'
    silent! execute '!start /min cmd /c start ' . url
  else
    silent! execute "!start rundll32 url.dll,FileProtocolHandler " . url
  endif
endfunction

function! s:bw_open_url_mac(url)
  silent! execute '!open ' . shellescape(a:url)
endfunction

function! s:bw_open_url_unix(url)
  silent! execute '!xdg-open ' . shellescape(a:url)
endfunction

function! s:Browser()
  let line0 = getline('.')
  let line = matchstr(line0, '\(https\?\|ftp\|file\)://[^ ]*')
  if line == ''
    echo 'vim-browser: No URL found on current line.'
    return
  endif
  if has('win32') || has('win64') || has('win95')
    call s:bw_open_url_win32(line)
  elseif has('mac') || has('macunix')
    call s:bw_open_url_mac(line)
  else
    call s:bw_open_url_unix(line)
  endif
endfunction
nnoremap <Leader>w :call <SID>Browser()<CR>
