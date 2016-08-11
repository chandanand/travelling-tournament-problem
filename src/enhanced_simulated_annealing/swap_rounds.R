SwapRounds <- function(schedule, ith.round, jth.round) {
  # Swaps rounds of two teams' schedules.
  #
  # Args:
  #   schedule: DRR schedule of tournament.
  #   ith.round: ith Round.
  #   jth.round: jth Round.
  #
  # Returns:
  #   Schedule after implementing move.

	no.teams <- nrow(schedule)

	for (team in 1:no.teams) {
		temp <- schedule[team, ith.round]
		schedule[team, ith.round] <- schedule[team, jth.round]
		schedule[team, jth.round] <- temp
	}

	return (schedule)
}