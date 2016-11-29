#!/usr/bin/python

import os
from winfstest import *

name = uniqname()

f = open(name, "w")
f.truncate(1024)
f.seek(0, os.SEEK_END)

testeval(f.tell() == 1024)
f.seek(0)
f.write("Hello")
testeval(f.tell() == 5)
f.close()

testeval(os.stat(name).st_size == 1024)

os.unlink(name)

testdone()
