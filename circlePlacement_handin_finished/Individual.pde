class Individual {
  int[] genome;
  int genomeSize;
  double length;
  
  Individual(int genomeSize) {
    this.genomeSize = genomeSize;
    genome = new int[genomeSize];
    for (int i = 0; i < genomeSize; i++) {
      genome[i] = i;
    }
    shuffleGenome();
  }
  
  Individual(int[] genes) {
    this.genomeSize = genes.length;
    genome = Arrays.copyOf(genes, genes.length);
  }
  
  void shuffleGenome() {
    for (int i = 0; i < genome.length; i++) {
      int randomIndex = (int) (Math.random() * genome.length);
      int temp = genome[i];
      genome[i] = genome[randomIndex];
      genome[randomIndex] = temp;
    }
  }
  
  void mutate(float mut_rate) {
    if (Math.random() < mut_rate) {
      int i = (int) (Math.random() * genomeSize);
      int j = (int) (Math.random() * genomeSize);
      int temp = genome[i];
      genome[i] = genome[j];
      genome[j] = temp;
    }
  }
  
  void evaluateIndividual(Bunch bunch) {
    for (int i = 0; i < genome.length; i++) {
      bunch.Circles[i].i = genome[i];
    }
    bunch.orderedPlace();
    length = bunch.computeBoundary();
  }

  @Override
  public String toString() {
    return Arrays.toString(genome);
  }
}
