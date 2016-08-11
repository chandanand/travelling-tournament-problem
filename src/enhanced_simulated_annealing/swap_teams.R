SwapTeams <- function(schedule, ith.team, jth.team) {
  # Swaps Teams of two teams' schedules.
  #
  # Args:
  #   schedule: DRR schedule of tournament.
  #   ith.team: ith Team.
  #   jth.team: jth Team.
  #
  # Returns:
  #   Schedule after implementing move.

	no.teams <- nrow(schedule)

	for (round in 1:(2*(no.teams-1))) {
		if (abs(schedule[ith.team, round]) == jth.team) {
			next
		}

		temp <- schedule[ith.team, round]
		schedule[ith.team, round] <- schedule[jth.team, round]
		schedule[jth.team, round] <- temp
	}

	for (team in 1:no.teams) {
		if (team == ith.team || team == jth.team) {
			next
		}
		for (round in 1:(2*(no.teams-1))) {
			if (abs(schedule[team, round]) == ith.team) {
				if (schedule[team, round] > 0) {
					schedule[team, round] <- jth.team
				}
				else {
					schedule[team, round] <- -jth.team
				}
				next
			}
			if (abs(schedule[team, round]) == jth.team) {
				if (schedule[team, round] > 0) {
					schedule[team, round] <- ith.team
				}
				else {
					schedule[team, round] <- -ith.team
				}
			}
		}
	}

	return (schedule)
}