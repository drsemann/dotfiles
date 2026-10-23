# zsh essentials
HISTFILE="$HOME/.zsh_history"             # Save 100000 lines of history
HISTSIZE=100000
SAVEHIST=100000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.

source "$HOME/.config/zsh/aliases.zsh"
[[ -r "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -r "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# A Colorful Prompt with OS Version
#autoload -Uz colors
#colors
bg1='#bdf'; bg2='#259'; bg3='236'
fg1='#259'; fg2='#bdf'; fg3='245'

PROMPT_USER="%K{$bg1}%F{$fg1} %n %K{$bg2}%F{$bg1}"
PROMPT_HOSTNAME="%K{$bg2}%F{$fg2} %m %(!.%K{red}%F{$bg2}.%K{$bg3}%F{$bg2})"
PROMPT_DIRECTORY="%(!.%K{red}%F{white}.%K{$bg3}%F{$fg3})%3~ %(!.%k%F{red}.%k%F{$bg3})%f%k "

PROMPT="${PROMPT_USER} ${PROMPT_HOSTNAME} ${PROMPT_DIRECTORY}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
    alias cd="z"
fi
