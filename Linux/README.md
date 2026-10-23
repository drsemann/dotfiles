# Dotfiles Linux

Configurações organizadas por aplicativo, com instalação por links simbólicos.
Os arquivos principais são derivados de `tmux-novo`, `vimrc-novo` e
`bashrc-powerline`. As outras versões e os backups antigos foram retirados
do conjunto ativo e estão na cópia integral anterior à reorganização.

## Estrutura

- `packages/`: cada pacote espelha os caminhos dentro de `$HOME`.
- `profiles/`: seleção de pacotes por ambiente.
- `hosts/example/`: exemplos de configuração específica de monitores.
- `assets/wallpapers/`: coleção original de imagens, preservada.
- `system/plymouth/`: recurso de sistema; não é instalado automaticamente.
- `scripts/`: instalador e verificação.

## Instalação no Linux

Requisitos do instalador: Bash, find e utilitários GNU usuais. Não use sudo.
O destino é o `$HOME` do usuário atual. Os caminhos XDG padrão são usados;
esta configuração não trata diretórios XDG personalizados.

```bash
bash scripts/check.sh
bash scripts/install.sh --profile minimal
bash scripts/install.sh --profile desktop-sway
bash scripts/install.sh --profile desktop-sway --apply --backup
```

Sem `--apply`, o instalador apenas mostra o plano. Com `--apply`, conflitos
interrompem a instalação antes dos links serem criados. `--backup` move os
arquivos conflitantes para `~/.local/state/dotfiles-backups/<data-pid>/`,
preservando seus caminhos relativos. Repetir a instalação mantém links já
corretos. Os links são absolutos: mantenha o checkout no mesmo local ou
reinstale com backup depois de movê-lo.

Para desfazer, remova somente os links criados pelo instalador, listados
na saída `LINK`, e restaure os arquivos do diretório de backup para os
respectivos caminhos em `$HOME`. O instalador não instala pacotes do sistema.

## Perfis e dependências

Os nomes abaixo são executáveis/projetos; nomes dos pacotes variam por distribuição.

| Perfil | Componentes e dependências |
| --- | --- |
| minimal | Bash 4.4+, Git, Tmux, Vim, Nerd Font; fzf opcional com suporte a `--bash` |
| desktop-sway | minimal + Zsh, Neovim, Kitty, Fastfetch, Ranger, Sway, swaybg, swayidle, Waybar, SwayNC, gtklock, Foot, Wofi, Rofi com suporte a Wayland, grim, slurp, wl-clipboard, cliphist, libnotify, pamixer, pactl, pulsemixer, brightnessctl, playerctl, Thunar, nm-applet, lxpolkit |
| desktop-i3 | minimal + Zsh, Neovim, Alacritty, Fastfetch, Ranger, i3, Polybar, Picom, Rofi, dex, xss-lock, i3lock, nitrogen, pactl, playerctl |

Sway também tem atalhos para `brave-browser`, `subl` e `proton-mail`:
instale esses aplicativos ou altere os atalhos. Fontes referenciadas incluem
Lilex Nerd Font, JetBrainsMono Nerd Font, Hack Nerd Font e fontes de ícones
da Polybar. Ajuste para as fontes disponíveis no seu sistema.

Aliases usam eza ou exa quando disponíveis; grc, zoxide e plugins do Zsh são
opcionais. Plugins do Zsh podem ser instalados em
`~/.zsh/zsh-autosuggestions/` e `~/.zsh/zsh-syntax-highlighting/`.

Os pacotes `starship`, `foot` e `wofi` são alternativas disponíveis. Starship
não é ativado pelos perfis, pois o Bash usa Powerline próprio e o Zsh usa
seu prompt original. Para adotá-lo, substitua a inicialização do prompt.
Kitty é o terminal padrão no Sway; Alacritty é o padrão no i3.

## Ajustes por máquina

- Sway: edite `~/.config/sway/outputs`, `workspaces` ou `local.conf`.
  Há um exemplo em `hosts/example/sway-outputs.conf`.
- i3: edite `~/.config/i3/local.conf`; o mapeamento antigo de HDMI-1/VGA-1
  está em `hosts/example/i3-monitors.conf`, sem ativação automática.
- Polybar: exporte `POLYBAR_EXTERNAL_MONITOR` antes de iniciar o i3 para
  ativar a segunda barra. Sem essa variável, inicia apenas a barra principal.
- `~/.screenlayout/screenlayout.sh` é opcional; só será chamado se executável.

Os arquivos locais também são links para o checkout. Para manter ajustes
privados fora do Git, substitua o link local por um arquivo regular antes
de editá-lo. Faça backup desse arquivo antes de reinstalar.

## Validação e manutenção

`check.sh` verifica sintaxe Bash/Zsh e usa ShellCheck se disponível.
Ele não inicia sessões gráficas nem executa comandos de energia.
Na máquina Linux, após instalar os links, valide com `i3 -C` ou
`sway --validate` e verifique os logs dos aplicativos. A sintaxe do Alacritty
deve ser conferida contra a versão instalada; foi preservado o formato original.

Arquivos de texto usam UTF-8 e LF. Antes de publicar mudanças no Git,
registre o bit executável dos scripts com `git update-index --chmod=+x`
ou `chmod +x` em um checkout Linux. A coleção de temas do Alacritty foi
preservada para evitar descartar alternativas sem uma seleção explícita.

Plymouth exige instalação específica da distribuição, privilégios de
administrador e eventual atualização do initramfs. Seu ZIP permanece
somente em `system/plymouth/`, sem cópia duplicada na raiz.
