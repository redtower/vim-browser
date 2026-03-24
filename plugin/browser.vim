function! s:bw_open_url(url)
  if has('win32') || has('win64')
    let url = substitute(a:url, '%', '%25', 'g')
    if url =~# ' '
      let url = substitute(url, ' ', '%20', 'g')
      let url = substitute(url, '^file://', 'file:/', '')
    endif
    let url = escape(url, '%#')
    if !has('win95') && url !~ '[&!]'
      silent! execute '!start /min cmd /c start ' . shellescape(url)
    else
      silent! execute '!start rundll32 url.dll,FileProtocolHandler ' . shellescape(url)
    endif
  elseif has('macunix') || has('mac')
    silent! execute '!open ' . shellescape(a:url) . ' &'
    redraw!
  else
    silent! execute '!xdg-open ' . shellescape(a:url) . ' &'
    redraw!
  endif
endfunction

function! Browser()
    let line0 = getline(".")
    let line = matchstr(line0, "http[^ ]*")
    if line==""
      let line = matchstr(line0, "ftp[^ ]*")
    endif
    if line==""
      let line = matchstr(line0, "file[^ ]*")
    endif
    call s:bw_open_url(line)
endfunction
map <Leader>w :call Browser()<CR>
