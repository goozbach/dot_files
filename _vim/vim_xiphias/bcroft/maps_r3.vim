"if exists("loaded_xiphias_base_maps")
"  finish
"endif
"let loaded_xiphias_base_maps=1


"Define mapping Keys
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:InsertStartTagKey    = "<F2>"
let s:InsertTagTemplateKey = "<F3>"
let s:InsertEndTagKey      = "<F4>"
let s:MagicTagKey          = "<F9>"
let s:TagLeftWord          = "<S-F5>"
let s:TagLeftChar          = "<S-F6>"
let s:TagRightChar         = "<S-F7>"
let s:TagRightWord          = "<S-F8>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Patterns for XML tags and for words.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:XMLTag="</\\{0,1}[^>]\\{1,}>"
let s:Word="</\\{0,1}[^>]\\{1,}>\\|[^ <\\t,()]\\{1,}"


" Define Tag templates.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Template_dl = "<dl><CR>"
   \."  <dt>-:-</dt><CR>"
   \."  <dd></dd><CR>"
   \."</dl>"

let g:Template_ol = "<ol><CR>"
   \."  <li>-:-</li><CR>"
   \."</ol>"

let g:Template_al = "<al><CR>"
   \."  <aa>-:-</aa><CR>"
   \."  <ad></ad><CR>"
   \."</al>"
	 
let g:Template_table = "<table><CR>"
   \."  <tr><th>-:-</th>   <th></th></tr><CR>"
   \."  <tr><td></td>   <td></td></tr><CR>"
   \."</table>"

let g:Template_ul = "<ul><CR>"
   \."  <li>-:-</li><CR>"
   \."</ul>"

let g:Template_img = "<img src=\"-:-\" />"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function! FindTag(str, tpos, spos, epos)
	" Find beginning and end of tag.
	let st = match(a:str, s:XMLTag)
	let et = matchend(a:str, s:XMLTag)
	while st != -1  &&  et != -1  &&  et < a:tpos
		let st = match(a:str, s:XMLTag, et)
		let et = matchend(a:str, s:XMLTag, st)
	endwhile

	return "let " . a:spos . "=" . st . " | let " . a:epos . "=" . et
endfunction


function! FindWord(str, tpos, spos, epos)
	" Look for start and end of word.
	let sw = match(a:str, s:Word)
	let ew = matchend(a:str, s:Word)
	while sw != -1  &&  ew != -1  &&  ew < a:tpos
		let tsw = match(a:str, s:Word, ew)
		if tsw >= a:tpos
			break
		endif
		let sw = tsw
		let ew = matchend(a:str, s:Word, sw)
	endwhile

	return "let " . a:spos . "=" . sw . " | let " . a:epos . "=" . ew
endfunction


function! TagWord(stag, etag)
	let n = line(".")
	let c = col(".")-1
	let s = getline(n)

	" Look for start and end of word at cursor.
	execute FindWord(s, c, "sw", "ew")

	if c >= sw  &&  c < ew
		let t = strpart(s, 0, sw)
		let u = strpart(s, ew)
		let w = strpart(s, sw, ew-sw)
		let v = t . a:stag . w . a:etag . u
		call setline(n, v)
		call cursor(n, c + strlen(a:stag) + 3)
	else
		echo "Cursor not on a word"
	endif
endfunction


