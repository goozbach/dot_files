# generic aliases
alias bazlog='vi `baz make-log`'
alias mplayer='mplayer -zoom -fs '
alias hr='for i in $(seq 1 $COLUMNS); do echo -n -; done'
alias 'isodate'='date +%Y-%m-%d'

# ls color is different on darwin than linux
myvar=$(uname | tr 'A-Z' 'a-z')
case $myvar in
linux)
   alias ls='ls -F --color'
;;
darwin)
   alias ls='ls -F -G'
   export LSCOLORS="gxfxbxdxcxegedabagacad"
;;
sunos)
   alias ls='ls -F'
;;
*)
   alias ls='ls'
;;
esac

