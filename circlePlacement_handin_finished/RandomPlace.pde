class RandomPlace {
  int[] radii;
  Bunch randomCircles;
  int maxIterations;
  float bestBoundary;
  int[] bestRadii;
  int randomGeneration; // Tracks the number of iterations
  boolean finished; // Tracks if the algorithm has completed

  RandomPlace(int[] inRad, int maxIters) {
    radii = Arrays.copyOf(inRad, inRad.length);
    maxIterations = maxIters;
    bestBoundary = Float.MAX_VALUE;
    bestRadii = new int[radii.length];
    randomGeneration = 0; // Initialize to 0
    finished = false; // Initialize to false

    println("Created new RandomPlace:");
    System.out.println(Arrays.toString(radii));
  }

  void randomPlacementStep() {
    if (randomGeneration < maxIterations) {
      int[] radCopy = Arrays.copyOf(radii, radii.length);

      // Shuffle the array
      for (int i = 0; i < radCopy.length; i++) {
        int randomIndex = int(random(radCopy.length));
        int temp = radCopy[randomIndex];
        radCopy[randomIndex] = radCopy[i];
        radCopy[i] = temp;
      }

      // Create a new Bunch object
      Bunch tmpBunch = new Bunch(radCopy);

      // Place the Circles with the shuffled ordering
      tmpBunch.orderedPlace();

      // Assess it
      float boundary = tmpBunch.computeBoundary();
      if (boundary < bestBoundary) {
        bestBoundary = boundary;
        bestRadii = Arrays.copyOf(radCopy, radCopy.length);
      }

      randomGeneration++;
    } else {
      finished = true; // Set finished to true when all iterations are done
    }

    // Create the best result Bunch
    randomCircles = new Bunch(bestRadii);
    randomCircles.orderedPlace();
  }
}
