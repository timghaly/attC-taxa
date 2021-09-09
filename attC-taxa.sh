#!/bin/bash

usage() { printf "\nusage: ./attC-taxa.sh -d -i [optional arguments]\n\nMandatory arguments:\n-d : path to directory containing all 11 CMs \n-i : input fasta of attC sequences\n\nOptional arguments:\n-t : number of CPUs | default: 1 \n-o : output directory | default: current directory\n\nDependencies:\nINFERNAL version 1\n\n"; exit 0;}
[ $# -eq 0 ] && usage

while getopts d:i:t:o: flag
do
case "${flag}"
in
d) CMDIR=${OPTARG};;
i) INPUT=${OPTARG};;
t) THREADS=${OPTARG};;
o) OUTPUT=${OPTARG};;
*) usage exit 0;;
esac
done


if [ -z "$THREADS" ]
then
THREADS="1"
fi

if [ -z "$OUTPUT" ]
then
OUTPUT="."
fi

if [ -z "$CMDIR" ]
then
printf "\nMissing: -d <path to CM directory>\n" >&2
usage
exit 0
fi

if [ -z "$INPUT" ]
then
printf "\nMissing: -i <input.fasta>\n" >&2
usage
exit 0
fi

printf "\nattC-taxa.sh determines if any input attC has a sequence and folding structure that is conserved among one of several bacterial taxa\n\nPlease be aware that each taxon-specific model exhibits different sensitivities in detecting true positives and thus the relative proportion of different taxa cannot be compared within the same sample\n\nHowever, the relative proportion of the same taxon can be compared between different samples\n\nRunning cmsearch...\n\n"

# Extract sample name from contig file
name=$(basename "$INPUT" | rev | cut -d'.' -f2- | rev);

cmsearch --cpu $THREADS --notrunc --max -T 62 --tblout $OUTPUT/$name.Temp.1.tab $CMDIR/Alteromonadales.cm $INPUT > /dev/null;
cmsearch --cpu $THREADS --notrunc --max -T 63 --tblout $OUTPUT/$name.Temp.2.tab $CMDIR/Methylococcales.cm $INPUT > /dev/null;
cmsearch --cpu $THREADS --notrunc --max -T 79 --tblout $OUTPUT/$name.Temp.3.tab $CMDIR/Oceanospirillales.cm $INPUT > /dev/null;
cmsearch --cpu $THREADS --notrunc --max -T 60 --tblout $OUTPUT/$name.Temp.4.tab $CMDIR/Pseudomonadales.cm $INPUT > /dev/null;
cmsearch --cpu $THREADS --notrunc --max -T 45 --tblout $OUTPUT/$name.Temp.5.tab $CMDIR/Vibrionales.cm $INPUT > /dev/null;
cmsearch --cpu $THREADS --notrunc --max -T 73 --tblout $OUTPUT/$name.Temp.6.tab $CMDIR/Xanthomonadales.cm $INPUT > /dev/null;
cmsearch --cpu $THREADS --notrunc --max -T 64 --tblout $OUTPUT/$name.Temp.7.tab $CMDIR/Acidobacteria.cm $INPUT > /dev/null;
cmsearch --cpu $THREADS --notrunc --max -T 61 --tblout $OUTPUT/$name.Temp.8.tab $CMDIR/Cyanobacteria.cm $INPUT > /dev/null;
cmsearch --cpu $THREADS --notrunc --max -T 64 --tblout $OUTPUT/$name.Temp.9.tab $CMDIR/Deltaproteobacteria.cm $INPUT > /dev/null;
cmsearch --cpu $THREADS --notrunc --max -T 60 --tblout $OUTPUT/$name.Temp.10.tab $CMDIR/Planctomycetes.cm $INPUT > /dev/null;
cmsearch --cpu $THREADS --notrunc --max -T 43 --tblout $OUTPUT/$name.Temp.11.tab $CMDIR/Spirochaetes.cm $INPUT > /dev/null;

for i in $OUTPUT/$name.Temp.*.tab; do gawk -i inplace '{a[$1]++}!(a[$1]-1)' $i; done

awk 'NR==FNR { a[$1]++ } NR!=FNR && a[$1]==1' <(cat $OUTPUT/$name.Temp.*.tab) <(cat $OUTPUT/$name.Temp.*.tab) | sed '/^#/ d' | awk '{print $1"\t"$3"\t"$15}' > $OUTPUT/$name.attC_taxa.out; rm $OUTPUT/$name.Temp.*.tab

printf "Finished\n\nOutput saved as $OUTPUT/$name.attC_taxa.out\n\n"

