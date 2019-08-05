
public class Edge extends AbstractEdge{
  
  public Edge(Vertex a,Vertex b){
    super(a,b);
    thickness=4;
    c=color(150,200,0);
  }
  
  @Override
  void display(){
    strokeWeight(thickness);
    strokeCap(ROUND);
    stroke(c);
    line(u.loc.x, u.loc.y, v.loc.x, v.loc.y);
  }
  
  
  void display(int thn, color clr, int tsp){
    strokeWeight(thn);
    strokeCap(ROUND);
    stroke(clr,tsp);
    line(u.loc.x, u.loc.y, v.loc.x, v.loc.y);
  }
}
