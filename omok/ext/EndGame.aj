package omok.ext;

import java.awt.*;

import java.awt.event.ActionEvent;

import omok.base.BoardPanel;
import omok.base.OmokDialog;
import omok.model.Board;
import omok.model.Board.Place;
import omok.model.Player;

public privileged aspect EndGame {
	
	//Around used to stop the makeMove is the game is over
		void around(OmokDialog dialog): this(dialog)
	    && execution(void OmokDialog.makeMove(..)) 
	    {
			if (dialog.board.isGameOver()) 
			{ 
				return;
			}
			else
				 proceed(dialog);
		}
	
	
	pointcut makeMove(OmokDialog od):
		execution(void makeMove(Place))
		&& this(od);
	
	pointcut newGame(OmokDialog od): 
		execution(void OmokDialog.playButtonClicked(ActionEvent)) 
		&& target(od); 
	
	/**
	 -	 * Displays the message at the end of the game. If the board 
	 -	 * if full and no player won, it display "Draw!".
	 -	 * @param od OmokDialog handling the current game interaction
	 -	*/
	 after(OmokDialog od): makeMove(od){
		 if(od.board.isGameOver()){
			 if(od.board.isWonBy(od.player))
				 od.showMessage("Draw!");
			 else
				 od.showMessage(od.player.name() + " wins!");
			 }
		 }

	/**
	 * Determines whether or not a player is allowed to make a move. 
	 * A player can't make a move after the game has ended.
	 * @param od OmokDialog handling the current game interaction
	 */
	
	
	/**
	 * Determines whether or not a JOptionPane is displayed asking 
	 * for confirmation to start a new game. The JOptionPane is not
	 * shown if the game has ended.
	 * @param od OmokDialog handling the current game interaction
	 */
	void around(OmokDialog od): newGame(od){
		if(!od.board.isGameOver()){
			proceed(od);
		}
		else{
			od.startNewGame();
		}
	}
	
	pointcut winningRow(Graphics a, BoardPanel bo) : execution(void BoardPanel.paint(..)) && args(a) && this(bo);
	
	after(Graphics a, BoardPanel table) : winningRow(a, table){
		if(table.board.winningRow.size() > 0) {
			for(Board.Place stone: table.board.winningRow){
				a.setColor(Color.RED);
				int x = table.placeSize + stone.x * table.placeSize; // center x
				int y = table.placeSize + stone.y * table.placeSize; // center y
				int r = table.placeSize / 3;               // radius
				a.fillOval(x - r, y - r, r * 2, r * 2);	
			}
		}
	}
}
