NumberOfViolations <- function(schedule) {
  # Calculates Number of Constraint Violations for DRR Schedule.
  #
  # Args:
  #   schedule: DRR schedule created.
  #
  # Returns:
  #   Number of Violations.
  
	mu <- 1
	return (NumberOfViolationsAtMost(schedule) +
	          NumberOfViolationsNoRepeat(schedule) +
	          (NumberOfViolationsMirror(schedule)/mu))
}

NumberOfViolationsAtMost <- function(schedule) {
  # Calculates Number of At-Most Constraint Violations 
  # for DRR Schedule.
  #
  # Args:
  #   schedule: DRR schedule created.
  #
  # Returns:
  #   Number of At-Most constraint violations.
  
	violations <- 0

	no.teams <- nrow(schedule)
	rounds <- 2*no.teams - 2
	for (team in 1:no.teams) {
		i <- 1
		while (i <= rounds) {
			home.stadium <- schedule[team, i] > 0
			n <- 0
			j <- i

			while ((schedule[team, j] > 0) == home.stadium) {
				n <- n + 1
				j <- j + 1
				if (j > rounds)
					break
			}

			if (n > 3) 
				violations <- violations+1
			
			i <- i + 1
		}
	}
	return (violations)
}

NumberOfViolationsNoRepeat <- function(schedule) {
  # Calculates Number of No-Repeat Constraint Violations 
  # for DRR Schedule.
  #
  # Args:
  #   schedule: DRR schedule created.
  #
  # Returns:
  #   Number of No-Repeat violations.
  
  
	violations <- 0
	no.teams <- nrow(schedule)
	rounds <- 2*no.teams - 2

	for (team in 1:no.teams) {
		for (i in 1:(rounds-1)) {
			if (schedule[team, i] == -schedule[team,i+1]) {
				violations <- violations + 1
			}
		}
	}
	return (violations)
}

NumberOfViolationsMirror <- function(schedule) {
  # Calculates Number of Mirrored Constraint Violations 
  # for DRR Schedule.
  #
  # Args:
  #   schedule: DRR schedule created.
  #
  # Returns:
  #   Number of Mirrored Constraint Violations.
  
	violations <- 0

	no.teams <- nrow(schedule)
	half.rounds <- no.teams - 1
	for (team in 1:no.teams) {
		for (i in 1:half.rounds) {
			if (schedule[team, i] != -schedule[team, i+no.teams-1]) {
				violations <- violations + 1
			}
		}
	}
	return (violations)
}