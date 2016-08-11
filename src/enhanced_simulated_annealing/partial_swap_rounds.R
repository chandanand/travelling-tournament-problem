PartialSwapRounds <- function(schedule, ith.team, ith.round, jth.round) {

	queue <- c(ith.team)
	i <- 1

	while (!is.na(queue[i])) {

		if (!(abs(schedule[queue[i], ith.round]) %in% queue)) {
			queue <- cbind(queue, abs(schedule[queue[i], ith.round]))
		}
		if (!(abs(schedule[queue[i], jth.round]) %in% queue)) {
			queue <- cbind(queue, abs(schedule[queue[i], jth.round]))
		}

		temp <- schedule[queue[i], ith.round]
		schedule[queue[i], ith.round] <- schedule[queue[i], jth.round]
		schedule[queue[i], jth.round] <- temp

		i <- i+1
	}

	return (schedule)
}