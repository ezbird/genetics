#! /usr/bin/env firstscript

# Script which runs a Partial Mantel test
# between two dissimilarity matrices

# PARAMETERS: 1. paralog name (must have .csv by this name in same folder)

# Ezra Huscher
# Kane Lab, University of Colorado Boulder
# last updated December 2017


args = commandArgs(trailingOnly=TRUE)
library(vegan)

headers <- c('15717.csv','16618.csv','16618_mod.csv','16618_mod_EX1.csv','16618_mod_EX2.csv','16618_mod_INT1.csv','3891.csv','1330.csv','19603.csv','74778.csv','50320.csv','3498.csv','395.csv','1774.csv',
             '001774_mod.csv','2936.csv','4341.csv','4650.csv','5134.csv','6591.csv','6705.csv','7396.csv','7887.csv','8242.csv','Comb_THC.csv','Comb_CBD.csv','Comb_CBG.csv','Comb_CBN.csv','Comb_CBC.csv')

tPrime = as.matrix(read.table(paste(args[1],".csv", sep="")))
tablerelat = as.matrix(read.table("relatedness.csv"))

t15717 = as.matrix(read.table(headers[1]))
t16618 = as.matrix(read.table(headers[2]))
t16618_mod = as.matrix(read.table(headers[3]))
t16618_mod_EX1 = as.matrix(read.table(headers[4]))
t16618_mod_EX2 = as.matrix(read.table(headers[5]))
t16618_mod_INT1 = as.matrix(read.table(headers[6]))
t3891 = as.matrix(read.table(headers[7]))
t1330 = as.matrix(read.table(headers[8]))
t19603 = as.matrix(read.table(headers[9]))
t74778 = as.matrix(read.table(headers[10]))
t50320 = as.matrix(read.table(headers[11]))
t3498 = as.matrix(read.table(headers[12]))
t395 = as.matrix(read.table(headers[13]))
t1774 = as.matrix(read.table(headers[14]))
t001774_mod = as.matrix(read.table(headers[15]))
t2936 = as.matrix(read.table(headers[16]))
t4341 = as.matrix(read.table(headers[17]))
t4650 = as.matrix(read.table(headers[18]))
t5134 = as.matrix(read.table(headers[19]))
t6591 = as.matrix(read.table(headers[20]))
t6705 = as.matrix(read.table(headers[21]))
t7396 = as.matrix(read.table(headers[22]))
t7887 = as.matrix(read.table(headers[23]))
t8242 = as.matrix(read.table(headers[24]))
tComb_THC = as.matrix(read.table(headers[25]))
tComb_CBD = as.matrix(read.table(headers[26]))
tComb_CBG = as.matrix(read.table(headers[27]))
tComb_CBN = as.matrix(read.table(headers[28]))
tComb_CBC = as.matrix(read.table(headers[29]))

sink(paste("mantel_",args[1],".txt",sep=""))
mantel.partial(tPrime, t15717, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t16618, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t16618_mod, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t16618_mod_EX1, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t16618_mod_EX2, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t16618_mod_INT1, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t3891, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t1330, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t19603, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t74778, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t50320, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t3498, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t395, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t1774, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t001774_mod, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t2936, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t4341, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t4650, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t5134, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t6591, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t6705, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t7396, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t7887, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, t8242, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, tComb_THC, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, tComb_CBD, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, tComb_CBG, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, tComb_CBN, tablerelat, method = "pearson", permutations = 999)
mantel.partial(tPrime, tComb_CBC, tablerelat, method = "pearson", permutations = 999)
sink()

print("Partial Mantel tests completed.")

