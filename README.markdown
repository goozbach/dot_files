# Dot File Managment
I have always wanted a simple way of managing my bash file settings (bashrc, bash_profile and the like).  
I had built a system much like this one, but it didn't work very well. So this is a ground-up rewrite

## instructions
Any file which matches the shell glob `_*` will be linked into `$HOME` as a symlink with the first `_`  
replaced with a `.`

For example:

        _bashrc

becomes

        ${HOME}/.bashrc

## requirements
* bash
* gnu make
