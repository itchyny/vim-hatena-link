" " =============================================================================
" Filename: autoload/hatena_link.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/09/06 18:52:13.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! hatena_link#paste(link) abort
  let link = get(a:link, 0, @+)
  if link =~# '\v^https?://'
    if link =~# '\v^https?://.*(issues|pull)/\d+$'
      let title =  '#' . matchstr(link, '\v(issues|pull)/\zs\d+$')
    else
      let title = system('curl -sL ' . link . ' | perl -l -0777 -ne ''print $1 if /<title.*?>\s*(.*?)\s*<\/title/si'' | tr -d ''\n''')
    endif
    let text = '[' . link . ':title=' . title . ']'
    if getline('.') =~# '[^ ]$' && getline('.')[col('.'):] ==# ''
      let text = ' ' . text
    endif
  else
    let text = link
  endif
  let pos = getcurpos()
  call setline(line('.'), getline('.')[:col('.') - 1] . text . getline('.')[col('.'):])
  let pos[2] += len(text)
  call setpos('.', pos)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
