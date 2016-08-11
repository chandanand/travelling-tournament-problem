# GWO to produce best permutations
GetBestPermutation <- function (distance.matrix) {
  # Calculates best permutation for scheduling.
  #
  # Args:
  #   distance.matrix: distance matrix of stadiums.
  #
  # Returns:
  #   Best Permutation.
  
  no.teams <- nrow(distance.matrix)

	population.size <- 50

	max.iteration <- 1

	population <- GetRandomPopulation(population.size, no.teams)

	# score = fitness, Inf because of minimization problem
	alpha.permutation <- matrix(0, 1, no.teams)
  alpha.score <- Inf

  beta.permutation <- matrix(0, 1, no.teams)
  beta.score <- Inf

  delta.permutation <- matrix(0, 1, no.teams)
  delta.score <- Inf

  iteration <- 0

  while (iteration < max.iteration) {
    for (i in 1:nrow(population)) {
      # Return back the search agents that go beyond the boundaries of the search space
      flag.upperbound <- population[i,] > no.teams
      flag.lowerbound <- population[i,] < 1
      
      population[i,] <- (population[i,] * (!(flag.upperbound + flag.lowerbound))) + 
                        (no.teams * flag.upperbound) + (1 * flag.lowerbound)
        
      # Calculate objective function for each search agent
      fitness <- CostOfTournament(population[i,], no.teams, distance.matrix)
        
      if (fitness < alpha.score) {
        alpha.score <- fitness
        alpha.permutation <- population[i,]
      }
        
      if (fitness > alpha.score && fitness < beta.score) {
        beta.score <- fitness
        beta.permutation <- population[i,]
      }
        
      if (fitness > alpha.score && fitness > beta.score && fitness < delta.score) {
        delta.score <- fitness
        delta.permutation <- population[i,]
      }
    }
    
    a <- 2 - iteration * (2 / max.iteration)             # a decreases linearly fron 2 to 0

    # Update the Position of search agents including omegas
    for (i in 1:nrow(population)) {
      for (j in 1:ncol(population)) {
        r1 <- runif(1)                  # r1 is a random number in [0,1]
        r2 <- runif(1)                  # r2 is a random number in [0,1]
                
        A1 <- 2*a*r1 - a            # Equation (3.3)
        C1 <- 2*r2                  # Equation (3.4)
                
        d.alpha <- abs(C1 * alpha.permutation[j] - population[i,j])     # Equation (3.5)-part 1
        X1 <- alpha.permutation[j] - A1 * d.alpha                       # Equation (3.6)-part 1
                       
        r1 <- runif(1)
        r2 <- runif(1)
            
        A2 <- 2*a*r1 - a            # Equation (3.3)
        C2 <- 2*r2                  # Equation (3.4)
            
        d.beta <- abs(C2 * beta.permutation[j] - population[i,j])        # Equation (3.5)-part 2
        X2 <- beta.permutation[j] - A2 * d.beta                         # Equation (3.6)-part 2 
            
        r1 <- runif(1)
        r2 <- runif(1) 
            
        A3 <- 2*a*r1 - a            # Equation (3.3)
        C3 <- 2*r2                  # Equation (3.4)
            
        d.delta <- abs(C3 * delta.permutation[j] - population[i,j])      # Equation (3.5)-part 3
        X3 <- delta.permutation[j] - A3 * d.delta                       # Equation (3.5)-part 3
            
        population[i,j] <- (X1 + X2 + X3) / 3                    # Equation (3.7)
      }
    }

    iteration <- iteration+1
  }

  return (alpha.permutation)
}