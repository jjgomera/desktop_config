#!/usr/bin/env python

 ### For support please send email to pranczke[at]gmail.com 
 
 ## Add a line like this to your menu.xml
 ## <menu id="books-menu" label="Books" execute="/path/to/script  /path/to/your/ebooks/" />
 
import sys,os,glob,string

exe_chm = "xchm"			## A program for *.chm files
exe_pdf = "evince"			## A program for *.pdf files
exe = ""

chmfiles = []
pdffiles = []
otherBooks = []
pythonBooks = []
perlBooks = []

def Usage(): 
 	print "Run this script with parametr:  /dir/name"
 	sys.exit(0)

def DirExists(dirname):
	 return len(glob.glob(dirname)) > 0

def GetFiles(dirname):
	return os.listdir(dirname)
			
def GetBooks(files):
	for x in files:
		if string.find(x, 'python') != -1 or string.find(x, 'Python') != -1:
			pythonBooks.append(x)
		elif string.find(x, 'perl') != -1 or string.find(x,'Perl') != -1:
			perlBooks.append(x)
		else:
			otherBooks.append(x)

def CheckType(book):
	if string.find(book, 'pdf') != -1: 
		fileType = "PDF"
	elif string.find(book,  'chm') !=-1:
	 	fileType = "CHM"
	else: 
	 	 fileType = "UNKNOW"
	return fileType

def WhatIsExecuteCommand(x):
	 if CheckType(x) == "PDF":
	 	exe = exe_pdf
	 elif CheckType(x) == "CHM":
	 	exe = exe_chm
	 else:
	 	exe = "Unknown file format"
	 return exe
	 
def RemoveSpaceAndOthers(x):
	 x = string.join(string.split(x, " "), "\ ")
	 x = string.join(string.split(x,  "\'"), "\\'")
	 return x

def MakePythonBooksMenu(pythonBooks,dirname):
	 print "<menu id=\"pythonBooks\" label=\"Programacion\">"
	 for x in pythonBooks:
	 	exe = WhatIsExecuteCommand(x)
	 	print "<item label=\"%s\">" % x[0:-4]
	 	x = RemoveSpaceAndOthers(x)
	 	print "	<action name=\"Execute\"><execute>%s %s%s</execute></action>"  % (exe,dirname,x)
	 	print "</item>"
	 print "</menu>"

def MakePerlBooksMenu(perlBooks,dirname):
	 print "<menu id=\"perlBooks\" label=\"Perl Books\">"
	 for x in perlBooks:
	 	exe = WhatIsExecuteCommand(x)
	 	print "<item label=\"%s\">" % x[0:-4]
		x = RemoveSpaceAndOthers(x)
	 	print "	<action name=\"Execute\"><execute>%s %s%s</execute></action>"  % (exe,dirname,x)
	 	print "</item>"
	 print "</menu>"
	 
def MakeOtherBooksMenu(otherBooks,dirname):
	print "<menu id=\"otherBooks\" label=\"Ingenieria\">"
	for x in otherBooks:
		exe = WhatIsExecuteCommand(x)		
		print "<item label=\"%s\">" % x[0:-4]
		x = RemoveSpaceAndOthers(x)
		print "	<action name=\"Execute\"><execute>%s %s%s</execute></action>"  % (exe,dirname,x)
	 	print "</item>"
	print "</menu>"

def main(argv):
	if len(argv) == 1:
		dirname = argv[0]
		if not DirExists(dirname):
			print "<item label=\"%s doesn't exist\"></item>" % dirname 
			print "</openbox_pipe_menu>"
			sys.exit(2)
			
		if dirname[-1] != '/':
			dirname  = dirname + '/'
		files = GetFiles(dirname)
		GetBooks(files)
#		MakePythonBooksMenu(pythonBooks,dirname)
#		MakePerlBooksMenu(perlBooks,dirname)
		MakeOtherBooksMenu(otherBooks,dirname)
		
	else:
		Usage() 
		
if __name__  == "__main__":
	print "<openbox_pipe_menu>"
	main(sys.argv[1:])
	print "</openbox_pipe_menu>"
	  	 
