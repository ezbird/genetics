#!/usr/bin/python
import os

"""
Script for generating coverage table for particular scaffolds of numerous strains
Partners with "coverage_table_make.py" script

run with this command:  awk -v s=5 -v e=25 -f makeTable.awk data.mpileup
PARAMETERS: s = lower confidence boundary, e = upper confidence boundary

Ezra Huscher
Kane Lab, University of Colorado Boulder

last updated July 2016
"""

# ----------------------------------------------
# General Script Parameters
# ----------------------------------------------
showScaffoldName = False  # True/False
endingStringOfStrainFiles = ".sorted.bam_depth"
informationFile = "info_depth_coverage_flock.txt"
strainList = "names_67strains_nospaces_05042016.txt"
#outputFile = "scaffold006591_pacbio_wholescaffold_67individuals.txt"
strainFolder = "depth/"  # folder containing the depth file for each strain
scaffoldsToRun = 7      # this is the number of times we call the "coverage_table_make.py" script
# ----------------------------------------------

# Scaffold 1
name1 = "1330"
startpos1 = 1119
endpos1 = 2754
# ----------------------------------------------
# Scaffold 2
name2 = "19603"
startpos2 = 7696
endpos2 = 9335
# ----------------------------------------------
# Scaffold 3
name3 = "74778"
startpos3 = 8041
endpos3 = 9596
# ----------------------------------------------
# Scaffold 4
name4 = "50320"
startpos4 = 6962
endpos4 = 8771
# ----------------------------------------------
# Scaffold 5
name5 = "3498"
startpos5 = 10088
endpos5 = 11650
# ----------------------------------------------
# Scaffold 6
name6 = "15717"
startpos6 = 211735
endpos6 = 213054
# ----------------------------------------------
# Scaffold 7
name7 = "16618"
startpos7 = 11303
endpos7 = 12613
# ----------------------------------------------
# Scaffold 8
name8 = "006705"
startpos8 = 30197
endpos8 = 31835
# ----------------------------------------------
# Scaffold 9
name9 = "007396"
startpos9 = 10468
endpos9 = 12106
# ----------------------------------------------
# Scaffold 10
name10 = "007887"
startpos10 = 6692
endpos10 = 8326
# ----------------------------------------------
# Scaffold 11
name11 = "008242"
startpos11 = 20123
endpos11 = 21744
# ----------------------------------------------

i=0
while i < scaffoldsToRun:
	i+=1
	os.system("python coverage_table_make.py " + str(eval("name"+str(i))) + " " + str(eval("startpos"+str(i))) + " " + str(eval("endpos"+str(i))))		
