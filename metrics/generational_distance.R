###############################################################################
#
# Generational Distance (GD)
#
# MO_AGD_PSO
#
###############################################################################

###############################################################################
# Euclidean Distance
###############################################################################

euclideanDistance <- function(a, b)
{
  
  sqrt(
    
    sum(
      
      (a - b)^2
      
    )
    
  )
  
}

###############################################################################
# Generational Distance
###############################################################################

generationalDistance <- function(front,
                                 referenceFront)
{
  
  distances <- numeric(nrow(front))
  
  for(i in seq_len(nrow(front)))
  {
    
    d <- apply(
      
      referenceFront,
      
      1,
      
      function(ref)
      {
        
        euclideanDistance(
          
          front[i, ],
          
          ref
          
        )
        
      }
      
    )
    
    distances[i] <- min(d)
    
  }
  
  gd <- sqrt(
    
    mean(
      
      distances^2
      
    )
    
  )
  
  return(gd)
  
}