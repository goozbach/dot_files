" Vivek Venugopalan's .vimrc tweaks for use with DocBook 4.1.  This has been
" revised from Dan York's .vimrc 
" Revised: July 23, 2001
" Used with vim 5.7
" email : vivekv@yahoo.com

" MAPPINGS
" Like the .vimrc file shown at http://www.vim.org/ I decided to
" start all my mappings with a comma. Since I do pretty much all
" my work in DocBook, I just started with the letter after the 
" comma for a DB tag, rather than using something like 'd' to 
" indicate it was a DB tag (i.e. ',dp' instead of ',p'). If you 
" want to use other mappings, you may want to change this.
" My mappings are currently primarily for easy of entering DB
" tags. I haven't yet gotten into changing existing text with mappings.

" A side effect of using the comma for mappings is that when you type
" a comma in vim, it will now pause and wait for input. If you just hit
" the spacebar, you should see a regular old comma appear.

" Note: 'imap' = a mapping for 'insert' mode of vim
" All of these commands work ONLY when you are in Insert mode

" <CR> will put a line return in the file. This is purely my style of
" entering certain DocBook tags.  You may wish to remove some.

" After typing the DocBook tag, many of these macros then switch to 
" vim command mode, reposition the cursor to where I want it to be, 
" and then re-inter insert mode. You may wish to change where it ends.


" header and setup info for a book
imap ,dtbk <!DOCTYPE BOOK PUBLIC "-//OASIS//DTD DocBook V4.1//EN">
imap ,bk <book><CR><bookinfo><CR><title></title><CR><author><CR><firstname></firstname><CR><surname></surname><CR></author><CR><address><email></email></address><CR><copyright><CR><year></year><CR><holder></holder><CR></copyright><CR><revhistory><CR></revhistory><CR></bookinfo><CR><CR></book><esc>12k$bba
"Internal subset declaration
imap ,et <!ENTITY TODO-key "TODO-value"><CR>
imap ,rev <revision><CR><revnumber></revnumber><CR><date></date><CR><authorinitials></authorinitials><CR><revremark></revremark><CR></revision><esc>4k$bba

"header and setup info for an article.
imap ,dtart <!DOCTYPE ARTICLE PUBLIC "-//OASIS//DTD DocBook V4.1//EN">
imap ,art <article><CR><title></title><CR><CR><artheader><CR><CR><author><CR><firstname></firstname><CR><surname></surname><CR><affiliation><CR><address><email></email></address></affiliation><CR></author><CR><CR><revhistory><CR></revhistory><CR><CR></artheader><CR><abstract><CR><indexterm><CR><primary></primary><CR></indexterm><CR><para><CR><para><CR></abstract><CR><CR></article><esc>16k$bba

"Paragraph formatting
imap ,p <para><CR></para><esc>k$a

" character formatting
imap ,em <emphasis></emphasis><esc>bba
imap ,es <emphasis role="strong"></emphasis><esc>bbla

"Special characters
imap ,> &gt;
imap ,< &lt;

" links
imap ,u <ulink url=""></ulink><esc>bb3la
imap ,lk <link linkend=""></link><esc>bb3la

" lists
" note that ',l2' was created solely to fit into ,il and ,ol
imap ,li <listitem><CR><TAB><para><CR></para><CR></listitem><esc>kk$a
imap ,l2 <listitem><CR><TAB><para><CR></para><CR></listitem>
imap ,il <itemizedlist><CR><TAB>,l2<CR></itemizedlist><esc>kkk$a
imap ,ol <orderedlist><CR><TAB>,l2<CR></orderedlist><esc>kkk$a
imap ,ve <varlistentry><CR><TAB><term></term><CR>,l2<CR></varlistentry>
imap ,vl <variablelist><CR><TAB><title></title><CR>,ve<CR></variablelist>

" sections
" I put a <para> in here so that onsgmls will treat it as valid DB even with 
" nothing entered into the text.
" Note that I also assign an 'id' to each section so that openjade generates
" files with those ids as names.
imap ,s1 <sect1 id=""><CR><title></title><CR><para><CR></para><CR></sect1><esc>kkkk$bla
imap ,s2 <sect2 id=""><CR><title></title><CR><para><CR></para><CR></sect2><esc>kkkk$bla
imap ,s3 <sect3 id=""><CR><title></title><CR><para><CR></para><CR></sect3><esc>kkkk$bla
imap ,ch <chapter id=""><CR><title></title><CR><para><CR></para><CR></chapter><esc>kkkk$bla

" images
" My mediaobject has two imagedata entries - 1 for EPS and 1 for JPG
imap ,img <imageobject><CR><imagedata fileref="" format=""><CR></imageobject>
imap ,mo <mediaobject><CR>,img<esc>k$hiEPS<esc>j$a<CR>,img<esc>k$hiJPG<esc>j$a<CR></mediaobject>

" other objects
imap ,ti <title></title><esc>bba
imap ,fn <footnote><para></para></footnote>
imap ,sb <sidebar><CR><title></title><CR><para></para><CR></sidebar>
imap ,no <note><CR><para></para><CR></note>
imap ,w <warning><CR><para></para><CR></warning>
imap ,co <!--  --><esc>bhi
imap ,qt <blockquote><CR><attribution></attribution><CR><literallayout><CR></literallayout><CR></blockquote>
imap ,ge <glossentry><glossterm></glossterm><CR><glossdef><CR><para><CR></para><CR></glossdef><CR></glossentry><esc>kkkkk$bba

" examples
imap ,ex <example id=""><CR><title></title><CR></example><ESC>$kkba

"For preparing FAQs
imap ,faq <article class=faq><CR><title>Frequently asked questions</title><CR><CR><articleinfo><CR><CR><author><CR><firstname></firstname><CR><surname></surname><CR><affiliation><CR><address><email></email></address></affiliation><CR></author><CR><CR><revhistory><CR></revhistory><CR><CR></articleinfo><CR><abstract><CR><indexterm><CR><primary></primary><CR></indexterm><CR><para><CR><para><CR></abstract><CR><CR><qandaset><CR><qandadiv><CR><title></title><CR><qandaentry><CR><question><CR><para></para><CR></question><CR><answer><CR><para></para><CR></answer><CR></qandaentry><CR><qandadiv><CR><qandaset><CR><CR></article><esc>16k$bba

imap ,qd <qandaset><CR><qandadiv><CR><title></title><CR><qandaentry><CR><question><CR><para></para><CR></question><CR><answer><CR><para></para><CR></answer><CR></qandaentry><CR><qandadiv><esc>9k$bba

imap ,qa <qandaentry><CR><question><CR><para></para><CR></question><CR><answer><CR><para></para><CR></answer><CR></qandaentry><esc>5k$bba
"Setup for building docbook sgml from within vim.  The idea is to use a script
"that will run openjade and capture the output in a file called "jade.err".
"This file is then made to look like the error file to vim with the error
"fomat.  VIM will automatically point out the errors in the file.
set sp=
set makeef=jade.err
set makeprg=mkrtf.ksh\ %
set errorformat=jade:%f:%l:%c:%t:%m
