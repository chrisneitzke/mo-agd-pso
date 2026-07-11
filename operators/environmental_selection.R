###############################################################################
#
# Environmental Selection (NSGA-II)
#
# Deb et al. (2002)
#
###############################################################################

source("../operators/crowding_distance.R")

environmentalSelection <- function(population,
                                   fronts,
                                   populationSize)
{
  
  newPopulation <- list()
  
  currentSize <- 0
  
  ###########################################################################
  # Process each front
  ###########################################################################
  
  for(front in fronts)
  {
    
    #######################################################################
    # Calculate Crowding Distance
    #######################################################################
    
    population <-
      
      calculateCrowdingDistance(
        
        population,
        
        front
        
      )
    
    #######################################################################
    # Entire front fits
    #######################################################################
    
    if(currentSize + length(front) <= populationSize)
    {
      
      for(i in front)
      {
        
        newPopulation[[ length(newPopulation)+1 ]] <-
          
          population[[i]]
        
      }
      
      currentSize <- length(newPopulation)
      
    }
    else
    {
      
      ###################################################################
      # Partial front
      ###################################################################
      
      crowding <-
        
        sapply(
          
          front,
          
          function(i)
            population[[i]]$crowding
          
        )
      
      orderIndex <-
        
        order(
          
          crowding,
          
          decreasing = TRUE
          
        )
      
      sortedFront <-
        
        front[orderIndex]
      
      remaining <-
        
        populationSize -
        
        currentSize
      
      for(i in seq_len(remaining))
      {
        
        newPopulation[[ length(newPopulation)+1 ]] <-
          
          population[[ sortedFront[i] ]]
        
      }
      
      break
      
    }
    
  }
  
  return(newPopulation)
  
}