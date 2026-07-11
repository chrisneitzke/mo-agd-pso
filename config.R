###############################################################################
#
# MO_AGD_PSO
#
# Configuration
#
###############################################################################

###############################################################################
# Operators
###############################################################################

source("../operators/initialization.R")
source("../operators/dominance.R")
source("../operators/nondominated_sort.R")
source("../operators/crowding_distance.R")
source("../operators/selection.R")
source("../operators/sbx_crossover.R")
source("../operators/polynomial_mutation.R")
source("../operators/environmental_selection.R")
source("../operators/pso_update.R")
source("../operators/adaptive_mutation.R")
source("../operators/adaptive_mutation.R")

###############################################################################
# Algorithms
###############################################################################

source("../algorithms/nsga2.R")
source("../algorithms/mo_agd_pso.R")
