PLAN9=${HOME}/projects/plan9port
export PLAN9

pathmunge $PLAN9/bin after
export PATH

MANPATH=${MANPATH}:${PLAN9}/man

if [[ ${TERM} == 9term ]]
then
  unset PS1
  export PS1='\n[\D{%F:%T} \u@\h \W]\n» '
  alias lc=ls
  alias tree='\tree --charset ascii -n'
  alias grep='grep -Hn'
  alias git='git --no-pager -c color.status=never -c color.branch=never -c color.interactive=never -c color.diff=never'
  »(){
    eval ${@}
  }
  cd(){
    builtin cd $@ && awd $sysname
  }  
fi