function! Maps(key, tag, block_style, ...)
	" Define pattern used to start and end tag
	" special exception for comment tags
	if a:tag == "COMMENT"
		let stag = "<!-- "
		let etag = " -->"
	else
		if a:0 == 0
			let stag = "<" . a:tag . ">"
		else "use attributes if they were passed
			let stag = "<" . a:tag . a:1 . ">"
		endif
		let etag = "</" . a:tag . ">"
	endif

	" Map keys for start/end tag pair.
	if exists("g:Template_" . a:tag)
		"yes template - use it
		execute "imap " . s:InsertTagTemplateKey . a:key . " " . g:Template_{a:tag} . "\<Esc>?-:-<CR>3xi"
		execute "nmap " . s:InsertTagTemplateKey . a:key . " " . g:Template_{a:tag} . "\<Esc>?-:-<CR>3x"
	else
		"no template - use built-up tags
		let n = strlen(etag) - 1
		execute "imap " . s:InsertTagTemplateKey . a:key . " " . stag . etag . "<ESC>" . n . "hi"
		execute "nmap " . s:InsertTagTemplateKey . a:key . " i" . stag . etag . "<ESC>" . n . "h"
	endif

	" Map keys for start tag.
	execute "imap " . s:InsertStartTagKey . a:key . " " . stag
	execute "nmap " . s:InsertStartTagKey . a:key . " i" . stag . "<ESC>"

	" Map keys for end tag.
	execute "imap " . s:InsertEndTagKey . a:key . " " . etag
	execute "nmap " . s:InsertEndTagKey . a:key . " a" . etag . "<ESC>"

	" Map for [start/end] visual block or [every line in block]
	if a:block_style == 0
		" wrap just start and end
		execute "vmap " . s:MagicTagKey . a:key . " <Esc>'<O" . stag . "<Esc>'>o" . etag . "<Esc>"
	elseif a:block_style == 1
		" wrap every line in block - sneaky chaining of commands with CTRL-O needed for normal command
		execute "vmap " . s:MagicTagKey . a:key . " <Esc>:'<,'>normal I" . stag . "A" . etag . ""
		" wrap just current line when in normal mode
		execute "nmap " . s:MagicTagKey . a:key . " I" . stag . "<Esc>A" . etag . "<Esc>"
	elseif a:block_style == 2
		" wrap just visual-block selection
		execute "vmap " . s:MagicTagKey . a:key . " <Esc>`>a" . etag . "<Esc>`<i" . stag . "<Esc>gV"
		" wrap current WORD when in normal mode
		execute "nmap " . s:MagicTagKey . a:key . " :call TagWord(\"" . stag . "\", \"" . etag . "\")" . "<CR>"
	endif
endfunction


function! Map(key, tag)
	execute "nmap " . a:key . " i<" . a:tag . " /><Esc>"
	execute "imap " . a:key . " <" . a:tag . " />"
endfunction



" If the cursor is on a tag, move it to the right by one word.
function! MoveTagRight()
	let n = line(".")
	let c = col(".")
	let s = getline(n)

	" Find beginning and end of tag.
	execute FindTag(s, c, "st", "et")

	" If cursor is on a tag move it to the right of the following word.
	if c > st  &&  c <= et

		" Look for start and end of word following tag.
		let sw = match(s, s:Word, et)
		let ew = matchend(s, s:Word, sw)

		if sw != -1  &&  ew != -1
			let t = strpart(s, 0, st)		" upto start of tag
			let u = strpart(s, st, et-st)		" tag
			let v = strpart(s, et, ew-et)		" word
			let w = strpart(s, ew)			" after word
			call setline(n, t.v.u.w)
			call cursor(n, c+ew-et)
		else
			" Move tag to beginning of next line.
			if n < line("$")
				let t = strpart(s, 0, st)	" upto start of tag
				let u = strpart(s, st)		" tag
				call setline(n, t)
				let s = getline(n+1)
				call setline(n+1, u.s) 
				call cursor(n+1, c-st)
			else
				echo "No words to right of tag"
			endif
		endif
	else
		echo "Cursor not on tag"
	endif
endfunction


" If the cursor is on a tag, move it to the left by one word.
function! MoveTagLeft()
	let n = line(".")
	let c = col(".")
	let s = getline(n)

	" Find beginning and end of tag.
	execute FindTag(s, c, "st", "et")

	" If cursor is on a tag move it to the left of the preceding word.
	if c > st  &&  c <= et

		" Look for start and end of word preceding tag.
		execute FindWord(s, st, "sw", "ew")

		if ew > st
			let ew = st
		endif

		if sw != -1  &&  ew != -1  &&  ew > sw
			let t = strpart(s, 0, sw)		" upto word
			let u = strpart(s, sw, st-sw)		" word
			let v = strpart(s, st, et-st)		" tag
			let w = strpart(s, et)			" after tag
			call setline(n, t.v.u.w)
			call cursor(n, c-st+sw)
		else
			" Move tag to end of previous line.
			if n > 1
				let t = strpart(s, st, et-st)	" tag
				let u = strpart(s, et)		" after tag
				call setline(n, u)
				let s = getline(n-1)
				call setline(n-1, s.t) 
				call cursor(n-1, strlen(s)+c-st+sw)
			else
				echo "No words to left of tag"
			endif
		endif
	else
		echo "Cursor not on tag"
	endif
