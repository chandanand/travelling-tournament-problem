# Main Script

rm(list = ls())

## compiling all the functions
sapply(list.files(c('grey_wolf_optimizer/', 'modified_constructive_heuristic/'), full.names = TRUE), source)

# distance matrix
distance.matrix <- read.table('data/data8.txt')

permutation <- GetBestPermutation(distance.matrix)

print(permutation)

schedule <- ConstructTournamentSchedule(permutation, distance.matrix)

print(schedule)