package omok.ext;

import java.awt.*;

import java.awt.event.ActionEvent;

import omok.base.BoardPanel;
import omok.base.OmokDialog;
import omok.model.Board;
import omok.model.Board.Place;
import omok.model.Player;

public privileged aspect EndGame {
	
	pointcut makeMove(OmokDialog od):
		execution(void makeMove(Place))
		&& this(od);
	
	pointcut newGame(OmokDialog od): 
		execution(void OmokDialog.playButtonClicked(ActionEvent)) 
		&& target(od); 

	

	/**
	 * Determines whether or not a player is allowed to make a move. 
	 * A player can't make a move after the game has ended.
	 * @param od OmokDialog handling the current game interaction
	 */
	void around(OmokDialog od): newGame(od){
		if(od.board.isGameOver()){
			return;
		}
		proceed(od);
		
		if(od.board.winningRow.size() > 0){
				od.showMessage(od.player.name() + " wins!");
		} else
			od.showMessage("Draw!");
	}
	
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
				a.setColor(Color.GREEN);
				int x = table.placeSize + stone.x * table.placeSize; // center x
				int y = table.placeSize + stone.y * table.placeSize; // center y
				int r = table.placeSize / 2;               // radius
				a.drawOval(x - r, y - r, r * 2, r * 2);	
			}
		}
	}
}
