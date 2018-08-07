qsub -I -l ncpus=1,mem=1gb,cput=5:0:0 -l walltime=5:0:0 /bin/bash
module load intel intelmpi R
R

validation.dir <- "progs/pimass/pimass/output/validation"

######################################################################################

chr = 19

mcmc_gold <- read.table(paste0(validation.dir,"/c",chr,".mcmc.txt"),header = T)
gold = mean(mcmc_gold$postc)
end = 1000
# single pvalue calculation, less than 100 (by hand)

k = 0
for (i in 1:end){
  
  infile <- paste0(validation.dir,"/chr",chr,"/c",chr,"run",i,".mcmc.txt")
  mcmc <- read.table(infile, head = T, stringsAsFactors = FALSE)
  
  if( mean(mcmc$postc) > gold)
  {
    k = k + 1
    print(i)
  }
  
}

k
