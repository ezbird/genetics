# Ezra Huscher, December 2020
# feed in initial VCF (.vcf) file,
# convert it to a onemap input file

orig_vcf=$1

# Add these 2 lines to the top:
#data type f2 backcross 
#102 16552 0 0 0
#ID1 ID2 ID3 ID4 ID5 ID6 ID7 ID8 ID9 ID10 ID11 ID12 ID13 ID14 ID15 ID16 ID17 ID18 ID19 ID20 ID21 ID22 ID23 ID24 ID25 ID26 ID27 ID28 ID29 ID30 ID31 ID32 ID33 ID34 ID35 ID36 ID37 ID38 ID39 ID40 ID41 ID42 ID43 ID44 ID45 ID46 ID47 ID48 ID49 ID50 ID51 ID52 ID53 ID54 ID55 ID56 ID57 ID58 ID59 ID60 ID61 ID62 ID63 ID64 ID65 ID66 ID67 ID68 ID69 ID70 ID71 ID72 ID73 ID74 ID75 ID76 ID77 ID78 ID79 ID80 ID81 ID82 ID83 ID84 ID85 ID86 ID87 ID88 ID89 ID90 ID91 ID92 ID93 ID94 ID95 ID96 ID97 ID98 ID99 ID100 ID101 ID102

# Filter by quality and depth, if necessary
#grep -v "#" $orig_vcf         #|  awk '$6 > 800 && $4 != "N" && $5 !~ ","' > temp.vcf

# Remove header from VCF
grep -v "#" $orig_vcf > temp1.txt

# Remove all columns from the VCF except the genotype data (keep the 0/1, 1/1 etc.)
cut -f10- temp1.txt > temp2.txt

# Add first column which onemap requires, i.e. *M1, *M2, etc
#awk '{print "*M"NR,$0}' temp2.txt > temp3.txt
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
sed -i 's/1\/1/a/g' temp3.txt

# Replace ./. with -
sed -i 's/\.\/\./-/g' temp3.txt

cat onemap_header.txt temp3.txt > final.raw

# Insert required header for onemap input file, # of individuals, # of positions, chromosome information (0 if none), physical position information, phenotypic data
#sed -i '1 i\102 16552 0 0 0' temp3.txt
#sed -i '1 i\data type f2 backcross' temp3.txt

# Replace any tabs with spaces
sed 's/\t/ /g' temp3.txt > onemap_input.raw

#sed 's/[01]\/[01]:0,0,0:*/-9\t-9\t/g' > temp2.txt
#sed 's/:[0-9]*,[0-9]*,[0-9]*:[0-9]*:[0-9]*//g' | 
#sed 's/:[0-9]*,[0-9]*,[0-9]*//g' |    replace :#*,#*,# with blank
#sed 's/0\/0/0\t0/g' |      replace 0/0 with 0	0
#sed 's/0\/1/0\t1/g' |      replace 0/1 with 0	1
#sed 's/1\/1/1\t1/g' |      replace 1/1 with 1	1
#sed 's/\.\/\./-9\t-9\t/g'  replace ./. with -9	-9

#| sed 's/|/\//g' | sed -E 's/(\S{3})\S*:\S*/\1/g' | sed 's/0\/0/0\t0/g' | sed 's/0\/1/0\t1/g' | sed 's/1\/1/1\t1/g' | sed 's/\.\/\./-9\t-9\t/g' > temp2.txt


#grep -v DP=[0-9][0-9]\; temp.vcf | cut -f1,2,10- | sed 's/[01]\/[01]:0,0,0:*/-9\t-9\t/g' | sed 's/:[0-9]*,[0-9]*,[0-9]*:[0-9]*:[0-9]*//g' | sed 's/:[0-9]*,[0-9]*,[0-9]*//g' | sed 's/0\/0/0\t0/g' | sed 's/0\/1/0\t1/g' | sed 's/1\/1/1\t1/g' | sed 's/\.\/\./-9\t-9\t/g' > temp2.txt

echo 'Complete.'

