class GreedyPlace
{
  int [] radii;
  Bunch greedyCircles;
  
  GreedyPlace(int [] inRad)
  {
    radii= Arrays.copyOf(inRad, inRad.length);
    Arrays.sort(radii);
      
    println("Created new GreedyPLace with sorted radii:");
    System.out.println(Arrays.toString(radii));
  }
  
  float greedyPlacement()
  {
    // create a new Bunch object 
    Bunch tmpBunch=new Bunch(radii);
    
    // place the Circles with the shuffled ordering
    tmpBunch.orderedPlace();
    
    // save it
    greedyCircles=tmpBunch;
    
    // assess it
    return (tmpBunch.computeBoundary());
  }
  
}
