# find out if a perl module works
perluse() {
    if (( $# > 1 )) 
    then
        echo "Only one argument allowed" 1>&2
    else
        perl -e "use $1" &> /dev/null
        RETVAL=$?
        if [[ $RETVAL == 0 ]]
        then
           echo "Perl Module: $1 does work"
           exit 0
        else
           echo "Perl Module: $1 not found in $(perl -e "print join(':',@INC)")"
        fi
    fi
}
