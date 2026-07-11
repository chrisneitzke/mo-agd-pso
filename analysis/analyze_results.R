###############################################################################
#
# Results Analysis
#
# MO_AGD_PSO
#
###############################################################################

rm(list = ls())

graphics.off()

###############################################################################
# Create folders
###############################################################################

dir.create("../results/summary", showWarnings = FALSE)

dir.create("../plots", showWarnings = FALSE)

###############################################################################
# Load Results
###############################################################################

results <-
  
  read.csv(
    
    "../results/results.csv",
    
    stringsAsFactors = FALSE
    
  )

###############################################################################
# Summary Statistics
###############################################################################

summaryList <- list()

benchmarks <- unique(results$Benchmark)

algorithms <- unique(results$Algorithm)

for(b in benchmarks)
{
  
  for(a in algorithms)
  {
    
    subsetData <-
      
      subset(
        
        results,
        
        Benchmark == b &
          
          Algorithm == a
        
      )
    
    summaryList[[length(summaryList)+1]] <-
      
      data.frame(
        
        Benchmark = b,
        
        Algorithm = a,
        
        HV_Mean = mean(subsetData$Hypervolume),
        
        HV_SD   = sd(subsetData$Hypervolume),
        
        HV_Min  = min(subsetData$Hypervolume),
        
        HV_Max  = max(subsetData$Hypervolume),
        
        GD_Mean = mean(subsetData$GD),
        
        GD_SD   = sd(subsetData$GD),
        
        GD_Min  = min(subsetData$GD),
        
        GD_Max  = max(subsetData$GD),
        
        Time_Mean = mean(subsetData$Time),
        
        Time_SD   = sd(subsetData$Time),
        
        Pareto_Mean = mean(subsetData$ParetoSize)
        
      )
    
  }
  
}

summaryTable <-
  
  do.call(
    
    rbind,
    
    summaryList
    
  )

###############################################################################
# Save Summary
###############################################################################

write.csv(
  
  summaryTable,
  
  "../results/summary/summary.csv",
  
  row.names = FALSE
  
)

###############################################################################
# Labels
###############################################################################

results$Label <-
  
  with(
    
    results,
    
    paste(
      
      Benchmark,
      
      ifelse(
        
        Algorithm == "NSGAII",
        
        "NSGA-II",
        
        "MO-AGD-PSO"
        
      ),
      
      sep = "\n"
      
    )
    
  )

###############################################################################
# Hypervolume Boxplot
###############################################################################

pdf(
  
  "../plots/Hypervolume_boxplot.pdf",
  
  width = 9,
  
  height = 7
  
)

par(
  
  mar = c(8,4,4,2)
  
)

boxplot(
  
  Hypervolume ~
    
    Label,
  
  data = results,
  
  xlab = "",
  
  ylab = "Hypervolume",
  
  las = 2,
  
  col = "lightgray",
  
  main = "Hypervolume"
  
)

grid()

dev.off()

###############################################################################
# GD Boxplot
###############################################################################

pdf(
  
  "../plots/GD_boxplot.pdf",
  
  width = 9,
  
  height = 7
  
)

par(
  
  mar = c(8,4,4,2)
  
)

boxplot(
  
  GD ~
    
    Label,
  
  data = results,
  
  xlab = "",
  
  ylab = "Generational Distance",
  
  las = 2,
  
  col = "lightgray",
  
  main = "Generational Distance"
  
)

grid()

dev.off()

###############################################################################
# Time Boxplot
###############################################################################

pdf(
  
  "../plots/Time_boxplot.pdf",
  
  width = 9,
  
  height = 7
  
)

par(
  
  mar = c(8,4,4,2)
  
)

boxplot(
  
  Time ~
    
    Label,
  
  data = results,
  
  xlab = "",
  
  ylab = "Execution Time (s)",
  
  las = 2,
  
  col = "lightgray",
  
  main = "Execution Time"
  
)

grid()

dev.off()

###############################################################################
# Console
###############################################################################

cat("\n")
cat("=============================================================\n")
cat("RESULTS SUMMARY\n")
cat("=============================================================\n\n")

print(summaryTable)

cat("\n")
cat("Summary saved to:\n")
cat("  ../results/summary/summary.csv\n\n")

cat("Plots generated:\n")
cat("  ../plots/Hypervolume_boxplot.pdf\n")
cat("  ../plots/GD_boxplot.pdf\n")
cat("  ../plots/Time_boxplot.pdf\n")

cat("\n")
cat("=============================================================\n")
cat("END OF ANALYSIS\n")
cat("=============================================================\n")