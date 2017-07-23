import processing.net.*; // include the networking library

Server server; // will receive predictions 
Client client;
String messageText;
int dataIn;
PFont f;

void setup() {
  fullScreen(P3D);
  frameRate(600);
  server = new Server(this, 5204); // listen on port 5204
  client = server.available();

  messageText = "NO HAND";
  textAlign(CENTER);
  fill(255);
  f = createFont("Arial",48,true); // Arial, 16 point, anti-aliasing on
  textFont(f, 120);
}

void draw() {
  // draw
  background(0);
  text(messageText, width/2, height/2);
}

// If there is information available to read
// this event will be triggered
void clientEvent(Client client) {
  String msg = client.readStringUntil('\n');
  // The value of msg will be null until the 
  // end of the String is reached
  if (msg != null) {    
      int val = int(trim(line)); // extract the predicted class
      println(val);
      if (val == 1) {
        messageText = "NO HAND";
      } else if (val == 2) {
        messageText = "ONE FINGER";
      } else if (val == 3) {
        messageText = "FIVE FINGERS";
      } else if (val == 4) {
        messageText = "FULL HAND";
      }
    }
  }
  
}