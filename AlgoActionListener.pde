
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class AlgoActionListener implements ActionListener {

  @Override
    public void actionPerformed(ActionEvent e) {
    // TODO Auto-generated method stub

    switch(e.getActionCommand()) {
    case "dfs":
      println("the user wants to flood fill dfs");
      setAlgoPlayer(new DFS((Graph)graph));
      break;
    case "bfs":
      println("the user wants to flood fill bfs");
      setAlgoPlayer( new BFS((Graph)graph));
      break;
    case "kruskal":
      if (graph instanceof WeightedGraph) {
        setAlgoPlayer(new Kruskals((WeightedGraph)graph));
      } else {
        showMessageDialog(null, "Can only run MST algorithms on a weighted or undirected graph", "Alert", ERROR_MESSAGE);
      }
      break;
    case "prim":
      if (graph instanceof WeightedGraph) {
        setAlgoPlayer(new Prims((WeightedGraph)graph));
      } else {
        showMessageDialog(null, "Can only run MST algorithms on a weighted or undirected graph", "Alert", ERROR_MESSAGE);
      }
      break;
    case "cluster":
      if (graph instanceof WeightedGraph) {
        setAlgoPlayer(new Cluster((WeightedGraph)graph));
      } else {
        showMessageDialog(null, "Can only run MST algorithms on a weighted or undirected graph", "Alert", ERROR_MESSAGE);
      }
      break;
    case "single":
      if (graph instanceof WeightedGraph) {
        setAlgoPlayer(new DijkSingle((WeightedGraph)graph));
      } else {
        showMessageDialog(null, "Can only run MST algorithms on a weighted or undirected graph", "Alert", ERROR_MESSAGE);
      }
      break;
    case "multi":
      println("the user wants to dijkstra multiple source");
      break;
    default:
      // no nothing code block
    }
  }
}
