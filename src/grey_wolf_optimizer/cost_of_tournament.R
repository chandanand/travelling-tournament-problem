CostOfTournament <- function(schedule, distance.matrix) {
  # Computes cost of a schedule
  #
  # Args:
  #   schedule: DRR schedule of tournament
  #   distance.matrix: matrix consisting of distance between teams.
  #
  # Returns:
  #   Cost of Schedule

	total.cost <- 0
	no.teams <- nrow(distance.matrix)

	#schedule <- cbind(c(1:no.teams), schedule, c(1:no.teams))

	# Cost first round: teams start at home
	for (team in 1:no.teams) {
		cost <- 0
		if (schedule[team,1]<0) {# the team plays an away match
			cost = cost + distance.matrix[team, abs(schedule[team, 1])]
		}
		total.cost <- total.cost + cost

	}

	for (team in 1:no.teams) {
		cost <- 0
		for (round in 2:ncol(schedule)) {
			if (schedule[team, round] > 0) {# Team plays home
				if (schedule[team, round-1] < 0) {
					cost <- cost + distance.matrix[abs(schedule[team, round-1]), team]
				}
			} else {
				if (schedule[team, round-1] < 0)  {
					cost <- cost + distance.matrix[abs(schedule[team,round-1]), abs(schedule[team,round])]
				} else {
					cost <- cost + distance.matrix[team, abs(schedule[team, round])]
				}
			}
		}
		total.cost <- total.cost + cost
	}

	# Cost last round: teams return back home
	for (team in 1:no.teams) {
		if (schedule[team, ncol(schedule)] < 0) {# the team plays an away match
			total.cost = total.cost + distance.matrix[abs(schedule[team, ncol(schedule)]), team]
		}

	}
	return (total.cost)
}
