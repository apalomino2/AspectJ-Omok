package omok.ext;

import java.awt.Graphics;
import java.awt.event.ActionEvent;

import omok.base.OmokDialog;
import omok.model.Board.Place;

public privileged aspect EndGame {
	pointcut moved(OmokDialog od): execution(void OmokDialog.makeMove(Place)) && target(od);
	pointcut newGame(OmokDialog od): execution(void OmokDialog.playButtonClicked(ActionEvent)) && target(od); 
	
	void around(OmokDialog od): moved(od){
		if(!od.board.isGameOver()){
			proceed(od);
		}
	}
	/*
	after(OmokDialog od): moved(od){
		if(od.board.isGameOver()){
			if(od.board.winningRow.size() > 0){
				od.showMessage(od.player.name + " wins!");
				for(Place p: od.board.winningRow()){
					///AHHHH!!!
					Graphics g = od.board.getGraphics();
					int x = bp.placeSize + place.x * bp.placeSize; // center x
					int y = bp.placeSize + place.y * bp.placeSize; // center y
					int r = bp.placeSize / 2;               // radius
					g.drawOval(x - r, y - r, r * 2, r * 2);	
				}
			}
			else{
				od.showMessage("Draw!");
			}
		}
	}
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
