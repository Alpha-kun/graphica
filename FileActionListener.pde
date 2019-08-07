
public class FileActionListener implements ActionListener {

  @Override
    public void actionPerformed(ActionEvent e) {
    // TODO Auto-generated method stub

    switch(e.getActionCommand()) {
    case "graph":
      setupGraph(new Graph());
      break;
    case "wgraph":
      setupGraph(new WeightedGraph());
      break;
    case "digraph":
      setupGraph(new DiGraph());
      break;
    case "wdigraph":
      setupGraph(new WeightedDiGraph());
      break;
    case "save":
      saveGraph();
      break;
    case "open":
      openGraph();
      break;
    case "import":
      importMTX();
      break;
    case "image":
      saveImage();
      break;
    case "mtx":
      exportMTX();
      break;
    default:
      // no nothing code block
    }
  }


  void saveGraph() {
    selectInput("Select a file to process:", "writeGraph", new File("default.graph"));
  }


  void openGraph() {
    selectInput("Select a file to process:", "readGraph");
  }

  void saveImage() {
    selectInput("Select a file to process:", "writeImage", new File("default.png"));
  }

  void importMTX() {
    selectInput("Select a file to process:", "readMTX", new File("default.mtx"));
  }

  void exportMTX() {
    selectInput("Select a file to process:", "writeMTX", new File("default.mtx"));
  }
}
