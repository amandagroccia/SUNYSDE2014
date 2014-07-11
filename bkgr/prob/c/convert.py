#!/usr/bin/python

import re
import sys

fp = open("milsteinresults10k.csv","r")
a = "1"
accum = ""
number = 0
buffer = [ [] ]
while(True):
	a=fp.read(1)
	if(len(a)==0):
		print("break!")
		break
	elif((a==" ") or (a=="\n") or (a=="\t")):
		if(len(accum)>0):
			buffer[number].append(accum)
		
		if(a == "\n"):
			number = (number + 1)%2
			print("End of line: {0}".format(number))
			buffer.append([])
		#if(number == 0):
		#	sys.stdout.write("\n")
		#else:
		#	sys.stdout.write(",")
		a = ""
		accum = a

	else:
		#if(number > 0):
		#	sys.stdout.write(a)
		accum = "{0}{1}".format(accum,a)

fp.close()
#print(buffer[0][2])
#print(buffer[1][2])

fp = open("/tmp/milsteinresults10k.csv","w")
lupe = 0
N = len(buffer[0])
fp.write("x,y\n")
while(lupe < N):
	fp.write("{0},{1}\n".format(buffer[0][lupe],buffer[1][lupe]))
	lupe = lupe + 1
fp.close()

	
