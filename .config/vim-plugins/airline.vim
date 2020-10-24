" ####################
" airline specific keybinds and options
" https://github.com/vim-airline/vim-airline
" ####################

" {{{1 Options and keybinds
" ####################

" ---- Vim-Airline configs ----
let g:airline_theme = 'xcodedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_inactive_collapse = 1

" Requires powerline extra symbols [https://github.com/ryanoasis/powerline-extra-symbols]
let g:airline_left_sep = "\uE0B0"
let g:airline_right_sep = "\uE0B2"
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline_symbols = {}
let g:airline_symbols.branch = ''
