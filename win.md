# Installed
## apt-get
- zsh : Custom shell
- neovim : Forked project of vim
    - 0.9.5
    - Link: [neovim install][nvim-link]
        ```
        // install
        sudo add-apt-repository ppa:neovim-ppa/unstable
        sudo apt install neovim

        // settings for making `vi`, `vim` command to process neovim
        sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 10
        sudo update-alternatives --config vim
        sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 10
        sudo update-alternatives --config vi
        ```
- gcc : C compiler
- ripgrep : Die old grep (improved grep)
- lsd : Prettier ls
    ```
    // set command `ls`
    sudo update-alternatives --install /usr/bin/ls ls /usr/bin/lsd 10
    ```

- fd-find : file name search
    ```
    // set command `fd` for fd-find
    mkdir -p ~/.local/bin
    ln -s $(which fdfind) ~/.local/bin/fd
    ```

- openjdk17
    ```
    sudo apt install openjdk-17-jdk
    ```


## Manually installed
### Settings
- fonts : CaskaydiaCove Nerd font
    - Link: [NERD FONTS][nerdfonts-link]
- p10k : Shell styling
    - Link : [PowerLevel10k][powerlevel10k-link]
- NodeJS : 
    - Link: [NodeJs][node-link]
    - node : 22.13.0
    - npm : 10.9.2

### Build
- pnpm : faster package installer
    - Link: [pnpm install][pnpm-link]
    - 10.0.0

### Customize
- NvChad : Fancier neovim
    - Link: [NvChad install][nvchad-link]

[nvim-link]: https://github.com/neovim/neovim/blob/master/INSTALL.md#ubuntu "Go neovim"
[nerdfonts-link]: https://www.nerdfonts.com "Go Nerdfonts"
[powerlevel10k-link]: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#installation "Go p10k"
[node-link]: https://github.com/nodesource/distributions?tab=readme-ov-file#using-ubuntu-nodejs-22 "Go node"
[pnpm-link]: https://pnpm.io/ko/installation "Go pnpm"
[nvchad-link]: https://nvchad.com/docs/quickstart/install "Go NvChad"
