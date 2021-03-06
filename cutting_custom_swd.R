#Cutting chunks custom based on position
qsub -I -l ncpus=1,mem=1gb,cput=5:0:0 -l walltime=5:0:0 /bin/bash
module load intel intelmpi R
R

borders = matrix(c(34905605,86399092, 83907801,15724023,70379322,90573122,86887657,22638628),  ncol = 2,nrow = 4)
borders = cbind(borders, c(9,14,15,19))
colnames(borders)=c("start","end", "chr")

i=4
chr = as.numeric(borders[i,3])

position.file = read.table(paste0("/storage/nipm/kerimbae/swd/swdrecode/chr",chr,".recode.pos.txt"))
position.file=data.frame(position.file)

chunk.pos <- subset(position.file, (position.file$V2 < borders[i,2]& position.file$V2 >borders[i,1])) 
dim(chunk.pos)[1]
start= as.numeric(row.names(chunk.pos[1,]))
end= as.numeric(row.names(chunk.pos[dim(chunk.pos)[1],]))
length= end-start+1
print(length)

path = paste("/storage/nipm/kerimbae/swd/swdrecode/chr", chr, ".txt",sep ="")
conn <- file(path,open="r")
lines <- readLines(conn)

name <- paste("c", chr, sep ="")
assign(name, lines[start:end])

# write.table(get(name), file = paste("/storage/nipm/kerimbae/validation/chr",chr,".txt",sep =""), sep =",",quote = F, row.names = F, col.names = F)
close(conn)


