
public class Physics2 implements Player {

  float equilen = 150;
  float tension = 0.25;
  float drag = 0.8; 

  public Physics2(Graph grf) {
    g=grf;
    cp5.addSlider("equilibrium edge length", 0, 300, 128, 20, 100, 150, 20);
    cp5.addSlider("edge tension strength", 0, 1, 0.25, 20, 150, 150, 20);
    cp5.addSlider("drag factor", 0, 1, 0.8, 20, 200, 150, 20);
    velocity = new PVector[g.N];
    for (int i = 0; i<g.N; i++) {
      velocity[i]=new PVector(0, 0);
    }
    accl = new PVector[g.N];

    sp=new int[g.N][];
    for (int i = 0; i<g.N; i++) {
      sp[i]=bfs(i);
      for (int j = 0; j<g.N; j++) {
        //print(sp[i][j]+" ");
      }
      //println();
    }
    println("sp constructed");
  }

  PVector[] velocity;
  PVector[] accl;

  Graph g;

  int[] bfs(int s) {
    boolean[] marked =new boolean[g.N];
    int[] spTo =new int[g.N];
    LinkedList<Integer> Q=new LinkedList<Integer>();
    Q.addLast(s);
    marked[s]=true;
    while (!Q.isEmpty()) {
      int u = Q.removeFirst();
      for (Edge e : g.adjList.get(u)) {
        if (!marked[e.other(u)]) {
          Q.addLast(e.other(u));
          marked[e.other(u)]=true;
          spTo[e.other(u)]=spTo[u]+1;
        }
      }
    }
    return spTo;
  }

  int[][] sp;

  int frame;

  boolean repel = false;

  @Override
    boolean hasNextFrame() {
    return true;
  }

  @Override
    void drawNextFrame() {
    equilen=cp5.getController("equilibrium edge length").getValue();
    tension=cp5.getController("edge tension strength").getValue();
    drag=cp5.getController("drag factor").getValue();
    
    //println("frame update");
    for (int i=0; i<g.N; i++) {
      accl[i]=new PVector(0, 0);
    }
    //update a using x
    for (int i=0; i<g.N; i++) {
      for (int j=i+1; j<g.N; j++) {
        Vertex u = g.vertices.get(i);
        Vertex v = g.vertices.get(j);
        PVector ac = PVector.sub(v.loc, u.loc);
        //println(ac);
        if (repel) {
          ac.setMag(0.25*ln(ac.mag()/(sp[i][j]*30))+20/ac.mag());
        } else {
          ac.setMag(tension*ln(ac.mag()/(sp[i][j]*equilen)));
        }

        accl[i].add(ac);
        ac.mult(-1);
        accl[j].add(ac);
      }
    }

    //println("====frame "+frame+"====");
    for (int i =0; i<g.N; i++) {
      Vertex v = g.vertices.get(i);
      //println("--vertex "+i+"--");

      //update x using v and a
      v.loc.add(velocity[i]);

      //update v using a
      velocity[i].add(accl[i]);

      //velocity[i].add(new PVector(0,0,random(-5,5)));
      velocity[i].mult(drag);
      //println("velocity" +v);
    }

    g.display();
  }

  @Override
    void terminate() {
    cp5.getController("equilibrium edge length").remove();
    cp5.getController("edge tension strength").remove();
    cp5.getController("drag factor").remove();
    println("sliders removed");
  }

  final float ln10 = 1.0/log((float)Math.E);

  float ln(float x) {
    return ln10*log(x);
  }
}
