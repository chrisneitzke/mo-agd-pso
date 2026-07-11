###############################################################################
#
# Polynomial Mutation
#
# Deb & Goyal (1996)
#
###############################################################################

polynomialMutation <- function(solution,
                               lowerBounds,
                               upperBounds,
                               eta = 20,
                               probability = NULL)
{
  
  nVar <- length(solution)
  
  if(is.null(probability))
  {
    probability <- 1 / nVar
  }
  
  child <- solution
  
  for(i in seq_len(nVar))
  {
    
    if(runif(1) <= probability)
    {
      
      x  <- child[i]
      xl <- lowerBounds[i]
      xu <- upperBounds[i]
      
      if(xu - xl < 1e-14)
        next
      
      delta1 <- (x - xl) / (xu - xl)
      delta2 <- (xu - x) / (xu - xl)
      
      rand <- runif(1)
      
      mutPow <- 1 / (eta + 1)
      
      if(rand <= 0.5)
      {
        
        xy <- 1 - delta1
        
        val <- 2 * rand +
          (1 - 2 * rand) * xy^(eta + 1)
        
        deltaq <- val^mutPow - 1
        
      }
      else
      {
        
        xy <- 1 - delta2
        
        val <- 2 * (1 - rand) +
          2 * (rand - 0.5) * xy^(eta + 1)
        
        deltaq <- 1 - val^mutPow
        
      }
      
      x <- x + deltaq * (xu - xl)
      
      ###################################################################
      # Respect bounds
      ###################################################################
      
      x <- max(xl, min(xu, x))
      
      child[i] <- x
      
    }
    
  }
  
  return(child)
  
}