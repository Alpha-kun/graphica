
public class Physics implements Player {

  float equilen = 150;
  float tension = 0.25;
  float drag = 0.75; 
  boolean repel=true;
  float repstr=5;
  CheckBox cb;
  
  public Physics(Graph grf) {
    g=grf;

    cp5.addSlider("equilibrium edge length", 0, 300, 100, 20, 100, 150, 20);
    cp5.addSlider("edge tension strength", 0, 20, 8, 20, 150, 150, 20);
    cp5.addSlider("drag factor", 0, 1, 0.75, 20, 200, 150, 20);
    cb=cp5.addCheckBox("checkBox").setPosition(20, 250).setSize(20, 20).addItem("apply repulsion", 0);
    cp5.addSlider("repulsion strength", 0, 20, 5, 20, 300, 150, 20);

    velocity = new PVector[g.N];
    for (int i = 0; i<g.N; i++) {
      velocity[i]=new PVector(0, 0);
    }
    accl = new PVector[g.N];
  }

  PVector[] velocity;
  PVector[] accl;

  Graph g;

  @Override
    boolean hasNextFrame() {
    return true;
  }

  int frame;



  @Override
    void drawNextFrame() {
    equilen=cp5.getController("equilibrium edge length").getValue();//<==============================
    tension=cp5.getController("edge tension strength").getValue();
    drag=cp5.getController("drag factor").getValue();
    repstr=cp5.getController("repulsion strength").getValue();
    repel = cb.getState(0);
    //println("====frame "+frame+"====");
    for (int i =0; i<g.N; i++) {
      Vertex v = g.vertices.get(i);
      //println("--vertex "+i+"--");

      //update a using x
      PVector nacl = new PVector(0, 0);
      for (Edge e : g.adjList.get(i)) {
        PVector eg = PVector.sub(e.other(v).loc, v.loc);
        //println("eg"+eg);
        eg.setMag(tension*ln(eg.mag()/equilen));
        nacl.add(eg);
      }

      if (repel) {
        for (int j=0; j<g.N; j++) {
          if (i==j)continue;
          Vertex u = g.vertices.get(j);
          PVector rpl = PVector.sub(v.loc, u.loc);
          rpl.setMag(repstr/rpl.mag());
          nacl.add(rpl);
        }
      }
      accl[i]= nacl;
      //println("nacl"+nacl);

      //update x using v and a
      v.loc.add(velocity[i]);

      //update v using a
      velocity[i].add(accl[i]);
      velocity[i].mult(drag);
      //println("velocity" +v);
    }

    g.display();
  }

  @Override
    void terminate() {
      cp5.getController("equilibrium edge length").remove();
      cp5.getController("edge tension strength").remove();
      cp5.getController("drag factor").remove();
      cp5.getController("repulsion strength").remove();
      cb.remove();
  }

  final float ln10 = 1.0/log((float)Math.E);

  float ln(float x) {
    return ln10*log(x);
  }
}
