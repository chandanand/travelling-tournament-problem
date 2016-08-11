# Main Script

rm(list = ls())

## compiling all the functions
sapply(list.files('grey_wolf_optimizer/', full.names = TRUE), source)
sapply(list.files('modified_constructive_heuristic/', full.names = TRUE), source)
sapply(list.files('enhanced_simulated_annealing/', full.names = TRUE), source)


# distance matrix
distance.matrix <- read.table('data/data8.txt')

permutation <- GetBestPermutation(distance.matrix)

print(permutation)

schedule <- ConstructTournamentSchedule(permutation, distance.matrix)

print(schedule)

answer <- EnhanceScheduleUsingSA(schedule, distance.matrix)

print(answer[1])

print(answer[2])