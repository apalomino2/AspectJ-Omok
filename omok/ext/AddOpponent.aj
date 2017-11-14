package omok.ext;

import java.awt.Color;
import omok.base.ColorPlayer;
import omok.base.OmokDialog;
import omok.model.Player;

public privileged aspect AddOpponent {
	
	Player White = new ColorPlayer("White", Color.WHITE);
	Player Black = new ColorPlayer("Black", Color.BLACK);
	
	after(OmokDialog dialog): this(dialog) && execution(void OmokDialog.makeMove(..)) 
	{	
		
		if (dialog.player.name().equals("White")) {
			dialog.player = Black;
		} else if (dialog.player.name().equals("Black")) {
			dialog.player = White;
		}
	}
}