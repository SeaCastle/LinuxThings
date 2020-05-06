# Getting CoC.vim up and running

- All of the .vimrc coc settings should already be set in the .vimrc file in this repo.
- The CoC repo with instructions is found [here](https://github.com/neoclide/coc.vim)
- Using CoC extensions [wiki](https://github.com/neoclide/coc.vim/wiki/Using-coc-extensions). This contains language servers you can use/install
- Install [Nodejs](https://nodejs.org/en/download/) if you don't have it already: `curl -sL install-node-now.sh/lts | bash`

### Some useful notes

- :CocList is a very helpful command. Shows which commands you can use, which extensions are installed/in use etc
- :CocCommand <command> This is how you can execute extension specific commands and can be mapped to bindings in .vimrc

### To get CoC to work with C++:**

- Coc-clangd repository with instructrions is [here](https://github.com/clangd/coc-clangd)
- Inside a vim buffer run `:CocInstall coc-clangd`
- There are other language servers you can use but this one is the easiest
- You need to make sure your machine has clangd installed separately
  **- Installing clangd:**
- As of this edit, the most recent clangd version is [version 9](https://clangd.llvm.org/installation.html)
- on Debian/Ubuntu run `sudo apt-get install clangd-9`
- Now make the new version the default clangd: `sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100`
  **- Clangd project setup**
- To understand your source code, clangd needs to know your build flags. To fix this, you can make a compile_commands.json file that provides compile commands for every source file in a project. If you aren't using Cmake, look up how to make one?
- Cmake base projects: You can generate the compile_commands.json file by adding the flag `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1`. This will cause a compile_commands.json to be written to your build directory. You may need to move this to the root of your project?
  **- Clangd commands**
- `clangd.switchSourceHeader` (should be mapped to <Leader><C-o> in .vimrc)
- `clangd.install`            Install latest clangd release from GitHub
- `clangd.update`             Check for updates to clangd from GitHub

