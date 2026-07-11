###############################################################
#
# Benchmark ZDT2
#
###############################################################

createZDT2Benchmark <- function()
{
  
  benchmark <- list()
  
  benchmark$name <- "ZDT2"
  
  benchmark$numberOfVariables <- 30
  
  benchmark$numberOfObjectives <- 2
  
  benchmark$lowerBounds <-
    rep(
      0,
      benchmark$numberOfVariables
    )
  
  benchmark$upperBounds <-
    rep(
      1,
      benchmark$numberOfVariables
    )
  
  benchmark$evaluate <-
    function(x)
    {
      
      f1 <- x[1]
      
      g <-
        1 +
        9 *
        sum(
          x[2:30]
        ) /
        29
      
      h <-
        1 -
        (f1 / g)^2
      
      f2 <-
        g * h
      
      c(
        f1,
        f2
      )
      
    }
  
  benchmark$paretoFront <-
    function(n = 500)
    {
      
      f1 <-
        seq(
          0,
          1,
          length.out = n
        )
      
      f2 <-
        1 -
        f1^2
      
      data.frame(
        
        f1 = f1,
        
        f2 = f2
        
      )
      
    }
  
  return(
    benchmark
  )
  
}