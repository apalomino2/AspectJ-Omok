package omok.ext;
import java.io.IOException;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;

import omok.base.OmokDialog;

public privileged aspect AddSound {

	private static final String SOUND_DIR = "/sounds/";

	after(OmokDialog dialog): this(dialog)
	&& execution(void OmokDialog.makeMove(..)) {
		if(dialog.board.isGameOver())
		{
			playAudio("clapping.wav");
		}
		else
		{
			if(dialog.player.name().equals("Black")) {
				playAudio("p1_s.wav");

			} else {
				playAudio("click.wav");
			}
		}  
	}

	public static void playAudio(String filename)  {
		try {
			AudioInputStream audioIn = AudioSystem.getAudioInputStream(
					AddSound.class.getResource(SOUND_DIR + filename));
			Clip clip = AudioSystem.getClip();
			clip.open(audioIn);
			clip.start();
		} catch (UnsupportedAudioFileException
				| IOException | LineUnavailableException e) {
			e.printStackTrace();
		}
	}

}
