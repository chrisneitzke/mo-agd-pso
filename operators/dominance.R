###############################################################################
#
# Dominance Operator
#
# MO_AGD_PSO
#
###############################################################################

#-----------------------------------------------------------------------------
# Returns TRUE if solution A dominates solution B (minimization).
#-----------------------------------------------------------------------------

dominates <- function(objectivesA, objectivesB)
{
  
  betterInAtLeastOne <- FALSE
  
  for(i in seq_along(objectivesA))
  {
    
    # A is worse in one objective
    if(objectivesA[i] > objectivesB[i])
    {
      
      return(FALSE)
      
    }
    
    # A is strictly better
    if(objectivesA[i] < objectivesB[i])
    {
      
      betterInAtLeastOne <- TRUE
      
    }
    
  }
  
  return(betterInAtLeastOne)
  
}