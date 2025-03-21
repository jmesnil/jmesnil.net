#! /bin/sh

# Read the s3cmd private keys from my own s3cmd config...
AWS_ACCESS_KEY_ID=`s3cmd --dump-config | grep access_key | grep -oE '[^ ]+$'`
AWS_SECRET_ACCESS_KEY=`s3cmd --dump-config | grep secret_key | grep -oE '[^ ]+$'`

# ... and pass it to the s3cmd inside Docker using env variables
podman run -it --rm \
    -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    -e AWS_SECRET_KEY=$AWS_SECRET_ACCESS_KEY \
    -v `pwd`/:/home/dev/jmesnil.net \
    -v $HOME/.gitconfig:/home/dev/.gitconfig \
    -w /home/dev/jmesnil.net \
    -p 4242:4242 \
    jmesnil/jmesnil.net
