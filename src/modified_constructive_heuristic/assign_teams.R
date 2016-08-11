AssignTeams <- function(no.teams, consecutive.matrix, distance.matrix) {
  # Assigns Real teams to Abstract teams.
  #
  # Args:
  #   no.teams: Number of teams in tournament.
  #   consecutive.matrix: consecutive matrix for schedule
  #   distance.matrix: matrix consisting of distance between teams.
  #
  # Returns:
  #   Assignment for teams

	# matrix containing sorted pairs of abstract teams acc. to
	# consecutive opponents matrix
	sorted.abstract <- c()
	consecutive.matrix[upper.tri(consecutive.matrix)] <- 0
	while (max(consecutive.matrix) > 0) {
		pair <- which(consecutive.matrix == max(consecutive.matrix), arr.ind = TRUE)
		consecutive.matrix[pair[,1], pair[,2]] <- 0
		sorted.abstract <- rbind(sorted.abstract, pair)
	}

	# matrix containing sorted pairs of real teams acc. to
	# distance matrix
	sorted.real <- c()
	distance.matrix[!lower.tri(distance.matrix)] <- Inf
	while (min(distance.matrix) < Inf) {
		pair <- which(distance.matrix == min(distance.matrix), arr.ind = TRUE)
		distance.matrix[pair[,1], pair[,2]] <- Inf
		sorted.real <- rbind(sorted.real, pair)
	}

	# assigning real teams to abstract teams
	num.real <- nrow(sorted.real)
	num.abstract <- nrow(sorted.abstract)
	assignment <- matrix(0, 1, no.teams)


	for (i in 1:num.real) {
		t1 <- sorted.real[i, 1]
		t2 <- sorted.real[i, 2]

		at1 <- assignment[t1]
		at2 <- assignment[t2]

		if (at2 != 0) {
			for (j in 1:num.abstract) {

				a <- sorted.abstract[j, 1]
				b <- sorted.abstract[j, 2]

				if (a == at2) {
					if (!(b %in% assignment)) {
						assignment[t1] = b
					}
				}
			}
		}
		else {
			for (j in 1:num.abstract) {

				a <- sorted.abstract[j, 1]
				b <- sorted.abstract[j, 2]

				if (!(a %in% assignment || b %in% assignment)) {
					assignment[t1] = a
					assignment[t2] = b
				}
			}
		}
	}
	
	list <- c()
	for (i in 1:no.teams) {
		list <- cbind(list, c(assignment[i]))
	}
	for (i in 1:no.teams) {
		if (!(i %in% list)) {
			for (j in 1:no.teams) {
				if (assignment[j] == 0) {
					assignment[j] <- i
					break
				}
			}
		}
	}
	
	rev.assignment <- matrix(0, 1, no.teams)
	for (i in 1:no.teams) {
		rev.assignment[assignment[i]] <- i
	}

	return (rev.assignment)
}