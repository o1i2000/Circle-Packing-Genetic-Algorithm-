class Bunch {
  Circle[] Circles;
  int numCircles;
  float cx = 250, cy = 250;
  int w = 500, h = 500;
  
  Bunch(int[] radii) {
    Circles = new Circle[radii.length];
    numCircles = radii.length;
    for (int i = 0; i < numCircles; i++) {
      Circles[i] = new Circle(radii[i], i);
    }
  }
  
  void draw() {
    float bound = computeBoundary();
    stroke(0);
    fill(255);
    ellipse(cx, cy, bound * 2, bound * 2);
    
    for (int i = 0; i < numCircles; i++) {
      if (Circles[i].computed) {
        Circles[i].draw();
      }
    }
  }
  
  void orderedPlace() {
    Circles[0].x = (int) cx;
    Circles[0].y = (int) cy;
    Circles[0].computed = true;
    
    for (int i = 1; i < numCircles; i++) {
      Circles[i].computePosition(Circles);
    }
  }
  
  float computeBoundary() {
    int i;
    float outer_limit = 0;
    float dist = 0;
    
    for (i = 0; i < numCircles; i++) {
      if (Circles[i].computed) {
        int farx = Circles[i].x - (int) cx;
        int fary = Circles[i].y - (int) cy;
        dist = Circles[i].radius + (sqrt((farx * farx) + (fary * fary)));
        
        if (dist >= outer_limit) {
          outer_limit = dist;
        }
      }
    }
    return outer_limit;
  }
  
  float computeBoundaryForIndividual(int[] genome, int[] radii) {
    // Reset circle positions and computed flags
    for (int i = 0; i < numCircles; i++) {
      Circles[i] = new Circle(radii[genome[i]], genome[i]);
      Circles[i].computed = false;
    }
    
    // Place circles according to the genome
    orderedPlace();
    
    // Compute boundary
    return computeBoundary();
  }
}
