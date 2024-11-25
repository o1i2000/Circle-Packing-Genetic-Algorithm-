class OrderedCrossover {
  int[] parent1;
  int[] parent2;
  int[] offspring;
  
  public OrderedCrossover(int[] parent1, int[] parent2) {
    this.parent1 = Arrays.copyOf(parent1, parent1.length);
    this.parent2 = Arrays.copyOf(parent2, parent2.length);
    this.offspring = new int[parent1.length];
  }
  
  private boolean containsGene(int gene, int[] genome) {
    for (int i : genome) {
      if (i == gene) return true;
    }
    return false;
  }
  
  public void doCrossover() {
    Arrays.fill(offspring, -1);
    
    int substrPos1 = (int) (Math.random() * parent1.length);
    int substrPos2 = (int) (Math.random() * parent1.length);
    
    final int startSubstr = Math.min(substrPos1, substrPos2);
    final int endSubstr = Math.max(substrPos1, substrPos2);
    
    for (int i = startSubstr; i <= endSubstr; i++) {
      offspring[i] = parent1[i];
    }
    
    int currentPos = (endSubstr + 1) % parent2.length;
    for (int i = 0; i < parent2.length; i++) {
      int parent2Gene = (i + endSubstr + 1) % parent2.length;
      if (!containsGene(parent2[parent2Gene], offspring)) {
        offspring[currentPos] = parent2[parent2Gene];
        currentPos = (currentPos + 1) % parent2.length;
      }
    }
  }
  
  public int[] getOffspring() {
    return offspring;
  }
}
