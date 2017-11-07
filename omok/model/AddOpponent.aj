package omok.model;

import java.util.List;

public privileged aspect AddOpponent {
	private List<Player>players;
	
	private void OmokDialog.changeTurn(Player opponent){
		player = opponent;
		showMessage(player.name()+"'s turn.");
		repaint();
	}
}
