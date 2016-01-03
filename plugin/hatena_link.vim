" =============================================================================
" Filename: plugin/hatena_link.vim
" Author: itchyny
" License: MIT License
" Last Change: 2016/01/04 00:39:55.
" =============================================================================

if exists('g:loaded_hatena_link') || v:version < 700
  finish
endif
let g:loaded_hatena_link = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=* HatenaLinkPaste call hatena_link#paste(<q-args>)

let &cpo = s:save_cpo
unlet s:save_cpo
