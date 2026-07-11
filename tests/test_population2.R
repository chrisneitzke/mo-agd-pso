###############################################################################
#
# Test Population Initialization
#
###############################################################################

rm(list = ls())

graphics.off()

source("../benchmark/zdt1.R")
source("../operators/initialization.R")

problem <- createZDT1Benchmark()

population <-
  
  createPopulation(
    
    problem,
    
    populationSize = 5
    
  )

cat("\n")
cat("=============================================\n")
cat("POPULATION TEST\n")
cat("=============================================\n\n")

for(i in seq_along(population))
{
  
  cat("Individual", i, "\n")
  
  cat("Position:\n")
  print(round(population[[i]]$position,4))
  
  cat("\nObjectives:\n")
  print(round(population[[i]]$objectives,4))
  
  cat("\nRank:", population[[i]]$rank)
  
  cat("\nCrowding:", population[[i]]$crowding)
  
  cat("\n\n")
  
}