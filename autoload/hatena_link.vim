" =============================================================================
" Filename: autoload/hatena_link.vim
" Author: itchyny
" License: MIT License
" Last Change: 2019/01/15 20:16:00.
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
      let lines = split(system('curl -sL "' . link . '"'), '\n')
      let title = ''
      for line in lines
        if line =~# '\c<title.*>.*</title'
          let title = matchstr(line, '<title.*>\zs.*\ze</title')
          break
        endif
      endfor
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
