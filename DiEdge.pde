public class DiEdge extends AbstractEdge {

  public DiEdge(Vertex a, Vertex b) {
    super(a, b);
    thickness=4;
    c=color(150, 200, 0);
  }

  @Override
    void display() {
    strokeWeight(thickness);
    strokeCap(ROUND);
    stroke(c);
    drawArrow(this.u.loc, this.v.loc);
  }


  void display(int thn, color clr, int tsp) {
    strokeWeight(thn);
    strokeCap(ROUND);
    stroke(clr, tsp);
    drawArrow(this.u.loc, this.v.loc);
  }
}
