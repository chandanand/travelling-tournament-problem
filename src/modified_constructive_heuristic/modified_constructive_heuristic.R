# Modified Constructive Heuristic Module
ModifiedConstructiveHeuristic <- function(permutation, distance.matrix) {
  # Constructs Double Round Robin Schedule using Modified Constructive
  # Heuristics.
  #
  # Args:
  #   permutation: Permutation of teams.
  #   distance.matrix: matrix consisting of distance between teams.
  #
  # Returns:
  #   Double Round Robin (DRR) Schedule.

	no.teams <- nrow(distance)

	# ================= Stage 1: Build 1-factorization ================

	SRR.schedule <- CreateSRR(no.teams, permutation)

	DRR.schedule <- cbind(SRR.schedule, SRR.schedule)

	consecutive.matrix <- ConstructConsecutiveMatrix(no.teams, DRR.schedule)

	# =========== Stage 2: Assign real teams to abstract teams ============

	assignment <- AssignTeams(no.teams, consecutive.matrix, distance.matrix)

	SRR.schedule <- AssignTeamsInSchedule(no.teams, SRR.schedule, assignment)

	# ============== Stage 3: Assign stadiums to games ===============

	DRR.schedule <- AssignStadiums(no.teams, SRR.schedule)

	while (NumberOfViolations(DRR.schedule) != 0) 
		DRR.schedule <- AssignStadiums(no.teams, SRR.schedule)

	# return the schedule developed
	return (DRR.schedule)
}
