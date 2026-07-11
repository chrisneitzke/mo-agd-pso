###############################################################################
#
# Test SBX
#
###############################################################################

rm(list = ls())

graphics.off()

source("../operators/sbx_crossover.R")

parent1 <- c(0.20,0.40,0.60,0.80)

parent2 <- c(0.80,0.60,0.40,0.20)

lower <- rep(0,4)
upper <- rep(1,4)

set.seed(123)

offspring <-
  
  sbxCrossover(
    
    parent1,
    
    parent2,
    
    lower,
    
    upper
    
  )

cat("\n")
cat("=========================================\n")
cat("SBX TEST\n")
cat("=========================================\n\n")

cat("Parent 1\n")
print(round(parent1,4))

cat("\nParent 2\n")
print(round(parent2,4))

cat("\nChild 1\n")
print(round(offspring$child1,4))

cat("\nChild 2\n")
print(round(offspring$child2,4))

cat("\n")