CostObjectiveFunction <- function(schedule, weight, distance.matrix) {
  # Calculates Cost of Tournament.
  #
  # Args:
  #   schedule: SRR schedule.
  #   weight: Simulated Annealing weight.
  #   distance.matrix: Distance matrix of Stadiums.
  #
  # Returns:
  #   Cost of Tournament.

	original.cost <- CostOfTournament(schedule, distance.matrix)
	violations <- NumberOfViolations(schedule)
	
	if (violations == 0) {
		return (original.cost)
	}	else {
		sqrt(original.cost ^ 2 + (weight * SublinearFunction(violations)) ^ 2)
	}
}


SublinearFunction <- function(value) {
  # Sublinear function f: N -> N such that f(1) = 1.
  #
  # Args:
  #   value: value for function.
  #
  # Returns:
  #   Function value.
  
	lambda <- 2
	return (1 + (sqrt(value) * log(value)) / lambda)
}