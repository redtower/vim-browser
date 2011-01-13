function! s:bw_open_url_win32(url)
  let url = substitute(a:url, '%', '%25', 'g')
  if url =~# ' '
    let url = substitute(url, ' ', '%20', 'g')
    let url = substitute(url, '^file://', 'file:/', '')
  endif
  let url = escape(url, '%#')
  if !has('win95') && url !~ '[&!]'
    silent! execute a:'!start /min cmd /c start ' . url
  else
    silent! execute a:"!start rundll32 url.dll,FileProtocolHandler " . url
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
    call s:bw_open_url_win32(line)
endfunction
map <Leader>w :call Browser()<CR>
