" Vim filetype plugin
" Language:	spec file
" Maintainer:	Guillaume Rousse <rousse@ccr.jussieu.fr>
" URL:		http://lis.snv.jussieu.fr/~rousse/linux/spec.vim
" Version:	$Id: spec.vim,v 1.6 2004/01/10 14:55:44 rousse Exp $

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

" Add mappings, unless user doesn't want
if !exists("no_plugin_maps") && !exists("no_spec_maps")
	if !hasmapto("<Plug>AddChangelogBlock")
		map <buffer> <LocalLeader>ch <Plug>AddChangelogBlock
	endif
	if !hasmapto("<Plug>AddChangelogEntry")
		map <buffer> <LocalLeader>CH <Plug>AddChangelogEntry
	endif
	noremap <buffer> <unique> <script> <Plug>AddChangelogBlock :call <SID>AddChangelogBlock()<CR> 
	noremap <buffer> <unique> <script> <Plug>AddChangelogEntry :call <SID>AddChangelogEntry()<CR>
endif

" compilation option
setlocal makeprg=rpm\ -ba\ %
setlocal errorformat=error:\ line\ %l:\ %m

" navigation through sections
let b:match_ignorecase = 0
let b:match_words =
	\ '^Name:^%description:^%clean:^%setup:^%build:^%install:^%files:' .
	\ '^%package:^%preun:^%postun:^%changelog'

if !exists("*s:AddChangelogBlock")
	" Adds a changelog block
	function s:AddChangelogBlock()
		" look for changelog section
		let line = <SID>GetFirstLocation(0, '^%changelog')
		call <SID>InsertChangelogHeader(line)
		call <SID>InsertChangelogEntry(line + 1)
	endfunction
endif

if !exists("*s:AddChangelogEntry")
	" Adds a changelog entry
	function s:AddChangelogEntry()
		" look for changelog section
		let line = <SID>GetFirstLocation(0, '^%changelog')
		" look for last entry
		let line = <SID>GetLastLocation(line + 1, '^- ')
		call <SID>InsertChangelogEntry(line)
	endfunction
endif

if !exists("*s:InsertChangelogHeader")
	" Insert a changelog header just after the given line
	function s:InsertChangelogHeader(line)
		" ensure english locale
		language time C
		" insert blank line first
		call append(a:line, "")
		" insert changelog header
		call append(a:line,
			\ "* " . strftime("%a %b %d %Y") . 
			\ " " . <SID>GetTagValue("Packager") .
			\ " " . <SID>GetTagValue("Version") .
			\ "-" . <SID>GetTagValue("Release")
			\)
	endfunction
endif

if !exists("*s:InsertChangelogEntry")
	" Insert a changelog entry just after the given line
	function s:InsertChangelogEntry(line)
		" insert changelog entry
		call append(a:line, "- ")
		" position cursor here
		execute a:line
		" enter insert mode
		startinsert!
	endfunction
endif

if !exists("*s:GetTagValue")
	" Return value of a rpm tag
	function s:GetTagValue(tag)
		let pattern = '^' . a:tag . ':\s*'
		let line = <SID>GetFirstLine(0, pattern)
		let value = substitute(line, pattern, "", "")

		" resolve macros
		while (value =~ '%{\?\w\{3,}}\?')
			let macro = matchstr(value, '%{\?\w\{3,}}\?')
			let macro_name = substitute(macro, '%{\?\(\w\{3,}\)}\?', '\1', "")
			let macro_value = <SID>GetMacroValue(macro_name)
			let value = substitute(value, '%{\?' . macro_name . '}\?', macro_value, "")
		endwhile
		
		" try to read externaly defined values
		if (value == "")
			let value = <SID>GetExternalMacroValue(a:tag)
		endif

		return value
	endfunction
endif

if !exists("*s:GetMacroValue")
	" Return value of a rpm macro
	function s:GetMacroValue(macro)
		let pattern = '^%define\s*' . a:macro . '\s*'
		let line = <SID>GetFirstLine(0, pattern)
		return substitute(line, pattern, "", "")
	endfunction
endif

if !exists("*s:GetExternalMacroValue")
	" Return value of an external rpm macro defined in $HOME/.rpmmacros
	function s:GetExternalMacroValue(macro)
		if filereadable($HOME . "/.rpmmacros")
			let pattern = '^%' . tolower(a:macro) . '\s*'
			let line = system("grep '" . pattern . "' $HOME/.rpmmacros")
			" get rid of this !#&* trailing <NL>
			let line = strpart(line, 0, strlen(line) - 1)
			return substitute(line, pattern, "", "")
		endif
	endfunction
endif

if !exists("*s:GetFirstLocation")
	" Return location of first line matching the given pattern after the given line
	" Return -1 if not found at the end of the file
	function s:GetFirstLocation(from, pattern)
		let linenb = a:from
		while (linenb <= line("$"))
			let linenb = linenb + 1
			let linestr = getline(linenb)
			if (linestr =~ a:pattern)
				return linenb
			endif
		endwhile
		return -1
	endfunction
endif

if !exists("*s:GetLastLocation")
	" Return location of last line matching the given pattern after the given line
	" Return -1 if still found at the end of the file
	function s:GetLastLocation(from, pattern)
		let linenb = a:from
		while (linenb <= line("$"))
			let linenb = linenb + 1
			let linestr = getline(linenb)
			if (linestr !~ a:pattern)
				return linenb - 1
			endif
		endwhile
		return -1
	endfunction
endif

if !exists("*s:GetFirstLine")
	" Return first line matching the given pattern after the given line
	" Return "" if not found at the end of the file
	function s:GetFirstLine(from, pattern)
		let linenb = a:from
		while (linenb <= line("$"))
			let linenb = linenb + 1
			let linestr = getline(linenb)
			if (linestr =~ a:pattern)
				return linestr
			endif
		endwhile
		return ""
	endfunction
endif
