SwapHomes <- function(schedule, ith.team, jth.team) {
  # Swaps stadiums of two teams' schedules.
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
			schedule[ith.team, round] <- -schedule[ith.team,round]
			schedule[ith.team, round+no.teams-1] <- -schedule[ith.team,round+no.teams-1]
			schedule[jth.team, round] <- -schedule[jth.team,round]
			schedule[jth.team, round+no.teams-1] <- -schedule[jth.team,round+no.teams-1]
			break
		}
	}

	return (schedule);
}