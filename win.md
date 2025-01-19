# Installed
## apt-get
- zsh : Custom shell
- neovim : Forked project of vim
    - 0.9.5
    - https://github.com/neovim/neovim/blob/master/INSTALL.md#ubuntu
        - sudo add-apt-repository ppa:neovim-ppa/unstable
        - sudo apt install neovim
        - sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 10
        - sudo update-alternatives --config vim
        - sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 10
        - sudo update-alternatives --config vi
- gcc : C compiler
- ripgrep : Die old grep
- lsd : Prettier ls
    - sudo update-alternatives --install /usr/bin/ls ls /usr/bin/lsd 10

 


## Manually installed
### Settings
- fonts : CaskaydiaCove Nerd font (from. Nerd Fonts)
- p10k : Shell styling
- NodeJS : 
    - https://github.com/nodesource/distributions?tab=readme-ov-file#using-ubuntu-nodejs-22
    - node : 22.13.0
    - npm : 10.9.2

### Build
- pnpm : faster package installer
    - https://pnpm.io/ko/installation
    - 10.0.0

### Customize
- NvChad : Fancier neovim
    - https://nvchad.com/docs/quickstart/install