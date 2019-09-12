" Based on https://github.com/vim-scripts/Smart-Home-Key but for Home and End
" keys

if get(g:, 'smartmove_setup', 0)
    finish
endif

let g:smartmove_setup = 1

function! smartmove#home()
    let l:lnum = line('.')
    let l:current_column = col('.')
    execute 'normal! ^'
    let l:first_non_blank_column = col('.')
    execute 'normal! 0'
    let l:first_column = col('.')

    " Prefer first non blank before
    if l:current_column != l:first_non_blank_column
        call cursor(l:lnum, l:first_non_blank_column)
    else
        call cursor(l:lnum, l:first_column)
    endif
endfun

function! smartmove#end(mode)
    " When on insert mode we'll move 1 column past so the user can append text
    " directly, which seems to be the most common case really
    let l:offset = a:mode ==# 'insert' ? 1 : 0        

    let l:lnum = line('.')
    let l:current_column = col('.')
    execute 'normal! g_'
    let l:last_non_blank_column = col('.')
    execute 'normal! $'
    let l:last_column = col('.')

    " Prefer last column before last non blank column
    if l:current_column != l:last_column + l:offset
        call cursor(l:lnum, l:last_column + l:offset)
    else
        call cursor(l:lnum, l:last_non_blank_column + l:offset)
    endif
endfun

nnoremap <silent> <Home> :call smartmove#home()<CR>
inoremap <silent> <Home> <C-\><C-O>:call smartmove#home()<CR>
nnoremap <silent> <End> :call smartmove#end('normal')<CR>
inoremap <silent> <End> <C-\><C-O>:call smartmove#end('insert')<CR>