endfunction

function! s:InCommentAt(line, col)
	return synIDattr(synID(a:line, a:col, 0), "name") =~ 'xmlComment'
endfunction

function! ScanLineForTag(line, tag, scol, base)
	"needs: line number to scan, tag to scan for, starting column, variable name to place return value in
	"returns: string that can be executed to set base
	let tags = match(getline(a:line), a:tag, a:scol)
	if tags != -1 "means we have a match
		if s:InCommentAt(a:line, tags) == 0 "means we have a non-comment match
			return "let ".a:base." = ".tags 
		endif
	else
		return "let ".a:base." = ".tags "must not have a match on this line, return the -1
	endif
endfunction

function! ScanForTagMatch(line, tag, scan, scol)
	 "needs: stating line number, tag text (without <>/), scan direction (1 forward, -1 backward), start column
	 "returns: string that can be executed to set linenum of match, and stags or etags
		
		"scan current line for a match first
		let lnum=a:line
		if scan==1
			"go look for ending tag on this line
			execute ScanLineForTag(lnum,"</".tag.">",a:scol,etag)
			if etag != -1
				return "let lnum = ".lnum." | let etags = ".etags
		else
			call ScanLineForTag(lnum,"<".tag.">",a:scol,stag) "go look for start tag


			"stop scanning and return error if we hit the top or bottom of the buffer and havent found a match
			"TODO - figure out the || operator and combine these into a single if...
			if lnum == 1 || lnum >= line("$")
				return "let el = -1"
			endif
		endwhile
	 	return "let el = " . lnum
endfunction


function! DeleteTag()
	"If cursor is on a <> then move cursor into tag to disambiguate
	"Actually move the cursor so that we are in a tag
	let col = col(".")
	let char = getline(".")[col - 1]
	if char == "<"
		call cursor(line("."), col + 1) 
	elseif char == ">"
		call cursor(line("."), col - 1) 
	endif
	 
	let pos = synIDattr(synID(line("."), col("."), 1), "name")
	if pos == "xmlTagName" || pos == "xmlAttrib" || pos == "xmlEqual" || pos == "xmlString"
		"TODO - implement a proper tag stack function. Need to +1 for each additional open tag, and -1 for close (if synid not comment!). When stack is empty, then I've got the proper close tag.
		"find open tag
		let sl = line(".")
		let sline = getline(".")
		let stags = strridx(strpart(sline, 0, col(".")), "<") + 1 "chop everything after current cursor column then find the pos of the last <
		let stag  = matchstr(sline, "[^>\ ]*", stags) "grab tag name - break on <Space> to avoid getting attributes
		let stage = stridx(strpart(sline, stags), ">") + stags "chop from start of tag to end of line then find the pos of the first > add stags to compensate for the discarded start of line
		"locate corresponding close tag
		if strpart(sline, stage) =~ "</".stag.">" "matching close tag on this line
			let etags = match(sline, "</".stag.">", stage)
			let etag  = matchstr(sline, "[^>]*>", etags)
			let etage = matchend(strpart(sline, etags), ">") + etags "matchend finds next occurance and does +1 for me
			"delete tag pair
			call setline(sl, strpart(sline, 0, stags -1).strpart(sline, stage +1, etags-stage-1).strpart(sline, etage))
		else
			execute ScanForTagMatch(sl, stag, 1)
			if el == -1 "no companion tag found
				call setline(sl, strpart(sline, 0, stags -1).strpart(sline, stage+1)) "nuke just tag under cursor
				if getline(sl) =~ "^[ \t]*$"
					execute sl."d"
				endif
				echo 'No matching tag found. Only deleting tag under cursor!' 
				call getchar()
			else
				call setline(sl, strpart(sline, 0, stags -1).strpart(sline, stage+1)) " nuke start tag
				let eline = getline(el)
				let etags = match(eline, "</".stag.">")
				let etage = etags + strlen(stag) + 1
				call setline(el, strpart(eline, 0, etags).strpart(eline,etage+2)) " nuke end tag
				if getline(sl) =~ "^[ \t]*$" "delete the line if its empty
					execute sl."d"
					let el = el - 1 "if we delete the start line, then the end linenum shifts up
				endif
				if getline(el) =~ "^[ \t]*$"
					execute el."d"
				endif
			endif		
		endif
 	elseif pos == "xmlEndTag"
		"TODO
 		"find/store start and end of etag
 		"locate corresponding open tag
 		"find/store start and end of stag
 		"delete tag pair
 		echo "Within a Close-Tag"
 	elseif pos == "xmlComment" || pos == "xmlCommentPart"
		"TODO
 		"find and delete open/close comment tags
 		echo "Within a Comment-Tag"
 	elseif pos == "xmlTag"
		"since we shifted the cursor before entering, this is not <>
		"must be the / of a self closing tag.
	else
		"apparently not on a tag slurp backwards until a tag is found
		"delete the text between the tag pair
 	echo "ARGGGH: " pos
	endif
