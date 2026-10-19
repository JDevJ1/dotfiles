# My dotfiles

This directory contains the dotfiles for a custom zsh shell

## Requirements

Ensure you have the following installed on your system

### Git

```
dnf install git
```

### Stow

```
dnf install stow
```

### Zsh

```
dnf install zsh

chsh -s $(command -v zsh)
```

### Nerd Fonts

Install a nerd font for the shell theme to be displayed correctly

### Additional tools

```
dnf install fzf fastfetch
```

Optional: [Homebrew](https://brew.sh) and terraform. They are only loaded if they are installed.

[oh-my-posh](https://ohmyposh.dev) and the plugin manager [zinit](https://github.com/zdharma-continuum/zinit) are installed automatically on the first start of zsh (requires `curl` and `git`).

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
git clone git@github.com:JDevJ1/dotfiles.git

cd dotfiles
```

then use GNU stow to create symlinks

```
stow .
```

then execute zsh
```
exec zsh
```
