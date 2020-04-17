" Vim/NVim housekeeping
if !has('nvim')
  set ttymouse=xterm2
endif


" {{1
" ---- Plugins and Plugin Configs ----

call plug#begin(stdpath('data').'/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}    " Autocomplete
Plug 'Yggdroot/indentLine'                         " Shows indents
Plug 'junegunn/fzf', {'do': { -> fzf#install() } } " Fuzzy finder
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ---- Unsure plugins ----
Plug 'skywind3000/asynctasks.vim'  " This is the github repo to check out
Plug 'skywind3000/asyncrun.vim'
Plug 'sakhnik/nvim-gdb', {'do': ':!./install.sh \| UpdateRemotePlugins' }
Plug 'mhinz/vim-grepper'
Plug 'pechorin/any-jump.vim'

if has('nvim') || has('patch-8.0.902')
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
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

set termguicolors

colorscheme codedark

hi CursorLine    guibg=#402B3D
"let ayocolor="mirage"

" ---- vim-signify ----
set updatetime=500 " Time (in ms) to wait before showing changes in the side panel

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


" {{2
" ---- Typical Vim Settings ----

set nocompatible              " Disable vi compatibility


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
set ruler                     " Shows Column / Line number
set colorcolumn=160
set mouse=a

" ---- Indentation and Text-Wrap ----
set expandtab                 " Expand tabs to spaces
set tabstop=2                 " Tab is # spaces
set softtabstop=2             " Tab key results in # spaces
set shiftwidth=2              " The # of spaces for indenting
set smarttab                  " At start of line, <Tab> inserts shift width spaces, <Bs> deletes shift width spaces
set autoindent smartindent    " Auto/smart indent
set copyindent                " Copy previous indentation on auto indent
set wrap                      " Wrap lines

" ---- Searching ----
" ---- https://stackoverflow.com/questions.1445992/vim-file-navigation
set wildignore+=*.o,*.obj     " Do not list
set wildmode=full

" ---- Code specific stuff ----
set foldenable
set foldmethod=indent
set foldlevelstart=10

" Currently not needed since using airline plugin
" Add useful stuff to title bar (file name, flags, cwd)
"if has('title') && (has('gui_running') || &title)
"  set titlestring=
"  set titlestring+=%f
"  set titlestring+=%h%m%r%w
"  set titlestring+=\ -\ %{v:progname}
"  set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
"endif

" ---- Bindings ----
" Set <Space> as the leader
map <Space> <Leader>
nnoremap j gj
nnoremap k gk

noremap <Leader>tw :call TrimWhitespace()<CR>

" Clear search highlight
nnoremap <Leader>cl :nohlsearch<CR>
" Open/Close code folds
nnoremap <Leader>za

" {{3
" ---- Functions ----
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

