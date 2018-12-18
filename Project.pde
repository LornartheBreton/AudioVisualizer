import processing.serial.*;
//import cc.arduino.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;
int blue;
float[] back= new float [3];
int cols, rows;
int scl=30;
int w=int(1920*1.455);
int h=int(950);
float flying=0;;
float[][] terrain;
//Arduino arduino;
void setup()
{
  fullScreen(P3D);
  noCursor();
  
  minim = new Minim(this);
  
  cols=w/scl;
  rows=h/scl;
  terrain=new float[cols][rows];
  player = minim.loadFile("song.mp3");
  frameRate(60);
  
  surface.setResizable(true);
  /*arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(2,0);
  arduino.pinMode(3,0);
  arduino.pinMode(4,0);*/
}


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
  /*for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, player.bufferSize(), 0, width );
    //float x2 = map( i+1, 0, player.bufferSize(), 0, width )+20;
    stroke(255-blue/2,150+blue/2,6+blue/2);
    
    line( x1, 0.25*height + player.left.get(i)*50, 0,0);
    stroke(255-blue/2,0+blue/2,0+blue/2);
    
    line( x1, 0.75*height + player.right.get(i)*50, width,height);
  }*/
  
  flying-=(player.left.level()+player.right.level())/2*0.8;
  println(frameRate);
  float yoff=flying;
  for(int y=0;y<rows;y++){
    float xoff=0;
    for(int x=0;x<cols;x++){
      terrain[x][y]=map(noise(xoff,yoff),0,1,-100,100);
      xoff+=0.2;
    }
    yoff+=0.2;
  }
  pushMatrix();
  //background (0);
  stroke(255-blue/2,150+blue/2,6+blue/2);
  noFill();
  strokeWeight(2);
  translate(width/2,height/2+500);
  rotateX(PI/2.4);
  translate(-w/2,-h/2);
 
  for(int y=0;y<rows-1;y++){
    beginShape(TRIANGLE_STRIP);
    for(int x=0;x<cols;x++){
      vertex(x*scl,y*scl, terrain[x][y]*(player.left.level()+player.right.level())/2*5);
      vertex(x*scl,(y+1)*scl,terrain[x][y+1]*(player.left.level()+player.right.level())/2*5);
    }
    endShape();
  }
  popMatrix();
  pushMatrix();
  strokeWeight(2);
  stroke(255-blue/2,0+blue/2,0+blue/2);
  translate(width/2,height/2-500);
  rotateX(PI/1.6);
  translate(-w/2,-h/2);
  for(int y=0;y<rows-1;y++){
    beginShape(TRIANGLE_STRIP);
    for(int x=0;x<cols;x++){
      vertex(x*scl,y*scl, terrain[x][y]*(player.left.level()+player.right.level())/2*5);
      vertex(x*scl,(y+1)*scl,terrain[x][y+1]*(player.left.level()+player.right.level())/2*5);
    }
    endShape();
  }
  popMatrix();
  
  
  
  
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
