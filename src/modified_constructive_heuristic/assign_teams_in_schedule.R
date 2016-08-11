AssignTeamsInSchedule <- function(no.teams, schedule, assignment) {
  # Assign Real Teams From Assignment into Schedule.
  #
  # Args:
  #   no.teams: Number of teams in tournament.
  #   schedule: Schedule generated.
  #   assignment: Assignment of real teams to abstract teams.
  #
  # Returns:
  #   Real Teams Assigned in Schedule

	new.schedule <- matrix(0, no.teams, no.teams-1)

	for (team in 1:no.teams) {
		for (round in 1:(no.teams-1)) {
			new.schedule[assignment[team],round] <- assignment[schedule[team,round]]
		}
	}

	return (new.schedule)
}
