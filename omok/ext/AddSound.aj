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
	
	private static final String SOUND_DIR = "../sounds/";
	
	
	after(OmokDialog dialog): this(dialog)
    && execution(void OmokDialog.makeMove(..)) {
		
		System.out.println("Hi1");
    
    if(dialog.board.isGameOver())
    {
    	System.out.println("Hi4");
    	
    	
			playAudio("clapping.wav");
		
    }
    else
    {
    	if(dialog.player.name().equals("Black")) {
    		System.out.println("Hi2");
    		
    			System.out.println("Hi16");
    			playAudio("p1_s.wav");
    		
    	} else {
    		System.out.println("Hi3");
    		
    			System.out.println("Hi17");
    			playAudio("click.wav");
    		
    			
    		
    	}
    }  
}
	
	public static void playAudio(String filename)  {
		
		System.out.println("Hi10");
		 
	      try {
	    	  System.out.println("Hi15");
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
	      System.out.println("Hi11");
	    }

}
