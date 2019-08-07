import java.util.PriorityQueue;
import java.util.Arrays;

public class DijkMulti implements Player {

  public DijkMulti(WeightedGraph graph) {
    grf=graph;
    spTo = new int[grf.N];
    path = new WeightedEdge[grf.N];

    eventQ=new ArrayList();
    dijk_edge=new ArrayList();
    vertex_covered=new ArrayList();

    live_disTo=new int[grf.N];
    Arrays.fill(live_disTo, Integer.MAX_VALUE);
    relax=new LinkedList();
    
    String input = takeMatchingInput("enter the vertices you want to start with, seperate by comma (e.g. 3,4,5)", "(\\d+,)+\\d+");
    if (input==null) return;
    String[] src = input.split(",");
    int[] s= new int[src.length];
    while (true) {
      for (int i=0; i<src.length; i++) {
        try {
          s[i]=Integer.parseInt(src[i]);
          if (s[i]>=grf.N) throw new NumberFormatException();
        }
        catch(NumberFormatException nfe) {
          showMessageDialog(null, src[i]+"is not a vertex, please re-enter", "Alert", ERROR_MESSAGE);
          input = takeMatchingInput("enter the vertices you want to start with, seperate by comma (e.g. 3,4,5)", "(\\d+,)+\\d+");
          if (input==null) return;
          src = input.split(",");
          s= new int[src.length];
        }
      }
      break;
    }

    dijkstra(s);
  }

  WeightedGraph grf;

  // after running, the answer will be stored in these two arrays
  int[] spTo;
  WeightedEdge[] path;

  void dijkstra(int[] s) {
    int[] dis = new int[grf.N];

    Arrays.fill(dis, Integer.MAX_VALUE);

    PriorityQueue<Integer> pq = new PriorityQueue();
    for (int i=0; i<s.length; i++) {
      dis[s[i]] = 0;
      pq.add(s[i]);
    }

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
          relax.addLast(new int[]{w, dis[w]});
        }
      }
    }
    spTo = dis;
  }

  ArrayList<Object> eventQ;
  ArrayList<WeightedEdge> dijk_edge;
  ArrayList<Integer> vertex_covered;
  
  int[] live_disTo;
  LinkedList<int[]> relax;
  
  int frm;

  @Override
    boolean hasNextFrame() {
    return frm<=eventQ.size();
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
    
    for (int i=0; i<grf.N; i++) {
      if (live_disTo[i]!=Integer.MAX_VALUE) {
        Vertex v=grf.vertices.get(i);
        textSize(20);
        fill(250,0,0,200);
        String dis=""+live_disTo[i];
        text(dis, v.loc.x-textWidth(dis)/2, v.loc.y);
      }
    }
    
    if(frm==eventQ.size()){
      noLoop();
      return;
    }

    if (eventQ.get(frm) instanceof WeightedEdge) {
      ((WeightedEdge)eventQ.get(frm)).display(6, color(250, 0, 0), 150);
      int[] update =relax.removeFirst();
      live_disTo[update[0]]=update[1];
      Vertex v=grf.vertices.get(update[0]);
      v.display(20, color(250, 250, 0), 150);
      textSize(30);
      text(""+update[1], v.loc.x, v.loc.y);
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
      loop();
  }
}
