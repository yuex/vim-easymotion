"=============================================================================
" FILE: highlight.vim
" AUTHOR: haya14busa
" Reference: https://github.com/t9md/vim-smalls
" Last Change: 11 Feb 2014.
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================
scriptencoding utf-8
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

function! EasyMotion#highlight#load()
   "load
endfunction

" -- Default highlighting ---------------- {{{
let g:EasyMotion_hl_group_target         = get(g:,
    \ 'EasyMotion_hl_group_target', 'EasyMotionTarget')
let g:EasyMotion_hl2_first_group_target  = get(g:,
    \ 'EasyMotion_hl2_first_group_target', 'EasyMotionTarget2First')
let g:EasyMotion_hl2_second_group_target = get(g:,
    \ 'EasyMotion_hl2_second_group_target', 'EasyMotionTarget2Second')
let g:EasyMotion_hl_group_shade          = get(g:,
    \ 'EasyMotion_hl_group_shade', 'EasyMotionShade')

let g:EasyMotion_hl_inc_search     = get(g:,
    \ 'EasyMotion_hl_inc_search', 'EasyMotionIncSearch')
let g:EasyMotion_hl_inc_cursor     = get(g:,
    \ 'EasyMotion_hl_inc_cursor', 'EasyMotionIncCursor')
let g:EasyMotion_hl_move           = get(g:,
    \ 'EasyMotion_hl_move', 'EasyMotionMoveHL')

let s:target_hl_defaults = {
    \   'gui'     : ['NONE', '#ff0000' , 'bold']
    \ , 'cterm256': ['NONE', '196'     , 'bold']
    \ , 'cterm'   : ['NONE', 'red'     , 'bold']
    \ }

let s:target_hl2_first_defaults = {
    \   'gui'     : ['NONE', '#ffb400' , 'bold']
    \ , 'cterm256': ['NONE', '11'      , 'bold']
    \ , 'cterm'   : ['NONE', 'yellow'  , 'bold']
    \ }

let s:target_hl2_second_defaults = {
    \   'gui'     : ['NONE', '#b98300' , 'bold']
    \ , 'cterm256': ['NONE', '3'       , 'bold']
    \ , 'cterm'   : ['NONE', 'yellow'  , 'bold']
    \ }

let s:shade_hl_defaults = {
    \   'gui'     : ['NONE', '#777777' , 'NONE']
    \ , 'cterm256': ['NONE', '242'     , 'NONE']
    \ , 'cterm'   : ['NONE', 'grey'    , 'NONE']
    \ }

let s:shade_hl_line_defaults = {
    \   'gui'     : ['red' , '#FFFFFF' , 'NONE']
    \ , 'cterm256': ['red' , '242'     , 'NONE']
    \ , 'cterm'   : ['red' , 'grey'    , 'NONE']
    \ }

let s:target_hl_inc = {
    \   'gui'     : ['NONE', '#7fbf00' , 'bold']
    \ , 'cterm256': ['NONE', 'green'   , 'bold']
    \ , 'cterm'   : ['NONE', 'green'   , 'bold']
    \ }
let s:target_hl_inc_cursor = {
    \   'gui'     : ['#ACDBDA', '#121813' , 'bold']
    \ , 'cterm256': ['cyan'   , 'black'   , 'bold']
    \ , 'cterm'   : ['cyan'   , 'black'   , 'bold']
    \ }
let s:target_hl_move = {
    \   'gui'     : ['#7fbf00', '#121813' , 'bold']
    \ , 'cterm256': ['green'  , 'white'   , 'bold']
    \ , 'cterm'   : ['green'  , 'white'   , 'bold']
    \ }
