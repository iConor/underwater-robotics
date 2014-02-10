/*****************************************************
 *                                                   *
 *   Classes:                                        *
 *   - GUI_2 - Sara's newfangled visual interface.   *
 *     Functions:                                    *
 *     - GUI_2 - Call in setup().   (Constructor)    *
 *     - update() - Call in draw().                  *
 *     - keyboard() - Call in keyPressed().          *
 *     - mouse() - Call in mouseDragged().           *
 *   Functions:                                      *
 *   - keyPressed() - Activates on keyboard event.   *
 *   - mouseDragged() - Activates on mouse event.    *
 *                                                   *
 *****************************************************/

class GUI_2 {

  PApplet main_function; // Use 'main_function' instead of 'this' for starting cameras and so on.

  PImage arrow, Black, arrow_black, Rectangle_Permanent1, Rectangle_Permanent2, Rectangle_Permanent3, startupimage1, startupimage2, startupimage3, rotatedimage1, rotatedimage2, rotatedimage3, cam3, cam2;
  float counter1=0, counterObj1=0, counterObj2=0, counterObj3=0, counter_rotate = 0, Rec_x, Rec_y, Rec_x2, Rec_y2, Rec_x1perm, Rec_x2perm, Rec_x3perm, Rec_y1perm, Rec_y2perm, Rec_y3perm;
  float angle = 0, angle2 = 0, angleperm1, angleperm2, angleperm3, Rec_xrotate, Rec_yrotate, temp_x, temp_y, angle2_arrow =0, Robot_x, Robot_y, Robot_x2, Robot_y2, Robot_angle;
  float cam_place1_x=30, cam_place1_y=40, cam_place2_x=680, cam_place2_y=90, cam_place3_x=1020, cam_place3_y=90;
  int Object = 0, Status = 0, Permanent1 = 0, Permanent2 = 0, Permanent3 = 0, cam_1 = 1, cam_2 = 2, cam_3 = 3, cam_1temp, cam_2temp, cam_3temp;
  PFont font1;
  Capture cam1;
  String a = "CONTROL CENTER";
  String b = "CAMERA 1";
  String c = "CAMERA 2";
  String d = "CAMERA 3";
  String e = "Manual Movement";
  String f = "NAVIGATION";


  //-------------------- GUI_2 / setup() --------------------//

