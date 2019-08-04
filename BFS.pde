
public class BFS implements Player {

  public BFS(Graph grf) {
    g=grf;
    //prep for bfs
    edge_trace=new ArrayList<Edge>();
    vertex_trace = new LinkedList<Integer>();

    //prep for animation
    edge_covered = new ArrayList<Edge>();
    vertex_covered = new ArrayList<Integer>();

    //run dfs
    int id = takeInput("Please enter source vertex ID", 0, 0, g.N-1);
    bfs(id);
  }

  Graph g;

  ArrayList<Edge> edge_trace;
  LinkedList<Integer> vertex_trace;


  void bfs(int s) {
    println("start BFS");
    boolean[] marked =new boolean[g.N];
    LinkedList<Integer> Q=new LinkedList<Integer>();
    Q.addLast(s);
    marked[s]=true;
    while (!Q.isEmpty()) {
      int u = Q.removeFirst();
      for (Edge e : g.adjList.get(u)) {
        if (!marked[e.other(u)]) {
          Q.addLast(e.other(u));
          marked[e.other(u)]=true;
          edge_trace.add(e);
          vertex_trace.add(e.other(u));
        }
      }
    }
    println("end BFS");
  }

  ArrayList<Edge> edge_covered;
  ArrayList<Integer> vertex_covered;

  int frm;

  @Override
    boolean hasNextFrame() {
    return frm<edge_trace.size();
  }

  @Override
    void drawNextFrame() {
    background(40);
    println("drawing frame: "+frm);
    graph.display(3, color(200, 200, 200), 30, 10, color(250, 250, 250), 50);

    edge_covered.add(edge_trace.get(frm));
    vertex_covered.add(vertex_trace.removeFirst());
    for (Edge e : edge_covered) {
      e.display(4, color(200, 200, 200), 200);
    }

    for (int v : vertex_covered) {
      g.vertices.get(v).display(20, color(250, 250, 250), 100);
    }

    edge_trace.get(frm).display(6, color(250, 0, 0), 150);

    frm++;
    sleep(550-50*animation_speed);
  }
  
  @Override
  void terminate(){
    
  }
}
