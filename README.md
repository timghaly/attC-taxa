
# attC-taxa.sh

The script 'attC-taxa.sh' predicts the taxonomic origins of integron gene cassette recombination sites (*attC*s).

The gene cassettes of sedentary chromosomal integrons (SCIs), generally possess highly similar *attC* sites, and this conservation spans the SCIs of different bacteria within the same taxon. In our recent [paper](https://www.nature.com/articles/s42003-021-02489-0), we modelled the conserved sequence and structure of *attC* sites from the chromosomal integrons of 11 bacterial taxa. These included six Gammaproteobacterial orders (Alteromonadales, Methylococcales, Oceanospirillales, Pseudomonadales, Vibrionales, Xanthomonadales) and an additional five phyla (Acidobacteria, Cyanobacteria, Deltaproteobacteria, Planctomycetes, Spirochaetes).

The attC-taxa.sh pipeline uses covariance models (CMs) built from the *attC*s of each of the 11 taxa. It can be used to determine if any input *attC* sequences (which can be detected using [attC_screening.sh](https://github.com/timghaly/integron-filtering), [IntegronFinder](https://github.com/gem-pasteur/Integron_Finder), or [MIG-Finder](https://github.com/maribuon/migfinder)) have likley originated from the SCIs of one of these taxa. 

**N.B.** Input sequences must represent a single *attC* sequence and should not represent full length integrons, contigs, or genomes. 

**N.B.** Each taxon-specific model exhibits different sensitivities in detecting true positives and thus the relative proportion of different taxa cannot be compared within the same sample. However, the relative proportion of the same taxon can be compared between different samples.

## attC-taxa.sh usage:


**usage:** ./attC-taxa.sh


**Mandatory arguments:**

-d : path to directory containing all 11 CMs ('attC-taxon-CMs')

-i : input fasta of attC sequences (each sequence must represent a single *attC* sequence)


**Optional arguments:**

-t : number of CPUs | default: 1 

-o : output directory | default: current directory


**Dependencies:**

[INFERNAL](http://eddylab.org/infernal/) version 1


## Citations:

If you use attC-taxa.sh, please cite the following, which describe the *attC* models and the attC-taxa.sh pipeline, respectively:

Ghaly, T.M., Tetu, S.G. and Gillings, M.R. 2021. Predicting the taxonomic and environmental sources of integron gene cassettes using structural and sequence homology of *attC* sites. *Communications Biology*, **4**(1):946. [https://doi.org/10.1038/s42003-021-02489-0](https://doi.org/10.1038/s42003-021-02489-0).

Ghaly, T.M., Penesyan, A., Pritchard, A., Qi, Q., Rajabal, V., Tetu, S.G. and Gillings, M.R. 2021. Methods for the targeted sequencing and analysis of integrons and their gene cassettes from complex microbial communities. *Microbial Genomics*, **8**(3): 000788. doi: [10.1099/mgen.0.000788](https://doi-org.simsrad.net.ocs.mq.edu.au/10.1099/mgen.0.000788).

Please also cite INFERNAL:

Nawrocki, E.P. and Eddy, S.R. 2013. Infernal 1.1: 100-fold faster RNA homology searches. *Bioinformatics*, 29(22):2933-2935.
