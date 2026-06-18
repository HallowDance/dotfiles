# Path to your oh-my-zsh installation.
export ZSH="/home/hallowdance/.oh-my-zsh"

export EDITOR=/usr/sbin/nvim
export TERMINAL=urxvt

SAVEHIST=999999
HISTSIZE=999999
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

ZSH_THEME="spaceship"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Prompt settings
P9K_PROMPT_ON_NEWLINE=true
P9K_RPROMPT_ON_NEWLINE=true
P9K_MULTILINE_FIRST_PROMPT_PREFIX_ICON=$'%K{white}%k'
P9K_MULTILINE_LAST_PROMPT_PREFIX_ICON=$'%K{green}%F{black} \uf155 %f%F{green}%k\ue0b0%f '




# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export LS_COLORS="$(vivid -m 8-bit generate solarized-light)"



autoload -Uz compinit 
compinit
#promptinit

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain priviliges 1

plugins=(zsh-fzf-history-search)



#Configure PATH
typeset -U path
path=(/home/hallowdance/perl5/bin:/home/hallowdance/perl5/perlbrew/bin:/home/hallowdance/perl5/perlbrew/perls/perl-5.20.1/bin:/home/hallowdance/bin:/home/hallowdance/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin $path[@])


# Aliases 
alias i3lock='i3lock-fancy -t "Speak Friend and Enter" -f Inconsolata -- scrot'  
alias lock='dm-tool lock'
alias gulp='$HOME/.config/i3/i3-swallow'
alias nemo='gulp nemo'
alias fehthumb='feh --auto-zoom --scale-down --full-screen --thumbnails  --thumb-height 100 --thumb-width 100 --index-info ""'
alias v='NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim' 
alias cp='cp -iv'
alias rcp='rsync -v --progress'
alias rmv='rsync -v --progress --remove-source-files'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'
alias ln='ln -v'
alias rn='ranger'
alias feh='feh --auto-zoom --scale-down'
alias dp='( urxvt & ) &>/dev/null'
alias cdd='cd "$($(history | cut -c 8- | tail -1))"'
alias srxvt="urxvt -fg green"
# Print Neofetch Buffer

export COWPATH=/usr/local/share/cows
#for latex
export TEXMFHOME=~/tex/texmf
alias pandasay="cowsay -f panda"

# Show largest entries (incl. dotfiles) in a dir. Usage: dirsizes [path] [count]
dirsizes() {
  du -sh "${1:-.}"/* "${1:-.}"/.[!.]* 2>/dev/null | sort -rh | head -"${2:-20}"
}


export ZSH="/home/hallowdance/.oh-my-zsh"
source ~/.oh-my-zsh/oh-my-zsh.sh

export PATH=$PATH:~/fun
export PATH=$PATH:~/scripts

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Manage dotfiles via bare repo at ~/.dotfiles
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
