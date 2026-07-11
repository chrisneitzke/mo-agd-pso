###############################################################################
#
# Experimental Campaign
#
# MO_AGD_PSO
#
###############################################################################

rm(list = ls())

graphics.off()

###############################################################################
# Framework
###############################################################################

source("../config.R")

###############################################################################
# Benchmarks
###############################################################################

source("../benchmark/zdt1.R")
source("../benchmark/zdt2.R")
source("../benchmark/zdt3.R")

###############################################################################
# Metrics
###############################################################################

source("../metrics/hypervolume.R")
source("../metrics/generational_distance.R")

###############################################################################
# Parameters
###############################################################################

numberOfRuns <- 31

populationSize <- 100

generations <- 200

###############################################################################
# Benchmarks
###############################################################################

benchmarks <- list(
  
  createZDT1Benchmark(),
  
  createZDT2Benchmark(),
  
  createZDT3Benchmark()
  
)

###############################################################################
# Algorithms
###############################################################################

algorithms <- list(
  
  list(
    name = "NSGAII",
    execute = runNSGA2
  ),
  
  list(
    name = "MO_AGD_PSO",
    execute = runMOAGDPSO
  )
  
)

###############################################################################
# Results
###############################################################################

results <- data.frame(
  
  Benchmark = character(),
  
  Algorithm = character(),
  
  Run = integer(),
  
  Hypervolume = numeric(),
  
  GD = numeric(),
  
  Time = numeric(),
  
  ParetoSize = integer(),
  
  stringsAsFactors = FALSE
  
)

###############################################################################
# Create folders
###############################################################################

dir.create("../results", showWarnings = FALSE)

dir.create("../results/raw", showWarnings = FALSE)

###############################################################################
# Experimental Campaign
###############################################################################

for(problem in benchmarks)
{
  
  cat("\n")
  cat("=============================================\n")
  cat(problem$name,"\n")
  cat("=============================================\n")
  
  referenceFront <- problem$paretoFront()
  
  colnames(referenceFront) <- c("f1","f2")
  
  for(algorithm in algorithms)
  {
    
    cat("\n")
    cat("Algorithm:",algorithm$name,"\n")
    
    for(run in seq_len(numberOfRuns))
    {
      
      cat("Run",run,"\n")
      
      set.seed(run)
      
      startTime <- Sys.time()
      
      result <-
        
        algorithm$execute(
          
          problem,
          
          populationSize = populationSize,
          
          generations = generations
          
        )
      
      endTime <- Sys.time()
      
      #######################################################################
      # Pareto Front
      #######################################################################
      
      pareto <-
        
        do.call(
          
          rbind,
          
          lapply(
            
            result$pareto,
            
            function(ind)
            {
              
              ind$objectives
              
            }
            
          )
          
        )
      
      ###########################################################################
      # Prepare Pareto Front
      ###########################################################################
      
      pareto <-
        
        as.data.frame(
          
          pareto
          
        )
      
      colnames(pareto) <-
        
        c(
          
          "f1",
          
          "f2"
          
        )
      
      ###########################################################################
      # Metrics
      ###########################################################################
      
      hv <-
        
        hypervolume2D(
          
          as.matrix(pareto),
          
          referencePoint = c(1.1, 1.1)
          
        )
      
      gd <-
        
        generationalDistance(
          
          as.matrix(
            
            pareto
            
          ),
          
          as.matrix(
            
            referenceFront
            
          )
          
        )
      
      
      elapsed <-
        
        as.numeric(
          
          difftime(
            
            endTime,
            
            startTime,
            
            units = "secs"
            
          )
          
        )
      
      #######################################################################
      # Save Pareto Front
      #######################################################################
      
      write.csv(
        
        pareto,
        
        file = sprintf(
          
          "../results/raw/%s_%s_run%02d.csv",
          
          algorithm$name,
          
          problem$name,
          
          run
          
        ),
        
        row.names = FALSE
        
      )
      
      #######################################################################
      # Store Result
      #######################################################################
      
      results <-
        
        rbind(
          
          results,
          
          data.frame(
            
            Benchmark = problem$name,
            
            Algorithm = algorithm$name,
            
            Run = run,
            
            Hypervolume = hv,
            
            GD = gd,
            
            Time = elapsed,
            
            ParetoSize = nrow(pareto)
            
          )
          
        )
      
    }
    
  }
  
}

###############################################################################
# Save Results
###############################################################################

write.csv(
  
  results,
  
  "../results/results.csv",
  
  row.names = FALSE
  
)

###############################################################################
# End
###############################################################################

cat("\n")
cat("=============================================\n")
cat("EXPERIMENTAL CAMPAIGN FINISHED\n")
cat("=============================================\n")