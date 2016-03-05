#! /bin/sh

# Read the s3cmd private keys from my own s3cmd config...
AWS_ACCESS_KEY_ID=`s3cmd --dump-config | grep access_key | grep -oE '[^ ]+$'`
AWS_SECRET_ACCESS_KEY=`s3cmd --dump-config | grep secret_key | grep -oE '[^ ]+$'`

# ... and pass it to the s3cmd inside Docker using env variables
docker run -it --rm -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_KEY=$AWS_SECRET_ACCESS_KEY -v `pwd`/:/home/jmesnil/jmesnil.net -p 4242:4242 -w /home/jmesnil/jmesnil.net jmesnil/jmesnil.net
