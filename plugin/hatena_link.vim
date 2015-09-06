" =============================================================================
" Filename: plugin/hatena_link.vim
" Author: itchyny
" License: MIT License
" Last Change: 2015/09/06 18:53:27.
" =============================================================================

if exists('g:loaded_hatena_link') || v:version < 700
  finish
endif
let g:loaded_hatena_link = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=* HatenaLinkPaste call hatena_link#paste([<f-args>])

let &cpo = s:save_cpo
unlet s:save_cpo
