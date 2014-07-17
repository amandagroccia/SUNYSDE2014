#!/usr/bin/python


import csv

fp = open("shrimpPopMulNoiseFULL.csv",'r')
rowReader = csv.reader(fp,delimiter=',')
xsum = 0.0
ysum = 0.0
x2sum = 0.0
y2sum = 0.0
sums = {}
header = rowReader.next()
print("top row: {0}".format(header))
for row in rowReader:
	x = float(row[0])
	y = float(row[1])
	#print("{0},{1},{2},{3}".format(x,y,row[2],row[3]))
	index = "{0},{1}".format(row[2],row[3])
	if (index not in sums):
		sums[index] = [0.0,0.0,0.0,0.0]
		print("New index: {0}".format(index))
	sums[index][0] = sums[index][0] + x
	sums[index][1] = sums[index][1] + x*x
	sums[index][2] = sums[index][2] + y
	sums[index][3] = sums[index][3] + y*y
fp.close()


fp = open("mulNoiseResults.csv",'w')
fp.write("sx,sx2,sy,sy2,gamma,delta\n")
for key, value in sums.iteritems():
	fp.write("{0},{1},{2},{3},{4}\n".format(value[0],value[1],value[2],value[3],key))
fp.close()
