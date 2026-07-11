###############################################################################
#
# Fast Non-Dominated Sorting
#
# Deb et al. (2002)
#
###############################################################################

fastNonDominatedSort <- function(population)
{
  
  N <- length(population)
  
  ###########################################################################
  # Initialization
  ###########################################################################
  
  S <- vector("list", N)
  
  n <- integer(N)
  
  fronts <- list()
  
  F1 <- integer(0)
  
  ###########################################################################
  # First Front
  ###########################################################################
  
  for(p in seq_len(N))
  {
    
    S[[p]] <- integer(0)
    
    n[p] <- 0
    
    for(q in seq_len(N))
    {
      
      if(p == q)
        next
      
      if(
        dominates(
          population[[p]]$objectives,
          population[[q]]$objectives
        )
      )
      {
        
        S[[p]] <- c(S[[p]], q)
        
      }
      else if(
        dominates(
          population[[q]]$objectives,
          population[[p]]$objectives
        )
      )
      {
        
        n[p] <- n[p] + 1
        
      }
      
    }
    
    if(n[p] == 0)
    {
      
      population[[p]]$rank <- 1
      
      F1 <- c(F1, p)
      
    }
    
  }
  
  fronts[[1]] <- F1
  
  ###########################################################################
  # Remaining Fronts
  ###########################################################################
  
  i <- 1
  
  while(i <= length(fronts))
  {
    
    if(length(fronts[[i]]) == 0)
      break
    
    Q <- integer(0)
    
    for(p in fronts[[i]])
    {
      
      for(q in S[[p]])
      {
        
        n[q] <- n[q] - 1
        
        if(n[q] == 0)
        {
          
          population[[q]]$rank <- i + 1
          
          Q <- c(Q, q)
          
        }
        
      }
      
    }
    
    if(length(Q) > 0)
    {
      
      fronts[[i + 1]] <- unique(Q)
      
    }
    
    i <- i + 1
    
  }
  
  ###########################################################################
  # Return
  ###########################################################################
  
  return(
    
    list(
      
      population = population,
      
      fronts = fronts
      
    )
    
  )
  
}