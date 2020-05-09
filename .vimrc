" ####################
" .vimrc
" ####################

set nocompatible     " Disable Vi compatability

filetype plugin on
filetype indent off
syntax enable
set hidden


" Vim/NVim housekeeping
if !has('nvim')
  set ttymouse=xterm2
endif


" {{{1
" ---- Plugins and Plugin Configs ---- "
" ####################

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}    " Autocomplete
Plug 'Yggdroot/indentLine'                         " Shows indents
Plug 'junegunn/fzf', {'do': { -> fzf#install() } } " Fuzzy finder
Plug 'junegunn/fzf.vim'                            " Also needed for Fuzzy finder
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ---- Unsure plugins ---- "
"Plug 'skywind3000/asynctasks.vim'  " This is the github repo to check out
"Plug 'skywind3000/asyncrun.vim'
Plug 'sakhnik/nvim-gdb', {'do': ':!./install.sh \| UpdateRemotePlugins' }
Plug 'mhinz/vim-grepper'
Plug 'luochen1990/rainbow'
Plug 'jlanzarotta/bufexplorer'
Plug 'mhinz/vim-startify'

if has('nvim') || has('patch-8.2')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" ---- Colorschemes ---- "
Plug 'tomasiser/vim-code-dark'                     " Visual studio-like colorscheme
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim', {'as': 'dracula'}

call plug#end()

" ####################
" Vim plugin specific setups by file, to keep .vimrc cleaner
" ####################
source $HOME/.config/vim-plugins/airline.vim
source $HOME/.config/vim-plugins/coc.vim
source $HOME/.config/vim-plugins/fzf.vim
source $HOME/.config/vim-plugins/indentline.vim
source $HOME/.config/vim-plugins/signify.vim
source $HOME/.config/vim-plugins/startify.vim

"set termguicolors
"hi CursorLine    guibg=#402B3D

colorscheme codedark
let g:rainbow_active=1


" {{{2
" ---- Typical Vim Settings ---- "
" ####################

" ---- Search ---- "
set hlsearch                  " Highlight searches
set incsearch                 " Start highlighting as soon as you start typing
set ignorecase smartcase      " Makes searches case-insensitive, unless they contain upper-case letters

" ---- Keys ---- "
set backspace=indent,eol,start  " Allow backspacing over everything
set nostartofline               " Make j/k respect columns
set timeoutlen=500              " How long to wait for mapped commands

" ---- UI ---- "
set cursorline                " Highlight current line
set showmode                  " Show the current mode
set showcmd                   " Show partial command on last line on screen
set title                     " Show the filename in the window titlebar
set scrolloff=7               " Start scrolling n lines before horizontal border of window
set sidescrolloff=7           " Start scrolling n chars before end of screen
set number                    " Enable line numbers
set relativenumber            " Enable relative line numbers
set ruler                     " Shows Column / Line number
set colorcolumn=160           " Visually show where 160 character line limit is
set mouse=a                   " Allow using the mouse in all modes
set splitbelow splitright     " Open splits in a sensible way

" ---- Indentation and Text-Wrap ---- "
set expandtab                 " Expand tabs to spaces
set tabstop=2                 " Tab is # spaces
set softtabstop=2             " Tab key results in # spaces
set shiftwidth=2              " The # of spaces for indenting
set smarttab                  " At start of line, <Tab> inserts shift width spaces, <Bs> deletes shift width spaces
set smartindent               " Smart indent
set copyindent                " Copy previous indentation on auto indent
set nowrap                    " Don't wrap lines (line wrapping is awful!)

" ---- Searching ---- "
" ---- https://stackoverflow.com/questions.1445992/vim-file-navigation
set wildignore+=*.o,*.obj     " Do not list these types of files
set wildmode=full             " Complete full match(?)

" ---- Code specific stuff ---- "
"  Code folding can be toggled with <Leader>za
set foldenable                " Allow code folding
set foldmethod=indent         " The type of code folding
set foldlevelstart=10         " When to start automatically folding

" ---- Experimental ---- "
set pumheight=10              " How many items to show at a time in the pop up menu
set laststatus=0              " I don't like a constant status line. Set to 2 if you always want one
set clipboard=unnamedplus     " set yy and p to automatically use the system clipboard

" ---- Bindings ---- "
"  h: key-notation to learn all about different key meanings
" Set <Space> as the leader
map <Space> <Leader>

" Make j,k respect virtual lines rather than physical lines. This may only be
" needed if you have word wrapping (?)
nnoremap <silent> j gj
nnoremap <silent> k gk

" Trim all unnecessary whitespace
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
" ---- Functions ---- "
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

" unused
func! GetScriptNumber(script_name)
    " Return the <SNR> of a script.
    "
    " Args:
    "   script_name : (str) The name of a sourced script.
    "
    " Return:
    "   (int) The <SNR> of the script; if the script isn't found, -1.

    redir => scriptnames
    silent! scriptnames
    redir END

    for script in split(l:scriptnames, "\n")
        if l:script =~ a:script_name
            return str2nr(split(l:script, ":")[0])
        endif
    endfor

    return -1
endfunc
