"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set showcmd

set swapfile
set directory^=~/.vim/backup/
"" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
set backupdir=~/.vim/backup/

set relativenumber
set number

" colorcolumn
set colorcolumn=81

" tabs
set tabstop=8
set shiftwidth=8
