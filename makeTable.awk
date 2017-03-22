#!/usr/bin/awk -f

# run with this command:  awk -v s=5 -v e=25 -f makeTable.awk data.mpileup
# PARAMETERS: s = lower confidence boundary, e = upper confidence boundary

# Ezra Huscher
# May, 2014

BEGIN {
	count=0
	countHetero = 0
}

{
other = ""
hetCount = 1
possibleHet = ""
for(i=1; i<=length($5); i++) {   # Loop over column of reads and increment when "," or "."
	thisChar = toupper(substr($5,i,1))
	if (thisChar == "." || thisChar == ",") { count++ }
	else {
		if (thisChar == possibleHet) { hetCount++ }
		if (length(other) == 0) { other = $3 }
		if ((thisChar == "A" || thisChar == "G" ||
		     thisChar == "C" || thisChar == "T") && other != thisChar) { 
		     	other = other "," thisChar # add to Query column if it's a nucleotide and not already in the list
		     	possibleHet = thisChar
		     }
	}
}

if (length($5) > 0)	# prevent dividing by 0
	percent = sprintf("%.2f", count/length($5)); # round percentage to two decimal places
else 
	percent = "-"
	
if (possibleHet != "") 
	percent = percent "," (1-percent) # display second nucleotide's frequency % (if any)
	
if (percent == "1.00") # update variable to display in the Query column
	queryCol = $3
else
	queryCol = other

# If an alternate letter appears 3+ times in $5, we set the line as "Heterozygous"
if (length(percent) > 4 && hetCount >= 3) { het = "Heterozygous?"; countHetero++; }
else { het = "" }

$3=$3 FS queryCol;	# add query column after reference column (i.e. A,G or C, etc)
$3 != "N" 		# don't print if the base is not known
$2 = sprintf("%05d", $2)# round Position column to 5 digits for easier viewing
!($5="")  		# delete column 5 (read itself)
!($6="")  		# delete column 6 (confidence)
$(NF+1) = percent   	# add new column for the percentage of correct
$(NF+1) = het   	# add new column for the percentage of correct
if ($4 > s && $4 < e)   # keep coverage above s parameter and below e parameter
{ print }		# print formatted row!

count = 0;		# reset count variable
}

END {
	print "Done! Found " countHetero " potential heterozygous sites."
}
