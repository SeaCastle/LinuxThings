#!/bin/bash

# Replace all tabs with spaces
# :%retab

### Aliases ###
# -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_COMPILER_LAUNCHER=ccache
alias cmakeDebug="cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
alias cmakeRelease="cmake .. -DCMAKE_BUILD_TYPE=Release"
alias glog='git log --oneline --decorate --graph'
alias gbranches='git branch -r'
alias gc='git commit -m'
alias valgrindFull='/usr/local/bin/valgrind --leak-check=full --leak-resolution=high --track-origins=yes --main-stacksize=52428800 --child-silent-after-fork=yes'
alias diffSmall='diff -y --suppress-common-lines'


### Functions ###
function kbg()
{
  killall $1; bg;
}
