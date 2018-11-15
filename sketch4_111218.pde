 //sketch 4 Texts and Images 
 //Due Nov. 15 
 //First Push
PImage llama;
PImage bground;
PImage particles;
PImage grnvas;
PImage pkvas;
PImage floor;
PFont font;//add font
PFont fontt;
//String letter = "A";//text and string

// 
String [] title = {"Flower", "Shop" };//moving text
float[] titlePosX, titlePosY, hawPosX, hawPosY;
float theta=0;
float spacing =60;//space bt title words

/*Cellular automaton on text: divided into non-overlapping blocks (
//"MRS. DALLOWAY SAID she would buy the flowers herself."
Control:
 * MousePressed — start to collapse
*/

boolean[] b=new boolean[4];
Status status;
boolean p1, p2, p3, p4;
color bc =color (200), tc=color(17,112,160);  // color of text
boolean change=false, collapse=false;  //  unclicked 
 
void setup (){
 size (700,430);
 //llama = loadImage ("llama.jpg"); 
 bground = loadImage ("flowershop.jpg");
  bground.resize(width, height);//resize background image to window size
  image (bground, 0,40);//offset 40 pixels downward 
 
  //flower shop text
  titlePosX=new float[title.length];  // title position x
  titlePosY=new float[title.length];//title posistion y
  hawPosX=new float[title.length];  // ball position  x
  hawPosY=new float[title.length];//y
  
  
  
 font  = createFont ("Copperplate", 20);
 fontt = createFont ("Arial", random (20,28));//font for narration 

  textFont (font);
  textAlign (CENTER, CENTER);
  
  //narration collapse: narration text
  textAlign(CENTER);
  textFont(fontt);
  
  fill(tc);
  text ("MRS. DALLOWAY SAID she would buy the flowers herself.", width*0.5,20);
   text ("MRS. DALLOWAY SAID she would buy the flowers herself.", width*0.5,320);
    textFont(fontt);
  text ("flowers ", width*0.8,120);
    textFont(fontt);
  text ("herself.", width*0.8,300);
    textFont(fontt);
  text ("buy ", width*0.1,200);
      textFont(fontt);
  text ("Mrs. Dalloway", width*0.1,360);
  
  

  
  
   
}

void draw(){
  //image (llama, 0, 0);
 int x1 = (int) random (0, width);
 int y1 =0;
 
 int x2 = round (x1 + random (-7, 7));
 int y2 = round (random (-5,5));
 
 int w = (int) random (35,50);
 int h = height;
 
 copy (x1,y1, w,h,  x2, y2, w,h);//cooy is executed
 
 
 //images:
 //background for title
 grnvas = loadImage ("grnvas.png");
 grnvas.resize (220,220);
 image (grnvas, 100, 100);
//floor =loadImage ("floor.jpg");
//floor.resize (400,400);
//image (floor, 100,55);
 
 
 
   //vase position
 //transparent vase
 
// particles =loadImage ("particles.png");
 // image (particles, 0,width/2);
 
 
 
 //text
 theta =(theta +1.5)% 360;
 
 for (int i = 0; i<title.length; i++){
  hawPosX[i] = sin (radians (theta +(i*30))*4);//pause
  hawPosY [i]= cos (radians (theta +(i*30))*4);//speed
  titlePosX[i] = width*0.40-spacing*2 + i * spacing;//actuall x, y positions
  titlePosY[i] = height*0.568;
  //bouncing balls
    noStroke();
    fill(1, random(75), 65);//blue and green color
    ellipse(titlePosX[i], (20*hawPosY[i])+titlePosY[i], 10, 10);
  
 //title
  pushMatrix();
   translate(30*hawPosX[i]+titlePosX[i], titlePosY[i]);//
    fill(17,40,112);//
    textFont(font);
    text(title[i], 15, 15);
    popMatrix();
  
 }//flower shop ends



if (collapse) {
    if (change) {
      update(0);
      change=false;
      
    } else {
      update(1);
      change=true;
    }
  }//naration end


 
  //collage
  
 
  
}//draw end



 
 
 void mousePressed() {
  collapse=true;
}//mouse pressed = true, collapse starts



void update(int g) {
  // for each one cellur getting 4 separated pixels
  for (int i=g; i<width-1; i+=2) {
    for (int j=g; j<height-1; j+=2) {
      // get the pixels from the color of the text "tc"
      //so 4 situations or status 
      if (get(i, j)==tc) {
        p1=true;
      } else {
        p1=false;
      }
      if (get(i+1, j)==tc) {
        p2=true;
      } else {
        p2=false;
      }
      if (get(i, j+1)==tc) {
        p3=true;
      } else {
        p3=false;
      }    
      if (get(i+1, j+1)==tc) {
        p4=true;
      } else {
        p4=false;
      }

      status=new Status(p1, p2, p3, p4);  // Status status targets 
      b=status.output();  // update status
 // b[i] 
      // color the celluar change to background color ==invisible  
      if (b[0]==true) {//starts from 0 1.
        set(i, j, tc);
      } else {
        set(i, j, bc);//background 
      }
      if (b[1]==true) {//2.
        set(i+1, j, tc);
      } else {
        set(i+1, j, bc);
      }
      if (b[2]==true) {//3.
        set(i, j+1, tc);
      } else {
        set(i, j+1, bc);
      }
      if (b[3]==true) {//4.
        set(i+1, j+1, tc);
      } else {
        set(i+1, j+1, bc);
      }
    }
  }
}
//for pilling on the ground
class Status {
  boolean s1, s2, s3, s4;  // 
  float p=50f;  //
  boolean result[]=new boolean[4];
//result four new boolean
  Status(boolean b1, boolean b2, boolean b3, boolean b4) {
    // 16 situations 2^4
    if (b1==true && b2==false && b3==false && b4==false) {  // 1.
      s1=false;
      s2=b2;
      s3=true;
      s4=b4;
    } else if (b1==false && b2==true && b3==false && b4==false) {  // 2
      s1=b1;
      s2=false;
      s3=b3;
      s4=true;
    } else if (b1==true && b2==true && b3==false && b4==false) {   // 3.
      float odd=random(100);
      if (odd<p) {
        s1=b1;
        s2=b2;
        s3=b3;
        s4=b4;
      } else {
        s1=false;
        s2=false;
        s3=true;
        s4=true;
      }
    } else if (b1==true && b2==false && b3==true && b4==false) {  // 4.
      s1=false;
      s2=b2;
      s3=b3;
      s4=true;
    } else if (b1==false && b2==true && b3==true && b4==false) {  // 5.
      s1=b1;
      s2=false;
      s3=b3;
      s4=true;
    } else if (b1==true && b2==true && b3==true && b4==false) {   // 6.
      s1=b1;
      s2=false;
      s3=b3;
      s4=true;
    } else if (b1==true && b2==false && b3==false && b4==true) {  // 7.
      s1=false;
      s2=b2;
      s3=true;
      s4=b4;
    } else if (b1==false && b2==true && b3==false && b4==true) {  // 8.
      s1=b1;
      s2=false;
      s3=true;
      s4=b4;
    } else if (b1==true && b2==true && b3==false && b4==true) {  // 9.
      s1=false;
      s2=b2;
      s3=true;
      s4=b4;
    } else {  // 7 situations
      s1=b1;
      s2=b2;
      s3=b3;
      s4=b4;
    }
  }

  // new 
  boolean[] output() {
    boolean[] result={s1, s2, s3, s4};
    return result;
  }
}//not sure how to remove the floor image once clicked 
 
