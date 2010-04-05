set nocompatible
set nopaste
set nosmartindent
                                                                                    
source <sfile>:h/tag_templates.vim
source <sfile>:h/tag_functions.vim
source <sfile>:h/map_functions.vim
source <sfile>:h/maps.vim

" Easy folding of a tag pair (does not handle nested tags of the same type) --redo in visual mode
" map <F6> <Esc>*zf''
                                                                                    
" Delete the nearest wrapping open/close tag pair (within a line)
nmap ;x wbF<df>f<df>
" Delete nearest wrapping open/close tag pair (can span lines)
nmap ;X ?<<CR>df>/<<CR>df>:noh<CR>
                                                                                    
" Visual mode mappings
vmap ;f <Esc>`>a</file><Esc>`<i<file><Esc>gV
vmap ;c <Esc>`>a</cmd><Esc>`<i<cmd><Esc>gV
vmap ;ct <Esc>`>a</ct><Esc>`<i<ct><Esc>gV
vmap ;ui <Esc>`>a</ui><Esc>`<i<ui><Esc>gV
vmap ;ol <Esc>'<O<ol><Esc>'>o</ol><Esc>:'<,'>s#^\(.*\)$#  <li>\1</li>#<CR>
vmap ;ul <Esc>'<O<ul><Esc>'>o</ul><Esc>:'<,'>s#^\(.*\)$#  <li>\1</li>#<CR>
vmap ;p <Esc>:'<,'>s#^\(.*\)$#<p>\1</p>#<CR>
vmap ;1 <Esc>:'<,'>s#^\(.*\)$#<s1>\1</s1>#<CR>
vmap ;2 <Esc>:'<,'>s#^\(.*\)$#<s2>\1</s2>#<CR>
vmap ;3 <Esc>:'<,'>s#^\(.*\)$#<s3>\1</s3>#<CR>
vmap ;12 <Esc>:'<+1,'>s#^[ 	·•]*\(.*\)$#  <s2>\1</s2>#<CR>'<I<s1><Esc>'>A</s1><Esc>
vmap ;tr <Esc>:'<,'>s#^\(.*\)$#<tr>\1</tr>#<CR>
vmap ;e <Esc>'<O<example><Esc>'>o</example><Esc>

" Make a tag pair from the current word
imap ;m <Esc>wbgueyei<<Esc>ea></<Esc>pa><Esc>bba

" move the current line up or down
nmap <silent> <C-j> :m+<CR>
nmap <silent> <C-k> :m-2<CR>
imap <silent> <C-j> <C-O>:m+<CR><C-O>
imap <silent> <C-k> <C-O>:m-2<CR><C-O>
" move the selected block up or down
vmap <silent> <C-j> :m'>+<CR>gv=gv
vmap <silent> <C-k> :m'<-2<CR>gv=gv

" arrow keys move via screen lines instead of logical lines
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk
nmap <silent> <Down> gj
nmap <silent> <Up> gk

" slide tags around
"nmap <C-Right> F<df>ep
"nmap <C-Left>  F<df

