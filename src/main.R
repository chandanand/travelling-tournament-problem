# Main Script

rm(list = ls())

## compiling all the functions
source('grey_wolf_optimizer/get_random_population.R')

# distance matrix
distance.matrix <- read.table('data/data8.txt')

permutation <- GetRandomPopulation(population.size = 50, no.teams = nrow(distance.matrix))

print(permutation)