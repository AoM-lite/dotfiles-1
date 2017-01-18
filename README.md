Instructions to get a pretty and functional VIM setup!

# Installation

Checkout this repo: `git clone https://github.com/christianrondeau/.vim ~/.vim`

## Windows-specific
1. Create environment variables:
  1. User `HOME` pointing to to `C:\Users\(username)`
  1. User `VIM` pointing to to `C:\Users\(username)\.vim`
  1. System `VIMRUNTIME` pointing to to the Vim installation path (may not be required)
1. Get [The Silver Searcher (Ag)](http://geoff.greer.fm/ag/) using `choco install ag -y`, or download it  from https://blog.kowalczyk.info/software/the-silver-searcher-for-windows.html
1. Get [vimproc.vim](https://github.com/Shougo/vimproc.vim) assemblies from https://github.com/Shougo/vimproc.vim/releases (if using TypeScript)
1. Install the Hack font *with PowerLine patch* using `choco install hackfont` or download it from: Download from https://github.com/powerline/fonts/tree/master/Hack
1. Start VIM and run `:PlugInstall`

## Linux-specific
1. Create a symlink to the `vimrc` file": `ln -s ~/.vim/_vimrc ~/.vimrc`
1. Install [The Silver Searcher (Ag)](http://geoff.greer.fm/ag/): `sudo apt-get install silversearcher-ag`
1. Install the Hack font: `sudo apt-get install fonts-hack-ttf`

## Cygwin-specific
1. Create a symlink to the `vimrc` file": `ln -s ~/.vim/_vimrc ~/.vimrc`
1. Add the content of the [cygwin bashrc template](templates/.bashrc_cygwin) to `~/.bashrc` and [gitconfig template](templates/.gitconfig_cygwin) to `~/.gitconfig`
1. Start VIM and run `:PlugInstall`

## Termux-specific
1. Create a symlink to the `vimrc` file": `ln -s ~/.vim/_vimrc ~/.vimrc`
1. Install [The Silver Searcher (Ag)](http://geoff.greer.fm/ag/): `apt install silversearcher-ag`
1. Install the Hack font: Buy https://play.google.com/store/apps/details?id=com.termux.styling&hl=en

# Usage

See [_vimrc](https://github.com/christianrondeau/.vim/blob/master/_vimrc) for all shortcuts and overrides
