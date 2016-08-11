GetRandomPopulation <- function(population.size, no.teams) {
  # Generates Random Population.
  #
  # Args:
  #   population.size: Size of the population.
  #   no.teams: Number of teams in tournament.
  #
  # Returns:
  #   Matrix having initial population of permutations.
  
	pool <- c(1:no.teams)
	population <- sample(pool)

	for (i in 2:population.size) {
		random.permutation <- sample(pool)
		while ((i > 2) && IsPresent(random.permutation, population))
			random.permutation <- sample(pool)
		population <- rbind(population, random.permutation)
	}

	return (population)
}

IsPresent <- function(row.vector, matrix) {
  # Validates if row.vector is present in matrix.
  #
  # Args:
  #   row.vector: The vector to be searched.
  #   matrix: The matrix to be searched in.
  #
  # Returns:
  #   TRUE if present, FALSE otherwise.
  
	for (i in 1:nrow(matrix)) {
		if (all(row.vector == matrix[i,]) == TRUE)
			return (TRUE)
	}
	return (FALSE)
}