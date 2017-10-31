
AssignStadiums <- function(no.teams, SRR.schedule) {
  # Assigns Home/Away stadiums to matches.
  #
  # Args:
  #   no.teams: Number of teams in tournament.
  #   SRR.schedule: single round robin schedule.
  #
  # Returns:
  #   DRR schedule

	#x <- c(-1,1)
	#x <- kronecker(matrix(1,no.teams/2,1),x)
	# randomly assigning stadiums in first round
	#SRR.schedule[,1] <- sample(x) * SRR.schedule[,1]
	#SRR.schedule[,1] <- sample(x) * abs(SRR.schedule[,1])

	# In total, there are n/2 matches per round
	# Randomly determine whether team with smallest number plays at home
	home <- sample(c(TRUE, FALSE), no.teams/2, TRUE)
	matchnr = 1	
	for (i in 1 : no.teams) {
		if (i < SRR.schedule[i, 1]) {
			if (home[matchnr] == FALSE) {
				SRR.schedule[i, 1] = SRR.schedule[i, 1] * -1
			}
			else {
				SRR.schedule[SRR.schedule[i, 1], 1] = i * -1
			}
			++matchnr
		}
	}	
	# first step building a feasible schedule

	# assigning stadiums to first phase
	for (round in 2:(no.teams-2)) {
		done <- c()
		for (t1 in 1:no.teams) {
			t2 <- SRR.schedule[t1, round]

			if (abs(t1) %in% done || abs(t2) %in% done) {
				next
			}
			else
				done <- cbind(done, cbind(t1, t2))			

			# calculate n.t1
			nt1 <- 1
			home.stadium <- SRR.schedule[t1, round-1] > 0
			i <- round-2
			while (i > 0) {
				if ((SRR.schedule[t1, i] > 0) == home.stadium) {
					nt1 <- nt1 + 1
				}
				else {
					break
				}
				i <- i-1
			}

			# calculate n.t2
			nt2 <- 1
			home.stadium <- SRR.schedule[t2, round-1] > 0
			i <- round-2
			while (i > 0) {
				if ((SRR.schedule[t2, i] > 0) == home.stadium) {
					nt2 <- nt2 + 1
				}
				else {
					break
				}
				i <- i-1
			}
			
			if (nt2 > nt1) {
				home.stadium.t2 <- SRR.schedule[t2, round-1] > 0
				
				if (home.stadium.t2) {
					SRR.schedule[t2, round] = (-1)*SRR.schedule[t2, round]
				}
				else {
					SRR.schedule[t1, round] = (-1)*SRR.schedule[t1, round]
				}
			}
			else if (nt1 > nt2) {
				home.stadium.t1 <- SRR.schedule[t1, round-1] > 0
				
				if (home.stadium.t1) {
					SRR.schedule[t1, round] = (-1)*SRR.schedule[t1, round]
				}
				else {
					SRR.schedule[t2, round] = (-1)*SRR.schedule[t2, round]
				}
			}
			else if (nt1 == nt2) {
				home.stadium.t1 <- SRR.schedule[t1, round-1] > 0
				home.stadium.t2 <- SRR.schedule[t2, round-1] > 0

				if (home.stadium.t1 && !home.stadium.t2) {
					SRR.schedule[t1, round] = (-1)*SRR.schedule[t1, round]
				}
				else if (home.stadium.t2 && !home.stadium.t1) {
					SRR.schedule[t2, round] = (-1)*SRR.schedule[t2, round]
				}
				else {
					choice <- c(t1, t2)
					choice <- sample(choice, 1)
					SRR.schedule[choice, round] = (-1)*SRR.schedule[choice, round]
				}
			}
		}
	}

	# Randomly assign stadiums in last round
	home <- sample(c(TRUE, FALSE), no.teams/2, TRUE)
	matchnr = 1	
	for (i in 1 : no.teams) {
		if (i < SRR.schedule[i, no.teams-1]) {
			if (home[matchnr] == FALSE) {
				SRR.schedule[i, no.teams-1] = SRR.schedule[i, no.teams-1] * -1
			}
			else {
				SRR.schedule[SRR.schedule[i, no.teams-1], no.teams-1] = i * -1
			}
			++matchnr
		}
	}	

	# assigning stadiums to second phase
	DRR.schedule <- cbind(SRR.schedule, (-1)*(SRR.schedule[,1:(no.teams-1)]))

	#x <- c(-1,1)
	#x <- kronecker(matrix(1,no.teams/2,1),x)
	## randomly assigning stadiums in last round
	#DRR.schedule <- cbind(DRR.schedule, sample(x) * abs(SRR.schedule[,no.teams-1]))
}
