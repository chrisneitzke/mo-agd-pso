###############################################################################
#
# Test Tournament Selection
#
###############################################################################

rm(list=ls())

source("../operators/selection.R")

###############################################################################
# Population
###############################################################################

population <- list(
  
  list(rank=1,crowding=1.0,id=1),
  
  list(rank=1,crowding=2.5,id=2),
  
  list(rank=2,crowding=5.0,id=3),
  
  list(rank=3,crowding=8.0,id=4)
  
)

###############################################################################
# Execute
###############################################################################

cat("\n")

cat("====================================\n")
cat("TOURNAMENT SELECTION TEST\n")
cat("====================================\n\n")

set.seed(123)

wins <- integer(4)

for(k in 1:1000)
{
  
  winner <- binaryTournamentSelection(population)
  
  wins[winner$id] <- wins[winner$id] + 1
  
}

print(wins)