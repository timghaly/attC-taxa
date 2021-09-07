
# attC-taxa.sh

The script 'attC-taxa.sh' predicts the taxonomic origins of integron gene cassette recombiantion sites (*attC*s).

The gene cassettes of sedentary chromosomal integrons (SCIs), generally possess highly similar *attC* sites, and this conservation spans the SCIs of different bacteria within the same taxon. In out recent [paper](https://doi.org/10.1038/s42003-021-02489-0), we modelled the conserved sequence and structure of *attC* sites from the chromosomal integrons of 11 bacterial taxa. These included six Gammaproteobacterial orders (Alteromonadales, Methylococcales, Oceanospirillales, Pseudomonadales, Vibrionales, Xanthomonadales) and an additional five phyla (Acidobacteria, Cyanobacteria, Deltaproteobacteria, Planctomycetes, Spirochaetes).

The attC-taxa.sh pipeline uses covariance models (CMs) built from the *attC*s of each of the 11 taxa. It can be used to determine if any input *attC* sequences (which can be detected using [attC_screening.sh](https://github.com/timghaly/integron-filtering)) have likley originated from the SCIs of one of these taxa. 

**N.B.** Each taxon-specific model exhibits different sensitivities in detecting true positives and thus the relative proportion of different taxa cannot be compared within the same sample. However, the relative proportion of the same taxon can be compared between different samples.

## attC-taxa.sh usage:


**usage:** ./attC_taxa.sh


**Mandatory arguments:**

-d : path to directory containing all 11 CMs ('attC-taxon-CMs')

-i : input fasta of attC sequences


**Optional arguments:**

-t : number of CPUs | default: 1 

-o : output directory | default: current directory


**Dependencies:**

[INFERNAL](http://eddylab.org/infernal/) version 1



