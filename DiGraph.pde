
public class DiGraph extends AbstractGraph {

  ArrayList<DiEdge> edges;
  ArrayList<ArrayList<DiEdge>> adjList;


  public DiGraph() {
    vertices = new ArrayList<Vertex>();
    edges = new ArrayList<DiEdge>();
    adjList = new ArrayList<ArrayList<DiEdge>>();
  } 

  @Override
    synchronized void addV(int x, int y) {
    vertices.add(new Vertex(x, y, N++));
    adjList.add(new ArrayList<DiEdge>());
  }

  @Override
    synchronized void addE(Vertex u, Vertex v) {
    E++;
    DiEdge e=new DiEdge(u, v);
    edges.add(e);
    adjList.get(u.id).add(e);
  }

  @Override
    synchronized void removeE(int a, int b) {

    DiEdge toBeRemoved=null;

    for (int i=0; i<E; i++) {
      DiEdge e = edges.get(i);
      if (e.u.id==a&&e.v.id==b) {
        toBeRemoved=edges.remove(i);
        break;
      }
    }

    if (toBeRemoved==null) {
      showMessageDialog(null, String.format("the edge (%d,%d) does not exist!", a, b), "Alert", ERROR_MESSAGE);
      return;
    }

    E--;
    adjList.get(a).remove(toBeRemoved);
  }

  @Override
    synchronized void setUniversalEdgeColor(color clr) {
    for (DiEdge e : edges) {
      e.setColor(clr);
    }
  }

  @Override
    synchronized void setUniversalEdgeThickness(int thk) {
    for (DiEdge e : edges) {
      e.setThickness(thk);
    }
  }

  @Override
    synchronized void setSizeByDegree() {
    int min=Integer.MAX_VALUE;
    int max=-1;
    for (int i=0; i<N; i++) {
      min=min(min, adjList.get(i).size());
      max=max(max, adjList.get(i).size());
    }
    println(String.format("%d,%d", min, max));
    if (min==max)return;
    for (int i=0; i<N; i++) {
      Vertex v = vertices.get(i);
      float factor = 1.0*(adjList.get(i).size()-min)/(max-min);
      println(factor);
      v.size=(int)(10+40.0*factor);
    }
  }

  @Override
    synchronized void display() {
    //draw edges

    for (DiEdge e : edges) {//ConcurrentModificationException
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
    for (DiEdge e : edges) {
      e.display(edge_thickness, edge_color, edge_alpha);
    }

    //draw vertices
    strokeWeight(2.0);
    for (Vertex v : vertices) {
      v.display(vertex_size, vertex_color, vertex_alpha);
    }
  }

  @Override
    synchronized void saveGraph(File dest) {
    PrintWriter output = createWriter(dest);
    //output basic info
    output.println("DG");
    output.println(N+" "+E);
    //output gemoetry info
    for (Vertex v : vertices) {
      output.println(v.loc.x+" "+v.loc.y);
    }
    //output edge info
    for (DiEdge e : edges) {
      output.println(e.u.id+" "+e.v.id);
    }
    output.flush();
    output.close();
  }

  @Override
    synchronized void openGraph(File src) throws IOException {
    //println("executing "+Thread.currentThread().getName());
    vertices = new ArrayList<Vertex>();
    edges = new ArrayList<DiEdge>();
    adjList = new ArrayList<ArrayList<DiEdge>>();
    //sleep(500);
    BufferedReader reader = createReader(src);
    reader.readLine();//discharge file identifier
    StringTokenizer st = new StringTokenizer(reader.readLine());
    N=Integer.parseInt(st.nextToken());
    E=Integer.parseInt(st.nextToken());
    for (int i=0; i<N; i++) {

      st = new StringTokenizer(reader.readLine());
      vertices.add(new Vertex(Float.parseFloat(st.nextToken()), Float.parseFloat(st.nextToken()), i));
      adjList.add(new ArrayList<DiEdge>());
    }
    for (int i=0; i<E; i++) {

      st = new StringTokenizer(reader.readLine());
      int a=Integer.parseInt(st.nextToken());
      int b=Integer.parseInt(st.nextToken());
      DiEdge e = new DiEdge(vertices.get(a), vertices.get(b));
      edges.add(e);
      adjList.get(a).add(e);
    }
    reader.close();
    //throw new IOException("checkmate");
  }

  @Override
    synchronized void importMTX(File src) throws IOException {

    vertices = new ArrayList<Vertex>();
    edges = new ArrayList<DiEdge>();
    adjList = new ArrayList<ArrayList<DiEdge>>();
    //sleep(500);
    BufferedReader reader = createReader(src);
    StringTokenizer st = new StringTokenizer(reader.readLine());
    N=Integer.parseInt(st.nextToken());
    E=Integer.parseInt(st.nextToken());
    for (int i=0; i<N; i++) {
      vertices.add(new Vertex(random(0, width), random(0, height), i));
      adjList.add(new ArrayList<DiEdge>());
    }
    for (int i=0; i<E; i++) {
      st = new StringTokenizer(reader.readLine());
      int a=Integer.parseInt(st.nextToken());
      int b=Integer.parseInt(st.nextToken());
      DiEdge e = new DiEdge(vertices.get(a), vertices.get(b));
      edges.add(e);
      adjList.get(a).add(e);
    }
    reader.close();
  }

  @Override
    synchronized void exportMTX(File dest) {
    PrintWriter output = createWriter(dest);
    output.println(N+" "+E);
    for (DiEdge e : edges) {
      output.println(e.u.id+" "+e.v.id);
    }
    output.flush();
    output.close();
  }

  @Override
    protected void finalize() {
    println("a graph is dead");
  }

  @Override
    void setUnusableMenu(boolean b) {
    setupDG(b);
  }
}
