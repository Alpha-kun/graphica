import java.awt.Color;
import javax.swing.JOptionPane;
import javax.swing.JColorChooser;
import java.util.regex.Pattern;
import java.lang.NumberFormatException;

public class EditActionListener implements ActionListener {

  @Override
    public void actionPerformed(ActionEvent e) {
    // TODO Auto-generated method stub

    switch(e.getActionCommand()) {
    case "vcolor":
      Color javaColor = JColorChooser.showDialog(null, "Java Color Chooser", Color.white);
      if (javaColor!=null) { 
        color c = color(javaColor.getRed(), javaColor.getGreen(), javaColor.getBlue());
        graph.setUniversalVertexColor(c);
      }
      break;
    case "vsize":
      graph.setUniversalVertexSize(takeInput("Please enter vertex size", 20, 5, 40));
      break;
    case "vsizebd":
      graph.setSizeByDegree();
      break;
    case "vfont":
      graph.setUniversalVertexIdFont(takeInput("Please enter vertex id font", 20, 5, 60));
      break;
    case "ecolor":
      Color javaColor1 = JColorChooser.showDialog(null, "Java Color Chooser", Color.white);
      if (javaColor1!=null) { 
        color c = color(javaColor1.getRed(), javaColor1.getGreen(), javaColor1.getBlue());
        graph.setUniversalEdgeColor(c);
      }
      break;
    case "ethickness":
      graph.setUniversalEdgeThickness(takeInput("Please enter edge thickness", 3, 1, 10));
      break;
    case "efont":
      if (graph instanceof WeightedGraph) {
        ((WeightedGraph)graph).setUniversalEdgeWeightFont(takeInput("Please enter edge weight font", 20, 5, 80));
      }
      break;
    case "erem":
      String input = takeMatchingInput("enter the edge to delete as pair of numbers, seperate by comma (e.g. 3,4)", "\\d+,\\d");
      if (input==null) return;
      String[] pair = input.split(",");
      try {
        graph.removeE(Integer.parseInt(pair[0]), Integer.parseInt(pair[1]));
      }
      catch(NumberFormatException nfe) {
        showMessageDialog(null, "you shall not break my code!!", "Alert", ERROR_MESSAGE);
      }
      break;
    case "complete":
      if (graph instanceof WeightedGraph) {
        boolean decision = takeInput("applying euclidean weights will remove all previously added edges, and moving of vertices will result in erroneous weight. Do you wish to proceed?", "Warning");
        if (decision) {
          println("go euclidean");
          ((WeightedGraph)graph).completeEuclidean();
        }
      } else {
        showMessageDialog(null, "Cannot apply euclidean weights to unweighted or directed graph", "Alert", ERROR_MESSAGE);
      }
      break;
    case "existing":
      if (graph instanceof WeightedGraph) {
        boolean decision = takeInput("applying euclidean weights will erase all previously entered edge weights, and moving of vertices will result in erroneous weight. Do you wish to proceed?", "Warning");
        if (decision) {
          println("go euclidean");
          ((WeightedGraph)graph).toEuclidean();
        }
      } else {
        showMessageDialog(null, "Cannot apply euclidean weights to unweighted or directed graph", "Alert", ERROR_MESSAGE);
      }
      break;
    case "range":
      if (graph instanceof WeightedGraph) {
        boolean decision = takeInput("applying euclidean weights will erase all previously entered edge weights, and moving of vertices will result in erroneous weight. Do you wish to proceed?", "Warning");
        if (decision) {
          println("go euclidean");
          ((WeightedGraph)graph).partialEuclidean(takeInput("please enter range", 150, 0, 1920));
        }
      } else {
        showMessageDialog(null, "Cannot apply euclidean weights to unweighted or directed graph", "Alert", ERROR_MESSAGE);
      }
      break;
    default:
      // no nothing code block
    }
  }
}
