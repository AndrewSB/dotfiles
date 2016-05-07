" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

execute pathogen#infect()

syntax on					" enable syntax
set number 					" show line numbers
set showcmd					" show command in bottom bar
set cursorline				" highlight current line
set wildmenu				" visual autocomplete for command menu
set lazyredraw				" redraw only when we need to
set showmatch				" highlight matching [{()}]
set nobackup				" turn off backups
set noswapfile				" also turn off swapfiles

" searching
set incsearch 				" search as characters are entered
set hlsearch				" highlight matches
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR> 

" solarized theme
set background=light
 
" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

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
