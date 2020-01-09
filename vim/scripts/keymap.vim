" nnoremap = map keys that work only in the normal mode
" nmap = Normal mode map.
" Removed due to smartpairs Plugin 
" map vv as V
" nmap vv V
"
" go to the end of line
nnoremap aa A

" Print function signature
nnoremap <C-k> <C-W>}

" behavior of :
" ------------------------------------------------------------------------------
" without need to press shift, go into command modus.
nore ; :
nore : ;
" When double tap ;;, instead the command, you navigate through the bufferlist
cnoremap ; :bn<CR>
" Press same key ; again, to enter the command. If you really need to type ; 
" in the command line (be frankly, it will never happen), C-v then ;
autocmd CmdwinEnter * nnoremap <buffer> ; <CR><BS>
" Make omni completion much easier
inoremap ;; <C-x><C-o>

" behavior of '
" ------------------------------------------------------------------------------
" Faster way of appending double quotes (saves you hitting the shift key):
inoremap '' ""<Left>
"  Change buffer list
nnoremap '' :<C-u>Denite buffer<CR> 

" leaders
" ------------------------------------------------------------------------------
let g:mapleader=","
let g:maplocalleader="ff"

" reload source
nnoremap <leader>r :source ~/.vimrc<CR>

" compile code
nnoremap <leader>q <ESC>:make<CR>:cwindow<CR>
nnoremap cn	:cn<CR>
nnoremap cp :cp<CR>

" change fold behavior
nnoremap zd za
nnoremap za zd

"****************************** CommandT **********************************
nnoremap <leader>s :CommandT<CR>
"****************************** CommandT **********************************

"******************************** netrw ***********************************
nnoremap <leader>f :Explore<CR>
"******************************** netrw ***********************************
"****************************** Gundo **********************************
nnoremap <leader>w :UndotreeToggle<CR>
"****************************** Gundo **********************************

"*************************** Calendar **********************************
nnoremap <leader>c :Calendar -view=year -split=vertical -width=27<CR>
"*************************** Calendar **********************************

"****************************** vim-session **********************************
nnoremap <leader>so :OpenSession 
nnoremap <leader>ss :SaveSession 
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>
"****************************** vim-session **********************************

"****************************** Ack **********************************
" Open a new tab and search for something.
nnoremap <leader>a :Ack "
" Immediately search for the work under the cursor in a new tab
nnoremap <leader>A :Ack <C-r><C-w><CR>
"****************************** Ack **********************************

"****************************** Esc **********************************
" Go to normal mode when rolling the finger.
"inoremap jk <Esc>
"inoremap kj <Esc>

" use enter as esc!!!
" imap <CR> <Esc>

inoremap jj <Esc>
"****************************** Esc **********************************


"****************************** CAPS **********************************
" Make them uppercase, not only the character, but the whole word. Which is more
" common.
nnoremap gU <esc>mz<esc>gUiw`z
vnoremap gU <esc>mz<esc>gvgU`z
"
" And make it lowercase.
nnoremap gu <esc>mz<esc>guiw`z
vnoremap gu <esc>mz<esc>gvgu`z
"****************************** CAPS **********************************


"************************** SmoothScroll ******************************
" make scroll smooth (Plugin)
nnoremap <Space> :<C-U>call smoothie#downwards() <CR>
"************************** SmoothScroll ******************************


"************************** NerdTree ******************************
" Toggle comment (commenting out or commenting in)
map cc <plug>NERDCommenterToggle
"************************** NerdTree ******************************

"*********************** CamelCaseMotion **************************
" When words have uppercase, move to them (Plugin): 
" " ----------------------------------------
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e

sunmap w
sunmap b
sunmap e

omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie
"*********************** CamelCaseMotion **************************

"************************** TagList ******************************
" TagList for souce code handling (Plugin)
nnoremap <leader>t :TlistToggle<CR>:wincmd l<CR>:vertical resize 170<CR>
"************************** TagList ******************************

"*************************** vimtex ******************************
nmap <localleader>i 		<plug>(vimtex-info)
nmap <localleader>I 		<plug>(vimtex-info-full)
nmap <localleader>t 		<plug>(vimtex-toc-open)
nmap <localleader>T 		<plug>(vimtex-toc-toggle)
nmap <localleader>y 		<plug>(vimtex-labels-open)
nmap <localleader>Y 		<plug>(vimtex-labels-toggle)
nmap <localleader>v 		<plug>(vimtex-view)
nmap <localleader>r 		<plug>(vimtex-reverse-search)
nmap <localleader>l 		<plug>(vimtex-compile)
xnoremap <localleader>L		<plug>(vimtex-compile-selected)
nmap <localleader>k			<plug>(vimtex-stop)
nmap <localleader>K			<plug>(vimtex-stop-all)
nmap <localleader>e			<plug>(vimtex-errors)
nmap <localleader>o			<plug>(vimtex-compile-output)
nmap <localleader>g			<plug>(vimtex-status)
nmap <localleader>G			<plug>(vimtex-status-all)
nmap <localleader>C			<plug>(vimtex-clean)
nmap <localleader>c			<plug>(vimtex-clean-full)
nmap <localleader>m			<plug>(vimtex-imaps-list)
nmap <localleader>x			<plug>(vimtex-reload)
nmap <localleader>s			<plug>(vimtex-toggle-main)
