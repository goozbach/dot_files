set nocompatible
set nopaste
set nosmartindent
                                                                                    
" Get all the standard mappings
source <sfile>:h/maps_r3.vim

" Make it easy to render the current courselet - assumes that the parent of the current directory is the root of Xiphias
nmap ,r !<Space>(cd ..;make "%<".view)

" Delete the nearest wrapping open/close tag pair (within a line)
nmap ;x wbF<df>f<df>
" Delete nearest wrapping open/close tag pair (can span lines)
nmap ;X ?<<CR>df>/<<CR>df>:noh<CR>
                                                                                    
" Custom Hack Visual mode mappings
vmap ;ol <Esc>'<O<ol><Esc>'>o</ol><Esc>:'<,'>s#^\(.*\)$#  <li>\1</li>#<CR>
vmap ;ul <Esc>'<O<ul><Esc>'>o</ul><Esc>:'<,'>s#^\(.*\)$#  <li>\1</li>#<CR>
vmap ;12 <Esc>:'<+1,'>s#^[ 	·•]*\(.*\)$#  <s2>\1</s2>#<CR>'<I<s1><Esc>'>A</s1><Esc>

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

