import os
import sys
from urllib2 import urlopen

def open(url):
    os.system("open '%s'" % url)

if len(sys.argv) != 3:
    print "Usage: %s <base_dir> <base_url>" % sys.argv[0]
    sys.exit(-1)
        
base_dir=sys.argv[1]
base_url = sys.argv[2]
print "open files from %s with URLs to %s" % (base_dir, base_url)

for root, dirs, files in os.walk(base_dir, topdown=False):
    for f in files:
        if f == "index.html":
            url = root[len(base_dir):] + "/"
            open(base_url + url)
