#!/usr/bin/awk -f

# run with this command:  awk -f createComparison.awk pkTable.txt usoTable.txt

# Started from: awk 'NR==FNR {h[$2] = $3; next} {print $1,$2,$3,h[$2]}' file2 file1

{
	# Only true when in the first file 
	if (NR==FNR) {   
	a[$1,$2] = $3;
	b[$1,$2] = $4;
	c[$1,$2] = $6;
	}
	
	# add filler so columns stay aligned
	if (a[$1,$2] == "") a[$1,$2] = "-";
	if (b[$1,$2] == "") b[$1,$2] = "-";
	if (c[$1,$2] == "") c[$1,$2] = "----";
	
	# In second file
	if (NR>FNR) {
	d[$1,$2] = $3;
	e[$1,$2] = $4;
	f[$1,$2] = $6;
	}
	
	if (NR>FNR) print $1,$2,a[$1,$2],b[$1,$2],c[$1,$2],d[$1,$2],e[$1,$2],f[$1,$2] 
}
