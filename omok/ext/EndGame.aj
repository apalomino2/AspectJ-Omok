package omok.ext;

import java.awt.Graphics;
import java.awt.event.ActionEvent;

import javax.swing.SwingUtilities;
import javax.swing.JDialog;

import omok.base.OmokDialog;
import omok.model.Board;
import omok.model.Board.Place;
import omok.model.Player;

public privileged aspect EndGame {
	pointcut gameOver(Player player):
		execution(void Board.notifyGameOver(Player)) && args(player);
	
	pointcut moved(OmokDialog od): 
		execution(void OmokDialog.makeMove(Place)) && target(od);
	
	pointcut newGame(OmokDialog od): 
		execution(void OmokDialog.playButtonClicked(ActionEvent)) && target(od); 
	
	private String msg;
	after(Player player): gameOver(player){
		if(player == null)
			msg = "Draw!";
		else
			msg = player.name()+" wins!";
	}

	after(OmokDialog od): moved(od){
		if(od.board.isGameOver()){
			od.showMessage(msg);
		}
	}
	
	void around(OmokDialog od): moved(od){
		if(!od.board.isGameOver()){
			proceed(od);
		}
	}
	
	void around(OmokDialog od): newGame(od){
		if(!od.board.isGameOver()){
			proceed(od);
		}
		else{
			od.startNewGame();
		}
	}
}
