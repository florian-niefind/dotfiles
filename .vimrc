set nocompatible              " required
set hidden
syntax on
filetype plugin indent on

" vim-plug stuff ------------------------------------
" install vim plug automatically if it is not installed yet
if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" general plugins
Plug 'morhetz/gruvbox' "gruvbox color scheme
Plug 'tpope/vim-fugitive' "vim and git
Plug 'vim-airline/vim-airline'
Plug 'kien/rainbow_parentheses.vim'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" clojure specific plugins
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'tpope/vim-surround', {'for': 'clojure'}
Plug 'tpope/vim-repeat', {'for': 'clojure'}
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}

Plug 'vim-scripts/paredit.vim', {'for': 'clojure'}
Plug 'dense-analysis/ale', {'for': 'clojure'}


" python plugins
Plug 'tmhedberg/simpylfold', {'for': 'python'}

" others
Plug 'godlygeek/tabular', {'for': 'md'}
Plug 'plasticboy/vim-markdown', {'for': ['md', 'Rmd']}
Plug 'mechatroner/rainbow_csv'

Plug 'jalvesaq/Nvim-R', {'for': 'R'}

call plug#end()

" general settings ----------------------------
" leader key stuff
let mapleader = ","
let maplocalleader = "\\"
set showcmd "show when the leader key is pressed

" show five lines in the end at least
set scrolloff=5

set t_Co=256
set termguicolors
set background=dark

" set line numbering
set nu rnu

" access system clipboard instead of vim internal clipboard
set clipboard=unnamed

" utf-8!
set encoding=utf-8

" expand tab with spaces always
set expandtab
set tabstop=2

" folding based on indents
nnoremap <space> za
set foldenable
set foldmethod=indent
set foldlevel=99


" my remaps -----------------------------------
" remap leaving insert mode
inoremap jk <esc>
" leave insert mode and save
inoremap jw <esc>:w<cr>
" unmap the esc key
inoremap <esc> <nop>

" uppercase a word in insert mode after typing it
inoremap <c-u> <esc>hviwUea

" move lines up and down
nnoremap <leader>j ddp
nnoremap <leader>k ddkP

" switch L, H and $ and ^ due to frequency of use
nnoremap H ^
nnoremap L $
nnoremap $ L
nnoremap ^ H
vnoremap H ^
vnoremap L $
vnoremap $ L
vnoremap ^ H

" edit vimrc quickly
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"copy to system dashboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
"copy from system dashboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
"copy entire file contents to system dashboard
nnoremap <leader>yy ggVG"+y

" ag and fzf
nnoremap <leader>f :Files<cr>
nnoremap <leader>a :Ag<cr>

" tab cycles through popupmenu entries
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"


" autocommands -----------------------------------

" filetype based commenting options
augroup file_specific_keystrokes
        autocmd!
        autocmd FileType python
                                \ nnoremap <buffer> <localleader>c I# <esc> |
                                \ inoremap """ """<cr><cr>"""<up> |
        autocmd FileType sql nnoremap <buffer> <localleader>c I--<esc>
        autocmd FileType clojure
                                \ nnoremap <leader>rq :Require<cr> |
                                \ nnoremap <buffer> <localleader>c I;<esc> |
augroup end

" PEP-8 conform indenting and wrapping for python files
augroup file_specific_layouts
        autocmd!
        autocmd BufNewFile,BufRead,BufWinEnter *.R,*.sql
                                \ set tabstop=2 |
                                \ set softtabstop=2 |
                                \ set shiftwidth=2 |
                                \ set textwidth=79 |
                                \ set expandtab |
                                \ set autoindent |
                                \ set fileformat=unix |

        autocmd BufNewFile,BufRead,BufWinEnter *.py
                                \ set tabstop=4 |
                                \ set softtabstop=4 |
                                \ set shiftwidth=4 |
                                \ set textwidth=79 |
                                \ set expandtab |
                                \ set autoindent |
                                \ set fileformat=unix |

        autocmd BufNewFile,BufRead,BufWinEnter *.md,*.html,*.Rmd
                                \ set expandtab |
                                \ set tabstop=4 |
                                \ set shiftwidth=4 |
                                \ set textwidth=79 |
                                \ set autoindent |
augroup end

" remove trailing whitespace automatically
autocmd BufWritePre * %s/\s\+$//e

" Mark trailing whitespace
highlight BadWhitespace ctermbg=Red
autocmd BufNewFile,BufRead *.* match BadWhitespace /\s\+$/


" Plugin specific settings -----------------------------------
" gruvbox
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_italic=1

" default colorscheme
colorscheme gruvbox

" Rainbow parens
let g:rbpt_colorpairs = [
    \ ['brown',      '#fb4934'],
    \ ['Darkblue',   '#b8bb26'],
    \ ['darkgray',   '#fabd2f'],
    \ ['darkgreen',  '#83a598'],
    \ ['darkcyan',   '#d3869b'],
    \ ['darkred',    '#8ec07c'],
    \ ['darkmagenta','#fe8019'],
    \ ['brown',      '#a89984'],
    \ ['gray',       '#cc241d'],
    \ ['black',      '#98971a'],
    \ ['darkmagenta','#d79921'],
    \ ['Darkblue',   '#458588'],
    \ ['darkgreen',  '#b16286'],
    \ ['darkcyan',   '#689d6a'],
    \ ['darkred',    '#d65d0e'],
    \ ['red',        '#928374'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

augroup RainbowParens
        autocmd!
        au VimEnter * RainbowParenthesesToggle
        au Syntax * RainbowParenthesesLoadRound
        au Syntax * RainbowParenthesesLoadSquare
        au Syntax * RainbowParenthesesLoadBraces
        au Syntax * RainbowParenthesesLoadChevrons
augroup end

" simpylfold see docstrings
let g:SimpylFold_docstring_preview=1

" nvim R
" double underscore is replaced by '<-'
let R_assign = 2


" coc
let g:airline#extensions#coc#enabled = 1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

nmap <silent> gd <Plug>(coc-definition)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>d  :<C-u>CocList diagnostics<cr>

" language server
" highlight symbol under cursor
set updatetime=1000
autocmd CursorHold  * silent call CocActionAsync('highlight')
autocmd CursorHoldI * silent call CocActionAsync('highlight')
