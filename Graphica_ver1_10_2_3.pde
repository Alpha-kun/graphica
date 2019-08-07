import controlP5.*;

import java.awt.MenuBar;
import java.awt.Menu;
import java.awt.MenuItem;
import processing.awt.PSurfaceAWT;

ControlP5 cp5;

AbstractGraph graph;

void setupGraph(AbstractGraph ag) {
  if (graph!=null) {
    graph.setUnusableMenu(true);
  }
  graph=ag;
  graph.setUnusableMenu(false);
}

void setup() {
  size(1920, 1080);
  background(50);

  PImage icon = loadImage("icon_2.png");
  surface.setIcon(icon);
  //noStroke();

  cp5 = new ControlP5(this);

  setupMenu();
  setupGraph(new Graph());
}



int mode;
static final int VERTEX_MODE = 0;
static final int EDGE_MODE = 1;
static final int VERTEX_EDIT_MODE = 0;
static final int ANIMATION_MODE = 3;

int animation_speed = 8;
Player algoPlayer;

void terminateCurrentAlgoPlayer() {
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
    if (algoPlayer!=null) {
      algoPlayer.terminate();
      algoPlayer=null;
    }
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

void drawArrow(PVector s, PVector t) {
  pushMatrix();
  translate(s.x, s.y);
  PVector arr = PVector.sub(t, s);
  rotate(arr.heading());
  line(0, 0, arr.mag(), 0);
  line(arr.mag(), 0, arr.mag() - 16, -16);
  line(arr.mag(), 0, arr.mag() - 16, 16);
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

String takeMatchingInput(String msg, String reg) {
  String input = showInputDialog(msg);
  while (!Pattern.matches(reg, input)) {
    println(input+" does not match "+reg);
    showMessageDialog(null, "This must be fake input, please re-enter", "Alert", ERROR_MESSAGE);
    input = showInputDialog(msg);
    if (input==null) return null;
  }
  return input;
}

boolean takeInput(String msg, String title) {
  int dialogButton = JOptionPane.YES_NO_OPTION;
  int dialogResult = JOptionPane.showConfirmDialog (null, msg, title, dialogButton);
  return dialogResult == JOptionPane.YES_OPTION;
}
