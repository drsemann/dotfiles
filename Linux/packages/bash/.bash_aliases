# Aliases comuns; ferramentas opcionais só são ativadas se disponíveis.
if command -v dircolors >/dev/null 2>&1; then eval "$(dircolors -b)"; fi
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons'
elif command -v exa >/dev/null 2>&1; then
    alias ls='exa --icons'
else
    alias ls='ls --color=auto'
fi
alias ll='ls -l'
alias l='ls -lh'
alias la='ls -lha'
alias grep='grep --color=auto'
alias ip='ip -c'
alias diff='diff --color=auto'
alias meuip='curl https://ifconfig.me; echo'
if command -v grc >/dev/null 2>&1; then
    alias tail='grc tail'
    alias ping='grc ping'
    alias ps='grc ps'
    alias netstat='grc netstat'
    alias dig='grc dig'
    alias traceroute='grc traceroute'
    alias ifconfig='grc ifconfig'
fi
if command -v apt >/dev/null 2>&1; then
    alias aptu='sudo apt update && sudo apt upgrade'
    alias apti='sudo apt install'
    alias aptr='sudo apt remove'
    alias apts='apt search'
    alias aptc='sudo apt autoremove && sudo apt clean'
fi
