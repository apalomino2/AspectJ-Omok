package omok.ext;
import java.io.IOException;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;

import omok.base.OmokDialog;
import omok.model.Board;
import omok.model.Player;

public privileged aspect AddSound {
	
	private static final String SOUND_DIR = "./sounds/";
	
	after(OmokDialog dialog): this(dialog)
    && execution(void OmokDialog.makeMove(..)) {
		
		System.out.println("Hi1");
    
    if(dialog.board.isWonBy(dialog.player))
    {
    	System.out.println("Hi4");
    	playAudio("clapping.wav");
    }
    else
    {
    	if(dialog.player.name().equals("Black")) {
    		System.out.println("Hi2");
    		playAudio("p1_s.wav");
    	} else {
    		System.out.println("Hi3");
    		playAudio("click.wav");
    	}
    }  
}
	
	public static void playAudio(String filename) {
		 
	      try {
	          AudioInputStream audioIn = AudioSystem.getAudioInputStream(
		    AddSound.class.getResource(SOUND_DIR + filename));
	          System.out.println("Hi5");
	          Clip clip = AudioSystem.getClip();
	          System.out.println("Hi6");
	          clip.open(audioIn);
	          System.out.println("Hi7");
	          clip.start();
	          System.out.println("Hi8");
	      } catch (UnsupportedAudioFileException
	            | IOException | LineUnavailableException e) {
	    	  System.out.println("Hi9");
	          e.printStackTrace();
	      }
	    }

}