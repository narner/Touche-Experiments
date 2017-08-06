import processing.net.*; // include the networking library

Server server; // will receive predictions 
String messageText;
PFont f;

void setup() {
  fullScreen(FX2D);
  frameRate(600);
  server = new Server(this, 5204); // listen on port 5204
  
  messageText = "NO HAND";
  textAlign(CENTER);
  fill(255);
  f = createFont("Arial",48,true); // Arial, 16 point, anti-aliasing on
  textFont(f, 120);
}

void draw() {
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
        messageText = "ONE LEAF";
      } else if (val == 3) {
        messageText = "CARESSING";
      }
    } 
  }

  // draw
  background(0);
  text(messageText, width/2, height/2);
}