###############################################################################
#
# Test Crowding Distance
#
###############################################################################

rm(list=ls())

source("../operators/crowding_distance.R")

###############################################################################
# Population
###############################################################################

population <- list(
  
  list(objectives=c(0.0,1.0)),
  
  list(objectives=c(0.2,0.8)),
  
  list(objectives=c(0.4,0.6)),
  
  list(objectives=c(0.6,0.4)),
  
  list(objectives=c(0.8,0.2)),
  
  list(objectives=c(1.0,0.0))
  
)

front <- 1:6

###############################################################################
# Execute
###############################################################################

population <-
  
  calculateCrowdingDistance(
    
    population,
    
    front
    
  )

###############################################################################
# Results
###############################################################################

cat("\n")

cat("=========================================\n")

cat("CROWDING DISTANCE\n")

cat("=========================================\n\n")

for(i in front)
{
  
  cat(
    
    "Individual",
    
    i,
    
    "\n"
    
  )
  
  cat(
    
    "Objectives :",
    
    population[[i]]$objectives,
    
    "\n"
    
  )
  
  cat(
    
    "Crowding  :",
    
    population[[i]]$crowding,
    
    "\n\n"
    
  )
  
}

cat("=========================================\n")

plot(
  
  sapply(population,function(x)x$objectives[1]),
  
  sapply(population,function(x)x$objectives[2]),
  
  pch=19,
  
  cex=1.5,
  
  xlab="f1",
  
  ylab="f2",
  
  main="Crowding Distance Test"
  
)

text(
  
  sapply(population,function(x)x$objectives[1]),
  
  sapply(population,function(x)x$objectives[2]),
  
  labels=round(
    
    sapply(population,function(x)x$crowding),
    
    2
    
  ),
  
  pos=3
  
)