#Things to do when setting up a new Linux install

##Essential installs
sudo apt install make gcc nvim clangd
you can also install npm if you want for coc. Not needed though

##Terminal
https://sw.kovidgoyal.net/kitty/#configuring-kitty

##Fonts
https://www.nerdfonts.com/font-downloads  (currently using Fira Code)
  - cd /usr/share/fonts/truetype/
  - mkdir newfonts
  - cd newfonts
  - cp [nerd-font-name.ttf] .
  - fc-cache -f -v  (there should be an alias for this -- fontUpdate)
https://github.com/ryanoasis/powerline-extra-symbols  (used in kitty terminal)
  - cd /usr/share/fonts/opentype/
  - mkdir newfonts
  - cd newfonts
  - cp [nerd-font-name.otf] .
  - fc-cache -f -v  (there should be an alias for this -- fontUpdate)

##Vim
Don't forget to run :PlugInstall to install all plugins / colorschemes etc
  - if still using xcodedarkcpp then cp LinuxThings/extra/colors/xcodedarkcpp ~/.vim/colors
