import controlP5.*;

import java.awt.MenuBar;
import java.awt.Menu;
import java.awt.MenuItem;
import processing.awt.PSurfaceAWT;

ControlP5 cp5;

AbstractGraph graph;

void setup() {
  size(1920, 1080);
  background(50);
  
  PImage icon = loadImage("icon_2.png");
  surface.setIcon(icon);
  //noStroke();

  cp5 = new ControlP5(this);

  setupMenu();

  graph = new Graph();
}

void setupMenu() {
  MenuBar mbar = new MenuBar();

  //===============File Menu===============
  Menu menu_file = new Menu("File");
  Menu menu_export = new Menu("Export");
  Menu menu_new = new Menu("New");

  MenuItem item_graph = new MenuItem("Graph");
  MenuItem item_wgraph = new MenuItem("Weighted Graph");
  MenuItem item_open = new MenuItem("Open");
  MenuItem item_save = new MenuItem("Save");
  MenuItem item_import = new MenuItem("Import");
  MenuItem item_image = new MenuItem("Image");
  MenuItem item_mtx = new MenuItem("MTX file");

  menu_new.add(item_graph);
  menu_new.add(item_wgraph);
  menu_export.add(item_image);
  menu_export.add(item_mtx);

  mbar.add(menu_file);

  menu_file.add(menu_new);
  menu_file.add(item_open);
  menu_file.add(item_save);
  menu_file.add(item_import);
  menu_file.add(menu_export);

  FileActionListener fal = new FileActionListener();

  item_graph.setActionCommand("graph");
  item_wgraph.setActionCommand("wgraph");
  item_open.setActionCommand("open");
  item_save.setActionCommand("save");
  item_import.setActionCommand("import");
  item_image.setActionCommand("image");
  item_mtx.setActionCommand("mtx");

  item_graph.addActionListener(fal);
  item_wgraph.addActionListener(fal);
  item_open.addActionListener(fal);
  item_save.addActionListener(fal);
  item_import.addActionListener(fal);
  item_image.addActionListener(fal);
  item_mtx.addActionListener(fal);

  //===============Edit Menu===============
  Menu menu_edit = new Menu("Edit");
  Menu menu_vertex = new Menu("Vertex");
  Menu menu_edge = new Menu("Edge");
  Menu menu_euclidean = new Menu("Apply euclidean weight");
  
  MenuItem item_vcolor = new MenuItem("Color");
  MenuItem item_vsize = new MenuItem("Size");
  MenuItem item_vfont = new MenuItem("Id font");
  MenuItem item_ecolor = new MenuItem("Color");
  MenuItem item_efont = new MenuItem("Weight font");
  MenuItem item_ethickness = new MenuItem("Thickness");
  MenuItem item_existing = new MenuItem("to existing edges");
  MenuItem item_complete = new MenuItem("to complete graph");

  menu_vertex.add(item_vcolor);
  menu_vertex.add(item_vsize);
  menu_vertex.add(item_vfont);
  menu_edge.add(item_ecolor);
  menu_edge.add(item_ethickness);
  menu_edge.add(item_efont);
  menu_euclidean.add(item_existing);
  menu_euclidean.add(item_complete);


  mbar.add(menu_edit);

  menu_edit.add(menu_vertex);
  menu_edit.add(menu_edge);
  menu_edit.add(menu_euclidean);


  EditActionListener eal = new EditActionListener();

  item_vcolor.setActionCommand("vcolor");
  item_vsize.setActionCommand("vsize");
  item_vfont.setActionCommand("vfont");
  item_ecolor.setActionCommand("ecolor");
  item_ethickness.setActionCommand("ethickness");
  item_existing.setActionCommand("existing");
  item_complete.setActionCommand("complete");
  item_efont.setActionCommand("efont");


  item_vcolor.addActionListener(eal);
  item_vsize.addActionListener(eal);
  item_vfont.addActionListener(eal);
  item_ecolor.addActionListener(eal);
  item_ethickness.addActionListener(eal);
  item_efont.addActionListener(eal);
  item_existing.addActionListener(eal);
  item_complete.addActionListener(eal);

  //===============Algorithm Menu===============
  Menu menu_algorithm = new Menu("Algorithm");

  Menu menu_floodfill = new Menu("Floodfill");
  Menu menu_mst = new Menu("MST");
  Menu menu_sp = new Menu("SP");

  MenuItem item_dfs = new MenuItem("DFS");
  MenuItem item_bfs = new MenuItem("BFS");
  MenuItem item_kruskal = new MenuItem("Kruskal's");
  MenuItem item_prim = new MenuItem("Prim's");
  MenuItem item_cluster = new MenuItem("Cluster");
  MenuItem item_dijkstra = new MenuItem("Dijkstra");

  menu_floodfill.add(item_dfs);
  menu_floodfill.add(item_bfs);
  menu_mst.add(item_kruskal);
  menu_mst.add(item_prim);
  menu_mst.add(item_cluster);
  menu_sp.add(item_dijkstra);

  mbar.add(menu_algorithm);

  menu_floodfill.add(item_dfs);
  menu_floodfill.add(item_bfs);
  menu_mst.add(item_kruskal);
  menu_mst.add(item_prim);
  menu_mst.add(item_cluster);
  menu_sp.add(item_dijkstra);

  menu_algorithm.add(menu_floodfill);
  menu_algorithm.add(menu_mst);
  menu_algorithm.add(menu_sp);

  AlgoActionListener aal = new AlgoActionListener();

  item_dfs.setActionCommand("dfs");
  item_bfs.setActionCommand("bfs");
  item_kruskal.setActionCommand("kruskal");
  item_prim.setActionCommand("prim");
  item_cluster.setActionCommand("cluster");
  item_dijkstra.setActionCommand("dijkstra");

  item_dfs.addActionListener(aal);
  item_bfs.addActionListener(aal);
  item_kruskal.addActionListener(aal);
  item_prim.addActionListener(aal);
  item_cluster.addActionListener(aal);
  item_dijkstra.addActionListener(aal);

  //===============Animation Menu===============
  Menu menu_animation = new Menu("Animation");

  MenuItem item_speed = new MenuItem("Speed");
  MenuItem item_render = new MenuItem("Render to image sequence");
  MenuItem item_physics = new MenuItem("Run physics");
  MenuItem item_physics2 = new MenuItem("Run physics2");

  mbar.add(menu_animation);

  menu_animation.add(item_speed);
  menu_animation.add(item_render);
  menu_animation.add(item_physics);
  menu_animation.add(item_physics2);

  AnimationActionListener anime = new AnimationActionListener();

  item_speed.setActionCommand("speed");
  item_render.setActionCommand("render");
  item_physics.setActionCommand("physics");
  item_physics2.setActionCommand("physics2");

  item_speed.addActionListener(anime);
  item_render.addActionListener(anime);
  item_physics.addActionListener(anime);
  item_physics2.addActionListener(anime);

  PSurfaceAWT awtSurface = (PSurfaceAWT)surface;
  PSurfaceAWT.SmoothCanvas smoothCanvas = (PSurfaceAWT.SmoothCanvas)awtSurface.getNative();
  smoothCanvas.getFrame().setMenuBar(mbar);
}

