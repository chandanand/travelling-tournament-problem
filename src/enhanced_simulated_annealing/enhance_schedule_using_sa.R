# Enhanced Simulated Annealing Module
EnhanceScheduleUsingSA <- function(schedule, distance.matrix) {
  # Enhances Schedule Using Simulated Annealing
  #
  # Args:
  #   schedule: DRR schedule.
  #   distance.matrix: Distance matrix of Stadiums.
  #
  # Returns:
  #   Cost of Tournament and New Schedule.
	best.schedule = schedule
	no.teams <- nrow(schedule)
	
	best.feasible <- Inf
	number.best.feasible <- Inf
	
	best.infeasible <- Inf
	number.best.infeasible <- Inf

	reheat <- 0
	counter <- 0

	# initialize parameters
	beta <- 0.9999
	temperature <- 400
	weight <- 4000
	delta <- 1.04
	theta <- 1.04
	max.reheat <- 10
	max.phase <- 10
	max.counter <- 10

	while (reheat <= max.reheat) {
		phase <- 0
		
		while (phase <= max.phase) {
			counter <- 0

			while (counter <= max.counter) {
			  
			  # get 2 random teams
				team <- sample(1:no.teams, 2)
				teami <- team[1]
				teamj <- team[2]
				
				# get 2 random rounds
				round <- sample(1:2*(no.teams-1), 2)
				roundi <- round[1]
				roundj <- round[2]
				
				# get a random move to apply
				move <- sample(1:4, 1)

				if (move == 1) {
					new.schedule <- SwapHomes(schedule, teami, teamj)
				} else if (move == 2) {
					new.schedule <- SwapRounds(schedule, roundi, roundj)
				}	else if (move == 3) {
					new.schedule <- SwapTeams(schedule, teami, teamj)
				}	else if (move == 4) {
					new.schedule <- PartialSwapRounds(schedule, teami, roundi, roundj)
				}# else if (move == 5) {
				#	  new.schedule <- PartialSwapTeams(schedule, teami, teamj, roundi)
				#  }
				
				tri <- CostObjectiveFunction(new.schedule, weight, distance.matrix) - 
				  CostObjectiveFunction(schedule, weight, distance.matrix)

				if (CostObjectiveFunction(new.schedule, weight, distance.matrix) < CostObjectiveFunction(schedule, weight, distance.matrix) ||
					  (NumberOfViolations(new.schedule) == 0 && CostObjectiveFunction(new.schedule, weight, distance.matrix) < best.feasible) ||
					  (NumberOfViolations(new.schedule) > 0 && CostObjectiveFunction(new.schedule, weight, distance.matrix) < best.infeasible)) {
					accept <- TRUE
				}	else {
					if (if(runif(1, 0, 1) < exp((-tri)/temperature)) TRUE else FALSE) {
						accept <-TRUE
					} else {
						accept <- FALSE
					}
				}

				if (accept) {
					schedule <- new.schedule

					if (NumberOfViolations(schedule) == 0) {
						number.best.feasible <- min(CostObjectiveFunction(schedule, weight, distance.matrix), best.feasible)
					} else {
						number.best.infeasible <- min(CostObjectiveFunction(schedule, weight, distance.matrix), best.infeasible)
					}

					if (number.best.feasible < best.feasible || number.best.infeasible < best.infeasible) {
						if (number.best.feasible < best.feasible && NumberOfViolations(schedule) == 0) {
							cat("New best: ", number.best.feasible, "\n") 
							best.schedule = schedule
						}
						reheat <- 0
						counter <- 0
						phase <- 0
						best.temperature <- temperature
						best.feasible <- number.best.feasible
						best.infeasible <- number.best.infeasible

						if (NumberOfViolations(schedule) == 0) {
							weight <- weight / theta
						}	else {
							weight <- weight * delta
						}
					}	else {
						counter <- counter + 1
					}
				}
			}
			phase <- phase + 1
			temperature <- temperature * beta
		}
		reheat <- reheat+1
		temperature <- 2 * best.temperature
	}

	return (list(best.feasible, best.schedule))
}
