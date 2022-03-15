fpath=( "${ZDOTDIR:-$HOME}/.zfunctions" $fpath )

# .zshrc
autoload -U promptinit; promptinit
prompt spaceship

## Theme spaceship
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="🚀"
SPACESHIP_CHAR_SUFFIX=" "

## Custom alias
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/doc/fzf/examples/key-bindings.zsh

export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='exa --icons'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lha'

alias grep='grep --color'
alias egrep='egrep --color'
alias ip='ip -c'
alias diff='diff --color'
alias meuip='curl ifconfig.me; echo;'
alias tail='grc tail'
alias ping='grc ping'
alias ps='grc ps'
alias netstat='grc netstat'
alias dig='grc dig'
alias traceroute='grc traceroute'
alias apt='sudo apt'
alias ifconfig='grc ifconfig'
alias l='ls -lh'
alias la='ls -lha'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

## Vte
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
