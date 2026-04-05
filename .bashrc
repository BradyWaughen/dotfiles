# ~/.bashrc — Tokyo Night (portable, no dependencies)
# ============================================================
 
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
 
# --- Git branch in prompt ---
parse_git_branch() {
    git branch 2>/dev/null | sed -n 's/^\* //p'
}
 
# --- Tokyo Night Prompt Colors ---
# Using 256-color codes that map to the Tokyo Night palette.
# These work on any terminal with 256-color support — no config needed.
#   colour204  ~ #f7768e  red/pink (arrows, accents)
#   colour141  ~ #bb9af7  magenta  (username)
#   colour111  ~ #7aa2f7  blue     (paths)
#   colour209  ~ #ff9e64  orange   (git branch)
#   colour60   ~ #565f89  comment  (muted text, brackets)
#   colour114  ~ #9ece6a  green    (success indicators)
_reset='\[\e[0m\]'
_red='\[\e[38;5;204m\]'
_magenta='\[\e[38;5;141m\]'
_blue='\[\e[38;5;111m\]'
_orange='\[\e[38;5;209m\]'
_comment='\[\e[38;5;60m\]'
_green='\[\e[38;5;114m\]'
 
# Prompt:
# [09:41] >> brady in ~/projects/app
# on (main) -> _
PS1="${_comment}[\t]${_reset} ${_red}>>${_reset} ${_magenta}\u${_reset} ${_comment}in${_reset} ${_blue}\w${_reset}\n\$(b=\$(parse_git_branch); [ -n \"\$b\" ] && echo \"${_comment}on${_reset} ${_orange}(\$b)${_reset} \")${_red}->${_reset} "
 
# --- Aliases ---
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias tmc='~/.scripts/tmux-session.sh'
alias ccd='claude --dangerously-skip-permissions'
alias ccauto='claude --enable-auto-mode'
 
# --- History ---
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
 
# Flush history after every command (shared across sessions)
PROMPT_COMMAND="history -a;${PROMPT_COMMAND:-}"
 
# --- Shell Options ---
shopt -s checkwinsize
shopt -s cdspell          # auto-correct minor cd typos
shopt -s dirspell         # auto-correct directory name typos during completion
shopt -s globstar         # ** matches recursively in pathname expansion
shopt -s autocd           # type a directory name to cd into it
 
# --- PATH ---
export PATH="$HOME/.npm-global/bin:$HOME/.local/bin:$PATH"
 
# --- Env Vars ---
export EDITOR=vim
export CLAUDE_CODE_NO_FLICKER=1
