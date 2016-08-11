CostOfTournament <- function(permutation, no.teams, distance) {
  # Computes cost of a permutation.
  #
  # Args:
  #   permutation: Permutation of teams.
  #   no.teams: Number of teams in tournament.
  #   distance.matrix: matrix consisting of distance between teams.
  #
  # Returns:
  #   Cost of Permutation.

	# generating schedule for the given permutation
	schedule <- ModifiedConstructiveHeuristic(permutation, distance)

	total.cost <- 0

	schedule <- cbind(c(1:no.teams), schedule, c(1:no.teams))

	for (team in 1:no.teams) {
		cost <- 0
		for (round in 2:ncol(schedule)) {
			if (schedule[team, round] > 0) {
				if (schedule[team, round-1] < 0) {
					cost <- cost + distance[abs(schedule[team, round-1]), team]
				}
			} else {
				if (schedule[team, round-1] < 0)  {
					cost <- cost + distance[abs(schedule[team,round-1]), abs(schedule[team,round])]
				} else {
					cost <- cost + distance[team, abs(schedule[team, round])]
				}
			}
		}
		total.cost <- total.cost + cost
	}

	return (total.cost)
}