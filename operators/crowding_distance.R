###############################################################################
#
# Crowding Distance
#
# Deb et al. (2002)
#
###############################################################################

calculateCrowdingDistance <- function(population, front)
{
  
  ###########################################################################
  # Empty front
  ###########################################################################
  
  if(length(front) == 0)
  {
    
    return(population)
    
  }
  
  ###########################################################################
  # Single individual
  ###########################################################################
  
  if(length(front) == 1)
  {
    
    population[[front]]$crowding <- Inf
    
    return(population)
    
  }
  
  ###########################################################################
  # Two individuals
  ###########################################################################
  
  if(length(front) == 2)
  {
    
    population[[front[1]]]$crowding <- Inf
    population[[front[2]]]$crowding <- Inf
    
    return(population)
    
  }
  
  ###########################################################################
  # Initialize
  ###########################################################################
  
  for(i in front)
  {
    
    population[[i]]$crowding <- 0
    
  }
  
  numberObjectives <-
    
    length(
      population[[ front[1] ]]$objectives
    )
  
  ###########################################################################
  # Each objective
  ###########################################################################
  
  for(m in 1:numberObjectives)
  {
    
    #######################################################################
    # Sort by objective
    #######################################################################
    
    values <-
      
      sapply(
        
        front,
        
        function(i)
          population[[i]]$objectives[m]
        
      )
    
    orderIndex <-
      
      order(values)
    
    sortedFront <-
      
      front[orderIndex]
    
    sortedValues <-
      
      values[orderIndex]
    
    #######################################################################
    # Boundary solutions
    #######################################################################
    
    population[[ sortedFront[1] ]]$crowding <- Inf
    
    population[[ sortedFront[length(sortedFront)] ]]$crowding <- Inf
    
    minValue <- min(sortedValues)
    
    maxValue <- max(sortedValues)
    
    if(maxValue == minValue)
      next
    
    #######################################################################
    # Internal solutions
    #######################################################################
    
    for(k in 2:(length(sortedFront)-1))
    {
      
      previous <-
        
        sortedValues[k-1]
      
      nextValue <-
        
        sortedValues[k+1]
      
      distance <-
        
        (nextValue - previous) /
        
        (maxValue - minValue)
      
      if(!is.infinite(population[[ sortedFront[k] ]]$crowding))
      {
        
        population[[ sortedFront[k] ]]$crowding <-
          
          population[[ sortedFront[k] ]]$crowding +
          
          distance
        
      }
      
    }
    
  }
  
  return(population)
  
}