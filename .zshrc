# ~/.config/zsh/.zshrc

# ---------- Load core modules ----------
autoload -Uz compinit && compinit
autoload -Uz colors && colors
zmodload zsh/complist

# ---------- Completion ----------
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
setopt auto_menu
setopt autocd
setopt auto_param_slash
setopt no_case_glob
setopt interactive_comments
setopt share_history

# ---------- History ----------
HISTFILE=~/.cache/zsh_history
HISTSIZE=5000
SAVEHIST=5000

# ---------- Prompt ----------
PROMPT='%{%F{cyan}%}%n%{%f%} [%{%F{yellow}%}%~%{%f%}]
> '


# ---------- Plugins ----------
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ---------- Aliases ----------
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -a'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias v='nvim'
alias x='exit'
alias zz='shutdown now'
alias rs='reboot'
alias ff='fastfetch'
alias pl='pacman -Q | less'
alias p='yay'
alias rem='sudo pacman -Rns'
alias cl='curl -O'
