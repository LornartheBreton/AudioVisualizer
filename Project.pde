import processing.serial.*;
//import cc.arduino.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;
//Arduino arduino;
void setup()
{
  fullScreen(P3D);
  noCursor();
  
  minim = new Minim(this);
  
  
  player = minim.loadFile("song.mp3");
  frameRate(60);
  
  surface.setResizable(true);
  /*arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(2,0);
  arduino.pinMode(3,0);
  arduino.pinMode(4,0);*/
}
int blue;
float[] back= new float [3];

void draw()
{
  if(keyPressed!=true){
   for(int i=0;i<3;i++){
      back[i]=255*player.right.level()*1.5;
    }   
  }
  
  background(back[0], back[1],back[2]);
  //println(arduino.digitalRead(2));
  /*if(arduino.digitalRead(2)==0&&arduino.digitalRead(3)==0&&
  arduino.digitalRead(4)==0){
    background(back[0], back[1],back[2]);
  }else{
    if(arduino.digitalRead(2)==1){
      background(220,60,20);
    }
    if(arduino.digitalRead(3)==1){
      background(60,190,20);
    }
    if(arduino.digitalRead(4)==1){
      background(60,20,150);
    }
  }*/
  
  stroke(255);
  blue=int(map(mouseX,0,width,0,255));
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), 0, width );
    //float x2 = map( i+1, 0, player.bufferSize(), 0, width )+20;
    stroke(255-blue/2,150+blue/2,6+blue/2);
    
    line( x1, 0.25*height + player.left.get(i)*50, 0,0);
    stroke(255-blue/2,0+blue/2,0+blue/2);
    
    line( x1, 0.75*height + player.right.get(i)*50, width,height);
  }
  fill(50,0,255);
  stroke(255-(255*player.right.level()*1.5));
  //text(player.left.level(),700,100);
  strokeWeight(3);
  lights();
  translate(width/2,height/2);
  noFill();
  float rot = map(player.position(), 0, player.length(), 0, TWO_PI);
  rotateY(rot);
  rotateX(rot);
  box(width/2*player.right.level());
  //ellipse(width/2, height/2,height*player.left.level(),width*player.right.level());
  // draw a line to show where in the song playback is currently located
 
 /* strokeWeight(5);
  stroke(0,200,0);
  line(posx, 0, posx, height);*/
  
  
}

void keyPressed()
{
  if ( player.isPlaying() && key=='p' )
  {
    player.pause();
  }
  else if ( player.position() == player.length() )
  {
    player.rewind();
    player.play();
  }
  else if(player.isPlaying()==false&&key=='p')
  {
    player.play();
  }
  switch(key){
    default:
    for(int i=0;i<3;i++){
      back[i]=255*player.right.level()*1.5;
    }
    break;
    case 'r':
      back[0]=220;
      back[1]=60;
      back[2]=20;
    break;
    case 'g':
      back[0]=60;
      back[1]=190;
      back[2]=20;
    break;
    case 'b':
      back[0]=60;
      back[1]=20;
      back[2]=150;
    break;
  }
}
