import java.util.StringTokenizer;

public class Graph extends AbstractGraph {

  ArrayList<Edge> edges;
  ArrayList<ArrayList<Edge>> adjList;


  public Graph() {
    vertices = new ArrayList<Vertex>();
    edges = new ArrayList<Edge>();
    adjList = new ArrayList<ArrayList<Edge>>();
  } 

  @Override
    void addV(int x, int y) {
    vertices.add(new Vertex(x, y, N++));
    adjList.add(new ArrayList<Edge>());
  }

  @Override
    void addE(Vertex u, Vertex v) {
    E++;
    Edge e=new Edge(u, v);
    edges.add(e);
    adjList.get(u.id).add(e);
    adjList.get(v.id).add(e);
  }
  
  @Override
  void setUniversalEdgeColor(color clr){
    for(Edge e:edges){
      e.setColor(clr);
    }
  }
  
  @Override
  void setUniversalEdgeThickness(int thk){
    for(Edge e:edges){
      e.setThickness(thk);
    }
  }

  @Override
    synchronized void display() {
    //draw edges

    for (Edge e : edges) {//ConcurrentModificationException

      e.display();
    }

    //draw vertices
    strokeWeight(2.0);
    for (Vertex v : vertices) {
      v.display();
    }
  }

  @Override
    synchronized void display(int edge_thickness, color edge_color, int edge_alpha, int vertex_size, color vertex_color, int vertex_alpha) {
    //draw edges
    for (Edge e : edges) {
      e.display(edge_thickness, edge_color, edge_alpha);
    }

    //draw vertices
    strokeWeight(2.0);
    for (Vertex v : vertices) {
      v.display(vertex_size, vertex_color, vertex_alpha);
    }
  }

  @Override
    void saveGraph(File dest) {
    PrintWriter output = createWriter(dest);
    //output basic info
    output.println(N+" "+E);
    //output gemoetry info
    for (Vertex v : vertices) {
      output.println(v.loc.x+" "+v.loc.y);
    }
    //output edge info
    for (Edge e : edges) {
      output.println(e.u.id+" "+e.v.id);
    }
    output.flush();
    output.close();
  }

  @Override
    synchronized  void openGraph(File src) throws IOException {
    //println("executing "+Thread.currentThread().getName());
    vertices = new ArrayList<Vertex>();
    edges = new ArrayList<Edge>();
    adjList = new ArrayList<ArrayList<Edge>>();
    //sleep(500);
    BufferedReader reader = createReader(src);
    StringTokenizer st = new StringTokenizer(reader.readLine());
    N=Integer.parseInt(st.nextToken());
    E=Integer.parseInt(st.nextToken());
    for (int i=0; i<N; i++) {

      st = new StringTokenizer(reader.readLine());
      vertices.add(new Vertex(Float.parseFloat(st.nextToken()), Float.parseFloat(st.nextToken()), i));
      adjList.add(new ArrayList<Edge>());
    }
    for (int i=0; i<E; i++) {

      st = new StringTokenizer(reader.readLine());
      int a=Integer.parseInt(st.nextToken());
      int b=Integer.parseInt(st.nextToken());
      Edge e = new Edge(vertices.get(a), vertices.get(b));
      edges.add(e);
      adjList.get(a).add(e);
      adjList.get(b).add(e);
    }
    reader.close();
    //throw new IOException("checkmate");
  }

  @Override
    synchronized void importMTX(File src) throws IOException {

    vertices = new ArrayList<Vertex>();
    edges = new ArrayList<Edge>();
    adjList = new ArrayList<ArrayList<Edge>>();
    //sleep(500);
    BufferedReader reader = createReader(src);
    StringTokenizer st = new StringTokenizer(reader.readLine());
    N=Integer.parseInt(st.nextToken());
    E=Integer.parseInt(st.nextToken());
    for (int i=0; i<N; i++) {
      vertices.add(new Vertex(random(0, width), random(0, height), i));
      adjList.add(new ArrayList<Edge>());
    }
    for (int i=0; i<E; i++) {
      st = new StringTokenizer(reader.readLine());
      int a=Integer.parseInt(st.nextToken());
      int b=Integer.parseInt(st.nextToken());
      Edge e = new Edge(vertices.get(a), vertices.get(b));
      edges.add(e);
      adjList.get(a).add(e);
      adjList.get(b).add(e);
    }
    reader.close();
  }

  @Override
    void exportMTX(File dest) {
    PrintWriter output = createWriter(dest);
    output.println(N+" "+E);
    for (Edge e : edges) {
      output.println(e.u.id+" "+e.v.id);
    }
    output.flush();
    output.close();
  }
}
