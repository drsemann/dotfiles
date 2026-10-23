#!/usr/bin/env bash
set -euo pipefail
root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
profile=minimal
apply=0
backup=0
while (($#)); do
    case "$1" in
        --apply) apply=1 ;;
        --backup) backup=1 ;;
        --profile) shift; profile=${1:?Informe o perfil} ;;
        --help) printf 'Uso: bash scripts/install.sh [--profile minimal|desktop-sway|desktop-i3] [--apply] [--backup]\n'; exit 0 ;;
        *) printf 'Opção desconhecida: %s\n' "$1" >&2; exit 1 ;;
    esac
    shift
done
case "$profile" in minimal|desktop-sway|desktop-i3) ;; *) echo 'Perfil inválido' >&2; exit 1 ;; esac
sources=()
targets=()
while IFS= read -r package; do
    [[ -n $package && $package != \#* ]] || continue
    [[ -d $root/packages/$package ]] || { echo "Pacote ausente: $package" >&2; exit 1; }
    while IFS= read -r -d '' file; do
        sources+=("$file")
        targets+=("$HOME/${file#"$root/packages/$package/"}")
    done < <(find "$root/packages/$package" -type f -print0)
done < "$root/profiles/$profile.txt"
if [[ $profile == desktop-sway ]]; then
    sources+=("$root/assets/wallpapers")
    targets+=("$HOME/.local/share/wallpapers")
fi
# Valida todos os conflitos antes da primeira alteração.
conflicts=0
for i in "${!sources[@]}"; do
    src=${sources[$i]}; dst=${targets[$i]}
    if [[ -L $dst && $(readlink -- "$dst") == "$src" ]]; then continue; fi
    if [[ -e $dst || -L $dst ]]; then
        printf 'CONFLITO: %s\n' "$dst"
        if (( ! backup )); then conflicts=1; fi
    fi
    parent=${dst%/*}
    while [[ $parent != / ]]; do
        if [[ -e $parent && ! -d $parent ]]; then
            printf 'Diretório pai inválido: %s\n' "$parent" >&2; exit 1
        fi
        parent=${parent%/*}
        [[ -n $parent ]] || parent=/
    done
    printf 'LINK: %s -> %s\n' "$dst" "$src"
done
if (( ! apply )); then echo 'Simulação concluída. Use --apply para instalar; --backup para preservar conflitos.'; exit 0; fi
if (( conflicts )); then echo 'Instalação interrompida: resolva conflitos ou use --backup.' >&2; exit 1; fi
# Confirma suporte a links antes de mover qualquer configuração existente.
probe_dir=$(mktemp -d "$HOME/.dotfiles-link-check.XXXXXX")
cleanup_probe() { rm -f -- "$probe_dir/link" "$probe_dir/source"; rmdir -- "$probe_dir"; }
trap cleanup_probe EXIT
: > "$probe_dir/source"
if ! ln -s -- "$probe_dir/source" "$probe_dir/link" || [[ ! -L $probe_dir/link ]]; then
    echo 'Este ambiente não permite links simbólicos reais. Nenhuma configuração foi substituída.' >&2
    exit 1
fi
cleanup_probe
trap - EXIT
backup_dir="$HOME/.local/state/dotfiles-backups/$(date +%Y%m%d-%H%M%S)-$$"
for i in "${!sources[@]}"; do
    src=${sources[$i]}; dst=${targets[$i]}
    if [[ -L $dst && $(readlink -- "$dst") == "$src" ]]; then continue; fi
    if [[ -e $dst || -L $dst ]]; then
        saved="$backup_dir/${dst#"$HOME/"}"
        mkdir -p -- "$(dirname -- "$saved")"
        mv -- "$dst" "$saved"
        printf 'BACKUP: %s\n' "$saved"
    fi
    mkdir -p -- "$(dirname -- "$dst")"
    case "$src" in */scripts/*|*/launch.sh) chmod u+x -- "$src" ;; esac
    ln -s -- "$src" "$dst"
done
printf 'Perfil instalado: %s\n' "$profile"
