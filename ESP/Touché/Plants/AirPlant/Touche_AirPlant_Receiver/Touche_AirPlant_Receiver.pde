// Processing example for receiving predictions from ESP
// Draws a small ball (circle) dropping from the top of the window
// to the bottom. ESP predictions make the ball move left (class 1)
// and right (class 2).

import processing.net.*; // include the networking library

Server server; // will receive predictions from ESP
String messageText;
PFont f;

void setup()
{
  fullScreen();

  server = new Server(this, 5204); // listen on port 5204
  messageText = "NO HAND";

  f = createFont("Arial",16,true); // Arial, 16 point, anti-aliasing on
}

void draw()
{
  // check for incoming data
  Client client = server.available();
  if (client != null) {
    // check for a full line of incoming data
    String line = client.readStringUntil('\n');

    if (line != null) {
      println(line);
      int val = int(trim(line)); // extract the predicted class
      println(val);
      if (val == 1) {
        messageText = "NO HAND";
      } else if (val == 2) {
        messageText = "RESTING HAND";
      } else if (val == 3) {
        messageText = "TICKLING";
      }
    }
  }
  
  // draw
  background(0);
  textFont(f,64);
  fill(255);
  textAlign(CENTER);
  text(messageText, width/2, height/2);

}