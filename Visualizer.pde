void visualizer(){
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
    
    flying-=(player.left.level()+player.right.level())/2*1.2;
    //println(frameRate);
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
    stroke(255-blue/2,150+blue,6+blue/3);
    noFill();
    strokeWeight(2);
    translate(width/2,height/2+500);
    rotateX(PI/2.4);
    translate(-w/2,-h/2);
   
    for(int y=0;y<rows-1;y++){
      beginShape(TRIANGLE_STRIP);
      for(int x=0;x<cols;x++){
        vertex(x*scl,y*scl, terrain[x][y]*(player.left.level()+player.right.level())/2*7);
        vertex(x*scl,(y+1)*scl,terrain[x][y+1]*(player.left.level()+player.right.level())/2*7);
      }
      endShape();
    }
    popMatrix();
    pushMatrix();
    strokeWeight(2);
    stroke(255-blue*1.8,0,0+blue*1.8);
    translate(width/2,height/2-500);
    rotateX(PI/1.6);
    translate(-w/2,-h/2);
    for(int y=0;y<rows-1;y++){
      beginShape(TRIANGLE_STRIP);
      for(int x=0;x<cols;x++){
        vertex(x*scl,y*scl, terrain[x][y]*(player.left.level()+player.right.level())/2*7);
        vertex(x*scl,(y+1)*scl,terrain[x][y+1]*(player.left.level()+player.right.level())/2*7);
      }
      endShape();
    }
    popMatrix();
    
    
    
    
    fill(50,0,255);
    stroke(255-(255*player.right.level()*1.5));
    //text(player.left.level(),700,100);
    strokeWeight(3);
    lights();
    pushMatrix();
    translate(width/2,height/2);
    noFill();
    float rot = map(player.position(), 0, player.length(), 0, TWO_PI);
    rotateY(-rot);
    rotateX(rot);
    
    box(width/2*(player.right.level()+player.left.level())/2);
    
    popMatrix();
    pushMatrix();
    translate(width*0.25,height*0.5);
    rotateY(rot);
    rotateZ(rot);
    box(width/2*player.right.level()*0.3);
    popMatrix();
  
    pushMatrix();
    translate(width*0.75,height*0.5);
    rotateY(-rot);
    rotateZ(-rot);
    box(width/2*player.left.level()*0.3);
    popMatrix();
    //ellipse(width/2, height/2,height*player.left.level(),width*player.right.level());
    // draw a line to show where in the song playback is currently located
   
   /* strokeWeight(5);
    stroke(0,200,0);
    line(posx, 0, posx, height);*/
    print(player.position());
    print ("---");
    println(cPP);
    if(player.position()==cPP&&cPP!=0&&player.position()!=0&&pauseState==false){
      samePP++;
    }else{
      cPP=player.position();
      samePP=0;
    }
    
    if(samePP>=5&&currentSong+1<files.length){
      
      samePP=0;
      currentSong++;
      if(currentSong>=files.length){
        exit();
      }else{
      player=minim.loadFile(files[currentSong].getAbsolutePath());
      
      player.play();
     }
    }/*else if(currentSong+1>=files.length){
       *
      exit();
    }*/
}