" }}}
function! EasyMotion#highlight#InitHL(group, colors) " {{{
    let group_default = a:group . 'Default'

    " Prepare highlighting variables
    let guihl = printf('guibg=%s guifg=%s gui=%s', a:colors.gui[0], a:colors.gui[1], a:colors.gui[2])
    let ctermhl = &t_Co == 256
        \ ? printf('ctermbg=%s ctermfg=%s cterm=%s', a:colors.cterm256[0], a:colors.cterm256[1], a:colors.cterm256[2])
        \ : printf('ctermbg=%s ctermfg=%s cterm=%s', a:colors.cterm[0], a:colors.cterm[1], a:colors.cterm[2])

    " Create default highlighting group
    execute printf('hi default %s %s %s', group_default, guihl, ctermhl)

    " Check if the hl group exists
    if hlexists(a:group)
        redir => hlstatus | exec 'silent hi ' . a:group | redir END

        " Return if the group isn't cleared
        if hlstatus !~ 'cleared'
            return
        endif
    endif

    " No colors are defined for this group, link to defaults
    execute printf('hi default link %s %s', a:group, group_default)
endfunction " }}}
function! EasyMotion#highlight#init() "{{{
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl_group_target, s:target_hl_defaults)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl2_first_group_target, s:target_hl2_first_defaults)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl2_second_group_target, s:target_hl2_second_defaults)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl_group_shade,  s:shade_hl_defaults)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl_inc_search, s:target_hl_inc)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl_inc_cursor, s:target_hl_inc_cursor)
    call EasyMotion#highlight#InitHL(g:EasyMotion_hl_move, s:target_hl_move)
    if exists(':CSApprox') == 2
        "TODO: better solution or remove completly
        CSApprox!
    endif
endfunction "}}}

" Reset highlighting after loading a new color scheme {{{
augroup EasyMotionInitHL
    autocmd!
    autocmd ColorScheme * call EasyMotion#highlight#init()
augroup end
" }}}

call EasyMotion#highlight#init()
" Init: {{{
let s:h = {}
let s:h.ids = {}
let s:priorities = {
    \  g:EasyMotion_hl_group_target : 1,
    \  g:EasyMotion_hl2_first_group_target : 1,
    \  g:EasyMotion_hl2_second_group_target : 1,
    \  g:EasyMotion_hl_group_shade : 0,
    \  g:EasyMotion_hl_inc_search : 1,
    \  g:EasyMotion_hl_inc_cursor : 2,
    \  g:EasyMotion_hl_move : 0,
    \ }
for group in keys(s:priorities)
    let s:h.ids[group] = []
endfor
"}}}

function! EasyMotion#highlight#delete_highlight(...) "{{{
    let groups = !empty(a:000) ? a:000 : keys(s:priorities)
    for group in groups
        for id in s:h.ids[group]
            silent! call matchdelete(id)
        endfor
        let s:h.ids[group] = []
    endfor
endfunction "}}}
function! EasyMotion#highlight#add_highlight(re, group) "{{{
    call add(s:h.ids[a:group], matchadd(a:group, a:re, s:priorities[a:group]))
endfunction "}}}
function! EasyMotion#highlight#attach_autocmd() "{{{
    " Reference: https://github.com/justinmk/vim-sneak
    augroup plugin-easymotion
        autocmd!
        autocmd InsertEnter,WinLeave,BufLeave <buffer>
            \ silent! call EasyMotion#highlight#delete_highlight()
            \  | autocmd! plugin-easymotion * <buffer>
        autocmd CursorMoved <buffer>
            \ autocmd plugin-easymotion CursorMoved <buffer>
            \ silent! call EasyMotion#highlight#delete_highlight()
            \  | autocmd! plugin-easymotion * <buffer>
    augroup END
endfunction "}}}
function! EasyMotion#highlight#add_color_group(new_groups) "{{{
    let s:priorities = extend(deepcopy(s:priorities), a:new_groups)
    for group in keys(a:new_groups)
        let s:h.ids[group] = []
    endfor
endfunction "}}}



" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" __END__  {{{
" vim: expandtab softtabstop=4 shiftwidth=4
" vim: foldmethod=marker
" }}}
