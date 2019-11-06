"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &compatible
	set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim

"if everything is configured right, you can press [i on an identifier to 
"display its definition, or [d for a macro constant.
" Required:
if dein#load_state('/home/cataldo/.vim')
	call dein#begin('/home/cataldo/.vim')

	" Let dein manage dein
	" Required:
	call dein#add('/home/cataldo/.vim/repos/github.com/Shougo/dein.vim')
	if !has('nvim')
		call dein#add('roxma/nvim-yarp')
		call dein#add('roxma/vim-hug-neovim-rpc')
	endif

	call dein#add('wsdjeg/dein-ui.vim')
	" Add or remove your plugins here like this:
	"Statusbar
	call dein#add('itchyny/lightline.vim')
	" Additional rules for highlighting
	call dein#add('octol/vim-cpp-enhanced-highlight')
	" Makes scrolling in Vim nice and smooh
	call dein#add('terryma/vim-smooth-scroll')
	" smart pars for visual mode. use viv, vav, civ, ... 
	" to select and v to expand.
	call dein#add('gorkunov/smartpairs.vim')
	" Comment/uncomment with cc
	call dein#add('scrooloose/nerdcommenter')
	" CamelCase motion (word inside function name)
	call dein#add('bkad/CamelCaseMotion')
	" Tag list for source code
	call dein#add('vim-scripts/taglist.vim', {
		\ 'lazy' : 1, 'on_cmd' : 'TlistToggle'})
	" Denite!
	call dein#add('Shougo/denite.nvim', {'lazy' : '1'})
	" Nerdtree
	call dein#add('scrooloose/nerdtree', {'lazy' : '1'})
	" MiniBufExpl
	call dein#add('fholgado/minibufexpl.vim')
	" CommandT for fuzzysearching
	call dein#add('wincent/command-t', {
		\ 'build': 
		\'sh -c "cd ruby/command-t/ext/command-t &&"
		\" ruby extconf.rb && make"'})
	" Ack support
	call dein#add('mileszs/ack.vim', {
		\'on_cmd' : 'Ack',
		\'build': 'sh -c "cp ftplugin/*.vim ~/.vim/ftplugin"'})
	" Color matching parentheses
	call dein#add('luochen1990/rainbow')
	" Asks for the right file to open
	call dein#add('EinfachToll/DidYouMean')
	" undo tree
	call dein#add('mbbill/undotree')
	" substitute surround components. cs", cst", ysiw}, etc
	call dein#add('tpope/vim-surround')
	" Syntastic! omg
	call dein#add('scrooloose/syntastic')
	" Vim syntax checkers for syntastic
	call dein#add('ynkdir/vim-vimlparser')
	call dein#add('syngan/vim-vimlint')
	" Localvimrc support
	call dein#add('embear/vim-localvimrc')
	" Easymotion (,,w, ,,f)
	call dein#add('easymotion/vim-easymotion')
	" Persistent sessions
	call dein#add('xolox/vim-misc')	
	call dein#add('xolox/vim-session')
	" mkview and loadview automatically
	call dein#add('vim-scripts/restore_view.vim')
	" Calendar (,c)
	call dein#add('itchyny/calendar.vim')
	" Jedi-vim!
	call dein#add('davidhalter/jedi-vim', {
		\'build':
		\'sh -c "cp ftplugin/python/*.vim ~/.vim/ftplugin/python"'})
	" vimtex
	" set omnifunc=vimtex#complete#omnifunc
	call dein#add('lervag/vimtex', {
		\'build':
		\'sh -c "cp ftplugin/*.vim ~/.vim/ftplugin"'})
	" a switching!
	call dein#add('LucHermitte/lh-vim-lib')
	call dein#add('LucHermitte/alternate-lite')
	" vim notes
	call dein#add('xolox/vim-notes', {
		\'build':
		\'sh -c "cp ftplugin/*.vim ~/.vim/ftplugin &&"
		\"cp syntax/*.vim ~/.vim/syntax"'})
	" colors for html/rgb
	call dein#add('lilydjwg/colorizer')
	" for neomutt
	call dein#add('neomutt/neomutt.vim', {
		\'build':
		\'sh -c "cp ftdetect/*.vim ~/.vim/ftdetect &&"
		\"cp syntax/*.vim ~/.vim/syntax &&"
		\"cp ftplugin/*.vim ~/.vim/ftplugin"'})

	" Required:
	call dein#end()
	call dein#save_state()
endif

" Required:
 filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
	call dein#install()
endif

let g:jedi#force_py_version = 3

" activate matchit plugin
runtime macros/matchit.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TagList
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Display_Prototype = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim scripts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cpp_posix_standard = 1
let g:cpp_bsd_standard = 1
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

"" must be loaded later
source ~/.vim/scripts/minibufexpl.vim
source ~/.vim/scripts/python.vim
