# Main Script

# compiling all the functions
sapply(list.files('grey_wolf_optimizer/', full.names = TRUE), source)
sapply(list.files('modified_constructive_heuristic/', full.names = TRUE), source)
sapply(list.files('enhanced_simulated_annealing/', full.names = TRUE), source)

Main <- function(data.file.name) {
  # Runs Application.
  #
  # Args:
  #   data.file.name: data file name from data folder
  #
  # Returns:
  #   None.
  
  rm(list = ls())
  
  # distance matrix
  distance.matrix <- read.table('data/' + data.file.name)
  
  permutation <- GetBestPermutation(distance.matrix)
  
  cat("Best permutation: ", permutation)
  
  schedule <- ConstructTournamentSchedule(permutation, distance.matrix)
  
  cat("Schedule using Permutation: ", schedule)
  
  answer <- EnhanceScheduleUsingSA(schedule, distance.matrix)
  
  cat("Minimum Feasible Cost:", answer[1])
  
  cat("New Schedule:", answer[2])
}