  // Constructor.
  GUI_2( PApplet parent ) {
    main_function = parent;
    size(1350, 700, P3D);
    colorMode(RGB, 255);
    noStroke();
    background(50);

    //load images
    startupimage1 = loadImage("Rectangle_Red1.png");
    startupimage2 = loadImage("Rectangle_Red2.png");
    startupimage3 = loadImage("Rectangle_Red3.png");
    Black = loadImage("Black.gif");
    arrow = loadImage("arrow.gif");
    arrow_black = loadImage("arrow_black.gif");
    cam2 = loadImage("cam2.jpg");
    cam3 = loadImage("cam3.jpg");

    //control center rectangle
    fill(0, 0, 150);
    rect(8, 447, 690, 240, 10);
    //navigation rectangle
    fill(0);
    rect(width-640, height-360, 640, 360);
    font1 = loadFont("LilyUPCBoldItalic-48.vlw");
    textFont(font1);
    fill(150, 0, 0);
    //cameras, control center and navigation text
    text(a, 180, 440);
    text(f, width-420, height-370);
    textFont(font1, 32);
    text(b, 280, 30);
    text(c, 780, 80);
    text(d, 1120, 80);

    //initialize robot coordinates (remove when data stream in place)
    Robot_x = width - 320;
    Robot_x2 = width - 320;
    Robot_y = height - 180;
    Robot_y2 = height - 180;

    //find and start cameras 
    // use this instead once actual cameras are being used - cam1 = new Capture(parent, requestWidth, requestHeight, cameraName, frameRate) - replaces following 12 lines
    String[] cameras = Capture.list();

    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } 
    else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) {
        println(i + " " + cameras[i]);
      }
      //cam1 = new Capture(main_function, cameras[3]);//3
      //cam1.start();
      //cam2 = new Capture(main_function, cameras[34]);//28
      //cam2.start();
      cam1 = new Capture(main_function, cameras[0]);//72
      cam1.start();
    }
  }

  //-------------------- update() / draw() --------------------//

  void update() { 
    //cameras
    if (cam1.available() == true) {
      cam1.read();
    }

    //  if (cam2.available() == true) {
    //   cam2.read();
    //  }

    //  if (cam3.available() == true) {
    // cam3.read();
    //}

    //place camera image at correct location
    switch(cam_1) {
    case 1:
      image(cam1, cam_place1_x, cam_place1_y, 640, 360);
      break;
    case 2:
      image(cam2, cam_place1_x, cam_place1_y, 640, 360);
      break;
    case 3:
      image(cam3, cam_place1_x, cam_place1_y, 640, 360);
      break;
    }

    switch(cam_2) {
    case 1:
      image(cam1, cam_place2_x, cam_place2_y, 320, 180);
      break;
    case 2:
      image(cam2, cam_place2_x, cam_place2_y, 320, 180);
      break;
    case 3:
      image(cam3, cam_place2_x, cam_place2_y, 320, 180);
      break;
    }

    switch(cam_3) {
    case 1:
      image(cam1, cam_place3_x, cam_place3_y, 320, 180);
      break;
    case 2:
      image(cam2, cam_place3_x, cam_place3_y, 320, 180);
      break;
    case 3:
      image(cam3, cam_place3_x, cam_place3_y, 320, 180);
      break;
    }

    //draw grid lines
    for (int i = 0; i < 10; i++) {
      stroke(255);
      line((width-(i+1)*64), (height), -1, (width-(i+1)*64), (height-360), -1);
    }
    for (int i = 0; i < 6; i++) {
      line((width), (height-(i+1)*60), -1, (width-640), (height-(i+1)*60), -1);
    }

    //create startup images
    if (counterObj1<1) {
      image(startupimage1, width-83, height-350);
    }
    if (counterObj2<1) {
      image(startupimage2, width-83, height-300);
    }
    if (counterObj3<1) {
      image(startupimage3, width-83, height-250);
    }
    //maintain permanent images (uses permanent data collected when 'Enter' was pressed to maintain correct placement)

    //Image number 1
    if (Permanent1>0) {
      pushMatrix();
      translate(Rec_x1perm+Rectangle_Permanent1.width/2, Rec_y1perm+Rectangle_Permanent1.height/2);
      rotate(angleperm1);
      translate(-Rectangle_Permanent1.width/2, -Rectangle_Permanent1.height/2);
      tint(255, 10);
      image(Rectangle_Permanent1, 0, 0);
      popMatrix();
    }
    //Image number 2
    if (Permanent2>0) {
      pushMatrix();
      translate(Rec_x2perm+Rectangle_Permanent2.width/2, Rec_y2perm+Rectangle_Permanent2.height/2);
      rotate(angleperm2);
      translate(-Rectangle_Permanent2.width/2, -Rectangle_Permanent2.height/2);
      tint(255, 10);
      image(Rectangle_Permanent2, 0, 0);
      popMatrix();
    }

    //Image number 3
    if (Permanent3>0) {
      pushMatrix();
      translate(Rec_x3perm+Rectangle_Permanent3.width/2, Rec_y3perm+Rectangle_Permanent3.height/2);
      rotate(angleperm3);
      translate(-Rectangle_Permanent3.width/2, -Rectangle_Permanent3.height/2);
      tint(255, 10);
      image(Rectangle_Permanent3, 0, 0);
      popMatrix();
    }
  }

  //-------------------- keyboard() / keyPressed() --------------------//
  
  void keyboard() {

    //Assign placement of cameras on screen (press 2 to move image 2 to location 1, press 3 to move image 3 to location 1)
    if (keyCode>49 && keyCode<51) {
      cam_1temp = cam_1;
      cam_2temp = cam_2;
      cam_3temp = cam_3;

      cam_1 = cam_2temp;
      cam_2 = cam_1temp;
      cam_3 = cam_3temp;
    }

    if (keyCode>50 && keyCode<52) {
      cam_1temp = cam_1;
      cam_2temp = cam_2;
      cam_3temp = cam_3;

      cam_1 = cam_3temp;
      cam_2 = cam_2temp;
      cam_3 = cam_1temp;
    }

    //move and rotate arrow according to coordinates and angle (when 's' is pressed for testing)
    Robot_angle = counter1/10;
    //arrow will only appear after rectangles have been permanently placed
    if (Permanent1>0 && Permanent2>0 && Permanent3>0) {
      if (key>'r' && key<'t') {//replace with 'if getting coordinate and angle data'

        //blackout previous arrow
        pushMatrix();
        arrow_black.resize(32, 32);
        translate(Robot_x2, Robot_y2);
        rotate(angle2_arrow);
        translate(-arrow_black.width/2, -arrow_black.height/2);
        noTint();
        image(arrow_black, 0, 0);
        popMatrix();

        //creates current arrow
        pushMatrix();
        translate(width-320, height-180);
        Robot_x2 = Robot_x;
        Robot_y2 = Robot_y;
        rotate(Robot_angle);
        //translate so that rotation occurs around center of image
        angle2_arrow = Robot_angle;
        translate(-arrow.width/2, -arrow.height/2);
        noTint();
        image(arrow, 0, 0);
        popMatrix();
        counter1++; //won't need once data stream in place
      }
    }
    //signify that object is placed correctly and load permanent images
    if (keyCode>9 && keyCode<11) { //Must press 'Enter' to make placement permanent

      //Image number 1
      if (Object>0 && Object<2) {
        Status = -1; //signifies that object 1 has been placed (will not allow a second object 1 to be placed)
        Object = 0; //clears object #
        Permanent1 = 1; //signifies that permanent image 1 can be created in void draw()
        Rectangle_Permanent1 = loadImage("Rectangle_Blue1.png");
        //stores coordinate and angle data for permanent location
        Rec_x1perm = Rec_x2;
        Rec_y1perm = Rec_y2;
        angleperm1 = angle;
        angle = 0; //clears angle value
        angle2 = 0;
        counter_rotate = 0;
      }
      if (Object>1 && Object<3) {
        Status = -2; //signifies that object 2 has been placed (will not allow a second object 2 to be placed)
        Object = 0; //clears object #
        Permanent2 = 1; //signifies that permanent image 2 can be created in void draw()
        Rectangle_Permanent2 = loadImage("Rectangle_Blue2.png");
        //stores coordinate and angle data for permanent location
        Rec_x2perm = Rec_x2;
        Rec_y2perm = Rec_y2;
        angleperm2 = angle;
        angle = 0; //clears angle value
        angle2 = 0;
        counter_rotate = 0;
      }
      if (Object>2 && Object<4) {
        Status = -3; //signifies that object 3 has been placed (will not allow a second object 3 to be placed)
        Object = 0; //clears object #
        Permanent3 = 1; //signifies that permanent image 3 can be created in void draw()
        Rectangle_Permanent3 = loadImage("Rectangle_Blue3.png");
        //stores coordinate and angle data for permanent location
        Rec_x3perm = Rec_x2;
        Rec_y3perm = Rec_y2;
        angleperm3 = angle;
        angle = 0; //clears angle value
        angle2 = 0;
        counter_rotate = 0;
      }
    }

    //Rotate Image using left and right arrow keys (rotate images after moving them to the correct coordinate)
    rotatedimage1 = startupimage1;
    rotatedimage2 = startupimage2;
    rotatedimage3 = startupimage3;
    Rec_xrotate = Rec_x;
    Rec_yrotate = Rec_y;

    //Rotate left
    if (keyCode>36 && keyCode<38) {

      Black.resize(76, 43);    
      //If image 1  
      if (Object>0 && Object<2) {
        pushMatrix();
        translate(Rec_xrotate+rotatedimage1.width/2, Rec_yrotate+rotatedimage1.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+rotatedimage1.width/2, Rec_yrotate+rotatedimage1.height/2);
        angle = angle - .2;
        rotate(angle);
        angle2 = angle;
        translate(-rotatedimage1.width/2, -rotatedimage1.height/2);
        noTint();
        image(rotatedimage1, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 2
      if (Object>1 && Object<3) {
        pushMatrix();
        translate(Rec_xrotate+rotatedimage2.width/2, Rec_yrotate+rotatedimage2.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+rotatedimage2.width/2, Rec_yrotate+rotatedimage2.height/2);
        angle = angle - .2;
        rotate(angle);
        angle2 = angle;
        translate(-rotatedimage2.width/2, -rotatedimage2.height/2);
        noTint();
        image(rotatedimage2, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 3
      if (Object>2 && Object<4) {
        pushMatrix();
        translate(Rec_xrotate+rotatedimage3.width/2, Rec_yrotate+rotatedimage3.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+rotatedimage3.width/2, Rec_yrotate+rotatedimage3.height/2);
        angle = angle - .2;
        rotate(angle);
        angle2 = angle;
        translate(-rotatedimage3.width/2, -rotatedimage3.height/2);
        noTint();
        image(rotatedimage3, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
    }
    //Rotate Right
    if (keyCode>38 && keyCode<40) {

      Black.resize(76, 43);
      //If image 1  
      if (Object>0 && Object<2) {
        pushMatrix();
        translate(Rec_xrotate+rotatedimage1.width/2, Rec_yrotate+rotatedimage1.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+rotatedimage1.width/2, Rec_yrotate+rotatedimage1.height/2);
        angle = angle + .2;
        rotate(angle);
        angle2 = angle;
        translate(-rotatedimage1.width/2, -rotatedimage1.height/2);
        noTint();
        image(rotatedimage1, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 2
      if (Object>1 && Object<3) {
        pushMatrix();
        translate(Rec_xrotate+rotatedimage2.width/2, Rec_yrotate+rotatedimage2.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+rotatedimage2.width/2, Rec_yrotate+rotatedimage2.height/2);
        angle = angle + .2;
        rotate(angle);
        angle2 = angle;
        translate(-rotatedimage2.width/2, -rotatedimage2.height/2);
        noTint();
        image(rotatedimage2, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 3
      if (Object>2 && Object<4) {
        pushMatrix();
        translate(Rec_xrotate+rotatedimage3.width/2, Rec_yrotate+rotatedimage3.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+rotatedimage3.width/2, Rec_yrotate+rotatedimage3.height/2);
        angle = angle + .2;
        rotate(angle);
        angle2 = angle;
        translate(-rotatedimage3.width/2, -rotatedimage3.height/2);
        noTint();
        image(rotatedimage3, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
    }
  }

  //-------------------- mouse() / mouseDragged() --------------------//
  
  void mouse() {
    //Drag Rectangles to correct location by clicking and dragging, starting on top of the object you want to move

    //Determine which object was chosen (based on if the mouse is within the coordinates specified for each object)
    if (true) {
      if (mouseX>=(width-83) && mouseX<=(width-9) && mouseY>=(height-350)&& mouseY<=(height-309) && Status<1 && Status >-1) {
        Object = 1; //signifies that object 1 has been chosen
        Status = 1; //signifies that an object is in use (a second object can not be moved simultaneously)
        //sets initial values for blackout to the image startup location
        Rec_x2 = width-83;
        Rec_y2 = height-350;
      }
      if (mouseX>=(width-83) && mouseX<=(width-9) && mouseY>=(height-300) && mouseY<=(height-259) && Status<1 && Status>-2) {
        Object = 2; //signifies that object 2 has been chosen
        Status = 1; //signifies that an object is in use (a second object can not be used simultaneously)
        //sets initial values for blackout to the image startup location
        Rec_x2 = width-83;
        Rec_y2 = height-300;
      }
      if (mouseX>=(width-83) && mouseX<=(width-9) && mouseY>=(height-250) && mouseY<=(height-209) && Status<1 && Status>-3) {
        Object = 3; //signifies that object 3 has been chosen
        Status = 1; //signifies that an object is in use (a second object can not be used simultaneously)
        //sets initial values for blackout to the image startup location
        Rec_x2 = width-83;
        Rec_y2 = height-250;
      }

      angle = 0;
      Black.resize(76, 43);
      temp_x = mouseX;
      temp_y = mouseY;

      //If image 1  
      if (Object>0 && Object<2 && temp_x > (width-630) && temp_y > (height-335) && temp_x < (width-84) && temp_y < (height-61)) {
        //captures mouse data into variables 
        Rec_x = mouseX; 
        Rec_y = mouseY;
        pushMatrix();
        translate(Rec_x2+Black.width/2, Rec_y2+Black.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix(); 
        Rec_x2 = Rec_x;
        Rec_y2 = Rec_y;
        angle2 = 0;
        image(startupimage1, Rec_x, Rec_y); 
        counterObj1++;
      }
      //If image 2
      if (Object>1 && Object<3 && temp_x > (width-630) && temp_y > (height-335) && temp_x < (width-84) && temp_y < (height-61)) {
        //captures mouse data into variables 
        Rec_x = mouseX; 
        Rec_y = mouseY;
        pushMatrix();
        translate(Rec_x2+Black.width/2, Rec_y2+Black.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix(); 
        Rec_x2 = Rec_x;
        Rec_y2 = Rec_y;
        angle2 = 0;
        image(startupimage2, Rec_x, Rec_y); 
        counterObj2++;
      }
      //If image 3
      if (Object>2 && Object<4 && temp_x > (width-630) && temp_y > (height-335) && temp_x < (width-84) && temp_y < (height-61)) {
        //captures mouse data into variables 
        Rec_x = mouseX; 
        Rec_y = mouseY;
        pushMatrix();
        translate(Rec_x2+Black.width/2, Rec_y2+Black.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix(); 
        Rec_x2 = Rec_x;
        Rec_y2 = Rec_y;
        angle2 = 0;
        image(startupimage3, Rec_x, Rec_y);
        counterObj3++;
      }
    }
  }
}

//-------------------- GUI Event Functions --------------------//

void keyPressed() {
  // Need to determine which key was pressed here and then call the appropriate function to handle that event.
  gui2.keyboard(); 
} 

void mouseDragged() {
  gui2.mouse();
}

