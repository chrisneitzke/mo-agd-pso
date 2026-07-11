###############################################################################
#
# MO-AGD-PSO
#
# Multiobjective Adaptive Genetic Diversity Particle Swarm Optimization
#
###############################################################################

###############################################################################
# MO-AGD-PSO
###############################################################################

runMOAGDPSO <- function(problem,
                        populationSize = 100,
                        generations = 250,
                        crossoverProbability = 0.90,
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
  # Initial Ranking
  ###########################################################################
  
  result <-
    
    fastNonDominatedSort(
      population
    )
  
  population <- result$population
  
  fronts <- result$fronts
  
  ###########################################################################
  # Crowding Distance
  ###########################################################################
  
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
    
    #########################################################################
    # Population Diversity
    #########################################################################
    
    diversity <-
      
      populationDiversity(
        population
      )
    
    #########################################################################
    # Adaptive Mutation
    #########################################################################
    
    mutationProbability <-
      
      adaptiveMutationRate(
        diversity
      )
    
    #########################################################################
    # Leader
    #########################################################################
    
    leader <-
      
      population[[
        
        sample(
          
          fronts[[1]],
          
          1
          
        )
        
      ]]
    
    #########################################################################
    # Generate Offspring
    #########################################################################
    
    offspring <- list()
    
    while(length(offspring) < populationSize)
    {
      
      #######################################################################
      # Parent Selection
      #######################################################################
      
      parent1 <-
        
        binaryTournamentSelection(
          population
        )
      
      parent2 <-
        
        binaryTournamentSelection(
          population
        )
      
      #######################################################################
      # SBX
      #######################################################################
      
      children <-
        
        sbxCrossover(
          
          parent1$position,
          
          parent2$position,
          
          problem$lowerBounds,
          
          problem$upperBounds,
          
          eta = etaC,
          
          probability = crossoverProbability
          
        )
      
      #######################################################################
      # PSO Update - Child 1
      #######################################################################
      
      update1 <-
        
        psoUpdate(
          
          position = children$child1,
          
          velocity = parent1$velocity,
          
          pBestPosition = parent1$pBestPosition,
          
          leaderPosition = leader$position,
          
          lowerBounds = problem$lowerBounds,
          
          upperBounds = problem$upperBounds
          
        )
      
      #######################################################################
      # PSO Update - Child 2
      #######################################################################
      
      update2 <-
        
        psoUpdate(
          
          position = children$child2,
          
          velocity = parent2$velocity,
          
          pBestPosition = parent2$pBestPosition,
          
          leaderPosition = leader$position,
          
          lowerBounds = problem$lowerBounds,
          
          upperBounds = problem$upperBounds
          
        )
      
      #######################################################################
      # Adaptive Polynomial Mutation
      #######################################################################
      
      child1 <-
        
        polynomialMutation(
          
          update1$position,
          
          problem$lowerBounds,
          
          problem$upperBounds,
          
          eta = etaM,
          
          probability = mutationProbability
          
        )
      
      child2 <-
        
        polynomialMutation(
          
          update2$position,
          
          problem$lowerBounds,
          
          problem$upperBounds,
          
          eta = etaM,
          
          probability = mutationProbability
          
        )
      
      #######################################################################
      # Evaluation
      #######################################################################
      
      objectives1 <-
        
        problem$evaluate(
          child1
        )
      
      objectives2 <-
        
        problem$evaluate(
          child2
        )
      
      #######################################################################
      # Create Individual 1
      #######################################################################
      
      ind1 <- list(
        
        position = child1,
        
        objectives = objectives1,
        
        rank = NA,
        
        crowding = 0,
        
        velocity = update1$velocity,
        
        pBestPosition = child1,
        
        pBestObjectives = objectives1,
        
        mutationRate = mutationProbability,
        
        diversity = diversity
        
      )
      
      #######################################################################
      # Create Individual 2
      #######################################################################
      
      ind2 <- list(
        
        position = child2,
        
        objectives = objectives2,
        
        rank = NA,
        
        crowding = 0,
        
        velocity = update2$velocity,
        
        pBestPosition = child2,
        
        pBestObjectives = objectives2,
        
        mutationRate = mutationProbability,
        
        diversity = diversity
        
      )
      
      #######################################################################
      # Insert Offspring
      #######################################################################
      
      offspring[[length(offspring)+1]] <- ind1
      
      if(length(offspring) < populationSize)
      {
        
        offspring[[length(offspring)+1]] <- ind2
        
      }
      
    }
    
    #######################################################################
    # Combine Population
    #######################################################################
    
    combined <-
      
      c(
        
        population,
        
        offspring
        
      )
    
    #######################################################################
    # Fast Non-Dominated Sorting
    #######################################################################
    
    result <-
      
      fastNonDominatedSort(
        
        combined
        
      )
    
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
    
    #######################################################################
    # Ranking of New Population
    #######################################################################
    
    result <-
      
      fastNonDominatedSort(
        
        population
        
      )
    
    population <- result$population
    
    fronts <- result$fronts
    
    #######################################################################
    # Crowding Distance
    #######################################################################
    
    for(front in fronts)
    {
      
      population <-
        
        calculateCrowdingDistance(
          
          population,
          
          front
          
        )
      
    }
    
    #######################################################################
    # Update Personal Bests
    #######################################################################
    
    for(i in seq_along(population))
    {
      
      current <- population[[i]]
      
      #####################################################################
      # First Generation
      #####################################################################
      
      if(is.null(current$pBestObjectives))
      {
        
        current$pBestPosition <- current$position
        
        current$pBestObjectives <- current$objectives
        
      }
      else
      {
        
        ###############################################################
        # Dominance Comparison
        ###############################################################
        
        if(
          
          dominates(
            
            current$objectives,
            
            current$pBestObjectives
            
          )
          
        )
        {
          
          current$pBestPosition <-
            
            current$position
          
          current$pBestObjectives <-
            
            current$objectives
          
        }
        
      }
      
      population[[i]] <- current
      
    }
    
  }
  
  ###########################################################################
  # Final Ranking
  ###########################################################################
  
  result <-
    
    fastNonDominatedSort(
      
      population
      
    )
  
  population <- result$population
  
  fronts <- result$fronts
  
  ###########################################################################
  # Final Crowding Distance
  ###########################################################################
  
  for(front in fronts)
  {
    
    population <-
      
      calculateCrowdingDistance(
        
        population,
        
        front
        
      )
    
  }
  
  ###########################################################################
  # Return
  ###########################################################################
  
  return(
    
    list(
      
      population = population,
      
      fronts = fronts,
      
      pareto = population[ fronts[[1]] ]
      
    )
    
  )
  
}