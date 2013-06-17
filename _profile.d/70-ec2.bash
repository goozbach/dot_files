if [[ -f /usr/libexec/java_home ]] 
  then
    export JAVA_HOME="$(/usr/libexec/java_home)"
fi
if /bin/ls "$HOME"/.ec2/pk-*.pem &> /dev/null
then
  export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
  export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
  export EC2_AMITOOL_HOME="/usr/local/Library/LinkedKegs/ec2-ami-tools/jars"
fi
