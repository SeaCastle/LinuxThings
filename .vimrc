" Vim/NVim housekeeping
if !has('nvim')
  set ttymouse=xterm2
endif

set nocompatible     " Disable Vi compatability

filetype plugin indent off
syntax on

" {{{1
" ---- Plugins and Plugin Configs ----

"  Automatic Installation
"if empty(glob('~/.vim.autoload/plug.vim'))
"  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}    " Autocomplete
Plug 'Yggdroot/indentLine'                         " Shows indents
Plug 'junegunn/fzf', {'do': { -> fzf#install() } } " Fuzzy finder
Plug 'junegunn/fzf.vim'                            " Also needed for Fuzzy finder
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ---- Unsure plugins ----
"Plug 'skywind3000/asynctasks.vim'  " This is the github repo to check out
"Plug 'skywind3000/asyncrun.vim'
Plug 'sakhnik/nvim-gdb', {'do': ':!./install.sh \| UpdateRemotePlugins' }
Plug 'mhinz/vim-grepper'
Plug 'pechorin/any-jump.vim'

if has('nvim') || has('patch-8.2')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" ---- Colorschemes ----
Plug 'tomasiser/vim-code-dark'                     " Visual studio-like colorscheme
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim', {'as': 'dracula'}

call plug#end()


" ---- Colors ----
" Not sure if these are needed..
set t_Co=256
set t_ut=
"let &t_AB="\e[48;5;%dm"
"let &t_AF="\e[38;5;%dm"

set termguicolors

"let g:codedark_conservative=1
colorscheme codedark

hi CursorLine    guibg=#402B3D

" ---- indentLine configs ----
let g:indentLine_enabled = 1
let g:indentLine_concealLevel = 0
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_color_term = 25
"let g:indentLine_fileType = ['c', 'cpp']
"let g:indentLine_setColors = 0

" ---- Vim-Airline configs ----
let g:airline_theme = 'codedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline_inactive_collapse=1


" {{{2
" ---- Typical Vim Settings ----
set hidden

" ---- Search ----
set hlsearch                  " Highlight searches
set incsearch                 " Start highlighting as soon as you start typing
set ignorecase smartcase      " Makes searches case-insensitive, unless they contain upper-case letters


" ---- Keys ----
set backspace=indent,eol,start  " Allow backspacing over everything
set nostartofline               " Make j/k respect columns
set timeoutlen=500              " How long to wait for mapped commands
"set esckeys                     " Allow cursor keys in insert mode


" ---- UI ----
set cursorline                " Highlight current line
set showmode                  " Show the current mode
set showcmd                   " Show partial command on last line on screen
set title                     " Show the filename in the window titlebar
set scrolloff=7               " Start scrolling n lines before horizontal border of window
set sidescrolloff=7           " Start scrolling n chars before end of screen
set number                    " Enable line numbers
set relativenumber            " Enable relative line numbers
set ruler                     " Shows Column / Line number
set colorcolumn=160
set mouse=a
set splitbelow splitright     " Open splits in a sensible way

" ---- Indentation and Text-Wrap ----
set expandtab                 " Expand tabs to spaces
set tabstop=2                 " Tab is # spaces
set softtabstop=2             " Tab key results in # spaces
set shiftwidth=2              " The # of spaces for indenting
set smarttab                  " At start of line, <Tab> inserts shift width spaces, <Bs> deletes shift width spaces
set smartindent               " Smart indent
set copyindent                " Copy previous indentation on auto indent
set nowrap                    " Wrap lines

" ---- Searching ----
" ---- https://stackoverflow.com/questions.1445992/vim-file-navigation
set wildignore+=*.o,*.obj     " Do not list
set wildmode=full

" ---- Code specific stuff ----
set foldenable
set foldmethod=indent
set foldlevelstart=10

" ---- Experimental ---- "
set pumheight=10
set laststatus=0
set clipboard=unnamedplus     " set yy and p to automatically use the system clipboard

" ---- Bindings ----
" Set <Space> as the leader
map <Space> <Leader>
nnoremap <silent> j gj
nnoremap <silent> k gk

noremap <Leader>tw :call TrimWhitespace()<CR>

" Clear search highlight
nnoremap <Leader>cl :nohlsearch<CR>

" Better indenting
vnoremap <TAB> >gv
vnoremap <S-TAB> <gv

" Use <TAB> / <S-TAB> for navigating buffers
nnoremap <silent> <TAB> :bn<CR>
nnoremap <silent> <S-TAB> :bp<CR>

" Remap split navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" Make pasting better. NOTE: these are only needed if your system does not support
" the clipboard function [vim --version shows -clipboard], if your system does
" support the clipboard, then `set clipboard=unnamedplus` should suffice
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>Y "+Y
noremap <Leader>P "+P




" {{{3
" ####################
" ---- CoC specific stuff. Literally need it's own space because it's coc.. ----
" ####################
set nobackup nowritebackup
set updatetime=300
set shortmess+=c              " Don't pass messages to |ins-completion-menu|
set signcolumn=yes

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



" {{{4
" ####################
" ---- Functions ----
" ####################

" CoC check_back_space function
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" CoC show_documentation function
function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Check for plugin updates
function! s:JobHandlerVim(chanell, msg)
  if (a:msg =~ "is behind")
    let g:needToUpdate += 1
    let g:pluginUpdateStatus = string(g:needToUpdate) . ' new updates'
  endif
endfunction

function! s:JobHandlerNeovim(job_id, data, event) dict
  if (join(a:data) =~ "is behind")
    let g:needToUpdate += 1
    let g:pluginUpdateStatus = string(g:needToUpdate) . ' new updates'
  endif
endfunction

" Note: This function checks all downloaded plugins, not only active ones
function! CheckForUpdates()
  let g:needToUpdate = 0
  let g:pluginUpdateStatus = ''
  let s:callbacksNeovim = {'on_stdout': function('s:JobHandlerNeovim')}
  let s:callbacksVim    = {'out_cb': function('s:JobHandlerVim)}

  if has('nvim')
    for key in keys(g:plugs)
      let job2 = jobstart( ['bash', '-c' "cd " . g:plugs[key].dir ." && git remote update && git status -uno"], s:callbacksNeovim)
    endfor
  else
    for key in keys(g:plugs)
      let job2 = jobstart( ['bash', '-c' "cd " . g:plugs[key].dir ." && git remote update && git status -uno"], s:callbacksVim)
    endfor
  endif
endfunction

" https://vi.stackexchange.com/questions/454/whats-the-simplest-way-to-strip-trailing-whitespace-from-all-lines-in-a-file
function! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction


" ---- Unused stuff ----

" ---- Statusline definition ---- (Used if not using Airline) can't get colors to work though...
"set statusline=                                          " Clear
"set statusline+=%1*\                                     " Color -
"set statusline+=%t                                       " Tail of the filename
"set statusline+=%1*                                      " Color
"set statusline+=%h                                       " Help file flag
"set statusline+=%r                                       " Read only flag
"set statusline+=%1*                                      " Color
"set statusline+=%m                                       " Modified flag
"set statusline+=%=                                       " Left/right separator
"set statusline+=%1*\                                     " Color -
"set statusline+=\ \                                      " --
"set statusline+=%{&filetype}                             " Filetype
"set statusline+=\ \                                      " --
"set statusline+=%{&fenc}                                 " File encoding
"set statusline+=[%{&ff}]                                 " File format
"set statusline+=[                                        " Indent settings: begin
"set statusline+=%{&expandtab?\"sp\":\"tab\"}\            " Indent settings
"set statusline+=%{&shiftwidth}                           " Indent settings
"set statusline+=]                                        " Indent settings: end
"set statusline+=\ %7*\ \ \                               " - Color ---
"set statusline+=%2c                                      " Cursor column
"set statusline+=\ \                                      " --
"set statusline+=%2v                                      " Cursor column (virtual)
"set statusline+=\ \                                      " --
"set statusline+=(%l\ /\ %L)                              " Cursor line/total lines


" Window movements
"nnoremap <M-Right> <C-W><Right>
"nnoremap <M-Up> <C-W><Up>
"nnoremap <M-Left> <C-W><Left>
"nnoremap <M-Down> <C-W><Down>

" Open window below instad of above
"nnoremap <C-W>N :let sb=&sb<BAR>set sb<BAR>new<BAR>let &sb=sb<CR>

" Vertical equivalent of C-w-n and C-w-N
"nnoremap <C-w>v :vnew<CR>
"nnoremap <C-w>V :let spr=&spr<BAR>set nospr<BAR>vnew<BAR>let &spr=spr<CR>

" I open new windows to warrant using up C-M-arrows on this
"nmap <C-M-Up> <C-w>n
"nmap <C-M-Down> <C-w>N
"nmap <C-M-Right> <C-w>v
"nmap <C-M-Left> <C-w>V

