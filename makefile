all: 
	@for i in _*; do\
		source=${PWD}/$$i;\
		target=${HOME}/$${i/_/.};\
		ln -sfT $${source} $${target};\
	done;
