# Installed
## apt-get
- zsh : Custom shell
- neovim : Forked project of vim
    - 0.9.5
    - https://github.com/neovim/neovim/blob/master/INSTALL.md#ubuntu
```
# install
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt install neovim

# settings for making `vi`, `vim` command to process neovim
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 10
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 10
sudo update-alternatives --config vi
```
- gcc : C compiler
- ripgrep : Die old grep (improved grep)
- lsd : Prettier ls
    - sudo update-alternatives --install /usr/bin/ls ls /usr/bin/lsd 10

 - fd-find : file name search
    - set command `fd` for fd-find
        - mkdir -p ~/.local/bin
        - ln -s $(which fdfind) ~/.local/bin/fd



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
```
### Change some npm command to pnpm ###
# make npm cofig for command
sudo vim /usr/local/bin/npm
 
# inside of npm file
if [[ "$1" == "run" && ( "$2" == "build" || "$2" == "start" ) ]]; then
    echo "Redirecting npm run $2 to pnpm run $2..."
    pnpm run "$2"
elif [[ "$1" == "start" ]]; then
    echo "Redirecting npm start to pnpm start..."
    pnpm start
fi
```
    

### Customize
- NvChad : Fancier neovim
    - https://nvchad.com/docs/quickstart/install