library(SINCERA)
library(cluster)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <<- paste(pfix, "/", sep="")
  }
}

run <- function() {}

output <- function(outputfile) {
	## first iteration

#print(ipf.gapstats$iter1) # the gap statistics suggested 5 clusters
sc <- readRDS(paste(pfix, parameters["genes", 2], sep="/"))
# use the default HC algorithm to identify 5 clusters
# the clustering results were saved to the "CLUSTER" metadata
# if update.cellgroup is TRUE, the GROUP meta data will also be updated
sc <- cluster.assignment(sc, k=as.integer(parameters["k", 2]))
saveRDS(sc,paste(outputfile, "rds", sep="."))
pdf(paste(outputfile, "pdf", sep="."))
# different display of the dendrogram tree
plotHC(sc, do.radial=TRUE)
}
