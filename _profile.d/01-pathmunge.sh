pathmunge () {
    if ! echo $PATH | grep -E -q "(^|:)$1($|:)" ; then
       if [ "$2" = "after" ] ; then
          PATH=$PATH:$1
       else
          PATH=$1:$PATH
       fi
    fi
}

# ksh workaround
if [ -z "$EUID" -a -x /usr/bin/id ]; then
    EUID=`id -u`
    UID=`id -ru`
fi

# Path manipulation
if [ "$EUID" = "0" ]; then
    pathmunge /sbin
    pathmunge /usr/sbin
    pathmunge /usr/local/sbin
else
    pathmunge /usr/local/sbin after
    pathmunge /usr/sbin after
    pathmunge /sbin after
fi
pathmunge /usr/local/lib/perl5/site_perl/5.10.0/auto/share/dist/Cope
