# where does this freaking thing in my path come from?

wtf(){
  ARG1=$1
  FULLPATH=$(which ${ARG1})
  echo "type: $(type ${ARG1})"
  echo "path: ${FULLPATH}"
  rpm -qf ${FULLPATH}
}
