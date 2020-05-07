" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Search in all files (f) and only git tracked files (F). All files output can
" be customized by editing the FZF_DEFAULT_COMMAND variable in the .bashrc file
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>F :GFiles<CR>

" Search for open buffers (b), buffer history (h)
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>

" Search for tags in current buffer (t), or tags across the project (T)
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>

" Search for lines in current buffer (l), or search for lines in loaded buffers (L)
nnoremap <Leader>l :BLines<CR>
nnoremap <Leader>L :Lines<CR>

" Use ag to search for basically anything (/)
nnoremap <Leader>/ :Ag<CR>
nnoremap <Leader>* :AG<CR>

let g:fzf_layout={'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
let g:fzf_tags_command='ctags -R'

" Customize fzf colors to match your color scheme
"let g:fzf_colors =
"\ { 'fg':      ['fg', 'Normal'],
"  \ 'bg':      ['bg', 'Normal'],
"  \ 'hl':      ['fg', 'Comment'],
"  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"  \ 'hl+':     ['fg', 'Statement'],
"  \ 'info':    ['fg', 'PreProc'],
"  \ 'border':  ['fg', 'Ignore'],
"  \ 'prompt':  ['fg', 'Conditional'],
"  \ 'pointer': ['fg', 'Exception'],
"  \ 'marker':  ['fg', 'Keyword'],
"  \ 'spinner': ['fg', 'Label'],
"  \ 'header':  ['fg', 'Comment'] }
"
" These need to be tested!
" -----------------------
"
"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Use ag to get files that only contain the word under the cursor (can
" sometimes lead to less clutter and less typing)
command! -bang -nargs=* AG
  \ call fzf#vim#grep(
  \   "ag -u -g ".expand('<cword>')." ".shellescape(<q-args>.expand($HOME)), 1,
  \   fzf#vim#with_preview(), <bang>0)

