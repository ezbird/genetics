"""
Script to generate depth comparison matrices for a partial mantel test

TO RUN: python runMatrix.py
PARAMETERS: none

Ezra Huscher
Kane Lab, University of Colorado Boulder

November 2017
"""

import csv
import numpy

num = 31

headers = ['15717','16618','16618_mod','16618_mod_EX1','16618_mod_EX2','16618_mod_INT1','3891','1330','19603','74778','50320','3498','395','1774','001774_mod','2936','4341','4650','5134','6591','6705','7396','7887','8242','Comb_THC','Comb_CBD','Comb_CBG','Comb_CBN','Comb_CBC']

bigMatrix = numpy.zeros((num, num), dtype=object)  # Create a 2D array for the paralog's depth comparison
tempMatrix = numpy.zeros(num)  					 # Create a 1D array for each column

with open('depths.csv') as csvFile:     # reads in one row at a time
    csvReader = csv.reader(csvFile)
    transposed = zip(*csvReader)        # we need to work with columns, now rows, so transpose this

transposed = numpy.asarray(transposed)  # convert data to array, 29 rows and "num" columns

for i in range(0,29): 		# loop over paralogous genes
	for j in range(0,num):	# loop over specimens
		for k in range(0,num): # loop over # of specimens
			tempMatrix[k] =  round(float(transposed[i][k]) - float(transposed[i][j]),5)
			if j > k:
				tempMatrix[k] = tempMatrix[k] * -1
				
		bigMatrix[j] = tempMatrix
	numpy.savetxt( headers[i]+".csv", bigMatrix, delimiter="\t")

