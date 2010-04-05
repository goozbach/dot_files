set ts=10
:colorscheme desert
" Add a baz/tla log entry header
nmap ;d o<esc>:.!/bin/date '+\%G-\%m-\%d \%R'<enter>o-----<enter>
" Add a todo
nmap ;t <esc>:.!/bin/date '+\%G-\%m-\%d'<enter>A TODO --

" Add a rpmbuild log entry header
"nmap ;d o<esc>:.!/bin/date '+\%G-\%m-\%d \%R'<enter>o-----<enter>

" Source the Xiphias vim macros if we edit html/xml/xsl files
:au Filetype html,xml,xsl,php source ~/.vim/vim_xiphias/bcroft/maps_r3.vim
:au Filetype html,xml,xsl,php source ~/.vim/xiphias.vim

" refresh diff
map <F8> :diffupdate<CR>

" Line numbers
map <F9> :set<Space>nu!<CR>

" reveal codes
map <F10> :set<Space>list!<CR>

" ROT13 entire file stay on current line
map <F11> <Esc>mrggVGg?<CR>'r

" Toggle long lines with <F12>
map <F12> :set<Space>wrap!<CR>

" tabspaces and expandtab
set et
set ts=2
set ai
set nowrap

:au Filetype markdown source ~/.vim/markdown.vim

