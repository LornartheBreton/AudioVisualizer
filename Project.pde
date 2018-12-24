import controlP5.*;
import processing.serial.*;
//import cc.arduino.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;
ControlP5 cp5;
boolean pauseState=false;
int samePP=0;
int cPP;
int currentSong=0;
File[] files;
int blue;
float[] back= new float [3];
int cols, rows;
int scl=35;
int w=int(1920*1.5);
int h=int(900);
float flying=0;;
float[][] terrain;
String file;
PFont font;
//Arduino arduino;
void setup()
{
  
  
  fullScreen(P3D);
  noCursor();
  selectFolder("Escoge el folder con los archivos MP3", "fileSelected");
  minim = new Minim(this);
  
  cols=w/scl;
  rows=h/scl;
  terrain=new float[cols][rows];
 
  frameRate(60);
  
  surface.setResizable(true);
  /*arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(2,0);
  arduino.pinMode(3,0);
  arduino.pinMode(4,0);*/
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    exit();
  } else {
    println("User selected " + selection.getAbsolutePath());
     //player = minim.loadFile(selection.getAbsolutePath());
    File file = new File(selection.getAbsolutePath());
    if (file.isDirectory()) {
      files = file.listFiles();
      /*playlist=new String[files.length];
      playlistLength=playlist.length;
      for(int i=0;i<playlist.length;i++){
        playlist[i]=files[i].getAbsolutePath();
      }*/
      player=minim.loadFile(files[0].getAbsolutePath());
    } else {
      // If it's not a directory
      println("ERROR: Not a directory");
      exit();
    }
  }
}

void draw()
{
   
  if (player==null){
    /*cp5.addTextfield("How many songs do you want to play?")
     .setPosition(20,100)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;*/
     /*if(keyPressed){
       Playlist=int(key);
     }*/
     
  }else{
    //cp5.hide(cp5);
    visualizer();
  }
}

void keyPressed()
{
  if ( player.isPlaying() && key=='p' )
  {
    player.pause();
    pauseState=true;
  }
  else if(player.isPlaying()==false&&key=='p')
  {
    player.play();
    pauseState=false;
  }
  /*if ( player.position() == player.length()&&key=='p' )
  {
    player.rewind();
    player.play();
  }*/
  
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
