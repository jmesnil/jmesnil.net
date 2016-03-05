#! /bin/sh
docker run -it --rm -v `pwd`/:/home/jmesnil/jmesnil.net -p 4242:4242 -w /home/jmesnil/jmesnil.net jmesnil.net
