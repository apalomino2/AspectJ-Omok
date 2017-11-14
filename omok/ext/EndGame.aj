package omok.ext;

import java.awt.event.ActionEvent;

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
	 * Displays the message at the end of the game. If the board 
	 * if full and no player won, it display "Draw!".
	 * @param od OmokDialog handling the current game interaction
	*/
	after(OmokDialog od): makeMove(od){
		if(od.board.isGameOver()){
			if(od.board.isWonBy(od.player))
				od.showMessage(od.player.name() + " wins!");
			else
				od.showMessage("Draw!");
		}
		
	}

	/**
	 * Determines whether or not a player is allowed to make a move. 
	 * A player can't make a move after the game has ended.
	 * @param od OmokDialog handling the current game interaction
	 */
	void around(OmokDialog od): makeMove(od){
		if(!od.board.isGameOver()){
			proceed(od);
		}
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
}
