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
  


  # distance matrix
  distance.matrix <- read.table(paste('data/', data.file.name, sep=""))
  
  permutation <- GetBestPermutation(distance.matrix)
  
  cat("Best permutation:\n")
  print(permutation); 

  schedule <- ConstructTournamentSchedule(permutation, distance.matrix)
  
  cat("Schedule using Permutation:\n")
  print(schedule)
  
  answer <- EnhanceScheduleUsingSA(schedule, distance.matrix)
  
  cat("Minimum Feasible Cost:\n")
  print(answer[1])
  
  cat("New Schedule:")
  print(answer[2])
}
