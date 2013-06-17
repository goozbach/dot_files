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
pathmunge /usr/local/sbin after
pathmunge /usr/local/bin after
pathmunge /usr/sbin after
pathmunge /sbin after
pathmunge ${HOME}/.cabal/bin after
#pathmunge /usr/local/lib/perl5/site_perl/5.10.0/auto/share/dist/Cope
pathmunge ${HOME}/stowdir/bin
pathmunge /usr/local/opt/ruby/bin

export PATH
