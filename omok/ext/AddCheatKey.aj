package omok.ext;

import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;

import javax.swing.AbstractAction;
import javax.swing.ActionMap;
import javax.swing.InputMap;
import javax.swing.JComponent;
import javax.swing.KeyStroke;

import omok.base.BoardPanel;
import omok.model.Board;
import omok.model.Board.Place;

public privileged aspect AddCheatKey {
	pointcut createBP(BoardPanel bp):
		execution(BoardPanel BoardPanel(..))
		&& this(bp);

	after(BoardPanel bp): createBP(bp){
		ActionMap map = bp.getActionMap();
		int condition = JComponent.WHEN_IN_FOCUSED_WINDOW;
		InputMap inputMap = bp.getInputMap(condition);
		String reload = "Cheat";
		inputMap.put(KeyStroke.getKeyStroke(KeyEvent.VK_F5, 0), reload);
		map.put(reload, new KeyAction(bp, bp.board, reload));	
	}
	
	@SuppressWarnings("serial")
    private static class KeyAction extends AbstractAction {
       private final BoardPanel boardPanel;
       private final Board board;
       
       private KeyAction(BoardPanel boardPanel, Board board, String command) {
           this.boardPanel = boardPanel;
           this.board = board;
           putValue(ACTION_COMMAND_KEY, command);
       }
       
       /** Called when a cheat is requested. */
       public void actionPerformed(ActionEvent event) {
           // code to be run when the cheat (F5) key is pressed.
           // ...
    	   for(Place p: board.places()){
    		   
    	   }
       }   
    }
}

