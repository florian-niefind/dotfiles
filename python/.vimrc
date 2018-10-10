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
Plugin 'tmhedberg/SimpylFold' "code folding
Plugin 'vim-scripts/indentpython.vim' "nice auto-indent
Plugin 'scrooloose/syntastic' "syntax check
Plugin 'nvie/vim-flake8' "pep-8 checker
Plugin 'morhetz/gruvbox' "zenburn color scheme
Plugin 'scrooloose/nerdtree' "file tree
Plugin 'jistr/vim-nerdtree-tabs' "tabs for the file tree
Plugin 'kien/ctrlp.vim' "search for anything
Plugin 'tpope/vim-fugitive' "vim and git
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'Valloric/YouCompleteMe' "code completion
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fireplace'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'https://github.com/kien/rainbow_parentheses.vim'
Plugin 'https://github.com/mechatroner/rainbow_csv.git'

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
"nnoremap K i<cr><esc>

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
:iabbrev pyhdr #!/usr/bin/env python<cr># -*- coding: utf-8 -*-

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

" Enable folding with the spacebar
nnoremap <space> za

" filetype based commenting options
augroup commenting
	autocmd!
	autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
	autocmd FileType sql nnoremap <buffer> <localleader>c I--<esc>
augroup END

" go to definition (needs youcompleteme)
noremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

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
set tabstop=4

" Let the docstrings still be visible for folded code
let g:SimpylFold_docstring_preview=1

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

    " yaml
    autocmd BufNewFile,BufRead,BufWinEnter *.yml, *.yaml
                \ set tabstop=2 |
                \ set softtabstop=2 |
                \ set shiftwidth=2 |
                \ set textwidth=79 |
                \ set expandtab |
                \ set autoindent |
                \ set fileformat=unix |
augroup end

" Mark trailing whitespace
highlight BadWhitespace ctermbg=Red
autocmd BufNewFile,BufRead *.py,*.pyw,*.sql,*.c,*.h match BadWhitespace /\s\+$/

" close autocompletion window automatically, when finished
let g:ycm_autoclose_preview_window_after_completion=1

" let syntax look pretty
let python_highlight_all=1

" make YCM recognize if you are using a virtual environment right now
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF

"ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

"start nerdtree automatically
"autocmd vimenter * NERDTree

"syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ["flake8"]

" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Clojure stuff
" Rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
