
public abstract class AbstractEdge {

  Vertex u, v;
  int thickness;
  color c;
  
  public AbstractEdge(Vertex a,Vertex b){
    u=a;
    v=b;
  }

  int other(int s) {
    return s==u.id? v.id:u.id;
  }

  Vertex other(Vertex s) {
    return s==u? v:u;
  }
  
  void setColor(color clr){
    c=clr;
  }
  
  void setThickness(int thk){
    thickness=thk;
  }

  abstract void display();
}
