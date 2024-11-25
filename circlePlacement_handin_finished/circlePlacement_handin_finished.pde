import java.util.Arrays;
import java.util.ArrayList;

PFont f;

int generation;
int tournamentSize = 20;
float selectionPressure = 0.4;
Population myPopulation;
GreedyPlace greedyAlg;
RandomPlace randomAlg;
boolean gaFinished = false;

int [] test1 = {10,20,30,40,50,60,70,80,90,100}; 

int [] r1 = {10,12,15,20,21,30,30,30,50,40}; //110
int [] r2 = {10,40,25,15,18}; // 90
int [] r3 = {10,34,10,55,30,14,70,14}; //150
int [] r4 = {5,50,50,50,50,50,50}; // 173 
int [] r5 = {10,34,10,55,30,14,70,14,50,16,23,76,34,10,12,15,16,11,48,20}; //180
int [] t1 = {20, 22, 17, 17, 7, 21, 11, 5, 23, 8}; //63
int [] t2 = {8,14,8,15,11,17,21,16,6,18,24,13,20,10}; // ? lower then 82     67  
int [] t3 = {24,16,19,7,14,24,15,6,16,16,23,10,9,10,18,22,7,9,7,13,14,8,18,6,8}; //? lower then 100   88
int [] t4 = {6,12,20,6,14,19,9,20,10,13,12,14,23,17,16,19,15,10,12,18,21,6,20,17,13,20,17,6,21,15,12,9,14,20,23,16,23,9,23,18}; //121
int [] t5 = {17,23,17,13,18,21,23,22,7,9,8,13,20,11,10,19,10,14,12,22,19,10,17,11,21,8,15,16,19,21,17,19,8,6,13,13,14,19,18,23,20,24,24,13,13,19,7,6,10,8,8,10,24,19,2}; // lower then 160
int [] hard = {50,13,11,23,37,10,30,30,25,28,6,40,6,10,6,10,10,17,27,19,26,27,24,12,14,15,20};


int [] radii = r5;

ArrayList<Individual> bestIndividuals;

int displayMode = 0;

void setup() {
  
  size(700, 700);
  smooth(2);
  background(255);
  f = createFont("Arial", 18, true);
  
  randomAlg=new RandomPlace(radii,450);
  greedyAlg = new GreedyPlace(radii);
  myPopulation = new Population(100, 100, 0.029, radii);   // pop , gens , fitness
  bestIndividuals = new ArrayList<Individual>();
  generation = 0;

}

void draw() {
  background(255);
  switch(displayMode){
  
  case 0:
    if (!myPopulation.finished) {
    myPopulation.evolve(generation, radii);
    Individual best = myPopulation.getBest();
    text("Generation: " + generation, 20, 550);
    bestIndividuals.add(best); // Track the best individual of the current generation
    
    background(255);
    textFont(f, 16);
    fill(0);
    text("Best boundary length so far: " + best.length, 20, 600);
    text("Generation: " + generation, 20, 550);
 
    
    Bunch bestBunch = new Bunch(radii);
    bestBunch.computeBoundaryForIndividual(best.genome, radii);
    bestBunch.draw();
    
    
    generation++;
  } else {
    gaFinished = true; // Mark GA as finished
    displayBestResult(myPopulation.getBest(), "GA");
  }
    
  break;
  
  case 1:
  
   
    textFont(f, 16);
    float boundary = greedyAlg.greedyPlacement();
    text("Greedy Place boundary is " + boundary, 30, 620);
    println("greedy placement gives a boundary of " + boundary);
   
    greedyAlg.greedyCircles.draw();
    fill(0);
  
  break;
  
  
  case 2: 
  
   if (!randomAlg.finished) {
        randomAlg.randomPlacementStep();
      }
      displayBestResult(null, "Random");
      break;
  }
}

void displayBestResult(Individual best, String mode) {
  textFont(f, 16);
  fill(0);
  if (mode.equals("GA")) {
    text("Best boundary length so far: " + best.length, 20, 600);
    text("Generation: " + generation, 20, 550);

    Bunch bestBunch = new Bunch(radii);
    bestBunch.computeBoundaryForIndividual(best.genome, radii);
    bestBunch.draw();
  } else if (mode.equals("Random")) {
    text("Random Placement", 30, 650);
    text("Random Place boundary is " + randomAlg.bestBoundary, 30, 620);
    text("Random Generation: " + randomAlg.randomGeneration, 30, 590);
    println("Random placement gives a boundary of " + randomAlg.bestBoundary);
    randomAlg.randomCircles.draw();
  }
}
    
void mousePressed(){
  displayMode = (displayMode +1)% 3;
  redraw();  
}

void displayBestResults() {
  for (int i = 0; i < bestIndividuals.size(); i++) {
    Individual best = bestIndividuals.get(i);
    println("Generation " + i + ": Best boundary length = " + best.length);
  }
}
