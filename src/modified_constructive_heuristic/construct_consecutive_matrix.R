Constructconsecutive.matrixMatrix <- function(no.teams, schedule) {
  # Constructs consecutive.matrix Matrix for Schedule.
  #
  # Args:
  #   no.teams: Number of teams in tournament.
  #   schedule: DRR schedule created.
  #
  # Returns:
  #   consecutive.matrix Matrix.
	
	# initialize consecutive.matrix opponents matrix
	consecutive.matrix.matrix <- matrix(0, no.teams, no.teams)

	# construct consecutive.matrix opponents matrix
	for (team in 1:no.teams) {
		for (round in 1:(2*no.teams-3)) {
			consecutive.matrix[schedule[team, round], schedule[team, round+1]] <- consecutive.matrix[schedule[team, round], schedule[team, round+1]] + 1
			consecutive.matrix[schedule[team, round+1], schedule[team, round]] <- consecutive.matrix[schedule[team, round+1], schedule[team, round]] + 1
		}
	}

	return (consecutive.matrix)
}