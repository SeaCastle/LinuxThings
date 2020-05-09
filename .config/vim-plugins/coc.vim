" ####################
" coc specific keybinds and options
" https://github.com/neoclide/coc.nvim
" ####################

" {{{1 Options and keybinds
" ####################

set nobackup nowritebackup    " Not entirely sure what this is.. Coc told me to do it!
set updatetime=300            " Default is like 4000. This makes things feel faster
set shortmess+=c              " Don't pass messages to |ins-completion-menu|
set signcolumn=yes            " Constantly show the column to the left. Keeps the screen from shifting constantly

" Navigate autocomplete options with <C-j> and <C-k>
inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-h>"

" Vscode-like tab completion
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Use <Leader><C-o> to toggle between source and header (C++)
nnoremap <silent> <Leader><C-o> :CocCommand clangd.switchSourceHeader<CR>

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" EXPERIMENTAL
" -----------

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Explorer
let g:coc_explorer_global_presets = {
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 30,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'right-center',
\      'floating-width': 30,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

nnoremap <leader>e :CocCommand explorer<CR>

autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" {{{2 Functions
" ####################
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


