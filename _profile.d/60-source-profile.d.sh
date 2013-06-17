for i in /etc/profile.d/*.sh ; do
    if [ -r "$i" ]; then
        if [ "$PS1" ]; then
            source $i
        else
            source $i >/dev/null 2>&1
        fi
    fi
done
