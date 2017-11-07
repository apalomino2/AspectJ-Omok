package omok.ext;

import java.util.List;

import omok.model.Player;

public privileged aspect AddOpponent {
	private List<Player>players;
	
	private void OmokDialog.changeTurn(Player opponent){
		player = opponent;
		showMessage(player.name()+"'s turn.");
		repaint();
	}
}
