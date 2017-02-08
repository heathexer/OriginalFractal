import java.util.List;
List<Line> lines;
int level, curLevel, centerX, centerY;
float scale;

void setup() {
  noLoop();
  size(800,800);
  centerX = 400;
  centerY = 400;
  scale = .5;
  noFill();
  lines = new ArrayList<Line>();
  lines.add(new Line(0, 0, 10, 0));
}

void draw() {
  pushMatrix();
  translate(centerX, centerY);
  scale(scale);
  background(255);
  fractal(level);
  for(Line l : lines) l.show();
  popMatrix();
}

void keyPressed() {
  if(key == 'q' && level > 1) {
    level --;
  }
  if(key == 'e') {
    level ++;
  }
  if(key == 'w') centerY += 5*1/scale;
  if(key == 'a') centerX += 5*1/scale;
  if(key == 's') centerY -= 5*1/scale;
  if(key == 'd') centerX -= 5*1/scale;
  if(key == 'r') scale *= 1.05;
  if(key == 'f' && scale > 0) scale *= .95;
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

void fractal(int t) {
  if(t > curLevel) {
    ArrayList<Line> newLines = new ArrayList<Line>();
    for (Line l : lines) newLines.add(l.rotate());
    lines.addAll(reverse(newLines));
  } else
  if(t < curLevel) {
    lines = lines.subList(0, lines.size()/2);
  }
  for(Line l : lines) l.shift();
  curLevel = t;
}

ArrayList reverse(ArrayList n) {
  ArrayList nlist = new ArrayList();
  for(int i = n.size()-1; i >=0; i--) {
    nlist.add(n.get(i));
  }
  return nlist;
}
