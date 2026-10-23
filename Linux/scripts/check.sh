#!/usr/bin/env bash
set -euo pipefail
root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
count=0
while IFS= read -r -d '' file; do
    case "$file" in *.png|*.jpg|*.zip|*.gz) continue ;; esac
    first=$(head -n 1 "$file")
    if [[ $file == *.sh || $first == '#!'*bash* ]]; then
        bash -n "$file"
        if command -v shellcheck >/dev/null 2>&1; then shellcheck -S error "$file"; fi
        ((count+=1))
    fi
done < <(find "$root/packages" "$root/scripts" -type f -print0)
bash -n "$root/packages/bash/.bashrc"
bash -n "$root/packages/bash/.bash_aliases"
if command -v zsh >/dev/null 2>&1; then
    zsh -n "$root/packages/zsh/.zshrc"
    zsh -n "$root/packages/zsh/.config/zsh/aliases.zsh"
else
    echo 'Zsh ausente: validação ignorada.'
fi
printf 'Sintaxe verificada: %s scripts e arquivos Bash.\n' "$count"
echo 'Validar i3 e Sway na sessão Linux, depois de instalar: i3 -C; sway --validate'
