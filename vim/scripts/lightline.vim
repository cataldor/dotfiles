"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightlite
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('gui_running')
	set t_Co=256
endif

	"\ 'colorscheme': 'Dracula',
let g:lightline = {
	\ 'colorscheme' : 'one',
	\ 'active': {
	\ 	'left': [ ['mode', 'paste'],
	\			['readonly', 'filename', 'bufnum', 'modified', 'relativepath']]
	\ },
	\ 'component': {
	\ 'readonly': '%{&readonly?"RO":""}',
	\ 'modified': '%{&modified?"+":""}',
	\ 'bufnum': 'b:%n',
	\ 'relativepath': '%f',
	\},
	\ 'component_visible_condition': {
	\ 'readonly': '(&readonly)',
	\ 'modified': '(&modified)',
	\ }
	\}