int mode;
static final int VERTEX_MODE = 0;
static final int EDGE_MODE = 1;
static final int VERTEX_EDIT_MODE = 0;
static final int ANIMATION_MODE = 3;

int animation_speed = 8;
Player algoPlayer;

void terminateCurrentAlgoPlayer(){
  if (algoPlayer!=null) {
    println("terminate previous player");
    algoPlayer.terminate();
  }
  algoPlayer=null;
}

void setAlgoPlayer(Player plyr) {
  terminateCurrentAlgoPlayer();
  algoPlayer=plyr;
}

void draw() {
  fill(40, 20);
  rect(0, 0, width, height);


  if (algoPlayer!=null) {
    mode = ANIMATION_MODE;
    if (algoPlayer.hasNextFrame()) {
      algoPlayer.drawNextFrame();
    } else {
      algoPlayer.terminate();
      algoPlayer = null;
    }
  } else {
    graph.display();
  }

  strokeWeight(5.0);
  strokeCap(ROUND);
  stroke(150, 200, 0);

  if (firstV!=null) {
    line(firstV.loc.x, firstV.loc.y, mouseX, mouseY);
  }
}

Vertex firstV;
void mouseClicked() {
  if (mode == VERTEX_MODE) {
    graph.addV(mouseX, mouseY);
    println("add new v");
  } else if (mode == ANIMATION_MODE) {

    println("do nothing");
  } else if (mode==EDGE_MODE) {
    if (firstV==null) {
      firstV = graph.get(mouseX, mouseY);
    } else {
      Vertex secondV = graph.get(mouseX, mouseY);
      //we currently don't allow self-loop
      if (secondV==firstV) {
        firstV=null;
        return;
      }
      if (secondV!=null) {
        println("edge is added");
        graph.addE(firstV, secondV);
        firstV=null;
      }
    }
  }
}

Vertex selected;
void mousePressed() {
  selected = graph.get(mouseX, mouseY);
}

void mouseDragged() {
  if (selected!=null) {
    selected.setLoc(mouseX, mouseY);
  }
}

void keyPressed() {
  println("detected key press: "+key);
  println(Thread.currentThread().getName());
  switch(key) {
  case 'a':
    algoPlayer.terminate();
    algoPlayer=null;
    break;
  case 'v':
    println("switch to vertex mode");
    mode=VERTEX_MODE;
    break;
  case 'e':
    println("switch to edge mode");
    mode=EDGE_MODE;
    break;
  case 's':
    selectInput("Select a file to process:", "fileSelected", new File("goodDay.txt"));
    mode=EDGE_MODE;
    break;
  default:
    // code block
  }
}


void drawArrow(int cx, int cy, int len, float angle) {
  pushMatrix();
  translate(cx, cy);
  rotate(radians(angle));
  line(0, 0, len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  popMatrix();
}

void sleep(long milli) {
  try {
    Thread.sleep(milli);
  }
  catch(InterruptedException e) {
  }
}

int takeInput(String msg, int def, int min, int max) {
  int val=def;
  try {
    val= Integer.parseInt(showInputDialog(msg));
  }
  catch(NumberFormatException e) {
    showMessageDialog(null, "Invalid input, value set to default: " + def, "Alert", ERROR_MESSAGE);
  }
  finally {
    //return def;
  }
  if (val <min||max<val) {
    showMessageDialog(null, "Invalid input, value set to default: " + def, "Alert", ERROR_MESSAGE);
    return def;
  }
  return val;
}

boolean takeInput(String msg, String title) {
  int dialogButton = JOptionPane.YES_NO_OPTION;
  int dialogResult = JOptionPane.showConfirmDialog (null, msg, title, dialogButton);
  return dialogResult == JOptionPane.YES_OPTION;
}
