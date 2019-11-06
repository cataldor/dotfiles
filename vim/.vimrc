"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 " Note: Skip initialization for vim-tiny or vim-small.
 if 0 | endif

 if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif

 " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!
 
" Statusbar
NeoBundle 'itchyny/lightline.vim'
" Additional rules for highlighting
NeoBundle 'octol/vim-cpp-enhanced-highlight'
" Makes scrolling in Vim nice and smooh
NeoBundle 'terryma/vim-smooth-scroll'
" smart pars for visual mode. use viv, vav, civ, ... to select and v to expand.
NeoBundle 'gorkunov/smartpairs.vim'
" Comment/uncomment with cc
NeoBundle 'scrooloose/nerdcommenter'
" CamelCase motion (word inside function name)
NeoBundle 'bkad/CamelCaseMotion'
" Tag list for source code
NeoBundle 'vim-scripts/taglist.vim'
" Unite!
NeoBundle 'Shougo/unite.vim'
" Nerdtree
NeoBundle 'scrooloose/nerdtree'
" MiniBufExpl
NeoBundle 'fholgado/minibufexpl.vim'
" CommandT for fuzzysearching
NeoBundle 'wincent/command-t'
" Ack support
NeoBundle 'mileszs/ack.vim'
" Color matching parentheses
NeoBundle 'luochen1990/rainbow'
" Asks for the right file to open
NeoBundle 'EinfachToll/DidYouMean'
" undo tree
NeoBundle 'mbbill/undotree'
" substitute surround components. cs", cst", ysiw}, etc
NeoBundle 'tpope/vim-surround'
" Syntastic! omg
NeoBundle 'scrooloose/syntastic'
"NeoBundle 'vim-syntastic/syntastic'
" Vim syntax checkers for syntastic
NeoBundle 'syngan/vim-vimlint', {
    \ 'depends' : 'ynkdir/vim-vimlparser'}
" YouCompleteMe!
"NeoBundle 'Valloric/YouCompleteMe'
" YouCompleteMe get compile flags from makefile
"NeoBundle 'rdnetto/YCM-Generator'
" Localvimrc support
NeoBundle 'embear/vim-localvimrc'
" Easymotion (,,w, ,,f)
NeoBundle 'easymotion/vim-easymotion'
" Persistent sessions
NeoBundle 'xolox/vim-session', {
	\ 'depends' : 'xolox/vim-misc'}
" mkview and loadview automatically
NeoBundle 'vim-scripts/restore_view.vim'
" Calendar (,c)
NeoBundle 'itchyny/calendar.vim'
" Jedi-vim!
NeoBundle 'davidhalter/jedi-vim'
" vimtex
" set omnifunc=vimtex#complete#omnifunc
NeoBundle 'lervag/vimtex'
" nim
NeoBundle 'zah/nim.vim'
" a switching!
NeoBundle 'LucHermitte/alternate-lite', {
	\ 'depends' : 'LucHermitte/lh-vim-lib'}
" vim notes
NeoBundle 'xolox/vim-notes'
" colors for html/rgb
NeoBundle 'lilydjwg/colorizer'


 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

let g:jedi#force_py_version = 3

" activate matchit plugin
" Incompatible with nim
"runtime macros/matchit.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TagList
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let Tlist_Display_Prototype = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim scripts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vim/scripts/ack.vim
source ~/.vim/scripts/colorized.vim
source ~/.vim/scripts/cscope.vim
source ~/.vim/scripts/general.vim
source ~/.vim/scripts/keymap.vim
source ~/.vim/scripts/lightline.vim
source ~/.vim/scripts/notes.vim
source ~/.vim/scripts/rainbow.vim
source ~/.vim/scripts/search.vim
source ~/.vim/scripts/session.vim
source ~/.vim/scripts/syntastic.vim
source ~/.vim/scripts/theme.vim
source ~/.vim/scripts/undo.vim
source ~/.vim/scripts/unite_plus_nerdtree.vim
source ~/.vim/scripts/vimtex.vim
source ~/.vim/scripts/ycm.vim

" must be loaded later
source ~/.vim/scripts/minibufexpl.vim
source ~/.vim/scripts/python.vim
source ~/.vim/scripts/nim.vim
