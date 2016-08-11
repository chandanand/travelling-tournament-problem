# Travelling Tournament Problem using MetaHeuristics 

This project shows an *Enhanced Heuristic approach* of **Grey Wolf Optimizer(GWO)** and **Enhanced Simulated Annealing(ESA)** in order to find optimum solution for **Travelling Tournament Problem(TTP)**. In this project, I tackle the mirrored version of TTP. I use Prey Proximity Model of Grey Wolf Algorithm to find the best permutation to feed to a Fast Modified Constructive Heuristic algorithm to generate tournament schedules. I integrate an Enhanced Heuristic approach of Simulated Annealing to obtain least Cost Tournament Schedule. I upgrade the population updating step of GWO by using Probabilistic methods and hybridize it with SA to solve TTP and avoid getting stuck in local minima. This proposed hybrid algorithm converges to an _optimum solution for TTP_.


## Code Organization

Within the download you'll find the following directories and files. You'll see something like this:

```
src/
├── enhanced\_simulated\_annealing/
│   ├── cost\_objective\_function.R
│   ├── enhance\_schedule\_using\_SA.R
│   ├── partial\_swap\_rounds.R
│   ├── swap\_homes.R
│   ├── swap\_rounds.R
│   └── swap\_teams.R
├── grey\_wolf\_optimizer/
│   ├── cost\_of\_tournament.R
│   ├── get\_best\_permutation.R
│   └── get\_random\_population.R
└── modified\_constructive\_heuristics/
    ├── assign\_stadiums.R
    ├── assign\_teams.R
    ├── assign\_teams\_in\_schedule.R
    ├── construct\_consecutive\_matrix.R
    ├── construct\_tournament\_schedule.R
    ├── create\_SRR.R
    └── number\_of\_violations.R
```

**data** module contains *Distance Matrix* for different tournaments and number of teams.


## Running the Project

```
git clone https://github.com/chandanand/ttp_with_gwo.git
setwd('project_directory/src')
source('main.R')
Main('data_file_name')
```

## Creators

**Chand Anand**

* <https://twitter.com/chandanand>
* <https://github.com/chandanand>


## Copyright and license

Code released under [the MIT license](https://github.com/chandanand/ttp_with_gwo/blob/master/LICENSE).
