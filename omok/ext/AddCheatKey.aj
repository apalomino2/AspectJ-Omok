package omok.ext;

import omok.base.BoardPanel;

public aspect AddCheatKey {
	pointcut createBoardPanel(BoardPanel bp):
		execution(BoardPanel BoardPanel(..))
		&& this(bp);
	
	
}
