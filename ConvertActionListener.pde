public class ConvertActionListener implements ActionListener {

  @Override
    public void actionPerformed(ActionEvent e) {
    // TODO Auto-generated method stub

    switch(e.getActionCommand()) {
    case "PL":
      //convert to plain graph
      break;
    case "WG":
      //convert to weighted graph
      break;
    default:
      // no nothing code block
    }
  }
}
