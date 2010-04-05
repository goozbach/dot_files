#!/bin/sh
#
# File: ~/.ssh/ssh-login
#
# Checks authentication environment.
# If the ssh-agent is not running, starts a new one.
# 
# Setup instructions:
# 
# 1) For bash and ksh users:
#
#    Include the following in your ~/.bashrc or ~/.kshrc:
#
#    . $HOME/.ssh/ssh-login
#
#    Note, The common error is to instead include this command to ~/.bash_profile file.
#    The authentication method of any subsequent non-login shell sessions
#    started will not be supplied by the running ssh-agent which 
#    only calls ~/.bashrc for their shell session setup. The startup
#    of the login shell session includes a call to ~/.bashrc anyway.
#
#
#
# 2) For csh and tcsh users:
#
#    Include the following in your ~/.cshrc or ~/.tcshrc
#
#    source $HOME/.ssh/ssh-login
#
#

SSH_ENV=$HOME/.ssh/env-$HOSTNAME

function ssh_clean {
    d="$HOME/.ssh"

    f0=$d/known_hosts
    f1=$d/known_hosts_tmp

    cat /dev/null > $f1

    while read host line; do
	if [ $host != "localhost" ]; then
	    echo $host $line >> $f1
	fi
    done < $f0

    mv $f1 $f0

    chmod 644 $f0
}


# Initialize new agent and add authentication
function start_agent {


    # Start authenticating daemon
    # No authentications set up yet, just starting daemon!
    ssh-agent | head -2 > ${SSH_ENV}
    chmod 600 ${SSH_ENV}

    # Find SSH_AUTH_SOCK and SSH_AGENT_PID of the available daemon
    . ${SSH_ENV} > /dev/null

    # Add authentication to this and only this daemon
    for i in $HOME/.ssh/id_dsa*;
    do 
      if ! echo $i | grep -E '\.(pub|keystore)' &>/dev/null;
      then 
        ssh-add $i
      fi;
    done
}


if [ -f "$SSH_ENV" ]; then
    # Find SSH_AUTH_SOCK and SSH_AGENT_PID of the available daemon
    . ${SSH_ENV} > /dev/null

    # Check if the agent is still running
    ierr=0
    ps ${SSH_AGENT_PID} > /dev/null || ierr=1

    if [ $ierr == "0" ]; then
	echo > /dev/null
    else
	# If not initialize new agent and 
	# add authentication
	start_agent;
    fi
else
    start_agent;    
fi

# Clean localhost entry in the known host file
ssh_clean

