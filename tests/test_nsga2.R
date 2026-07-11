###############################################################################
#
# Test NSGA-II
#
###############################################################################

rm(list = ls())

graphics.off()

source("../config.R")

source("../benchmark/zdt1.R")

problem <- createZDT1Benchmark()

set.seed(123)

result <-
  
  runNSGA2(
    
    problem,
    
    populationSize = 100,
    
    generations = 200
    
  )

###############################################################################
# Plot
###############################################################################

pf <- problem$paretoFront()

plot(
  
  pf$f1,
  
  pf$f2,
  
  type="l",
  
  lwd=2,
  
  col="red",
  
  xlab="f1",
  
  ylab="f2",
  
  main="NSGA-II x ZDT1"
  
)

points(
  
  sapply(result$pareto,function(x)x$objectives[1]),
  
  sapply(result$pareto,function(x)x$objectives[2]),
  
  pch=19,
  
  col="blue"
  
)

legend(
  
  "topright",
  
  legend=c(
    
    "Reference",
    
    "NSGA-II"
    
  ),
  
  col=c(
    
    "red",
    
    "blue"
    
  ),
  
  lwd=c(2,NA),
  
  pch=c(NA,19)
  
)