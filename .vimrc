set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'wincent/command-t'

call vundle#end()            " required
filetype plugin indent on    " required

syntax enable

set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
