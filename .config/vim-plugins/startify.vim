" ####################
" startify specific keybinds and options
" https://github.com/mhinz/vim-startify
" ####################

" {{{1 Options and keybinds
" ####################

let g:astronaut = [
        \ "          _..._              ",
        \ "        .'     '.      _     ",
        \ "       /    .-''-\\   _/ \\  ",
        \ "     .-|   /:.   |  |   |    ",
        \ "     |  \\ |:.    /.-'-./    ",
        \ "     | .-'-;:__.'    =/      ",
        \ "     .'=  *=| SDL _.='       ",
        \ "    /   _.  |    ;           ",
        \ "   ;-.-'|    \\   |          ",
        \ "  /   | \\    _\\  _\\       ",
        \ "  \\__/'._;.  ==' ==\\       ",
        \ "           \\    \\   |      ",
        \ "           /    /   /        ",
        \ "           /-._/-._/         ",
        \ "           \\    \\  \\      ",
        \ "            `-._/._/         ",
        \]

" If you call center() once with just the two lists concatenated together as
" an argument, it will only center off of the quote, but I want both items
" centered in their own right so do it this way I guess
let quote = startify#center(startify#fortune#boxed())
let header = startify#center(astronaut) + quote
let g:startify_custom_header = header

" Unfortunately this function needs to be declared up here before it's called
" below.
"
" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Recent']                       },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ { 'type': function('s:gitModified'), 'header': ['   git modified']   },
          \ ]

