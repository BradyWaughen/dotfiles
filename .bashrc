# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- Git branch in prompt ---
parse_git_branch() {
    git branch 2>/dev/null | sed -n 's/^\* //p'
}

# Colors
_reset='\[\e[0m\]'
_pink='\[\e[38;5;204m\]'
_purple='\[\e[38;5;141m\]'
_blue='\[\e[38;5;39m\]'
_gold='\[\e[38;5;214m\]'
_gray='\[\e[38;5;240m\]'

# Prompt:
# [09:41] >> bradywaughen in ~/projects/app
# on (main) -> _
PS1="${_gray}[\t]${_reset} ${_pink}>>${_reset} ${_purple}\u${_reset} ${_gray}in${_reset} ${_blue}\w${_reset}\n\$(b=\$(parse_git_branch); [ -n \"\$b\" ] && echo \"${_gray}on${_reset} ${_gold}(\$b)${_reset} \")${_pink}->${_reset} "

# --- Aliases ---
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# --- History ---
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# --- Misc ---
shopt -s checkwinsize

# Update PATH
export PATH="$HOME/.npm-global/bin:$PATH"
