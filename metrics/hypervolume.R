###############################################################################
#
# Hypervolume (2 Objectives)
#
# MO_AGD_PSO
#
###############################################################################

hypervolume2D <- function(front,
                          referencePoint = c(1.1,1.1))
{
  
  ###########################################################################
  # Remove dominated duplicates
  ###########################################################################
  
  front <-
    
    unique(front)
  
  ###########################################################################
  # Sort by first objective
  ###########################################################################
  
  front <-
    
    front[order(front[,1]), , drop = FALSE]
  
  ###########################################################################
  # Hypervolume
  ###########################################################################
  
  hv <- 0
  
  previousF2 <- referencePoint[2]
  
  for(i in seq_len(nrow(front)))
  {
    
    width <-
      
      referencePoint[1] -
      
      front[i,1]
    
    height <-
      
      previousF2 -
      
      front[i,2]
    
    if(width > 0 &&
       height > 0)
    {
      
      hv <-
        
        hv +
        
        width * height
      
    }
    
    previousF2 <-
      
      front[i,2]
    
  }
  
  return(hv)
  
}