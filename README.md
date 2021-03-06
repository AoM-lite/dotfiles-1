# Christian Rondeau's dotfiles

Get a nice and clean environment in a few seconds!

## Overview

I am using vim, git, and all sorts of tools on Windows as well as multiple Linux distributions, and I got tired of synchronizing all my configurations, so here you go: a cross-platform bootstrapping script (using `apt` on Linux and `choco` on Windows), and a set of nice symlinked prompts and configuration files (using `stow` on Linux and home-made symlinks on Windows).

Optimized for `PowerShell` on Windows and `Fish` on Linux, but it also provides settings for `bash`.

## Installation

Clone this repo: `git clone https://github.com/christianrondeau/dotfiles ~/dotfiles` and run `bootstrap`.

### Profiles

- `minimal`: Just vim, core tools and some bash settings. Useful for docker machines. The default.
- `basic`: The common denominator of all development computers. Fish, tmux, vim plugins.
- `full`: All tools for a day-to-day use computer.

### Windows

In a PowerShell window:

    cd ~/
    Set-ExecutionPolicy RemoteSigned -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    # Restart console
    choco install git putty -y
    # Restart console
    git clone https://github.com/christianrondeau/dotfiles $env:HOMEDRIVE$env:HOMEPATH/dotfiles
    cd dotfiles
    ~/bootstrap.ps1 -Profile Basic

- Now, create a SSH key with puttygen in `~/.ssh/id_rsa`, and add a startup link in `%AppData%\Microsoft\Windows\Start Menu\Programs\Startup` to `C:\ProgramData\chocolatey\lib\putty.portable\tools\pageant.exe "%HOMEDRIVE%%HOMEPATH%\.ssh\id_rsa.ppk"`
- Add an environment variable `GIT_SSH` pointing to `C:\ProgramData\chocolatey\lib\putty.portable\tools\plink.exe`
- Add an environment variable `VIM_RUNTIME` pointing to `C:\Program Files\Vim\vim80`
- Add a `~/.gitlist` containing all repositories you want updated automatically by `update.ps1`

### Linux (Ubuntu/Mint)

    bash <(curl -s https://raw.githubusercontent.com/christianrondeau/dotfiles/master/provision/provision-ubuntu.sh)

Or if you prefer doing it manually:

    sudo apt-get install git -y
    git clone git@github.com:christianrondeau/dotfiles.git
    cd dotfiles
    ./bootstrap.sh -p basic

### Termux

Same instructions as linux, but instead run `./termux-bootstrap.sh`

Install the Hack font: https://play.google.com/store/apps/details?id=com.termux.styling&hl=en

### Docker

You can also run a mini development environment in Docker:

    docker-compose run devel fish
    ./bootstrap.sh -p basic

### Gotchas

- If a config file exists, `bootstrap` will complain; you'll have to manually delete those files. This is by design.
