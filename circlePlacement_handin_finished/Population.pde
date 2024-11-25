class Population {
  boolean finished;
  Individual solution;
  Individual[] genomes;
  
  int max_gens;
  int popsize;
  float mutation_rate;
  double currentbest;
  
  Population(int size, int maxgens, float mut, int[] radii) {
    popsize = size;
    mutation_rate = mut;
    max_gens = maxgens;
    finished = false;
    currentbest = Double.MAX_VALUE;
    genomes = new Individual[popsize];
    for (int i = 0; i < popsize; i++) {
      genomes[i] = new Individual(radii.length);
    }
    evaluatePopulation(radii);
    printInitialPopulation(); // Print the initial randomized population
  }
  
  void printInitialPopulation() {
    println("Initial randomized population:");
    for (int i = 0; i < popsize; i++) {
      println("Individual " + i + ": " + genomes[i] + " Boundary Length: " + genomes[i].length);
    }
  }
  
  void evaluatePopulation(int[] radii) {
    for (int i = 0; i < popsize; i++) {
      Bunch bunch = new Bunch(radii);
      genomes[i].length = bunch.computeBoundaryForIndividual(genomes[i].genome, radii);
      double thisscore = genomes[i].length;
      println("Evaluating Individual " + i + ": " + genomes[i] + " Boundary Length: " + thisscore);
      if (thisscore < currentbest) {
        solution = genomes[i];
        currentbest = thisscore;
        println("New Best Solution Found: " + solution + " Boundary Length: " + currentbest);
      }
    }
  }
  
  Individual tournamentSelection() {
    Individual[] Tourn = new Individual[tournamentSize];
    double shortestTour = Double.MAX_VALUE;
    int shortestIndex = 0;
    
    for (int i = 0; i < tournamentSize; i++) {
      int randomID = (int) (Math.random() * popsize);
      Tourn[i] = genomes[randomID];
    }
    
    if (Math.random() < selectionPressure) {
      for (int i = 0; i < tournamentSize; i++) {
        if (Tourn[i].length < shortestTour) {
          shortestTour = Tourn[i].length;
          shortestIndex = i;
        }
      }
      return Tourn[shortestIndex];
    } else {
      return Tourn[0];
    }
  }
  
  Individual getBest() {
    return solution;
  }
  
  void evolve(int gen, int[] radii) {
    println("Generation " + gen + " Evolution:");
    if (gen > max_gens) {
      finished = true;
    } else {
      ArrayList<Individual> matingPool = new ArrayList<>();
      for (int i = 0; i < popsize; i++) {
        matingPool.add(tournamentSelection());
      }
      
      Individual[] newGenomes = new Individual[popsize];
      for (int i = 0; i < popsize; i++) {
        int a = (int) (Math.random() * matingPool.size());
        int b = (int) (Math.random() * matingPool.size());
        Individual parentA = matingPool.get(a);
        Individual parentB = matingPool.get(b);
        
        OrderedCrossover crossover = new OrderedCrossover(parentA.genome, parentB.genome);
        crossover.doCrossover();
        int[] child_genome = crossover.getOffspring();
        
        Individual child = new Individual(child_genome);
        child.mutate(mutation_rate);
        newGenomes[i] = child;
      }
      
      genomes = newGenomes;
      evaluatePopulation(radii);
    }
  }
}
