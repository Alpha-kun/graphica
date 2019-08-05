import java.util.Comparator;
import java.util.Collections;

public class Cluster implements Player {

  public Cluster(WeightedGraph wg) {
    sorted_edges=new ArrayList<WeightedEdge>(wg.edges);
    graff=wg;

    Comparator<WeightedEdge> cpt = new Comparator<WeightedEdge>() {
      @Override
        int compare(WeightedEdge e1, WeightedEdge e2) {
        return Integer.compare(e1.weight, e2.weight);
      }
    };

    clusterNum =takeInput("Please enter desired number of clusters", 1, 1, wg.N);

    Collections.sort(sorted_edges, cpt);

    mst_edge=new ArrayList<WeightedEdge>();

    kruskal();
  }

  int clusterNum;

  WeightedGraph graff;

  ArrayList<WeightedEdge> sorted_edges;

  void kruskal() {
    HeuristicUF uf = new HeuristicUF(graff.N);
    for (int i=0; i<sorted_edges.size(); i++) {
      WeightedEdge we = sorted_edges.get(i);
      if (!uf.connected(we.u.id, we.v.id)) {
        mst_edge.add(we);
        uf.union(we.u.id, we.v.id);
      }
      if (mst_edge.size()==graff.N-clusterNum) {
        break;
      }
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
    graff.display(3, color(200, 200, 200), 30, 10, color(250, 250, 250), 50);

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
  void terminate(){
    
  }
}
