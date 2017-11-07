package omok.ext;

import java.io.IOException;

import javax.print.DocFlavor.URL;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;

import omok.model.Board;

public aspect AddSound {
	pointcut moved(): execution(void Board.placeStone(..));
	private static final String SOUND_DIR = "/sounds/";
	private static final String CLICK_NAME = "click.wav";

	after(): moved(){
		try {
			AudioInputStream audioIn = AudioSystem.getAudioInputStream(
					AddSound.class.getResource(SOUND_DIR + CLICK_NAME));
			Clip clip = AudioSystem.getClip();
			clip.open(audioIn);
			clip.start();
		} catch (UnsupportedAudioFileException 
				| IOException | LineUnavailableException e) {
			e.printStackTrace();
		}
	}
}
