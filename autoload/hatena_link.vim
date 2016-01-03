" =============================================================================
" Filename: autoload/hatena_link.vim
" Author: itchyny
" License: MIT License
" Last Change: 2016/01/04 00:41:15.
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

function! hatena_link#paste(text) abort
  let link = a:text ==# '' ? @+ : a:text
  if link =~# '\v^https?://'
    let link = substitute(link, '\v#[^/#]+$', '', '')
    if link =~# '\v^https?://.*(issues|pull)/\d+$'
      let title =  matchstr(link, '\v^https?://[^/]+/\zs.*\ze/(issues|pull)')
            \ . ' #' . matchstr(link, '\v(issues|pull)/\zs\d+')
    else
      let title = system('curl -sL ' . link . ' | perl -l -0777 -ne ''print $1 if /<title.*?>\s*(.*?)\s*<\/title/si'' | tr -d ''\n'' | tr ''·'' ''-''')
    endif
    let text = '[' . link . ':title=' . title . ']'
  else
    let text = link
  endif
  let pos = getcurpos()
  let col = 0
  for c in split(getline('.'), '\zs')
    let col += len(c)
    if col('.') <= col
      let pos[2] += len(c) - 1
      break
    endif
  endfor
  if text !=# link && getline('.')[:col - 1] =~# '\S$' && getline('.')[col :] ==# ''
    let text = ' ' . text
  endif
  call setline(line('.'), getline('.')[:col - 1] . text . getline('.')[col :])
  let pos[2] += len(text)
  call setpos('.', pos)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
