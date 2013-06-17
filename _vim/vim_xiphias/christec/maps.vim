" 1: is the key or text that is typed after the tag-key to insert the tag.
" 2: flag to insert a blank line before the open tag
" 3: flag fo insert a blank line after close tag
" 4: name of tag or tag template
" 5: attributes for tag

call MapTagKey("book", 0, 0, "book", "")
call MapTagKey("section", 0, 0, "section", "")
call MapTagKey("courselet", 0, 0, "courselet", "")
call MapTagKey("b", 1, 0, "body", "")
call MapTagKey("bs", 1, 0, "body", " span=yes")
call MapTagKey("c", 0, 0, "ct", "")
call MapTagKey("C", 0, 0, "COMMENT", "")
call MapTagKey("d", 1, 0, "definitionList", "")
call MapTagKey("e", 0, 0, "example", "")
call MapTagKey("f", 0, 0, "file", "")
call MapTagKey("g", 0, 0, "image", "")
call MapTagKey("h", 0, 0, "h1", "")
call MapTagKey("i", 0, 0, "ui", "")
call MapTagKey("k", 0, 0, "token", "")
call MapTagKey("l", 1, 0, "li", "")
call MapTagKey("m", 0, 0, "cmd", "")
call MapTagKey("n", 0, 0, "note", "")
call MapTagKey("o", 1, 0, "orderedList", "")
call MapTagKey("p", 0, 0, "p", "")
call MapTagKey("q", 1, 1, "blockquote", "")
call MapTagKey("s", 0, 1, "slide", "")
call MapTagKey("t", 1, 0, "table", "")
call MapTagKey("u", 1, 0, "unorderedList", "")
call MapTagKey("U", 0, 0, "url", "")
call MapTagKey("1", 1, 0, "s1", "")
call MapTagKey("2", 0, 0, "s2", "")
call MapTagKey("3", 0, 0, "s3", "")
call MapTagKey("Bp", 0, 0, "breakPage", "")
call MapTagKey("Bc", 0, 0, "breakColumn", "")
call MapTagKey("Bl", 0, 0, "breakLine", "")
call MapTagKey(";al", 0, 0, "leftArrow", "")
call MapTagKey(";ar", 0, 0, "rightArrow", "")
call MapTagKey(";snip", 0, 0, "snip", "")
call MapTagKey(";omit", 0, 0, "outputOmitted", "")
call MapTagKey(";wrap", 0, 0, "lineWrap", "")


" *********************************************************
" Moving and adjusting tags.

nmap <F12> :call DeleteTag()
nmap <F5> :call CursorLeftByTag()
nmap <F6> :call MoveTagLeft()
nmap <F7> :call MoveTagRight()
nmap <F8> :call CursorRightByTag()
imap <F12> :call DeleteTag()
imap <F5> :call CursorLeftByTag()a
imap <F6> :call MoveTagLeft()
imap <F7> :call MoveTagRight()
imap <F8> :call CursorRightByTag()a

nmap <S-F5> :call TightenTagLeft()
nmap <S-F6> :call InsertStringLeftOfTag(" ")
nmap <S-F7> :call InsertStringRightOfTag(" ")
nmap <S-F8> :call TightenTagRight()
imap <S-F5> :call TightenTagLeft()
imap <S-F6> :call InsertStringLeftOfTag(" ")
imap <S-F7> :call InsertStringRightOfTag(" ")
imap <S-F8> :call TightenTagRight()

