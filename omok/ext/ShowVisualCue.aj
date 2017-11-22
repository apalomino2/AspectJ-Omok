package omok.ext;

import omok.base.BoardPanel.BoardPanelListener;
import omok.model.Board;
import omok.model.Board.Place;
import omok.model.*;
import omok.base.OmokDialog;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
import java.awt.event.MouseListener;

import omok.base.BoardPanel;

public privileged aspect ShowVisualCue {
	public Place m1 = null;
	public Player p1 = new Player("White");
	private Place last = new Place(-1, -1);
	
	pointcut buildListener(BoardPanel bp):
		execution(BoardPanel.new(Board, BoardPanelListener))
		&& target(bp);
	
	pointcut makeMove(OmokDialog board): 
		execution(* OmokDialog.makeMove(..)) && this(board);
	
	after(OmokDialog board2) : makeMove(board2){
		p1 = board2.player;
	}
	
	/**
	 * Adds a listener to the board panel that follows the mouse's
	 * movements and draws the visual cue. 
	 * @param bp BoardPanel where the board is drawn
	 */
	after(BoardPanel bp): buildListener(bp){
		
		bp.addMouseMotionListener(new MouseMotionAdapter(){
			
			public void mouseMoved(MouseEvent e){
				
				Place place = bp.locatePlace(e.getX(), e.getY());
				
				if(place != null){
					if (last.x != place.x || last.y != place.y) {
						// erase the last cue after leaving the Place
						bp.repaint();
						last = place;
					}
					
					else{
						Graphics g = bp.getGraphics();
						Color c =  (p1.name().equals("White")? Color.BLACK : Color.WHITE);
						g.setColor(c);
						//g.setColor(Color.DARK_GRAY);
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
