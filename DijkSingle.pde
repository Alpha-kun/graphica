
public class DijkSingle implements Player {

  public DijkSingle(WeightedGraph graph) {
    grf=graph;
    spTo = new int[grf.N];
    path = new WeightedEdge[grf.N];

    eventQ=new ArrayList();
    dijk_edge=new ArrayList();
    vertex_covered=new ArrayList();
    
    int s = takeInput("Please enter the vertex to start with", 0, 0, graph.N-1);
    dijkstra(s);
  }

  WeightedGraph grf;

  // after running, the answer will be stored in these two arrays
  int[] spTo;
  WeightedEdge[] path;

  void dijkstra(int s) {
    int[] dis = new int[grf.N];

    Arrays.fill(dis, Integer.MAX_VALUE);

    PriorityQueue<Integer> pq = new PriorityQueue();
    dis[s] = 0;

    pq.add(s);
    while (!pq.isEmpty()) {
      int code = pq.poll();
      // code is consist of two parts, the first part indicates a known
      // distance to a vertex, times 1024, plus the second part, which
      // indicated the id of that vertex.
      // As long as the number of vertex don't exceed 1024, this
      // implementation will work correctly.
      int dist = code >>> 10;
      int v = code & 0x3FF;
      if (dist != dis[v]) {
        continue;
      }
      eventQ.add(v);
      for (WeightedEdge e : grf.adjList.get(v)) {
        int w = e.other(v);
        if (dis[v] + e.weight < dis[w]) {
          dis[w] = dis[v] + e.weight;
          path[w] = e;
          pq.add(dis[w] << 10 | w);
          eventQ.add(e);
        }
      }
    }
    spTo = dis;
  }

  ArrayList<Object> eventQ;
  ArrayList<WeightedEdge> dijk_edge;
  ArrayList<Integer> vertex_covered;
  int frm;

  @Override
    boolean hasNextFrame() {
    return frm<eventQ.size();
  }

  @Override
    void drawNextFrame() {
    background(40);
    println("drawing frame: "+frm);
    graph.display(3, color(200, 200, 200), 30, 10, color(250, 250, 250), 50);

    for (WeightedEdge we : dijk_edge) {
      we.display(4, color(200, 200, 200), 200);
    }

    for (int v : vertex_covered) {
      grf.vertices.get(v).display(20, color(250, 250, 250), 100);
    }

    if (eventQ.get(frm) instanceof WeightedEdge) {
      ((WeightedEdge)eventQ.get(frm)).display(6, color(250, 0, 0), 150);
    } else {
      int vtx = (Integer)eventQ.get(frm);
      grf.vertices.get(vtx).display(30, color(250, 0, 0), 150);
      vertex_covered.add(vtx);
      if (path[vtx]!=null) {
        dijk_edge.add(path[vtx]);
      }
    }

    frm++;
    sleep(550-50*animation_speed);
  }

  @Override
    void terminate() {
  }
}
