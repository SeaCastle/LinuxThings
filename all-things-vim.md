# Getting CoC.vim up and running

- All of the .vimrc coc settings should already be set in the .vimrc file in this repo.
- The CoC repo with instructions is found [here](https://github.com/neoclide/coc.nvim)
- Using CoC extensions [wiki](https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions). This contains language servers you can use/install
- Install [Nodejs](https://nodejs.org/en/download/) if you don't have it already: `curl -sL install-node-now.sh/lts | bash`

## Some useful notes

- :CocList is a very helpful command. Shows which commands you can use, which extensions are installed/in use etc
- :CocCommand <command> This is how you can execute extension specific commands and can be mapped to bindings in .vimrc
- :CocUninstall <extension> This is how you can uninstall coc extensions (obviously..). If you need to know an extension name you can run `:CocList extensions`

## To get CoC to work with C++:

- Coc-clangd repository with instructrions is [here](https://github.com/clangd/coc-clangd)
- Inside a vim buffer run `:CocInstall coc-clangd`
- There are other language servers you can use but this one is the easiest
- You need to make sure your machine has clangd installed separately

#### Installing clangd:

- As of this edit, the most recent clangd version is [version 9](https://clangd.llvm.org/installation.html)
- on Debian/Ubuntu run `sudo apt-get install clangd-9`
- Now make the new version the default clangd: `sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-9 100`

#### Clangd project setup:

- To understand your source code, clangd needs to know your build flags. To fix this, you can make a compile_commands.json file that provides compile commands for every source file in a project. If you aren't using Cmake, look up how to make one?
- Cmake base projects: You can generate the compile_commands.json file by adding the flag `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1`. This will cause a compile_commands.json to be written to your build directory. You may need to move this to the root of your project?

#### Clangd commands:

- `clangd.switchSourceHeader` (should be mapped to <Leader><C-o> in .vimrc)
- `clangd.install`            Install latest clangd release from GitHub
- `clangd.update`             Check for updates to clangd from GitHub

---

# Getting fzf up and running (Ubuntu versions below 19.10)

- Link to github with instructions [here](https://github.com/junegunn/fzf)
- For pretty much anything else, fzf is a simple install, but for Ubuntu version below 19.10 it's a pain in the butt
- There are some color schemes for fzf [listed here](https://github.com/junegunn/fzf/wiki/Color-schemes) (For the popup window when searching in vim)

#### Installing:
  - Run `git clone` in any directory and then run the install script:
  - `git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf`
  - `~/.fzf/install`

---

# Installing and using Ctags
- It seems like the go-to choice used to be exuberant-ctags but that looks like it's been abandoned since 2009.
A possible alternative to this could be [universal c-tags](https://github.com/universal-ctags/ctags). I will be investigating this
to see if it's an alternative that I like. Looks like somewhat of a pain to get setup but here are the [installation instructions for linux](https://docs.ctags.io/en/latest/autotools.html)
(don't forget to clone the repo after installing all the packages)
- Once everything is installed, run `ctags -R` in your root projet directory to generate a `tags` file that you can then query inside vim
using something like fzf. This should be defined in the .vimrc or [associated files](https://github.com/SeaCastle/LinuxThings/blob/master/.config/vim-plugins/fzf.vim)
