###############################################################################
#
# Pareto Front Comparison
#
# Generates a comparison between the best Pareto fronts obtained by
# NSGA-II and MO-AGD-PSO for the ZDT2 benchmark.
#
###############################################################################

rm(list = ls())

graphics.off()

###############################################################################
# Benchmark
###############################################################################

source("../benchmark/zdt2.R")

###############################################################################
# Load Benchmark
###############################################################################

problem <-

  createZDT2Benchmark()

reference <-

  problem$paretoFront()

###############################################################################
# Load Results Summary
###############################################################################

results <-

  read.csv(

    "../results/results.csv",

    stringsAsFactors = FALSE

  )

###############################################################################
# Select Best NSGA-II Run (Maximum Hypervolume)
###############################################################################

bestNSGA <-

  subset(

    results,

    Benchmark == "ZDT2" &

      Algorithm == "NSGAII"

  )

bestNSGA <-

  bestNSGA[

    which.max(bestNSGA$Hypervolume),

  ]

###############################################################################
# Select Best MO-AGD-PSO Run (Maximum Hypervolume)
###############################################################################

bestMO <-

  subset(

    results,

    Benchmark == "ZDT2" &

      Algorithm == "MO_AGD_PSO"

  )

bestMO <-

  bestMO[

    which.max(bestMO$Hypervolume),

  ]

###############################################################################
# Load Pareto Fronts
###############################################################################

nsga <-

  read.csv(

    sprintf(

      "../results/raw/NSGAII_ZDT2_run%02d.csv",

      bestNSGA$Run

    )

  )

mo <-

  read.csv(

    sprintf(

      "../results/raw/MO_AGD_PSO_ZDT2_run%02d.csv",

      bestMO$Run

    )

  )

###############################################################################
# Plot
###############################################################################

pdf(

  "../plots/Pareto_ZDT2.pdf",

  width = 7,

  height = 6

)

plot(

  reference$f1,

  reference$f2,

  type = "l",

  lwd = 3,

  col = "black",

  xlab = expression(f[1]),

  ylab = expression(f[2]),

  main = "Best Pareto Front Approximation - ZDT2",

  xlim = c(0,1),

  ylim = c(0,1)

)

###############################################################################
# NSGA-II
###############################################################################

points(

  nsga$f1,

  nsga$f2,

  pch = 1,

  cex = 0.9

)

###############################################################################
# MO-AGD-PSO
###############################################################################

points(

  mo$f1,

  mo$f2,

  pch = 16,

  cex = 0.7

)

###############################################################################
# Legend
###############################################################################

legend(

  "topright",

  legend = c(

    "Reference Pareto Front",

    "NSGA-II",

    "MO-AGD-PSO"

  ),

  lty = c(1, NA, NA),

  lwd = c(3, NA, NA),

  pch = c(NA, 1, 16),

  pt.cex = c(NA, 0.9, 0.7),

  bty = "n"

)

grid()

dev.off()

###############################################################################
# Console
###############################################################################

cat("\n")
cat("=============================================\n")
cat("PARETO FRONT COMPARISON GENERATED\n")
cat("=============================================\n\n")

cat("Benchmark : ZDT2\n")

cat(sprintf(
  "Best NSGA-II Run      : %02d (HV = %.6f)\n",
  bestNSGA$Run,
  bestNSGA$Hypervolume
))

cat(sprintf(
  "Best MO-AGD-PSO Run   : %02d (HV = %.6f)\n",
  bestMO$Run,
  bestMO$Hypervolume
))

cat("\nFigure saved to:\n")
cat("../plots/Pareto_ZDT2.pdf\n\n")

cat("=============================================\n")