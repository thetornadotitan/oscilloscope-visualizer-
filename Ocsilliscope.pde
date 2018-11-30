import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer in;
int cVal = 0;
ArrayList<String> songs;
String trackName;
boolean debug = true;

void setup(){
  size(720, 720, P2D);
  songs = new ArrayList<String>();
  minim = new Minim(this);
  
  songs.add("Attack Vector.aiff");
  songs.add("Helix Unchained.aiff");
  songs.add("Planned Obsolescence.aiff");
  songs.add("Plasma.aiff");
  songs.add("Plot Twist.aiff");
  trackName = "Default";
  PickNewSong();
  colorMode(HSB);
  noFill();
}

void draw(){
  background(0, 0, 0, 1);
  strokeWeight(1);
  stroke(cVal, 255, 255, 255);
  fill(cVal, 255, 255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text(trackName, width / 2, 50);
  
  for(int i = 1; i < in.bufferSize(); i++)
  {
    float lpg = in.left.get(i-1);
    float rpg = in.right.get(i-1);
    float lg = in.left.get(i);
    float rg = in.right.get(i);
    
    float px = map(i-1, 0, in.bufferSize(), 0, width);
    float py = lpg * 50 + height * .40;
    float x = map(i, 0, in.bufferSize(), 0, width);
    float y = lg * 50 + height * .40;
    line(px, py, x,y);
    
    px = map(i-1, 0, in.bufferSize(), 0, width);
    py = rpg * 50 + height * .60;
    x = map(i, 0, in.bufferSize(), 0, width);
    y = rg * 50 + height * .60;
    line(px, py, x,y);
    
    px = lpg * (width * 0.15) + width * 0.15;
    py = -rpg * (height * 0.15) + height * 0.15;
    x = lg * (width * 0.15) + width * 0.15;
    y = -rg * (height * 0.15) + height * 0.15;
    
    point(px, py);
    point(x, y);
    
    px = lpg * (width * 0.15) + width * 0.85;
    py = -rpg * (height * 0.15) + height * 0.85;
    x = lg * (width * 0.15) + width * 0.85;
    y = -rg * (height * 0.15) + height * 0.85;
    
    point(px, py);
    point(x, y);
    
    px = lpg * (width * 0.15) + width * 0.85;
    py = -rpg * (height * 0.15) + height * 0.15;
    x = lg * (width * 0.15) + width * 0.85;
    y = -rg * (height * 0.15) + height * 0.15;
    
    line(px, py, x, y);
    
    px = lpg * (width * 0.15) + width * 0.15;
    py = -rpg * (height * 0.15) + height * 0.85;
    x = lg * (width * 0.15) + width * 0.15;
    y = -rg * (height * 0.15) + height * 0.85;
    
    line(px, py, x, y);
  }
  
  if (in.position() >= in.length()){
    PickNewSong();
  }
  
  cVal++;
  if(cVal > 255){
   cVal = 0;
  }
}

void keyPressed(){
  if(key == ' '){
    if(in.isPlaying()){
      in.pause();
    }else{
      in.play();
    }
  }
  
  if(key == 'n'){
    PickNewSong();
  }
  
  if(key == 'd'){
    debug = !debug;
  }
}

void PickNewSong(){
  if(in != null){
    in.rewind();
    in.pause();
  }
  String filename = songs.get((int) random(songs.size()));
  in = minim.loadFile(filename);
  in.play();
  trackName = filename.split("\\.")[0];
}
