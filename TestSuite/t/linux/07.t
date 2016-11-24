#!/usr/bin/python

# SetFileAttributes

from winfstest import *

name = uniqname()

expect("CreateFile %s GENERIC_WRITE 0 0 CREATE_ALWAYS FILE_ATTRIBUTE_NORMAL 0" % name, 0)
expect("GetFileInformation %s" % name, lambda r: r[0]["FileAttributes"] == 0x20)
expect("SetFileAttributes %s FILE_ATTRIBUTE_READONLY" % name, 0)
expect("GetFileInformation %s" % name, lambda r: r[0]["FileAttributes"] == 0x21)
expect("SetFileAttributes %s FILE_ATTRIBUTE_SYSTEM" % name, 0)
expect("GetFileInformation %s" % name, lambda r: r[0]["FileAttributes"] == 0x20) # No system attribute on posix systems
expect("SetFileAttributes %s FILE_ATTRIBUTE_HIDDEN" % name, 0)
expect("GetFileInformation %s" % name, lambda r: r[0]["FileAttributes"] == 0x20) # hidden attribute is implicit for files beginning by a dot
expect("SetFileAttributes %s FILE_ATTRIBUTE_ARCHIVE" % name, 0)
expect("GetFileInformation %s" % name, lambda r: r[0]["FileAttributes"] == 0x20)
expect("DeleteFile %s" % name, 0)

testdone()
