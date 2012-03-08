import os
import sys
from urllib2 import urlopen

def check(url):
    try:
        code = urlopen(url).code
        if (code / 100 == 2):
            return True
        else:
            return False
    except:
        return False

if len(sys.argv) != 3:
    print "Usage: %s <base_dir> <base_url>" % sys.argv[0]
    sys.exit(-1)
        
base_dir=sys.argv[1]
base_url = sys.argv[2]
print "checking files from %s with URLs to %s" % (base_dir, base_url)

for root, dirs, files in os.walk(base_dir, topdown=False):
    for f in files:
        if f == "index.html":
            url = root[len(base_dir):] + "/"
            ok = check(base_url + url)
            if ok:
                status = "OK"
            else:
                status = "NOK"
            if not ok:
                print "%s: [%s]" % (url, status)
