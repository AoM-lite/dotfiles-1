Instructions to get a pretty and functional VIM setup!

# Installation

Clone this repo: `git clone https://github.com/christianrondeau/.vim ~/dotfiles` and run `bootstrap` with your desired profile.

## Profiles

* `minimal`: Just vim, core tools and some bash settings. Useful for docker machines. The default.
* `basic`: The common denominator of all development computers. Fish, tmux, vim plugins.
* `full`: All tools for a day-to-day use computer.

## Windows

    Set-ExecutionPolicy RemoteSigned
    ~/bootstrap.ps1

## Linux

    sudo ~/bootstrap.sh -p basic

## Cygwin

    ~/bootstrap.sh -p basic

## Termux

Install the Hack font: https://play.google.com/store/apps/details?id=com.termux.styling&hl=en

    ~/termux-bootstrap.sh -p basic

## Gotchas

* If a config file exists, `bootstrap` will complain; you'll have to manually delete those files. This is by design.
* Chocolatey installs vim in `~/.vim/vim80`... sometimes. Create a `VIMRUNTIME` environment variable.
* Get [Python 2.7 x86](https://www.python.org/) using `choco install choco install python2-x86_32 -y`, or download it from https://www.python.org/downloads/ if 32bit vim is used. Set the `PYTHONHOME` environment variable to `C:\tools\python2-x86_32` if using Python 2.7.11 ([fixed in 2.7.12](https://github.com/vim/vim/issues/526))
