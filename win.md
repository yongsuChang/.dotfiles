# Installed
## apt-get
- zsh : Custom shell
- neovim : Forked project of vim
    - 0.9.5
    - Link: [neovim install][nvim-link]
        ```
        // install
        sudo apt update
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
    // install
    sudo apt update
    sudo apt install lsd

    // set command `ls`
    sudo update-alternatives --install /usr/bin/ls ls /usr/bin/lsd 10
    ```

- fd-find : file name search
    ```
    // install
    sudo apt update
    sudo apt install fd-find

    // set command `fd` for fd-find
    mkdir -p ~/.local/bin
    ln -s $(which fdfind) ~/.local/bin/fd
    ```

- openjdk17
    ```
    sudo apt update
    sudo apt install openjdk-17-jdk
    ```
- maven
    ```
    sudo apt update
    sudo apt install maven
    ```

### Optional
- net-tools : netstat
    ```
    sudo apt update
    sudo apt install net-tools
    ```
- gh : github cli
    ```
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
    ```
- maria-db : mysql fork
    ```
    sudo apt update
    sudo apt install mariadb-server mariadb-client -y
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
