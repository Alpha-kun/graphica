
public class Kruskals implements Player {

  public Kruskals(WeightedGraph wg) {
    sorted_edges=new ArrayList(wg.edges);
    grf=wg;

    Comparator<WeightedEdge> cpt = new Comparator<WeightedEdge>() {
      @Override
        int compare(WeightedEdge e1, WeightedEdge e2) {
        return Integer.compare(e1.weight, e2.weight);
      }
    };

    Collections.sort(sorted_edges, cpt);

    mst_edge=new ArrayList();

    kruskal();
  }

  WeightedGraph grf;

  ArrayList<WeightedEdge> sorted_edges;

  void kruskal() {
    HeuristicUF uf = new HeuristicUF(grf.N);
    for (int i=0; i<sorted_edges.size(); i++) {
      WeightedEdge we = sorted_edges.get(i);
      if (!uf.connected(we.u.id, we.v.id)) {
        mst_edge.add(we);
        uf.union(we.u.id, we.v.id);
      }
      if (mst_edge.size()==grf.N-1) {
        break;
      }
    }
  }

  ArrayList<WeightedEdge> mst_edge;

  int frm;
  @Override
    boolean hasNextFrame() {
    return frm<=mst_edge.size();
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

    if (frm<mst_edge.size())
      mst_edge.get(frm).display(6, color(250, 0, 0), 150);
    else
      noLoop();
    frm++;
    sleep(550-50*animation_speed);
  }

  @Override
    void terminate() {
      loop();
  }
}
