# history stuff
export HISTSIZE=10000000
# create the historydir if it doesn't exist
if [[ ! -d ${HOME}/.bash_history.d/ ]]
then
        mkdir -p ${HOME}/.bash_history.d/
fi

# one history file per year
export HISTFILE=${HOME}/.bash_history.d/${HOSTNAME}.$(date +%Y)
export HISTTIMEFORMAT='%F_%T%t'
export HISTCONTROL='ignoreboth'
unset HISTFILESIZE

shopt -s histappend

histgrep (){
  cat ${HOME}/.bash_history.d/* | cut -d ':' -f 3 | grep "$1"| sort -rn | uniq -c | sort -rn;
}

# root user auditing
if [[ ${EUID} == 0 ]]
then
        if [[ ! -d ${HOME}/.bash_audit.d/ ]]
        then
                echo "creating audit dir"
                mkdir -p ${HOME}/.bash_audit.d/
                touch ${HOME}/.bash_audit.d/${AUDIT_USER}.log
                touch ${HOME}/.bash_audit.d/overall.log
                chattr +a ${HOME}/.bash_audit.d/${AUDIT_USER}.log  ${HOME}/.bash_audit.d/overall.log
        fi
        # set promptcommand to audit files
        prompt_command() {
                history -a;
                history -n;
                echo ": $AUDIT_USER ran command $(history 1)" >> ${HOME}/.bash_audit.d/${AUDIT_USER}.log
                echo ": $AUDIT_USER ran command $(history 1)" >> ${HOME}/.bash_audit.d/overall.log
        }
else
        prompt_command() {
                history -a;
                history -n;
        }
fi

