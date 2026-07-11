###############################################################################
#
# NSGA-II
#
# Deb et al. (2002)
#
###############################################################################



###############################################################################
# NSGA-II
###############################################################################

runNSGA2 <- function(problem,
                     populationSize = 100,
                     generations = 250,
                     crossoverProbability = 0.9,
                     mutationProbability = NULL,
                     etaC = 20,
                     etaM = 20)
{
  
  ###########################################################################
  # Initial Population
  ###########################################################################
  
  population <-
    
    createPopulation(
      problem,
      populationSize
    )
  
  ###########################################################################
  # Ranking
  ###########################################################################
  
  result <-
    
    fastNonDominatedSort(population)
  
  population <- result$population
  fronts <- result$fronts
  
  for(front in fronts)
  {
    
    population <-
      
      calculateCrowdingDistance(
        population,
        front
      )
    
  }
  
  ###########################################################################
  # Evolution
  ###########################################################################
  
  for(gen in seq_len(generations))
  {
    
    offspring <- list()
    
    #######################################################################
    # Generate offspring
    #######################################################################
    
    while(length(offspring) < populationSize)
    {
      
      ###############################################################
      # Tournament
      ###############################################################
      
      parent1 <-
        
        binaryTournamentSelection(population)
      
      parent2 <-
        
        binaryTournamentSelection(population)
      
      ###############################################################
      # SBX
      ###############################################################
      
      children <-
        
        sbxCrossover(
          
          parent1$position,
          
          parent2$position,
          
          problem$lowerBounds,
          
          problem$upperBounds,
          
          eta = etaC,
          
          probability = crossoverProbability
          
        )
      
      ###############################################################
      # Mutation
      ###############################################################
      
      child1 <-
        
        polynomialMutation(
          
          children$child1,
          
          problem$lowerBounds,
          
          problem$upperBounds,
          
          eta = etaM,
          
          probability = mutationProbability
          
        )
      
      child2 <-
        
        polynomialMutation(
          
          children$child2,
          
          problem$lowerBounds,
          
          problem$upperBounds,
          
          eta = etaM,
          
          probability = mutationProbability
          
        )
      
      ###############################################################
      # Evaluate
      ###############################################################
      
      ind1 <- list(
        
        position = child1,
        
        objectives = problem$evaluate(child1),
        
        rank = NA,
        
        crowding = 0,
        
        velocity = NULL,
        
        mutationRate = NULL,
        
        diversity = NULL
        
      )
      
      ind2 <- list(
        
        position = child2,
        
        objectives = problem$evaluate(child2),
        
        rank = NA,
        
        crowding = 0,
        
        velocity = NULL,
        
        mutationRate = NULL,
        
        diversity = NULL
        
      )
      
      offspring[[length(offspring)+1]] <- ind1
      
      if(length(offspring) < populationSize)
      {
        
        offspring[[length(offspring)+1]] <- ind2
        
      }
      
    }
    
    #######################################################################
    # Combine
    #######################################################################
    
    combined <-
      
      c(
        
        population,
        
        offspring
        
      )
    
    #######################################################################
    # Rank
    #######################################################################
    
    result <-
      
      fastNonDominatedSort(combined)
    
    combined <- result$population
    
    fronts <- result$fronts
    
    #######################################################################
    # Environmental Selection
    #######################################################################
    
    population <-
      
      environmentalSelection(
        
        combined,
        
        fronts,
        
        populationSize
        
      )
    
  }
  
  ###########################################################################
  # Final ranking
  ###########################################################################
  
  result <-
    
    fastNonDominatedSort(population)
  
  population <- result$population
  
  fronts <- result$fronts
  
  for(front in fronts)
  {
    
    population <-
      
      calculateCrowdingDistance(
        
        population,
        
        front
        
      )
    
  }
  
  return(
    
    list(
      
      population = population,
      
      fronts = fronts,
      
      pareto = population[ fronts[[1]] ]
      
    )
    
  )
  
}