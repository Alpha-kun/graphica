
public class WeightedEdge extends AbstractEdge {

  int weight;
  int weight_font;

  public WeightedEdge(Vertex a, Vertex b, int w) {
    super(a, b);
    thickness=4;
    c=color(150,200,0);
    weight=w;
    weight_font = 40;
  }

  @Override
    void display() {
    strokeWeight(thickness);
    strokeCap(ROUND);
    stroke(c,30);
    line(u.loc.x, u.loc.y, v.loc.x, v.loc.y);
    fill(c);
    textSize(weight_font);
    text(""+weight, (u.loc.x+v.loc.x)/2, (u.loc.y+v.loc.y)/2);
  }
  
  void display(int thn, color clr, int tsp){
    strokeWeight(thn);
    strokeCap(ROUND);
    stroke(clr,tsp);
    line(u.loc.x, u.loc.y, v.loc.x, v.loc.y);
    textSize(20);
    text(""+weight, (u.loc.x+v.loc.x)/2, (u.loc.y+v.loc.y)/2);
  }
}
