
public class Prims implements Player {

  public Prims(WeightedGraph wg) {

    grf=wg;
    marked=new boolean[grf.N];

    mst_edge=new ArrayList();

    Comparator<WeightedEdge> cpt = new Comparator<WeightedEdge>() {
      @Override
        int compare(WeightedEdge e1, WeightedEdge e2) {
        return Integer.compare(e1.weight, e2.weight);
      }
    };
    
    
    q = new PriorityQueue(cpt);
    
    prim(takeInput("please select source vertex",0,0,grf.N));
    
  }


  boolean[] marked;
  WeightedGraph grf;
  PriorityQueue<WeightedEdge> q;


  void visit(int s) {
    marked[s]=true;
    for (WeightedEdge we : grf.adjList.get(s)) {
      if (!marked[we.other(s)]) {
        q.add(we);
      }
    }
  }

  void prim(int s) {
    visit(s);
    while (!q.isEmpty()) {
      WeightedEdge we = q.poll();
      if (marked[we.u.id]&&marked[we.v.id]) continue;
      mst_edge.add(we);
      if (!marked[we.u.id]) visit(we.u.id);
      else visit(we.v.id);
    }
  }

  ArrayList<WeightedEdge> mst_edge;

  int frm;
  @Override
    boolean hasNextFrame() {
    return frm<mst_edge.size();
  }

  @Override
    void drawNextFrame() {
    background(40);
    println("drawing frame: "+frm);
    graph.display(3, color(200, 200, 200), 30, 10, color(250, 250, 250), 50);

    for (int i=0; i<frm; i++) {
      mst_edge.get(i).display(4, color(200, 200, 200), 200);
      mst_edge.get(i).u.display(20, color(250, 250, 250), 100);
      mst_edge.get(i).v.display(20, color(250, 250, 250), 100);
    }

    mst_edge.get(frm).display(6, color(250, 0, 0), 150);

    frm++;
    sleep(550-50*animation_speed);
  }

  @Override
    void terminate() {
  }
}
