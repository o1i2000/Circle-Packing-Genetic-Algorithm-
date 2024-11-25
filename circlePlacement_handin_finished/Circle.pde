class Circle {
  int x, y, i;
  int radius;
  boolean computed;
  
  Circle(int r, int num) {
    x = 0;
    y = 0;
    radius = r;
    i = num;
    computed = false;
  }
  
  void computePosition(Circle[] c) {
    int i, j;
    boolean collision;
    ArrayList<Point> openPoints = new ArrayList<Point>();
    int ang;
    Point pnt;
    
    if (computed) return;
    
    for (i = 0; i < c.length; i++) {
      if (c[i].computed) {
        for (ang = 0; ang < 360; ang += 1) {
          collision = false;
          pnt = new Point();
          pnt.x = c[i].x + int(cos(radians(ang)) * (radius + c[i].radius + 1));
          pnt.y = c[i].y + int(sin(radians(ang)) * (radius + c[i].radius + 1));
          
          for (j = 0; j < c.length; j++) {
            if (c[j].computed && !collision) {
              if (dist(pnt.x, pnt.y, c[j].x, c[j].y) < radius + c[j].radius) {
                collision = true;
              }
            }
          }
          
          if (!collision) {
            openPoints.add(pnt);
          }
        }
      }
    }
    
    float min_dist = -1;
    int best_point = 0;
    for (i = 0; i < openPoints.size(); i++) {
      if (min_dist == -1 || dist(250, 250, openPoints.get(i).x, openPoints.get(i).y) < min_dist) {
        best_point = i;
        min_dist = dist(250, 250, openPoints.get(i).x, openPoints.get(i).y);
      }
    }
    if (openPoints.size() == 0) {
      println("no points?");
    } else {
      x = openPoints.get(best_point).x;
      y = openPoints.get(best_point).y;
    }
    computed = true;
  }
  
  void draw() {
    fill(255);
    ellipseMode(CENTER);
    ellipse(x, y, radius * 2, radius * 2);
    fill(255, 0, 0);
    textFont(f, 8);
    text("" + i, x, y);
  }
}
