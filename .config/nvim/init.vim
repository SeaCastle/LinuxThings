" This allows you to share vim setups between vim and nvim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=$runtimepath
source ~/.vimrc
