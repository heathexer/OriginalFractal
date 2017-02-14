ArrayList<Line> lines;
int level, curLevel, centerX, centerY;
float scaly;

void setup() {
  noLoop();
  size(1000,800);
  centerX = width/2;
  centerY = height/2;
  scaly = .5;
  noFill();
  lines = new ArrayList<Line>();
  lines.add(new Line(0, 0, 10, 0));
}

void draw() {
  pushMatrix();
  translate(centerX, centerY);
  scale(scaly);
  background(255);
  fractal(level);
  for(Line l : lines) l.show();
  popMatrix();
}

void keyPressed() {
  if(key == 'q' && level > 0 && level == curLevel) {
    level --;
  }
  if(key == 'e' && level == curLevel) {
    level ++;
  }
  if(key == 'w') centerY += 5*1/scaly;
  if(key == 'a') centerX += 5*1/scaly;
  if(key == 's') centerY -= 5*1/scaly;
  if(key == 'd') centerX -= 5*1/scaly;
  if(key == ' ') {
    centerX = width/2;
    centerY = height/2;
  }
  if(key == 'r') scaly *= 1.05;
  if(key == 'f' && scaly > 0) scaly *= .95;
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
    lines = subList(lines, 0, lines.size()/2);
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

ArrayList subList (ArrayList n, int from, int to) {
  ArrayList res = new ArrayList();
  for(int i = from; i < to; i++) res.add(n.get(i));
  return res;
}
