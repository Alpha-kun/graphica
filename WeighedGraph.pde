import static javax.swing.JOptionPane.*;

public class WeightedGraph extends AbstractGraph {


  ArrayList<WeightedEdge> edges;
  ArrayList<ArrayList<WeightedEdge>> adjList;

  int N;
  int E;
  public WeightedGraph() {
    vertices = new ArrayList<Vertex>();
    edges = new ArrayList<WeightedEdge>();
    adjList = new ArrayList<ArrayList<WeightedEdge>>();
  } 

  @Override
    synchronized void addV(int x, int y) {
    vertices.add(new Vertex(x, y, N++));
    adjList.add(new ArrayList<WeightedEdge>());
  }

  @Override
    synchronized void addE(Vertex u, Vertex v) {
    int w=1;
    try {
      w= Integer.parseInt(showInputDialog("Please enter edge weight"));
    }
    catch(NumberFormatException e) {
    }
    E++;
    WeightedEdge e=new WeightedEdge(u, v, w);
    edges.add(e);
    adjList.get(u.id).add(e);
    adjList.get(v.id).add(e);
  }

  @Override
    synchronized void removeE(int a, int b) {

    WeightedEdge toBeRemoved=null;

    for (int i=0; i<E; i++) {
      WeightedEdge e = edges.get(i);
      if ((e.u.id==a&&e.v.id==b)||(e.u.id==b&&e.v.id==a)) {
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
    adjList.get(b).remove(toBeRemoved);
  }

  @Override
    synchronized void setUniversalEdgeColor(color clr) {
    for (WeightedEdge e : edges) {
      e.setColor(clr);
    }
  }

  @Override
    synchronized  void setUniversalEdgeThickness(int thk) {
    for (WeightedEdge e : edges) {
      e.setThickness(thk);
    }
  }

  synchronized void completeEuclidean() {
    edges=new ArrayList();
    E=N*(N-1)/2;
    for (int i=0; i<N; i++) {
      adjList.set(i, new ArrayList<WeightedEdge>());
    }
    for (int i=0; i<N; i++) {
      for (int j=i+1; j<N; j++) {
        Vertex u=vertices.get(i);
        Vertex v=vertices.get(j);        
        int w= (int)PVector.sub(u.loc, v.loc).mag();
        WeightedEdge e=new WeightedEdge(u, v, w);
        edges.add(e);
        adjList.get(i).add(e);
        adjList.get(j).add(e);
      }
    }
  }

  synchronized void partialEuclidean(int r) {
    E=0;
    edges=new ArrayList();
    for (int i=0; i<N; i++) {
      adjList.set(i, new ArrayList<WeightedEdge>());
    }
    for (int i=0; i<N; i++) {
      for (int j=i+1; j<N; j++) {
        Vertex u=vertices.get(i);
        Vertex v=vertices.get(j);        
        int w= (int)PVector.sub(u.loc, v.loc).mag();
        if (w>r) {
          continue;
        }
        E++;
        WeightedEdge e=new WeightedEdge(u, v, w);
        edges.add(e);
        adjList.get(i).add(e);
        adjList.get(j).add(e);
      }
    }
  }

  synchronized void toEuclidean() {
    for (WeightedEdge we : edges) {
      we.weight=(int)PVector.sub(we.u.loc, we.v.loc).mag();
    }
  }

  synchronized  void setUniversalEdgeWeightFont(int ft) {
    for (WeightedEdge v : edges) {
      v.weight_font=ft;
    }
  }

  @Override
    synchronized void display() {
    //draw edges
    strokeWeight(5.0);
    strokeCap(ROUND);
    stroke(150, 200, 0);
    for (WeightedEdge e : edges) {
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
    for (WeightedEdge e : edges) {
      e.display(edge_thickness, edge_color, edge_alpha);
    }

    //draw vertices
    strokeWeight(2.0);
    for (Vertex v : vertices) {
      v.display(vertex_size, vertex_color, vertex_alpha);
    }
  }

  @Override
    synchronized  void saveGraph(File dest) {
    PrintWriter output = createWriter(dest);
    //output basic info
    output.println("WG");
    output.println(N+" "+E);
    //output gemoetry info
    for (Vertex v : vertices) {
      output.println(v.loc.x+" "+v.loc.y);
    }
    //output edge info
    for (WeightedEdge e : edges) {
      output.println(e.u.id+" "+e.v.id+" "+e.weight);
    }
    output.flush();
    output.close();
  }

  @Override
    synchronized void openGraph(File src) throws IOException {
    vertices = new ArrayList<Vertex>();
    edges  =new ArrayList<WeightedEdge>();
    adjList = new ArrayList<ArrayList<WeightedEdge>>();

    BufferedReader reader = createReader(src);
    reader.readLine();//discharge file identifier
    StringTokenizer st = new StringTokenizer(reader.readLine());
    N=Integer.parseInt(st.nextToken());
    E=Integer.parseInt(st.nextToken());
    for (int i=0; i<N; i++) {
      st = new StringTokenizer(reader.readLine());
      vertices.add(new Vertex(Float.parseFloat(st.nextToken()), Float.parseFloat(st.nextToken()), i));
      adjList.add(new ArrayList<WeightedEdge>());
    }
    for (int i=0; i<E; i++) {
      st = new StringTokenizer(reader.readLine());
      int a=Integer.parseInt(st.nextToken());
      int b=Integer.parseInt(st.nextToken());
      int w=Integer.parseInt(st.nextToken()); 
      WeightedEdge e = new WeightedEdge(vertices.get(a), vertices.get(b), w);
      edges.add(e);
      adjList.get(a).add(e);
      adjList.get(b).add(e);
    }
  }

  @Override
    synchronized void importMTX(File src) throws IOException {

    vertices = new ArrayList<Vertex>();
    edges = new ArrayList<WeightedEdge>();
    adjList = new ArrayList<ArrayList<WeightedEdge>>();
    //sleep(500);
    BufferedReader reader = createReader(src);
    StringTokenizer st = new StringTokenizer(reader.readLine());
    N=Integer.parseInt(st.nextToken());
    E=Integer.parseInt(st.nextToken());
    for (int i=0; i<N; i++) {
      vertices.add(new Vertex(random(0, width), random(0, height), i));
      adjList.add(new ArrayList<WeightedEdge>());
    }
    for (int i=0; i<E; i++) {
      st = new StringTokenizer(reader.readLine());
      int a=Integer.parseInt(st.nextToken());
      int b=Integer.parseInt(st.nextToken());
      int w=Integer.parseInt(st.nextToken());
      WeightedEdge e = new WeightedEdge(vertices.get(a), vertices.get(b), w);
      edges.add(e);
      adjList.get(a).add(e);
      adjList.get(b).add(e);
    }
  }

  @Override
    synchronized  void exportMTX(File dest) {
    PrintWriter output = createWriter(dest);

    output.println(N+" "+E);

    for (WeightedEdge e : edges) {
      output.println(e.u.id+" "+e.v.id+" "+e.weight);
    }

    output.flush();
    output.close();
  }

  @Override
    protected void finalize() {
    println("a weighted graph is dead");
  }

  @Override
    void setUnusableMenu(boolean b) {
    setupWG(b);
  }
}
