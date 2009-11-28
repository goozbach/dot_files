all:
	@for i in _*; do ln -sfT ${PWD}/$i ${HOME}/$(echo $i | sed -e "s/^_\(.*\)/\.\1/"); done
