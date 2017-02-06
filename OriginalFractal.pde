ArrayList<Line> lines = new ArrayList<Line>();
int level, centerX, centerY;
float scale;
import java.util.Collections;

void setup() {
  noLoop();
  size(800,800);
  centerX = 400;
  centerY = 400;
  scale = .5;
  noFill();
  level = 15;
  fractal(level);
}

void draw() {
  pushMatrix();
  translate(centerX, centerY);
  scale(scale);
  background(255);
  for(Line l : lines) l.show();
  popMatrix();
}

void keyPressed() {
  if(key == 'q') {
    level --;
    fractal(level);
  }
  if(key == 'e') {
    level ++;
    fractal(level);
  }
  if(key == 'w') centerY += 50;
  if(key == 'a') centerX += 50;
  if(key == 's') centerY -= 50;
  if(key == 'd') centerX -= 50;
  if(key == 'r') scale += .05;
  if(key == 'f' && scale > 0) scale -= .05;
  redraw();

}

class Line {
  int x1, y1, x2, y2;
  Line(int x1, int y1, int x2, int y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
  public Line rotate() {
    return new Line(y2, -x2, y1, -x1);
  }
  public void shift() {
    this.x1 -= lines.get(lines.size()-1).x2;
    this.y1 -= lines.get(lines.size()-1).y2;
    this.x2 -= lines.get(lines.size()-1).x2;
    this.y2 -= lines.get(lines.size()-1).y2;
  }
  public void show() {
    line(x1, y1, x2, y2);
  }
}

void fractal(int level) {
  lines = new ArrayList<Line>();
  lines.add(new Line(0, 0, 10, 0));
  for(int i = 0; i < level-1; i++) {
    ArrayList<Line> newLines = new ArrayList<Line>();
    for (Line l : lines) {
      l.shift();
      newLines.add(l.rotate());
    }
    Collections.reverse(newLines);
    lines.addAll(newLines);
  }
}
