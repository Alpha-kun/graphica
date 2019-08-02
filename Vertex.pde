
public class Vertex {

  PVector loc;
  int size;
  int id;
  color c;
  int id_font;

  public Vertex(float x, float y, int i) {
    loc = new PVector(x, y); 
    size = 20;
    id = i;
    c = color(200, 200, 0);
    id_font=20;
  }

  public void setLoc(float x, float y) {
    loc = new PVector(x, y);
  }

  void setColor(color nc) {
    c = nc;
  }

  void display() {
    fill(c);
    ellipse(loc.x, loc.y, size, size);
    textSize(id_font);
    text(""+id, loc.x-size, loc.y-size);
  }
  
  void display(int sz,color clr, int tsp) {
    fill(clr,tsp);
    ellipse(loc.x, loc.y, sz, sz);
    stroke(clr,tsp);
    textSize(20);
    text(""+id, loc.x-size, loc.y-size);
  }
}
