set nocompatible              " required
filetype off                  " required 

" vundle stuff ------------------------------------ {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'morhetz/gruvbox' "gruvbox color scheme
Plugin 'scrooloose/nerdtree' "file tree
Plugin 'jistr/vim-nerdtree-tabs' "tabs for the file tree
Plugin 'kien/ctrlp.vim' "search for anything
Plugin 'tpope/vim-fugitive' "vim and git
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'tpope/vim-surround'
Plugin 'https://github.com/kien/rainbow_parentheses.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}}

"Customize where splits should occur "set splitbelow
"set splitright

" after vundle setup switch filetype on again
filetype on

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

" wrap a word in quotes, stars, dashes
nnoremap <leader>' viW<esc>a'<esc>hbi'<esc>lEl
nnoremap <leader>" viW<esc>a"<esc>hbi"<esc>lEl
nnoremap <leader>_ viW<esc>a_<esc>hbi_<esc>lEl
nnoremap <leader>* viW<esc>a*<esc>hbi*<esc>lEl

" edit vimrc quickly
nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" python docstrings
inoremap """ """<cr><cr>"""<up>

" some useful abbreviations
:iabbrev @@ florian@zenguard.org
:iabbrev FN Florian Niefind

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
augroup END

" start NERDTree
nnoremap <leader>o :NERDTree<cr>
" }}}



" default colorscheme
syntax enable
set t_Co=256
set background=dark
colorscheme gruvbox

" set line numbering
set nu

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
autocmd BufNewFile,BufRead *.py,*.pyw,*.sql,*.c,*.h match BadWhitespace /\s\+$/

"ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

"start nerdtree automatically
"autocmd vimenter * NERDTree

" Clojure stuff
" Rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
