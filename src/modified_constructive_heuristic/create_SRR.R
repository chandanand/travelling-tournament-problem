CreateSRR <- function(no.teams, permutation) {
  # Creates Single Round Robin Schedule using Polygon Method.
  #
  # Args:
  #   no.teams: Number of teams in tournament.
  #   permutation: permutation of teams.
  #
  # Returns:
  #   Schedule for half tournament from permutation.

	# Initialize SRR schedule
	SRR.schedule <- matrix(0, no.teams, no.teams-1)

	# Implement Polygon Method
	for (round in 1:(no.teams-1)) {
		for (l in 0:((no.teams/2) - 1)) {
			a <- (round -1 + l) %% (no.teams - 1)
      b <- (no.teams - 2 - l + round) %% (no.teams - 1)

      # Last team stays in the same place while the others
      # rotate around it.
      if (l == 0) {
        b <- no.teams - 1
      }

      # Add one so teams are number 1 to teams not 0 to teams - 1
      # upon display.
      SRR.schedule[a+1, round] <- b+1
      SRR.schedule[b+1, round] <- a+1
		}
	}

	new.schedule <- matrix(0, no.teams, no.teams-1)

	for (team in 1:no.teams) {
			new.schedule[team,1] <- SRR.schedule[team,1]

		for (round in 2:(no.teams-1)) {
			new.schedule[team,round] <- SRR.schedule[team, no.teams-round+1]
		}
	}

	SRR.schedule <- new.schedule

	for (team in 1:no.teams) {
		for (round in 1:(no.teams-1)) {
			new.schedule[permutation[team],round] <- permutation[SRR.schedule[team,round]]
		}
	}

	return (new.schedule)
}