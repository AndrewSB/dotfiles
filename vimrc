" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
call vundle#end()            " required by vundle
filetype plugin indent on    " required by vundle
" End Vundle

syntax on					" enable syntax
set tabstop=4				" number of visual spaces per TAB
set softtabstop=4 			" number of spaces in tab when editing
set number 					" show line numbers
set showcmd					" show command in bottom bar
set cursorline				" highlight current line
set wildmenu				" visual autocomplete for command menu
set lazyredraw				" redraw only when we need to
set showmatch				" highlight matching [{()}]

" searching
set incsearch 				" search as characters are entered
set hlsearch				" highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR> 

" folding
set foldenable 				" enable folding
set foldlevelstart=10 		" open most folds by default
" space open/close folds
nnoremap <space> za
set foldmethod=indent 		" fold based on indent level

" movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk 

" solarized theme
set background=light
 
" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" syntatic customization
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers=['']

nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

" javascript syntax
let g:javascript_enable_domhtmlcss = 1

" auto reload vimrc on changes
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" better tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>

" NERDTree auto open on startup with no files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" airline
let g:airline#extensions#tabline#enabled = 1
