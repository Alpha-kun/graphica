
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class AnimationActionListener implements ActionListener {

  @Override
    public void actionPerformed(ActionEvent e) {
    // TODO Auto-generated method stub

    switch(e.getActionCommand()) {
    case "speed":
      animation_speed=takeInput("Enter animation speed (1-10): ", 5, 1, 10);
      break;
    case "render":
      println("the user wants to render image");  
      break;
    case "physics":
      setAlgoPlayer(new Physics((Graph)graph));  
      break;
    case "physics2":
      setAlgoPlayer(new Physics2((Graph)graph));  
      break;
    default:
      //do nothing
    }
  }
}
