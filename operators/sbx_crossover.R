###############################################################################
#
# Simulated Binary Crossover (SBX)
#
# Deb & Agrawal (1995)
#
###############################################################################

sbxCrossover <- function(parent1,
                         parent2,
                         lowerBounds,
                         upperBounds,
                         eta = 20,
                         probability = 0.9)
{
  
  nVar <- length(parent1)
  
  child1 <- parent1
  child2 <- parent2
  
  ###########################################################################
  # Apply crossover?
  ###########################################################################
  
  if(runif(1) > probability)
  {
    
    return(
      
      list(
        
        child1 = child1,
        
        child2 = child2
        
      )
      
    )
    
  }
  
  ###########################################################################
  # SBX
  ###########################################################################
  
  for(i in seq_len(nVar))
  {
    
    if(runif(1) <= 0.5)
    {
      
      if(abs(parent1[i] - parent2[i]) > 1e-14)
      {
        
        x1 <- min(parent1[i], parent2[i])
        x2 <- max(parent1[i], parent2[i])
        
        lb <- lowerBounds[i]
        ub <- upperBounds[i]
        
        rand <- runif(1)
        
        beta <- 1 + (2 * (x1 - lb) / (x2 - x1))
        alpha <- 2 - beta^(-(eta + 1))
        
        if(rand <= 1 / alpha)
        {
          
          betaq <- (rand * alpha)^(1 / (eta + 1))
          
        }
        else
        {
          
          betaq <- (1 / (2 - rand * alpha))^(1 / (eta + 1))
          
        }
        
        c1 <- 0.5 * ((x1 + x2) - betaq * (x2 - x1))
        
        beta <- 1 + (2 * (ub - x2) / (x2 - x1))
        alpha <- 2 - beta^(-(eta + 1))
        
        if(rand <= 1 / alpha)
        {
          
          betaq <- (rand * alpha)^(1 / (eta + 1))
          
        }
        else
        {
          
          betaq <- (1 / (2 - rand * alpha))^(1 / (eta + 1))
          
        }
        
        c2 <- 0.5 * ((x1 + x2) + betaq * (x2 - x1))
        
        ################################################################
        # Bounds
        ################################################################
        
        c1 <- max(lb, min(ub, c1))
        c2 <- max(lb, min(ub, c2))
        
        if(runif(1) < 0.5)
        {
          
          child1[i] <- c2
          child2[i] <- c1
          
        }
        else
        {
          
          child1[i] <- c1
          child2[i] <- c2
          
        }
        
      }
      
    }
    
  }
  
  return(
    
    list(
      
      child1 = child1,
      
      child2 = child2
      
    )
    
  )
  
}