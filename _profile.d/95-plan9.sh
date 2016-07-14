PLAN9=${HOME}/projects/plan9port
export PLAN9

pathmunge $PLAN9/bin after
export PATH

MANPATH=${MANPATH}:${PLAN9}/man

# inside 9term stuff
if [[ ${TERM} == 9term || ${TERM} == dumb ]]
then
  unset PS1
  export PS1='\n[\D{%F:%T} \u@\h \W]\n» '
  alias lc=ls
  alias tree='\tree --charset ascii -n'
  alias grep='grep -Hn'
  alias git='git --no-pager -c color.status=never -c color.branch=never -c color.interactive=never -c color.diff=never'
  export ANSIBLE_NOCOWS=1
  export VAGRANT_NO_COLOR=true
  »(){
    eval ${@}
  }
  cd(){
    builtin cd $@ && awd $sysname
  }  
fi

acme(){
  export tabstop=2
  if [[ ! -d /mnt/plumb ]]
  then
    mkdir -p /mnt/plumb
  fi
  9p ls plumb &>/dev/null || plumber &
  mount | grep -q '/mnt/plumb' || 9pfuse `namespace`/plumb /mnt/plumb
  
  if [[ ! -d /mnt/font ]]
  then
    mkdir -p /mnt/font
  fi
  9p ls font &>/dev/null || fontsrv &
  mount | grep -q '/mnt/font' || 9pfuse `namespace`/font /mnt/font
  
  if [[ ! -d /mnt/acme ]]
  then
    mkdir -p /mnt/acme
  fi
  ( $PLAN9/bin/acme -f /mnt/font/LucidaGrande/15a/font -F /mnt/font/Menlo-Bold/15a/font $@; umount /mnt/acme; ) &
  disown -a
  sleep 3
  mount | grep -q '/mnt/acme' || 9pfuse `namespace`/acme /mnt/acme
}
