package omok.ext;

import omok.base.BoardPanel.BoardPanelListener;
import omok.model.Board;
import omok.model.Board.Place;

import java.awt.Graphics;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;

import omok.base.BoardPanel;

public privileged aspect ShowVisualCue {
	
	private Place last = new Place(-1, -1);
	
	pointcut buildListener(BoardPanel bp):
		execution(BoardPanel.new(Board, BoardPanelListener))
		&& target(bp);

	after(BoardPanel bp): buildListener(bp){
		bp.addMouseMotionListener(new MouseMotionAdapter(){
			public void mouseMoved(MouseEvent e){
				Board.Place place = bp.locatePlace(e.getX(), e.getY());
				if(place != null){
					if (last.x != place.x || last.y != place.y) {
						bp.repaint();
						last = place;
					}
					else{
						Graphics g = bp.getGraphics();
						int x = bp.placeSize + place.x * bp.placeSize; // center x
						int y = bp.placeSize + place.y * bp.placeSize; // center y
						int r = bp.placeSize / 2;               // radius
						g.drawOval(x - r, y - r, r * 2, r * 2);	
					}
				}
			}
		});
	}
}
