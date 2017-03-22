#!/usr/bin/awk -f

# run with this command:  awk -v s=5 -v e=25 -f makeContigs.awk sativa_pk_itself_assembly2.mpileup
# PARAMETERS: s = lower confidence boundary, e = upper confidence boundary

# Ezra Huscher
# May, 2014

BEGIN {
	q = 0;
	w = -1;
	theLastConfig = "asdf"
	print "Generating unique contigs and corresponding heterozygous sites..."
}

{
count = 0;	# reset count variable
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
		     thisChar == "C" || thisChar == "T") && other != thisChar) {   # !~ ?
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
if (length(percent) > 4 && hetCount >= 3) { het = "Heterozygous?"; countHeteroContig++; countHeteroTotal++; }  #
else { het = "" }

# Append contig array if this contig is new
thisContig = $1
if (thisContig != theLastConfig) {
	contigArrayHets[w++] = countHeteroContig;
	contigArray[q++] = $1;
	countHeteroContig = 0;
}

theLastConfig = thisContig;  # update the last config we've seen
}

END {
	contigArrayHets[w++] = countHeteroContig;
	k=0
	for (x in contigArray) { k++;
		total = total + contigArrayHets[x]
		print contigArray[x],contigArrayHets[x]
	}
	print "Found",k,"contigs with " total " potential heterozygous sites.";
}
