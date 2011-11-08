[Meters for Arduino](http://robotgrrl.com/apps4arduino/meters.php)
==================

Meters for Arduino brings back vintage memories of old VU Meters! Before LEDs were used to display volume units they used a magnoelectric meter that would move a pin around. You could measure the value using a scale that is painted on the back plate. VU Meters were originally quite slow to display the data. The delay is one aspect that Meters for Arduino does not try to mimic- we communicate at 115200 baud to display the analog pin data! 


##Usage

Meters for Arduino demonstrates how you can use [Matatino](http://robotgrrl.com/apps4arduino/matatino.php) to visually display the data that is being received from the Arduino.

The sketch that is used (MeterSketch.pde) prints out the analog input values in a way that Meters is looking for. We had to add in some delays because it was going a little too fast for the parsing code to keep up with (that's something you could fix, if you wanted to)- but it is still very responsive to quick changes.

If you are going to be using Meters for Arduino to build the application to use it as a standalone, then do a tweetware micro-action on [this page](http://robotgrrl.com/apps4arduino/meters.php). :)


##Contribute

Meters for Arduino is Open Source under the BSD 3-Clause license! Fork the repository, and modify it all you want. We encourage you to redistribute your code. If you do create something cool or improve upon this, please let us know!

Here are some features we would love to see:

  * Name on backplate: The "name" of the MeterWindowController (currently used for adjusting the name of the NSWindow) could also be used to write a label (NSTextField) on the backplate of the meter nib. The font has to look vintage though, so you'll probably need to use a custom font
	
  * Pin animations: Make the movement of the pin smoother by iterating from the previous value to the current value. This will probably only work good if previous is much greater or less than the current value. There are two example cases when this happens: on connect and disconnect
	
  * Resizable pin maths: In Lion we can resize windows from any side, which means that the window may not always be proportional. We tried to figure out a way to scale the pin so that it would always have the end points (0 and 1023) somewhat touching the edges, and the midpoint (512) touching the top. No dice yet, but there is probably a scale factor that can be deduced from some trig and geometry
	
  * Fullscreen mode: Transform the desktop into a steampunk-esque analog pin monitoring station would be just EPIC!
	
  * Sound effects: When pressing GO!/Stop there could be cool power up/power down sound effects. Also perhaps some light scratching noises or electronic sounds when the values change a lot...
	
  * Blocks & threads: We probably aren't updating the display in the best way, so creating threads and using some blocks to update each meter would make it zippier


##License

Meters for Arduino is released under the [BSD 3-Clause license](http://www.opensource.org/licenses/BSD-3-Clause). You can view our other legal information in legal.markdown or on the [website](http://robotgrrl.com/apps4arduino/meters.php).