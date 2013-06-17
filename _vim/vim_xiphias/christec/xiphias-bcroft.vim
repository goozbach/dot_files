version 6.0
set smartindent
set shiftwidth=2
set tabstop=2
set nohlsearch
set nocompatible
set textwidth=0

" Make it easy to edit/source ~.vimrc
nmap ,s :source<Space>~/.vimrc
nmap ,v :split!<Space>~/.vimrc
                                                                                    
" Line numbers
map <F9> :set<Space>nu!<CR>
                                                                                    
" reveal codes
map <F10> :set<Space>list!<CR>
                                                                                    
" ROT13 entire file stay on current line
map <F11> <Esc>mrggVGg?<CR>'r
                                                                                    
" Toggle long lines with <F12>
map <F12> :set<Space>wrap!<CR>
                                                                                    
" Easy folding of a tag pair (does not handle nested tags of the same type) --redo in visual mode
map <F6> <Esc>*zf''
                                                                                    
" Cut/copy/paste content between current tags on a line (uses "t)
nmap ;yt T>vt<"ty
nmap ;dt T>vt<"td
nmap ;pt "tp
nmap ;Pt "tP
" Delete the nearest wrapping open/close tag pair (within a line)
nmap ;x wbF<df>f<df>
" Delete nearest wrapping open/close tag pair (can span lines)
nmap ;X ?<<CR>df>/<<CR>df>:noh<CR>
                                                                                    
" Normal mode mappings
nmap ;h I<h1><Esc>A</h1><Esc>
nmap ;p I<p><Esc>A</p><Esc>
nmap ;1 I<s1><Esc>A</s1><Esc>
nmap ;2 I<s2><Esc>A</s2><Esc>
nmap ;3 I<s3><Esc>A</s3><Esc>
nmap ;bq I<blockquote><Esc>A</blockquote><Esc>
nmap ;f bi<file><Esc>ea</file><Esc>
nmap ;F Bi<file><Esc>Ea</file><Esc>
nmap ;t bi<token><Esc>ea</token><Esc>
nmap ;T Bi<token><Esc>Ea</token><Esc>
nmap ;c bi<cmd><Esc>ea</cmd><Esc>
nmap ;C Bi<cmd><Esc>Ea</cmd><Esc>
                                                                                    
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

"Insert mode mappings
imap ;p <p></p><Esc>3hi

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
nmap <C-Right> F<df>ep
nmap <C-Left>  F<df>bP

"Abbreviations