endfunction


function! DeleteWithinTag()
	let pos = synIDattr(synID(line("."), col("."), 1), "name")
	"TODO
	"Delete text within the tag pair
endfunction

function! FoldTag()
	let pos = synIDattr(synID(line("."), col("."), 1), "name")
	"TODO
	"If on a tag, create and collapse a fold for this tag pair
endfunction


"**********************************************************
" Call all the pretty Functions and actually do something *
"**********************************************************

" Tag movement mappings
execute "nmap " . s:TagLeftWord . " :call MoveTagLeft()"
execute "nmap " . s:TagLeftChar . " F<df>hP<Esc>"
execute "nmap " . s:TagRightChar . " F<df>p<Esc>"
execute "nmap " . s:TagRightWord . " :call MoveTagRight()"


" Define Tag Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1: mapkey
" 2: tagname - may match a predefined template for complex tags
" 3: block_behavior - optional unless an attribute will be used
"   (0 = wrap just start / end of visual-line selection) 
"   (1 = wrap every line in visual-line seleciton with tag 
"      - also create a normal mode map to tag just the current line
"   (2 = wrap just visual-block)
"      - also create a normal mode map to tag just the current word
" 4: attribute - optional

call Maps("C", "COMMENT", 0)

call Maps("A", "al", 0)
call Maps("a", "callout", 0)
call Maps("b", "body", 0)
call Maps("bs", "body", 0, " span=yes")
call Maps("c", "ct", 2)
call Maps("d", "dl", 0)
call Maps("e", "example", 0)
call Maps("f", "file", 2)
call Maps("g", "image", 2)
call Maps("h", "h1", 1)
call Maps("i", "ui", 2)
call Maps("k", "token", 2)
call Maps("ks", "keyseq", 2)
call Maps("kc", "keycaps", 2)
call Maps("kb", "keycombo", 2)
call Maps("l", "li", 1)
call Maps("m", "cmd", 2)
call Maps("n", "note", 1)
call Maps("o", "ol", 0)
call Maps("p", "p", 1)
call Maps("q", "blockquote", 0)
"call Maps("s", "slide", 0)
call Maps("s", "step", 0)
call Maps("t", "table", 0)
call Maps("u", "ul", 0)
call Maps("U", "url", 2)
call Maps("1", "s1", 1)
call Maps("2", "s2", 1)
call Maps("3", "s3", 1)

" Simpler function to handle self closing tags.
call Map(";Bp", "pbreak")
call Map(";Bc", "cbreak")
call Map(";Bl", "br")
call Map(";al", "larrow")
call Map(";ar", "rarrow")
call Map(";sn", "snip")
call Map(";om", "omitted")
call Map(";wr", "wrap")
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


nmap <F12> :call<Space>DeleteTag()

