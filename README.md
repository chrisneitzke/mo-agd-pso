# MO-AGD-PSO

**Multiobjective Adaptive Genetic Diversity Particle Swarm Optimization**

A research framework in **R** for multiobjective evolutionary optimization, implementing a novel **MO-AGD-PSO** algorithm and comparing it against the canonical **NSGA-II** using the **ZDT benchmark suite**.

---

## Overview

This repository was developed as part of a graduate-level research project in Evolutionary Computation.

The project implements:

- Canonical NSGA-II
- MO-AGD-PSO (proposed algorithm)
- ZDT1 benchmark
- ZDT2 benchmark
- ZDT3 benchmark
- Hypervolume metric
- Generational Distance (GD)
- Automated experimental campaign
- Statistical summaries
- Automatic generation of plots

The framework was entirely developed in **R** and emphasizes modularity, reproducibility, and ease of experimentation.

---

# Project Structure

```
MO_AGD_PSO/

│
├── algorithms/
│   ├── nsga2.R
│   └── mo_agd_pso.R
│
├── benchmark/
│   ├── zdt1.R
│   ├── zdt2.R
│   └── zdt3.R
│
├── operators/
│   ├── adaptive_mutation.R
│   ├── crowding_distance.R
│   ├── dominance.R
│   ├── environmental_selection.R
│   ├── initialization.R
│   ├── nondominated_sort.R
│   ├── polynomial_mutation.R
│   ├── pso_update.R
│   ├── sbx_crossover.R
│   └── tournament_selection.R
│
├── metrics/
│   ├── hypervolume.R
│   └── generational_distance.R
│
├── analysis/
│   ├── run_experiments.R
│   └── analyze_results.R
│
├── tests/
│
├── results/
│
└── plots/
```

---

# Algorithms

## NSGA-II

Implementation of the canonical **Non-dominated Sorting Genetic Algorithm II**, proposed by Deb et al. (2002).

Features:

- Fast Non-dominated Sorting
- Crowding Distance
- Binary Tournament Selection
- Simulated Binary Crossover (SBX)
- Polynomial Mutation
- Environmental Selection

---

## MO-AGD-PSO

The proposed algorithm extends NSGA-II by incorporating:

- Particle Swarm Optimization (PSO) position update
- Adaptive mutation controlled by population diversity
- Diversity monitoring
- Dynamic exploration and exploitation balance

The algorithm preserves the NSGA-II selection and elitism mechanisms while introducing adaptive search operators.

---

# Benchmarks

The following problems from the ZDT benchmark suite are included:

| Problem | Characteristics |
|----------|-----------------|
| ZDT1 | Convex Pareto front |
| ZDT2 | Non-convex Pareto front |
| ZDT3 | Discontinuous Pareto front |

---

# Performance Metrics

The framework evaluates algorithms using:

- Hypervolume (HV)
- Generational Distance (GD)
- Execution Time
- Pareto Front Size

---

# Running Experiments

Execute the complete experimental campaign:

```R
source("analysis/run_experiments.R")
```

This script automatically:

- runs NSGA-II
- runs MO-AGD-PSO
- evaluates ZDT1
- evaluates ZDT2
- evaluates ZDT3
- performs multiple independent runs
- computes HV and GD
- stores Pareto fronts
- generates results.csv

---

# Results Analysis

To summarize the experiments:

```R
source("analysis/analyze_results.R")
```

The script generates:

- summary.csv
- Hypervolume boxplots
- GD boxplots
- Execution time boxplots

---

# Experimental Configuration

Default configuration:

| Parameter | Value |
|-----------|------:|
| Population Size | 100 |
| Generations | 200 |
| Independent Runs | 31 |
| Objectives | 2 |
| Decision Variables | 30 (ZDT) |

---

# Requirements

The project was developed using:

- R ≥ 4.2

No external optimization packages are required.

---

# Reproducibility

Each experiment uses a fixed random seed for reproducibility.

The complete Pareto front obtained in every execution is stored under:

```
results/raw/
```

The summarized results are stored in:

```
results/summary/
```

---

# Citation

If this repository contributes to your research, please cite:

```
Neitzke, C. A.

MO-AGD-PSO:
Multiobjective Adaptive Genetic Diversity Particle Swarm Optimization.

GitHub Repository.
```

---

# Author

**Christiano Anderson Neitzke**

Ph.D. Student

Federal University of Maranhão (UFMA)

São Luís – Brazil

---

# License

This project is intended for academic and research purposes.