version 6.0
set smartindent
set shiftwidth=2
set nohlsearch
set nocompatible

" Make it easy to edit/source ~.vimrc
nmap ,s :source<Space>~/.vimrc
nmap ,v :split!<Space>~/.vimrc
                                                                                    
" Line numbers
map <F9> :set<Space>nu!<CR>
                                                                                    
" reveal codes
map <F10> :set<Space>list!<CR>
                                                                                    
" ROT13 entire file stay on current line
map <F11> <Esc>mrggVGg?<CR>'r
                                                                                    
" Delete the nearest wrapping open/close tag pair (within a line)
nmap ;x wbF<df>f<df>
                                                                                    
" Delete nearest wrapping open/close tag pair (can span lines)
nmap ;X ?<<CR>df>/<<CR>df>:noh<CR>
" Make a tag pair from the current word
imap ;m <Esc>wbgueyei<<Esc>ea></<Esc>pa><Esc>bba
                                                                                    
" Easy folding of a tag pair (does not handle nested tags of the same type) --redo in visual mode
map <F6> <Esc>*zf''
                                                                                    
" Cut/copy/paste content between current tags on a line (uses "t)
nmap yt T>vt<"ty
nmap dt T>vt<"td
nmap pt "tp
nmap Pt "tP
                                                                                    
" Normal mode mappings
nmap ;h I<h1><Esc>A</h1><Esc>
nmap ;p I<p><Esc>A</p><Esc>
nmap ;1 I<s1><Esc>A</s1><Esc>
nmap ;2 I<s2><Esc>A</s2><Esc>
nmap ;3 I<s3><Esc>A</s3><Esc>
nmap ;f Bi<file><Esc>Ea</file><Esc>
nmap ;t Bi<token><Esc>Ea</token><Esc>
nmap ;c Bi<ct><Esc>Ea</ct><Esc>
nmap ;C Bi<cmd><Esc>Ea</cmd><Esc>
nmap ;e bi<example><Esc>ea</example><Esc>
nmap ;ui Bi<ui><Esc>Ea</ui><Esc>
nmap ;url Bi<url><Esc>Ea</url><Esc>
nmap ;b A<br/><Esc>
nmap ;s o<snip/><Esc>
nmap ;o o<omitted/><Esc>
nmap ;k Bi<keycaps><Esc>Ea</keycaps><Esc>
nmap ;K Bi<keycombo><Esc>Ea</keycombo><Esc>
                                                                                    
" Visual mode mappings
vmap ;f <Esc>`>a</file><Esc>`<i<file><Esc>gV
vmap ;c <Esc>`>a</ct><Esc>`<i<ct><Esc>gV
vmap ;C <Esc>`>a</cmd><Esc>`<i<cmd><Esc>gV
vmap ;ui <Esc>`>a</ui><Esc>`<i<ui><Esc>gV
vmap ;url <Esc>`>a</url><Esc>`<i<url><Esc>gV
vmap ;t <Esc>`>a</token><Esc>`<i<token><Esc>gV
vmap ;e <Esc>'<O<example><Esc>'>o</example><Esc>
vmap ;ol <Esc>'<O<ol><Esc>'>o</ol><Esc>:'<,'>s#^\(.*\)$#<li>\1</li>#<CR>
vmap ;ul <Esc>'<O<ul><Esc>'>o</ul><Esc>:'<,'>s#^\(.*\)$#<li>\1</li>#<CR>
vmap ;p <Esc>:'<,'>s#^\(.*\)$#<p>\1</p>#<CR>
vmap ;1 <Esc>:'<,'>s#^\(.*\)$#<s1>\1</s1>#<CR>gV
vmap ;2 <Esc>:'<,'>s#^\(.*\)$#<s2>\1</s2>#<CR>gV
vmap ;3 <Esc>:'<,'>s#^\(.*\)$#<s3>\1</s3>#<CR>gV
vmap ;tr <Esc>:'<,'>s#^\(.*\)$#<tr>\1</tr>#<CR>
"vmap ;td <Esc>`>i</td><Esc>`<i<td><Esc>gV
vmap ;; <Esc>:'<,'>s/&/&amp;/g<CR>:'<,'>s/</&lt;/g<CR>:'<,'>s/>/&gt;/g<CR>gV
vmap ;b <Esc>:'<,'>s#^\(.*\)$#\1<br/>#<CR>gV
vmap ;s <Esc>C<snip/><Esc>gV
vmap ;o <Esc>C<omitted/><Esc>gV
vmap ;k <Esc>`>a</keycaps><Esc>`<i<keycaps><Esc>gV
vmap ;K <Esc>`>a</keycombo><Esc>`<i<keycombo><Esc>gV

"Insert mode mappings
imap ;p <p></p><Esc>3hi

"Abbreviations
