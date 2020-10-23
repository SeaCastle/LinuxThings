#!/bin/bash

# Replace all tabs with spaces
# :%retab

### Aliases ###
alias cmakeDebug="cmake .. -DCMAKE_BUILD_TYPE=Debug"
alias cmakeRelease="cmake .. -DCMAKE_BUILD_TYPE=Release"
alias glog='git log --oneline --decorate --graph'
alias valgrindFull='/usr/local/bin/valgrind --leak-check=full --leak-resolution=high --track-origins=yes --main-stacksize=52428800 --child-silent-after-fork=yes'
alias diffSmall='diff -y --suppress-common-lines'


### Functions ###
function kbg()
{
  killall $1; bg;
}
