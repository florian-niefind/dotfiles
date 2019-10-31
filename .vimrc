set nocompatible              " required
filetype off                  " required

" vim-plug stuff ------------------------------------ {{{
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

" clojure specific plugins
Plug 'tpope/vim-fireplace', {'for': 'clojure'}
Plug 'vim-scripts/paredit.vim', {'for': 'clojure'}
Plug 'tpope/vim-surround', {'for': 'clojure'}
Plug 'tpope/vim-repeat', {'for': 'clojure'}
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}

Plug 'mechatroner/rainbow_csv', {'for': 'csv'}

call plug#end()


" leader key stuff
let mapleader = ","
let maplocalleader = "\\"
set showcmd "show when the leader key is pressed

" my remaps ----------------------------------- {{{
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

" K splits lines as J joins them
nnoremap K i<cr><esc>

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

" python docstrings
inoremap """ """<cr><cr>"""<up>

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

" filetype based commenting options
augroup commenting
	autocmd!
	autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
	autocmd FileType sql nnoremap <buffer> <localleader>c I--<esc>
	autocmd FileType clj nnoremap <buffer> <localleader>c I;<esc>
augroup end

" default colorscheme
syntax enable
set t_Co=256
set background=dark
colorscheme gruvbox

" set line numbering
set nu rnu

" access system clipboard instead of vim internal clipboard
set clipboard=unnamed

" utf-8!
set encoding=utf-8

" folding based on indents
set foldmethod=indent
set foldlevel=99

" expand tab with spaces always
set expandtab
set tabstop=2

" PEP-8 conform indenting and wrapping for python files
augroup file_specific_mappings
    autocmd!
    autocmd BufNewFile,BufRead,BufWinEnter *.py
                \ set tabstop=4 |
                \ set softtabstop=4 |
                \ set shiftwidth=4 |
                \ set textwidth=79 |
                \ set expandtab |
                \ set autoindent |
                \ set fileformat=unix |

    " Indents for other files
    autocmd BufNewFile,BufRead,BufWinEnter *.sql
                \ set tabstop=2 |
                \ set softtabstop=2 |
                \ set shiftwidth=2 |
                \ set textwidth=79 |
                \ set expandtab |
                \ set autoindent |

    " markdown files
    autocmd BufNewFile,BufRead,BufWinEnter *.md
                \ set expandtab |
                \ set tabstop=4 |
                \ set shiftwidth=4 |
                \ set textwidth=79 |
                \ set autoindent |

    " html files
    autocmd BufNewFile,BufRead,BufWinEnter *.html
                \ set expandtab |
                \ set tabstop=4 |
                \ set shiftwidth=4 |
                \ set textwidth=79 |
                \ set autoindent |
augroup end

" Mark trailing whitespace
highlight BadWhitespace ctermbg=Red
autocmd BufNewFile,BufRead *.* match BadWhitespace /\s\+$/

" Clojure stuff
" Rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
