syntax on

set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
"
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Fix issue with background highlighting in WSL
set t_ut=""

" Creates directory structure for Vim Plug if it is missing
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'morhetz/gruvbox'
    Plug 'jremmen/vim-ripgrep'
    Plug 'tpope/vim-fugitive'
    Plug 'leafgarland/typescript-vim'
    Plug 'vim-utils/vim-man'
    Plug 'lyuts/vim-rtags'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'mbbill/undotree'
    Plug 'pangloss/vim-javascript'
    Plug 'mxw/vim-jsx'
    Plug 'ycm-core/YouCompleteMe'
call plug#end()

let g:ycm_clangd_binary_path = "/usr/bin/clangd"

colorscheme gruvbox
set background=dark

if executable('rg')
let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0

" Window selections
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Window splits
nnoremap <leader>L :vsplit<CR> :wincmd l<CR>
nnoremap <leader>H :vsplit<CR> :wincmd h<CR>
nnoremap <leader>J :split<CR> :wincmd j<CR>
nnoremap <leader>K :split<CR> :wincmd k<CR>

nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

inoremap jj <Esc>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()
