###############################################################
#
# Benchmark ZDT3
#
###############################################################

createZDT3Benchmark <- function()
{
  
  benchmark <- list()
  
  benchmark$name <- "ZDT3"
  
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
        sqrt(f1 / g) -
        (f1 / g) *
        sin(
          10 *
            pi *
            f1
        )
      
      f2 <-
        g * h
      
      c(
        f1,
        f2
      )
      
    }
  
  benchmark$paretoFront <-
    function(n = 1000)
    {
      
      intervals <- list(
        
        c(0.0000000000, 0.0830015349),
        
        c(0.1822287280, 0.2577623634),
        
        c(0.4093136748, 0.4538821041),
        
        c(0.6183967944, 0.6525117038),
        
        c(0.8233317983, 0.8518328654)
        
      )
      
      pf <- data.frame()
      
      pointsPerInterval <-
        
        ceiling(
          n /
            length(intervals)
        )
      
      for(interval in intervals)
      {
        
        f1 <-
          
          seq(
            
            interval[1],
            
            interval[2],
            
            length.out = pointsPerInterval
            
          )
        
        f2 <-
          
          1 -
          
          sqrt(f1) -
          
          f1 *
          
          sin(
            
            10 *
              
              pi *
              
              f1
            
          )
        
        pf <-
          
          rbind(
            
            pf,
            
            data.frame(
              
              f1 = f1,
              
              f2 = f2
              
            )
            
          )
        
      }
      
      return(
        
        pf
        
      )
      
    }
    return(
      benchmark
    )
  
}