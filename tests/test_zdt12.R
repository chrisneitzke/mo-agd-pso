source("../benchmark/zdt1.R")

problem <-
  createZDT1Benchmark()

x <-
  runif(
    problem$numberOfVariables
  )

problem$evaluate(x)

pf <-
  problem$paretoFront()

head(pf)


################################################################

source("../benchmark/zdt2.R")

problem <-
  createZDT2Benchmark()

x <-
  runif(
    problem$numberOfVariables
  )

problem$evaluate(x)

pf <-
  problem$paretoFront()

head(pf)

