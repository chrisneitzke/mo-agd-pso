###############################################################################
#
# Adaptive Mutation
#
# MO_AGD_PSO
#
###############################################################################

###############################################################################
# Population Diversity
###############################################################################

populationDiversity <- function(population)
{
  
  positions <-
    
    do.call(
      
      rbind,
      
      lapply(
        
        population,
        
        function(ind)
          ind$position
        
      )
      
    )
  
  centroid <-
    
    colMeans(
      
      positions
      
    )
  
  distances <-
    
    apply(
      
      positions,
      
      1,
      
      function(x)
      {
        
        sqrt(
          
          sum(
            
            (x-centroid)^2
            
          )
          
        )
        
      }
      
    )
  
  diversity <-
    
    mean(
      
      distances
      
    )
  
  return(diversity)
  
}

###############################################################################
# Adaptive Mutation Rate
###############################################################################

adaptiveMutationRate <- function(diversity,
                                 minRate = 0.01,
                                 maxRate = 0.20,
                                 reference = 0.50)
{
  
  normalized <-
    
    min(
      
      diversity/reference,
      
      1
      
    )
  
  rate <-
    
    maxRate -
    
    normalized *
    
    (maxRate-minRate)
  
  rate <-
    
    max(
      
      minRate,
      
      min(
        
        maxRate,
        
        rate
        
      )
      
    )
  
  return(rate)
  
}