
# prompt stuff
if [[ $EUID == 0 ]]
then
  export PS1="\[${Red}\][\u@\h \W]\$\[${Reset}\] "
else
  if /bin/hostname | grep 'mine' &>/dev/null
  then
    PS1="\n[\[${Cyan}\]\D{%F:%T} \[${Green}\]\u@\[${Blue}\]\h \[${Cyan}\]\w\[${Reset}\]]\n\$ "
  elif /bin/hostname | grep 'coraid' &> /dev/null
  then
    PS1="\n[\[${Cyan}\]\D{%F:%T} \[${Green}\]\u@\[${Yellow}\]\h \[${Cyan}\]\w\[${Reset}\]]\n\$ "
  else
    PS1="\n[\[${Cyan}\]\D{%F:%T} \[${Green}\]\u@\h \[${Cyan}\]\w\[${Reset}\]]\n\$ "
  fi
fi

# prompt_command() is set in 90-history
PROMPT_COMMAND='prompt_command'

export PS1 PROMPT_COMMAND
