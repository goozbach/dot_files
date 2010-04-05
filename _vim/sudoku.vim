"=============================================================================
" File: sudoku.vim
" Author: Bertram Scharpf <vim@bertram-scharpf.de>
" Last Change: 2005 August 18
" Version: 0.1
"-----------------------------------------------------------------------------
" This is an easy helper for Sudoku riddle solving.
"-----------------------------------------------------------------------------
" If you like, put this file into the plugins directory. If you're
" not sure whether you will like it, source it using the :source command.
" automatically sourced.  If not, you must manually source this file
" using :source explorer.vim
"
" Commands
"
"   :Sudoku  <filename>     open a new Sudoku
"   :VSudoku <filename>     dto., split vertically
"   :HSudoku <filename>     dto., split horizontally
"
"     If <filename> is omitted, a nameless buffer is created.
"
"   :let help_sudoku=0      avoid insertion of the help message
"
" Keys
"
"   1-9       Put digit to cursor position.
"   u <C-R>   Undo, redo.
"   #         Check Sudoku under cursor.
"   *         Highlight digit under cursor.
"   +         Unhighlight all.
"   C         Create new field.
"
"
" Please report bugs to <vimsudoku@bertram-scharpf.de>.
"
"
" By the way: Job offers
"
"   If you're doing a high-level project and you need a qualified
"   programmer maybe you like to consider hiring me. My favourite
"   languages are C, C++, Python, Ruby, and TeX. My preferred OS
"   is Linux. I live in Stuttgart, Germany. Please contact me at
"   <auftrag@bertram-scharpf.de>.
"
"=============================================================================


if exists("loaded_sudoku")
  finish
endif
let loaded_sudoku=1

if !exists("help_sudoku")
  let help_sudoku=1
endif


function s:MakeGrid()
  if line(".") != 1 || getline(".") != ""
    -1
    norm }
    -1
    exec "norm! o\<esc>"
  else
    exec "norm! O\<esc>"
  endif
  let i=1
  while 1
    let j=1
    while j<=3
      let k=1
      exec "norm! o\<esc>"
      while 1
        exec "norm! 3A.\<esc>$"
        let k=k+1
        if k>3 | break | endif
        exec "norm! A|\<esc>$"
      endwhile
      let j=j+1
    endwhile
    let i=i+1
    if i>3 | break | endif
    exec "norm! o\<esc>"
    let k=1
    while 1
      exec "norm! 3A-\<esc>$"
      let k=k+1
      if k>3 | break | endif
      exec "norm! A+\<esc>$"
    endwhile
  endwhile
endfunc


function s:CheckDigits( s)
  let s=substitute( a:s, "\\D", "", "g")
  let i=1
  while i<10
    let s=substitute( s, i, "", "")
    let i=i+1
  endwhile
  if s!=""
    let orig=substitute(a:s, "\n", "", "g")
    if strlen(s)>1
      let msg="Digits `".s."' occur more than once in `".orig."'."
    else
      let msg="Digit `".s."' does occur more than once in `".orig."'."
    endif
    throw msg
  endif
endfunc

function s:CheckAll()
  let pl=line(".")
  let pc=col(".")
  try
    setlocal selection=inclusive
    silent exec "norm! \"_yipV10j\<esc>"
    '<,'>v/^-/call s:CheckDigits(getline("."))
    silent exec "norm! \"_yip"
    while 1
      silent exec "norm! \<C-V>10j\"ay"
      call s:CheckDigits(@")
      if col(".")+1==col("$")
        break
      endif
      norm! l
    endwhile
    silent exec "norm! \"_yip"
    let i=1
    while 1
      let j=1
      while 1
        silent exec "norm! \<C-V>2j2ly"
        call s:CheckDigits(@")
        let j=j+1
        if j>3
           break
        endif
        norm! 4l
      endwhile
      norm! 0
      let i=i+1
      if i>3
         break
      endif
      norm! 4j
    endwhile
    silent exec "norm! yip"
    if strlen(substitute(@","\\D", "", "g"))==81
      echo "You're done. Congratulations."
    else
      echo "Everything is ok."
    endif
  catch
    echo v:exception
  endtry
  call cursor(pl,pc)
endfunc

function s:HighlightCur()
  set hlsearch
  let @/=escape( strpart(getline(line(".")), col(".")-1, 1), ".")
endfunc


function s:EstablishBuffer( vh, name)
  if a:name==""
    if a:vh == "v"
      let splitcmd="12vnew"
    elseif a:vh == "h"
      let splitcmd="12new"
    else
      let splitcmd="enew"
    endif
  else
    if a:vh == "v"
      let splitcmd="12vsplit"
    elseif a:vh == "h"
      let splitcmd="12split"
    else
      let splitcmd="edit"
    endif
    let splitcmd=splitcmd." ".a:name
  endif
  exec splitcmd
  setlocal selection=inclusive

  if a:name==""
    if g:help_sudoku
      0put ='Commands:'
      put  ='  1-9                  put digit to cursor position'
      put  ='  u <C-R>              undo, redo'
      put  ='  #                    check Sudoku under cursor'
      put  ='  *                    highlight digit under cursor'
      put  ='  +                    unhighlight all'
      put  ='  C                    create new field'
      put  ='  :let help_sudoku=0   avoid this message (in your .vimrc)'
      +1
    endif

    call s:MakeGrid()
  endif

  " digit mappings
  let i=1
  while i < 10
    exec "nnoremap <buffer> ".i." r".i
    let i=i+1
  endwhile

  " functionality mappings
  nnoremap <buffer> #   :call <SID>CheckAll()<cr>
  nnoremap <buffer> *   :call <SID>HighlightCur()<cr>
  nnoremap <buffer> +   :set nohlsearch<cr>
  nnoremap <buffer> C   :call <SID>MakeGrid()<cr>
endfunc


command -nargs=* -complete=file Sudoku    call <SID>EstablishBuffer( "", <q-args>)
command -nargs=* -complete=file VSudoku   call <SID>EstablishBuffer( "v", <q-args>)
command -nargs=* -complete=file HSudoku   call <SID>EstablishBuffer( "h", <q-args>)


" vim: set ts=8 sts=2 sw=2 et :
