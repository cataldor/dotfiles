" always populate list of erros (:lwindow, :lopen)
let g:syntastic_always_populate_loc_list = 1

"let g:syntastic_debug = 17
"let g:syntastic_nim_checkers = ['nim']

let g:syntastic_python_checkers = ['mypy']
let g:syntastic_python_mypy_args = '--strict --no-strict-optional'

"4.11. Q. I have enabled multiple checkers for the current filetype. How can I
"display all errors from all checkers together?
"
"A. Set g:syntastic_aggregate_errors to 1 in your vimrc:
"
"let g:syntastic_aggregate_errors = 1
"
"See :help syntastic-aggregating-errors for more details.

"4.13. Q. The error window is closed automatically when I :quit the current
"buffer but not when I :bdelete it?
"
"A. There is no safe way to handle that situation automatically, but you can
"work around it:
"
"nnoremap <silent> <C-d> :lclose<CR>:bdelete<CR>
"cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ?
"'lclose\|bdelete' : 'bd')<CR>

"*'syntastic_aggregate_errors'*
"Type: boolean
"Default: 0
"When enabled, syntastic runs all checkers that apply to
"the current filetype, then aggregates errors found
"by all checkers and displays them. When disabled,
"syntastic runs each checker in turn, and stops to display
"the results the first time a checker finds any
"errors. >
"
"let g:syntastic_aggregate_errors = 1

"Syntastic can be used together with the "YouCompleteMe" Vim plugin (see
"http://valloric.github.io/YouCompleteMe/). However, by default
""YouCompleteMe" disables syntastic's checkers for the "c", "cpp", "objc", and "objcpp"
"filetypes, in order to allow its own checkers to run. If you want to use YCM's
"identifier completer but still run syntastic's checkers for those filetypes you
"have to set |g:ycm_show_diagnostics_ui| to 0. E.g.: >
"let g:ycm_show_diagnostics_ui = 0

"*'g:syntastic_c_compiler_options'*
"Type: string
"Default: "-std=gnu99"
"Compilation flags (such as defines or include directories) to be passed to the
"checker.

"*'g:syntastic_c_config_file'*
"Type: string
"Default: ".syntastic_c_config"
"File containing additional compilation flags to be passed to the checker, one
"option per line (cf. |syntastic-config-files|).

"*'g:syntastic_c_include_dirs'*
"Type: array of strings
"Default: []
"Include directories to be passed to the checker, in addition to the above
"compilation flags. You can set it to something like this: >
"let g:syntastic_c_include_dirs = ["includes", "headers"]
"<
"and the corresponding "-Iincludes -Iheaders" will be added to the compilation
"flags.
