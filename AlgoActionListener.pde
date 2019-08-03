
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class AlgoActionListener implements ActionListener {

  @Override
    public void actionPerformed(ActionEvent e) {
    // TODO Auto-generated method stub

    switch(e.getActionCommand()) {
    case "dfs":
      setAlgoPlayer(new DFS((Graph)graph));
      break;
    case "bfs":
      setAlgoPlayer(new BFS((Graph)graph));
      break;
    case "kruskal":
      if (graph instanceof WeightedGraph) {
        setAlgoPlayer(new Kruskals((WeightedGraph)graph));
      } else {
        showMessageDialog(null, "Cannot run MST algorithms on a unweighted or directed graph", "Alert", ERROR_MESSAGE);
      }
      break;
    case "prim":
      if (graph instanceof WeightedGraph) {
        setAlgoPlayer(new Prims((WeightedGraph)graph));
      } else {
        showMessageDialog(null, "Cannot run MST algorithms on a unweighted or directed graph", "Alert", ERROR_MESSAGE);
      }
      break;
    case "cluster":
      if (graph instanceof WeightedGraph) {
        setAlgoPlayer(new Cluster((WeightedGraph)graph));
      } else {
        showMessageDialog(null, "Cannot run MST algorithms on a unweighted or directed graph", "Alert", ERROR_MESSAGE);
      }
      break;
    case "single":
      if (graph instanceof WeightedGraph) {
        setAlgoPlayer(new DijkSingle((WeightedGraph)graph));
      } else {
        showMessageDialog(null, "Cannot run Dijkstra algorithms on a unweighted graph", "Alert", ERROR_MESSAGE);
      }
      break;
    case "multi":
      if (graph instanceof WeightedGraph) {
        setAlgoPlayer(new DijkMulti((WeightedGraph)graph));
      } else {
        showMessageDialog(null, "Cannot run Dijkstra algorithms on a unweighted graph", "Alert", ERROR_MESSAGE);
      }
      break;
    default:
      // no nothing code block
    }
  }
}
