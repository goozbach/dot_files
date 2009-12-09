all: 
	@for i in _*; do   source=${PWD}/$$i;   target=${HOME}/$${i/_/.};   if [ -d $${source} ] ;   then      if [ -h $${target} ] ;     then        : ;     else        ln -sf $${source} $${target};     fi ;   else        ln -sf $${source} $${target};   fi ; done;
