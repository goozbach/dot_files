" Tag templates.

let g:Template_book = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><CR><CR>"
   \."<book xmlns:xi=\"http://www.w3.org/2001/XInclude\" xml:base=\"../sections/\"><CR>"
   \."  <code>GL-:-</code><CR>"
   \."  <title></title><CR>"
   \."  <abstract></abstract><CR>"
   \."  <xi:include href=\"FIXME.xml\"/><CR>"
   \."</book>"

let g:Template_section = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><CR><CR>"
   \."<section xmlns:xi=\"http://www.w3.org/2001/XInclude\"><CR>"
   \."   <title>-:-</title><CR>"
   \."   <abstract></abstract><CR>"
   \."   <xi:include href=\"FIXME.xml\" xml:base=\"../courselets/\"/><CR>"
   \."</section>"
   
let g:Template_courselet = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
   \."<courselet><CR>"
   \."  <info><CR>"
   \."     <title>FIXME</title><CR>"
   \."        <topics><CR>"
   \."            <topic>FIXME</topic><CR>"
   \."        </topics><CR>"
   \."        <abstract>FIXME</abstract><CR>"
   \."        <authors><CR>"
   \."            <author>FIXME</author><CR>"
   \."        </authors><CR>"
   \."  </info><CR>"
   \."  <text><CR>"
   \."     <title>-:-</title><CR>"
   \."     <slide><CR><CR>"
   \."     </slide><CR>"
   \."      <notes><CR>"
   \."      </notes><CR>"
   \."      <body><CR><CR>"
   \."      </body><CR>"
   \."  </text><CR>"
   \."</courselet>"

let g:Template_definitionList = "<dl><CR>"
   \."  <dt>-:-</dt><CR>"
   \."  <dd></dd><CR>"
   \."</dl>"

let g:Template_orderedList = "<ol><CR>"
   \."  <li>-:-</li><CR>"
   \."</ol>"

let g:Template_table = "<table><CR>"
   \."  <tr><th>-:-</th>   <th></th></tr><CR>"
   \."  <tr><td></td>   <td></td></tr><CR>"
   \."</table>"

let g:Template_unorderedList = "<ul><CR>"
   \."  <li>-:-</li><CR>"
   \."</ul>"

let g:Template_image = "<img src=\"-:-\" />"

let g:Template_breakPage = "<pbreak /> -:-"

let g:Template_breakColumn = "<cbreak /> -:-"

let g:Template_breakLine = "<br /> -:-"

let g:Template_leftArrow = "<larrow /> -:-"

let g:Template_rightArrow = "<rarrow /> -:-"

let g:Template_snip = "<snip /> -:-"

let g:Template_outputOmitted = "<omitted /> -:-"

let g:Template_lineWrap = "<wrap /> -:-"

