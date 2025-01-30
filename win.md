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
    ```

- fd-find : file name search
    ```
    // install
    sudo apt update
    sudo apt install fd-find
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
- gradle
    ```
    sudo apt update && sudo apt install -y gradle
    ```

- noto-san-cjk
    ```
    // install
    sudo apt update && sudo apt install -y fonts-nanum fonts-noto-cjk fonts-noto-cjk-extra fonts-noto-color-emoji

    // adjust
    sudo locale-gen ko_KR.UTF-8
    sudo update-locale LANG=ko_KR.UTF-8

    // restart
    exec zsh

    // check
    locale // LANG=ko_KR.UTF-8
    ```
- Korean type
    ```
    // install
    sudo apt install fcitx-hangul -y
    ```
    ```
    // ~/.zshrc
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"
    export DefaultIMModule=fcitx
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
- pass & gpg : password manager
    ```
    // install
    sudo apt update
    sudo apt install pass gpg

    // assert
    pass --version

    // create password
    gpg --gen-key
    gpg --list-keys

    // init
    pass init <gpg-id>

    // add password
    pass insert <password-name>

    // show password
    pass database/<password-name>
    // ex) pass database/github_token
    ```
    ```
    // git integration

    // make git repository
    cd ~/.password-store
    git init
    git remote add origin <git-repo>

    // commit
    git add .
    git commit -m "init"
    git push origin main
    ```
    ```
    // clone from other device

    // export gpg key
    git clone <git-repo> ~/.password-store
    gpg --export-secret-keys --armor "your-email@example.com" > gpg-key.asc

    // import gpg key
    gpg --import gpg-key.asc

    // set trust
    gpg --edit-key "your-email@example.com" trust

    // init
    pass init <gpg-id>
    ```
- telnet : network tool
    ```
    sudo apt update
    sudo apt install telnet
    ```

- tmux
    ```
    sudo apt update
    sudo apt install -y tmux
    ```
- tpm : tmux plugin manager
    ```
    // install
    git clone git@github.com:tmux-plugins/tpm.git ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```

## Manually installed
### Settings
- fonts : CaskaydiaCove Nerd font
    - Link: [NERD FONTS][nerdfonts-link]
- p10k : Shell styling
    - Link : [PowerLevel10k][powerlevel10k-link]
- nvm : Node Version Manager
    ```
    // ~/.zshrc
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    ```
    ```
    nvm install --lts
    nvm use --lts
    ```
    - node : 22.13.0
    - npm : 10.9.2

### Build
- pnpm : faster package installer
    - Link: [pnpm install][pnpm-link]
    - 10.0.0

### Customize
- NvChad : Fancier neovim
 - Link: [NvChad install][nvchad-link]

### Language Server
- jdtls-language-server
    - Java grammar check
    ```
    npm install -g jdtls
    ```
- typescript-language-server
    - TypeScript grammar check
    ```
    npm install -g typescript-language-server
    ```
- tailwindcss-language-server
    - TailwindCSS grammar check
    ```
    npm install -g tailwindcss-language-server
    ```

### Reminder
- Wayland error
    ```
    // unset
    unset WAYLAND_DISPLAY
    unset XDG_RUNTIME_DIR

    // set
    export XDG_RUNTIME_DIR=/run/user/1000
    touch /run/user/1000/wayland-0
    chmod 600 /run/user/1000/wayland-0
    ```

[nvim-link]: https://github.com/neovim/neovim/blob/master/INSTALL.md#ubuntu "Go neovim"
[nerdfonts-link]: https://www.nerdfonts.com "Go Nerdfonts"
[powerlevel10k-link]: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#installation "Go p10k"
[node-link]: https://github.com/nodesource/distributions?tab=readme-ov-file#using-ubuntu-nodejs-22 "Go node"
[pnpm-link]: https://pnpm.io/ko/installation "Go pnpm"
[nvchad-link]: https://nvchad.com/docs/quickstart/install "Go NvChad"
