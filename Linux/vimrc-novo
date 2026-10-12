" ====================================================================
" OPTIONS & BEHAVIOR (Mantidos da sua configuração original)
" ====================================================================
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set mouse-=a
set number
set splitbelow splitright
set title
set ttimeoutlen=0

set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on

set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set scrolloff=10
set nowrap

set incsearch
set ignorecase
set smartcase

set showcmd
set showmode
set showmatch
set hlsearch
set history=1000

set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" ====================================================================
" PALETA DE CORES AZUL MODERN (Igual ao seu TMUX)
" ====================================================================
" Ativa suporte a True Color (24-bit) no terminal
if has("termguicolors")
    set termguicolors
endif

" Customização das cores dos painéis e interface para combinar com o Tmux
highlight LineNr          guifg=#565f89 guibg=#1f2335 ctermfg=244 ctermbg=235
highlight CursorLineNr    guifg=#7aa2f7 guibg=#3b4261 ctermfg=111 ctermbg=236 cterm=bold
highlight VertSplit       guifg=#24283b guibg=#1f2335 ctermfg=236 ctermbg=235
highlight CursorLine                    guibg=#24283b                 ctermbg=236

" ====================================================================
" BARRA DE STATUS POWERLINE NATIVA (Melhorada e Dinâmica)
" ====================================================================
set laststatus=2 " Sempre mostra a barra de status

" Função para traduzir as siglas internas do Vim em texto amigável
function! StatuslineMode()
    let l:mode = mode()
    if l:mode==#"n"  | return "NORMAL"  | endif
    if l:mode==#"i"  | return "INSERT"  | endif
    if l:mode==#"v"  | return "VISUAL"  | endif
    if l:mode==#"V"  | return "V-LINE"  | endif
    if l:mode==#"\<C-v>" | return "V-BLOCK" | endif
    if l:mode==#"c"  | return "COMMAND" | endif
    if l:mode==#"R"  | return "REPLACE" | endif
    return l:mode
endfunction

" Definição das cores dos blocos (Ajustadas para transição suave dos glifos)
highlight User1 guifg=#1f2335 guibg=#7aa2f7 gui=bold ctermfg=235 ctermbg=111 cterm=bold " Bloco de Destaque (Modo/Posição)
highlight User2 guifg=#7aa2f7 guibg=#3b4261 gui=none ctermfg=111 ctermbg=236          " Informações de Arquivo
highlight User3 guifg=#565f89 guibg=#1f2335 gui=none ctermfg=244 ctermbg=235          " Fundo central escuro
highlight User4 guifg=#7aa2f7 guibg=#3b4261 gui=none ctermfg=111 ctermbg=236          " Transição Direita interna
" Destaques específicos para os triângulos rígidos do Powerline (Inversão de cores)
highlight User5 guifg=#7aa2f7 guibg=#3b4261 gui=none ctermfg=111 ctermbg=236
highlight User6 guifg=#3b4261 guibg=#1f2335 gui=none ctermfg=236 ctermbg=235

" Montagem milimétrica da linha de status com os separadores da Nerd Font
set statusline=
set statusline+=%1*\ %{StatuslineMode()}\ %*     " Bloco do Modo Atual
set statusline+=%5*%*                           " Seta transição bloco 1 -> 2
set statusline+=%2*\ %f\ %M%R%H%W\ %*            " Nome do arquivo e flags
set statusline+=%6*%*                           " Seta transição bloco 2 -> 3
set statusline+=%3*%=%*                          " Preenchimento vazio até a direita
set statusline+=%3*\ %Y\ %*                      " Tipo do arquivo (Syntax)
set statusline+=%6*%*                           " Seta invertida bloco 3 <- 4
set statusline+=%4*\ %{&fileencoding?&fileencoding:&encoding}\ [%{&ff}]\ %*
set statusline+=%5*%*                           " Seta invertida bloco 4 <- 5
set statusline+=%1*\ L:%l/%L\ C:%c\ %*           " Bloco de posição da linha e coluna
