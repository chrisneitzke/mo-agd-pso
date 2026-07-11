###############################################################################
#
# Environmental Selection Test
#
###############################################################################

rm(list = ls())

source("../operators/crowding_distance.R")
source("../operators/environmental_selection.R")

###############################################################################
# Population
###############################################################################

population <- list(
  
  list(rank=1,crowding=0,objectives=c(1,5),id=1),
  
  list(rank=1,crowding=0,objectives=c(2,4),id=2),
  
  list(rank=1,crowding=0,objectives=c(3,3),id=3),
  
  list(rank=2,crowding=0,objectives=c(3,5),id=4),
  
  list(rank=2,crowding=0,objectives=c(4,4),id=5),
  
  list(rank=3,crowding=0,objectives=c(5,5),id=6)
  
)

fronts <- list(
  
  c(1,2,3),
  
  c(4,5),
  
  c(6)
  
)

###############################################################################
# Execute
###############################################################################

newPopulation <-
  
  environmentalSelection(
    
    population,
    
    fronts,
    
    populationSize = 4
    
  )

###############################################################################
# Print
###############################################################################

cat("\n")
cat("=========================================\n")
cat("ENVIRONMENTAL SELECTION TEST\n")
cat("=========================================\n\n")

for(ind in newPopulation)
{
  
  cat(
    
    "ID:",
    
    ind$id,
    
    " Rank:",
    
    ind$rank,
    
    " Crowding:",
    
    ind$crowding,
    
    "\n"
    
  )
  
}