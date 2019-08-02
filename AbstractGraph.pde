
public abstract class AbstractGraph {


  ArrayList<Vertex> vertices;

  int N;
  int E;

  public Vertex get(int x, int y) {
    for (Vertex v : vertices) {
      if (Math.hypot(x-v.loc.x, y-v.loc.y)<v.size) {
        return v;
      }
    }
    return null;
  }

  void setUniversalVertexIdFont(int ft) {
    for (Vertex v : vertices) {
      v.id_font=ft;
    }
  }

  void setUniversalVertexSize(int sz) {
    for (Vertex v : vertices) {
      v.size=sz;
    }
  }

  void setUniversalVertexColor(color clr) {
    for (Vertex v : vertices) {
      v.c=clr;
    }
  }
  
  abstract void setUniversalEdgeColor(color clr);
  
  abstract void setUniversalEdgeThickness(int thk);

  abstract void addV(int x, int y);

  abstract void addE(Vertex u, Vertex v);

  abstract void saveGraph(File dest);

  abstract void openGraph(File src) throws IOException;

  abstract void importMTX(File src) throws IOException;

  abstract void exportMTX(File dest);

  abstract void display();

  abstract void display(int edge_thickness, color edge_color, int edge_alpha, int vertex_size, color vertex_color, int vertex_alpha);
}
