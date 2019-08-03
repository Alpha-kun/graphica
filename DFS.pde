import java.util.Stack;
import java.util.LinkedList;

public class DFS implements Player {


  public DFS(Graph grf) {
    g=grf;
    //prep for dfs
    marked=new boolean[g.N];

    edge_trace=new ArrayList<Edge>();
    edge_operation=new ArrayList<Boolean>();
    vertex_trace = new LinkedList<Integer>();

    //prep for animation
    edge_stack=new Stack<Edge>();
    edge_covered = new ArrayList<Edge>();
    vertex_covered = new ArrayList<Integer>();

    //run dfs
    int id = takeInput("Please enter source vertex ID",0,0,g.N-1);
    dfs(id);
  }

  Graph g;

  boolean[] marked;

  static final boolean PUSH = true;
  static final boolean POP = false;

  void dfs(int s) {
    marked[s]=true;

    for (Edge e : g.adjList.get(s)) {
      if (!marked[e.other(s)]) {

        edge_trace.add(e);
        edge_operation.add(PUSH);
        vertex_trace.addLast(e.other(s));

        dfs(e.other(s));

        edge_trace.add(e);
        edge_operation.add(POP);
      }
    }
  }



  ArrayList<Edge> edge_trace;
  ArrayList<Boolean> edge_operation;
  LinkedList<Integer> vertex_trace;

  int frm;

  @Override
    boolean hasNextFrame() {
    return frm<edge_operation.size();
  }


  Stack<Edge> edge_stack;
  ArrayList<Edge> edge_covered;
  ArrayList<Integer> vertex_covered;

  @Override
    void drawNextFrame() {
    background(40);
    println("drawing frame: "+frm);
    graph.display(3, color(200, 200, 200), 30, 10, color(250, 250, 250), 50);



    if (edge_operation.get(frm)==PUSH) {
      edge_stack.push(edge_trace.get(frm));
      vertex_covered.add(vertex_trace.removeFirst());
      edge_covered.add(edge_trace.get(frm));
    } else {
      edge_stack.pop();
    }

    for (Edge e : edge_covered) {
      e.display(4, color(200, 200, 200), 200);
    }

    for (int v : vertex_covered) {
      g.vertices.get(v).display(20, color(250, 250, 250), 100);
    }

    for (Edge e : edge_stack) {
      e.display(6, color(250, 0, 0), 255);
    }

    frm++;
    sleep(550-50*animation_speed);
  }
  
  @Override
  void terminate(){
    
  }
}
