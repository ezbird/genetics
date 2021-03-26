# -------------------------------------
# Ezra Huscher, March 2021
# feed in filtered VCF (.vcf) file,
# convert it to a onemap input file
# reference: https://cristianetaniguti.github.io/htmls/Inbred_Based_Populations.html

# USAGE: bash makeOnemapInput.sh final_vcf.vcf
# ------------------------------------
orig_vcf=$1

# Create a separate header file with these 3 lines at the top:
echo "data type f2 backcross" > onemap_header.txt
echo "102 16552 0 0 0" >> onemap_header.txt
echo "ID1 ID2 ID3 ID4 ID5 ID6 ID7 ID8 ID9 ID10 ID11 ID12 ID13 ID14 ID15 ID16 ID17 ID18 ID19 ID20 ID21 ID22 ID23 ID24 ID25 ID26 ID27 ID28 ID29 ID30 ID31 ID32 ID33 ID34 ID35 ID36 ID37 ID38 ID39 ID40 ID41 ID42 ID43 ID44 ID45 ID46 ID47 ID48 ID49 ID50 ID51 ID52 ID53 ID54 ID55 ID56 ID57 ID58 ID59 ID60 ID61 ID62 ID63 ID64 ID65 ID66 ID67 ID68 ID69 ID70 ID71 ID72 ID73 ID74 ID75 ID76 ID77 ID78 ID79 ID80 ID81 ID82 ID83 ID84 ID85 ID86 ID87 ID88 ID89 ID90 ID91 ID92 ID93 ID94 ID95 ID96 ID97 ID98 ID99 ID100 ID101 ID102" >> onemap_header.txt

# Add chromosome information from VCF file. What to do with all fragments (ctgX, etc)? Currently labeling as "11"
# grep -v "#" FinalFinalFinalGenotypedGATK_SC_SNV_FD_HighDepth.g.vcf | cut -f 1 | sed 's/ctg..../11/g' | sed 's/ctg.../11/g' | sed 's/ctg../11/g' | datamash transpose | sed 's/\t/ /g' | less -S

# Remove header from VCF
grep -v "#" $orig_vcf > temp1.txt

# Remove all columns from the VCF except the genotype data (keep the 0/1, 1/1 etc.)
cut -f10- temp1.txt > temp2.txt

# Add first column which onemap requires, i.e. *M1, *M2, etc
# and add 2nd column which specifies the marker for a backcross (A.H)
awk '{print "*M"NR,"A.H",$0}' temp2.txt > temp3.txt

# Sometimes there are vertical pipes "|". replace these with "/"s.
sed -i 's/|/\//g' temp3.txt

# Remove all the various symbols, i.e. 1/1:0,3:3:9:118,9,0 into 1/1 
sed -i -E 's/(\S{3})\S*:\S*/\1/g' temp3.txt

# Replace 0/0 with a
sed -i 's/0\/0/a/g' temp3.txt

# Replace 0/1 with ab
sed -i 's/0\/1/ab/g' temp3.txt

# Replace 1/0 with ab
sed -i 's/1\/0/ab/g' temp3.txt

# Replace 0/0 with b
sed -i 's/1\/1/b/g' temp3.txt

# Replace ./. with -
sed -i 's/\.\/\./-/g' temp3.txt

# Combine header and marker information into one file
cat onemap_header.txt temp3.txt > final.raw

# Replace any tabs with spaces
sed 's/\t/ /g' final.raw > onemap_input.raw

# Remove intermediate files
rm onemap_header.txt | rm final.raw | rm temp1.txt | rm temp2.txt | rm temp3.txt

echo 'Complete.'

