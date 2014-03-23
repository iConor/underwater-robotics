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

  PImage bg1,bg2,arrow, Black, Black2, Black3, arrow_black, Rectangle_Permanent1, Rectangle_Permanent2, Rectangle_Permanent3, Rectangle_Permanent4, Rectangle_Permanent5, Rectangle_Permanent6, Rectangle_Permanent7, startupimage1, startupimage2, startupimage3, startupimage4, startupimage5, startupimage6, startupimage7, cam3, cam2;
  float counter1=0, counterObj1=0, counterObj2=0, counterObj3=0, counterObj4=0, counterObj5=0, counterObj6=0, counterObj7=0, counter_rotate = 0, Rec_x, Rec_y, Rec_x2, Rec_y2, Rec_x1perm, Rec_x2perm, Rec_x3perm, Rec_x4perm, Rec_x5perm, Rec_x6perm, Rec_x7perm, Rec_y1perm, Rec_y2perm, Rec_y3perm, Rec_y4perm, Rec_y5perm, Rec_y6perm, Rec_y7perm;
  float angle = 0, angle2 = 0, angleperm1, angleperm2, angleperm3, angleperm4, angleperm5, angleperm6, angleperm7, Rec_xrotate, Rec_yrotate, temp_x, temp_y, angle2_arrow =0, Robot_x, Robot_y, Robot_x2, Robot_y2, Robot_angle;
  float cam_place1_x=(width*.0278), cam_place1_y=(height*.052), cam_place2_x=(width*.0278), cam_place2_y=(height*.655), cam_place3_x=(width*.294), cam_place3_y=(height*.655);
  int Object = 0, Status = 0, Permanent1 = 0, Permanent2 = 0, Permanent3 = 0, Permanent4= 0, Permanent5 = 0, Permanent6 = 0, Permanent7 = 0, cam_1 = 1, cam_2 = 2, cam_3 = 3, cam_1temp, cam_2temp, cam_3temp;
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
    size(1000, 600, P3D);
    colorMode(RGB, 255);
    noStroke();
    bg1 = loadImage("bg1.jpg");
    bg1.resize(width,height);
    background(bg1);

    //load images
    startupimage1 = loadImage("Rectangle_Red1.png");
    startupimage1.resize((int)(width*.12),(int)(height*.13));
    startupimage2 = loadImage("Rectangle_Red2.png");
    startupimage2.resize((int)(width*.0548),(int)(height*.05857));
    startupimage3 = loadImage("Rectangle_Red3.png");
    startupimage3.resize((int)(width*.0548),(int)(height*.05857));
    startupimage4 = loadImage("Rectangle_Red4.png");
    startupimage4.resize((int)(width*.0548),(int)(height*.05857));
    startupimage5 = loadImage("Rectangle_Red5.png");
    startupimage5.resize((int)(width*.0333),(int)(height*.03429));
    startupimage6 = loadImage("Rectangle_Red6.png");
    startupimage6.resize((int)(width*.0333),(int)(height*.03429));
    startupimage7 = loadImage("Rectangle_Red7.png");
    startupimage7.resize((int)(width*.0548),(int)(height*.05857));
    Black = loadImage("Black.gif");
    Black.resize((int)(width*.0548),(int)(height*.05857));
    Black2 = loadImage("Black.gif");
    Black2.resize((int)(width*.0333),(int)(height*.03429));
    Black3 = loadImage("Black.gif");
    Black3.resize((int)(width*.12),(int)(height*.13));
    arrow = loadImage("arrow.gif");
    arrow.resize((int)(height*.05),(int)(height*.03));
    arrow_black = loadImage("arrow_black.gif");
    arrow_black.resize((int)(height*.05),(int)(height*.03));
    cam2 = loadImage("cam2.jpg");
    cam3 = loadImage("cam3.jpg");

    //control center rectangle
    fill(0, 0, 150);
    rect(width*.583,height*.052,width*.389,height*.39);
    //navigation rectangle
    fill(0);
    rect(width*.583, height*.48,width*.389,height*.47);
    font1 = loadFont("LilyUPCBoldItalic-48.vlw");
    textFont(font1);
    fill(150, 0, 0);
    //cameras, control center and navigation text
    //text(a, 180, 440);
    //text(f, width-420, height-370);
    //textFont(font1, 32);
    //text(b, 280, 30);
    //text(c, 780, 80);
    //text(d, 1120, 80);

    //initialize robot coordinates (remove when data stream in place)
    Robot_x = width*.8;
    Robot_x2 = width*.8;
    Robot_y = height*.8;
    Robot_y2 = height*.8;

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
      cam1 = new Capture(main_function, cameras[11]);//72
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
      image(cam1, cam_place1_x, cam_place1_y, width*.533,height*.6);
      break;
    case 2:
      image(cam2, cam_place1_x, cam_place1_y, width*.533, height*.6);
      break;
    case 3:
      image(cam3, cam_place1_x, cam_place1_y, width*.533, height*.6);
      break;
    }

    switch(cam_2) {
    case 1:
      image(cam1, cam_place2_x, cam_place2_y, width*.267, height*.295);
      break;
    case 2:
      image(cam2, cam_place2_x, cam_place2_y, width*.267, height*.295);
      break;
    case 3:
      image(cam3, cam_place2_x, cam_place2_y, width*.267, height*.295);
      break;
    }

    switch(cam_3) {
    case 1:
      image(cam1, cam_place3_x, cam_place3_y, width*.267, height*.295);
      break;
    case 2:
      image(cam2, cam_place3_x, cam_place3_y, width*.267, height*.295);
      break;
    case 3:
      image(cam3, cam_place3_x, cam_place3_y, width*.267, height*.295);
      break;
    }

    //draw grid lines
    for (int i = 0; i < 12; i++) {
      stroke(255);
      line(((width*.583)+(i)*(height*.064)),(height*.48),-1,((width*.583)+(i)*(height*.064)),((height*.48)+(height*.47)),-1);
    }
    for (int i = 0; i < 8; i++) {
      line((width*.583),((height*.47)+(i)*(height*.064)),-1,((width*.583)+(width*.39)),((height*.47)+(i)*(height*.064)),-1);
    }

    //create startup images
    if (counterObj1<1) {
      image(startupimage1, width-(.153*width), height-(.52*height));
    }
    if (counterObj2<1) {
      image(startupimage2, width-(.08741*width), height-(.3834*height));//.3986
    }
    if (counterObj3<1) {
      image(startupimage3, width-(.08741*width), height-(.3194*height));//.3314
    }
    if (counterObj4<1) {
      image(startupimage4, width-(.08741*width), height-(.2554*height));//.2643
    }
    if (counterObj5<1) {
      image(startupimage5, width-(.08741*width), height-(.1914*height));//.1971
    }
    if (counterObj6<1) {
      image(startupimage6, width-(.08741*width), height-(.1504*height));//.1543
    }
    if (counterObj7<1) {
      image(startupimage7, width-(.08741*width), height-(.1114*height));
    }
    //maintain permanent images (uses permanent data collected when 'Enter' was pressed to maintain correct placement)

    //Image number 1
    if (Permanent1>0) {
      pushMatrix();
      translate(Rec_x1perm+Rectangle_Permanent1.width/2, Rec_y1perm+Rectangle_Permanent1.height/2);
      rotate(angleperm1);
      translate(-Rectangle_Permanent1.width/2, -Rectangle_Permanent1.height/2);
      tint(255, 10);
      Rectangle_Permanent1.resize((int)(width*.12),(int)(height*.13));
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
      Rectangle_Permanent2.resize((int)(width*.0548),(int)(height*.05857));
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
      Rectangle_Permanent3.resize((int)(width*.0548),(int)(height*.05857));
      image(Rectangle_Permanent3, 0, 0);
      popMatrix();
    }
    //Image number 4
    if (Permanent4>0) {
      pushMatrix();
      translate(Rec_x4perm+Rectangle_Permanent4.width/2, Rec_y4perm+Rectangle_Permanent4.height/2);
      rotate(angleperm4);
      translate(-Rectangle_Permanent4.width/2, -Rectangle_Permanent4.height/2);
      tint(255, 10);
      Rectangle_Permanent4.resize((int)(width*.0548),(int)(height*.05857));
      image(Rectangle_Permanent4, 0, 0);
      popMatrix();
    }
    //Image number 5
    if (Permanent5>0) {
      pushMatrix();
      translate(Rec_x5perm+Rectangle_Permanent5.width/2, Rec_y5perm+Rectangle_Permanent5.height/2);
      rotate(angleperm5);
      translate(-Rectangle_Permanent5.width/2, -Rectangle_Permanent5.height/2);
      tint(255, 10);
      Rectangle_Permanent5.resize((int)(width*.0333),(int)(height*.03429));
      image(Rectangle_Permanent5, 0, 0);
      popMatrix();
    }
    //Image number 6
    if (Permanent6>0) {
      pushMatrix();
      translate(Rec_x6perm+Rectangle_Permanent6.width/2, Rec_y6perm+Rectangle_Permanent6.height/2);
      rotate(angleperm6);
      translate(-Rectangle_Permanent6.width/2, -Rectangle_Permanent6.height/2);
      tint(255, 10);
      Rectangle_Permanent6.resize((int)(width*.0333),(int)(height*.03429));
      image(Rectangle_Permanent6, 0, 0);
      popMatrix();
    }
    //Image number 7
    if (Permanent7>0) {
      pushMatrix();
      translate(Rec_x7perm+Rectangle_Permanent7.width/2, Rec_y7perm+Rectangle_Permanent7.height/2);
      rotate(angleperm7);
      translate(-Rectangle_Permanent7.width/2, -Rectangle_Permanent7.height/2);
      tint(255, 10);
      Rectangle_Permanent7.resize((int)(width*.0548),(int)(height*.05857));
      image(Rectangle_Permanent7, 0, 0);
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

    //move and rotate arrow according to coordinates and angle (when 'a' is pressed for testing)
    Robot_angle = counter1/10;
    //arrow will only appear after rectangles have been permanently placed
    if (Permanent1>0 && Permanent2>0 && Permanent3>0) {
      if (key=='a') {//replace with 'if getting coordinate and angle data'

        //blackout previous arrow
        pushMatrix();
        arrow_black.resize((int)(height*.05),(int)(height*.04));
        translate(Robot_x2, Robot_y2);
        rotate(angle2_arrow);
        translate(-arrow_black.width/2, -arrow_black.height/2);
        noTint();
        image(arrow_black, 0, 0);
        popMatrix();

        //creates current arrow
        pushMatrix();
        translate(Robot_x, Robot_y);
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
    if (keyCode == 10) { //Must press 'Enter' to make placement permanent

      if (Object==1) {
        Status = -1; //signifies that object 1 has been placed (will not allow a second object 1 to be placed)
        Object = 0; //clears object #
        Permanent1 = 1; //signifies that permanent image 1 can be created in void draw()
        Rectangle_Permanent1 = loadImage("Rectangle_Blue1.png");
        //stores coordinate and angle data for permanent location
        Rec_x1perm = Rec_x2;
        Rec_y1perm = Rec_y2;
        angleperm1 = angle2;
        angle = 0; //clears angle value
        angle2 = 0;
        counter_rotate = 0;
      }
      if (Object==2) {
        Status = -2; //signifies that object 2 has been placed (will not allow a second object 2 to be placed)
        Object = 0; //clears object #
        Permanent2 = 1; //signifies that permanent image 2 can be created in void draw()
        Rectangle_Permanent2 = loadImage("Rectangle_Blue2.png");
        //stores coordinate and angle data for permanent location
        Rec_x2perm = Rec_x2;
        Rec_y2perm = Rec_y2;
        angleperm2 = angle2;
        angle = 0; //clears angle value
        angle2 = 0;
        counter_rotate = 0;
      }
      if (Object==3) {
        Status = -3; //signifies that object 3 has been placed (will not allow a second object 3 to be placed)
        Object = 0; //clears object #
        Permanent3 = 1; //signifies that permanent image 3 can be created in void draw()
        Rectangle_Permanent3 = loadImage("Rectangle_Blue3.png");
        //stores coordinate and angle data for permanent location
        Rec_x3perm = Rec_x2;
        Rec_y3perm = Rec_y2;
        angleperm3 = angle2;
        angle = 0; //clears angle value
        angle2 = 0;
        counter_rotate = 0;
      }
       if (Object==4) {
        Status = -4; //signifies that object 4 has been placed (will not allow a second object 4 to be placed)
        Object = 0; //clears object #
        Permanent4 = 1; //signifies that permanent image 4 can be created in void draw()
        Rectangle_Permanent4 = loadImage("Rectangle_Blue4.png");
        //stores coordinate and angle data for permanent location
        Rec_x4perm = Rec_x2;
        Rec_y4perm = Rec_y2;
        angleperm4 = angle2;
        angle = 0; //clears angle value
        angle2 = 0;
        counter_rotate = 0;
      }
      if (Object==5) {
        Status = -5; //signifies that object 5 has been placed (will not allow a second object 5 to be placed)
        Object = 0; //clears object #
        Permanent5 = 1; //signifies that permanent image 5 can be created in void draw()
        Rectangle_Permanent5 = loadImage("Rectangle_Blue5.png");
        //stores coordinate and angle data for permanent location
        Rec_x5perm = Rec_x2;
        Rec_y5perm = Rec_y2;
        angleperm5 = angle2;
        angle = 0; //clears angle value
        angle2 = 0;
        counter_rotate = 0;
      }
      if (Object==6) {
        Status = -6; //signifies that object 6 has been placed (will not allow a second object 6 to be placed)
        Object = 0; //clears object #
        Permanent6 = 1; //signifies that permanent image 6 can be created in void draw()
        Rectangle_Permanent6 = loadImage("Rectangle_Blue6.png");
        //stores coordinate and angle data for permanent location
        Rec_x6perm = Rec_x2;
        Rec_y6perm = Rec_y2;
        angleperm6 = angle2;
        angle = 0; //clears angle value
        angle2 = 0;
        counter_rotate = 0;
      }
      if (Object==7) {
        Status = -7; //signifies that object 7 has been placed (will not allow a second object 7 to be placed)
        Object = 0; //clears object #
        Permanent7 = 1; //signifies that permanent image 7 can be created in void draw()
        Rectangle_Permanent7 = loadImage("Rectangle_Blue7.png");
        //stores coordinate and angle data for permanent location
        Rec_x7perm = Rec_x2;
        Rec_y7perm = Rec_y2;
        angleperm7 = angle2;
        angle = 0; //clears angle value
        angle2 = 0;
        counter_rotate = 0;
      }
    }
    if (key == 's'){//press s to reactivate Ship prop
    Permanent1 = 0;
    Rec_x = Rec_x1perm;
    Rec_y = Rec_y1perm;
    Rec_x2 = Rec_x1perm;
    Rec_y2 = Rec_y1perm;
    Object = 1;
    angle2 = angleperm1;
    }
    if (key == 'h'){//press h to reactive sink Hole prop
    Permanent2 = 0;
    Rec_x = Rec_x2perm;
    Rec_y = Rec_y2perm;
    Rec_x2 = Rec_x2perm;
    Rec_y2 = Rec_y2perm;
    Object = 2;
    angle2 = angleperm2;
    }
    if (key == 'r'){//press r to reactivate sensor Rope prop
    Permanent3 = 0;
    Rec_x = Rec_x3perm;
    Rec_y = Rec_y3perm;
    Rec_x2 = Rec_x3perm;
    Rec_y2 = Rec_y3perm;
    Object = 3;
    angle2 = angleperm3;
    }
    if (key == 'c'){//press c to reactivate Cargo container prop
    Permanent4 = 0;
    Rec_x = Rec_x4perm;
    Rec_y = Rec_y4perm;
    Rec_x2 = Rec_x4perm;
    Rec_y2 = Rec_y4perm;
    Object = 4;
    angle2 = angleperm4;
    }
    if (key == 'p'){//press p to reactivate Plastic bottle prop
    Permanent5 = 0;
    Rec_x = Rec_x5perm;
    Rec_y = Rec_y5perm;
    Rec_x2 = Rec_x5perm;
    Rec_y2 = Rec_y5perm;
    Object = 5;
    angle2 = angleperm5;
    }
    if (key == 'g'){//press g to reactivate Glass bottle prop
    Permanent6 = 0;
    Rec_x = Rec_x6perm;
    Rec_y = Rec_y6perm;
    Rec_x2 = Rec_x6perm;
    Rec_y2 = Rec_y6perm;
    Object = 6;
    angle2 = angleperm6;
    }
    if (key == 'b'){// press b to reactivate Basket
    Permanent7 = 0;
    Rec_x = Rec_x7perm;
    Rec_y = Rec_y7perm;
    Rec_x2 = Rec_x7perm;
    Rec_y2 = Rec_y7perm;
    Object = 7;
    angle2 = angleperm7;
    }
      
    //Rotate Image using left and right arrow keys (rotate images after moving them to the correct coordinate)
    Rec_xrotate = Rec_x;
    Rec_yrotate = Rec_y;

    //Rotate left
    if (keyCode == 37) {

      Black.resize((int)(width*.0548),(int)(height*.05857));
      Black2.resize((int)(width*.0333),(int)(height*.03429));
      Black3.resize((int)(width*.12),(int)(height*.13));
      //If image 1  
      if (Object==1) {
        pushMatrix();
        translate(Rec_xrotate+startupimage1.width/2, Rec_yrotate+startupimage1.height/2);
        rotate(angle2);
        translate(-Black3.width/2, -Black3.height/2);
        noTint();
        image(Black3, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage1.width/2, Rec_yrotate+startupimage1.height/2);
        angle = angle - .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage1.width/2, -startupimage1.height/2);
        noTint();
        image(startupimage1, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 2
      if (Object==2) {
        pushMatrix();
        translate(Rec_xrotate+startupimage2.width/2, Rec_yrotate+startupimage2.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage2.width/2, Rec_yrotate+startupimage2.height/2);
        angle = angle - .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage2.width/2, -startupimage2.height/2);
        noTint();
        image(startupimage2, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 3
      if (Object==3) {
        pushMatrix();
        translate(Rec_xrotate+startupimage3.width/2, Rec_yrotate+startupimage3.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage3.width/2, Rec_yrotate+startupimage3.height/2);
        angle = angle - .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage3.width/2, -startupimage3.height/2);
        noTint();
        image(startupimage3, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 4
      if (Object==4) {
        pushMatrix();
        translate(Rec_xrotate+startupimage4.width/2, Rec_yrotate+startupimage4.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage4.width/2, Rec_yrotate+startupimage4.height/2);
        angle = angle - .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage4.width/2, -startupimage4.height/2);
        noTint();
        image(startupimage4, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 5
      if (Object==5) {
        pushMatrix();
        translate(Rec_xrotate+startupimage5.width/2, Rec_yrotate+startupimage5.height/2);
        rotate(angle2);
        translate(-Black2.width/2, -Black2.height/2);
        noTint();
        image(Black2, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage5.width/2, Rec_yrotate+startupimage5.height/2);
        angle = angle - .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage5.width/2, -startupimage5.height/2);
        noTint();
        image(startupimage5, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 6
      if (Object==6) {
        pushMatrix();
        translate(Rec_xrotate+startupimage6.width/2, Rec_yrotate+startupimage6.height/2);
        rotate(angle2);
        translate(-Black2.width/2, -Black2.height/2);
        noTint();
        image(Black2, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage6.width/2, Rec_yrotate+startupimage6.height/2);
        angle = angle - .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage6.width/2, -startupimage6.height/2);
        noTint();
        image(startupimage6, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 7
      if (Object==7) {
        pushMatrix();
        translate(Rec_xrotate+startupimage7.width/2, Rec_yrotate+startupimage7.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage7.width/2, Rec_yrotate+startupimage7.height/2);
        angle = angle - .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage7.width/2, -startupimage7.height/2);
        noTint();
        image(startupimage7, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
    }
    //Rotate Right
    if (keyCode>38 && keyCode<40) {

      Black.resize((int)(width*.0548),(int)(height*.05857));
      Black2.resize((int)(width*.0333),(int)(height*.03429));
      Black3.resize((int)(width*.12),(int)(height*.13));
      //If image 1  
      if (Object==1) {
        pushMatrix();
        translate(Rec_xrotate+startupimage1.width/2, Rec_yrotate+startupimage1.height/2);
        rotate(angle2);
        translate(-Black3.width/2, -Black3.height/2);
        noTint();
        image(Black3, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage1.width/2, Rec_yrotate+startupimage1.height/2);
        angle = angle + .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage1.width/2, -startupimage1.height/2);
        noTint();
        image(startupimage1, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 2
      if (Object==2) {
        pushMatrix();
        translate(Rec_xrotate+startupimage2.width/2, Rec_yrotate+startupimage2.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage2.width/2, Rec_yrotate+startupimage2.height/2);
        angle = angle + .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage2.width/2, -startupimage2.height/2);
        noTint();
        image(startupimage2, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 3
      if (Object==3) {
        pushMatrix();
        translate(Rec_xrotate+startupimage3.width/2, Rec_yrotate+startupimage3.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage3.width/2, Rec_yrotate+startupimage3.height/2);
        angle = angle + .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage3.width/2, -startupimage3.height/2);
        noTint();
        image(startupimage3, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 4
      if (Object==4) {
        pushMatrix();
        translate(Rec_xrotate+startupimage4.width/2, Rec_yrotate+startupimage4.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage4.width/2, Rec_yrotate+startupimage4.height/2);
        angle = angle + .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage4.width/2, -startupimage4.height/2);
        noTint();
        image(startupimage4, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 5
      if (Object==5) {
        pushMatrix();
        translate(Rec_xrotate+startupimage5.width/2, Rec_yrotate+startupimage5.height/2);
        rotate(angle2);
        translate(-Black2.width/2, -Black2.height/2);
        noTint();
        image(Black2, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage5.width/2, Rec_yrotate+startupimage5.height/2);
        angle = angle + .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage5.width/2, -startupimage5.height/2);
        noTint();
        image(startupimage5, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 6
      if (Object==6) {
        pushMatrix();
        translate(Rec_xrotate+startupimage6.width/2, Rec_yrotate+startupimage6.height/2);
        rotate(angle2);
        translate(-Black2.width/2, -Black2.height/2);
        noTint();
        image(Black2, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage6.width/2, Rec_yrotate+startupimage6.height/2);
        angle = angle + .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage6.width/2, -startupimage6.height/2);
        noTint();
        image(startupimage6, 0, 0 );
        popMatrix();
        counter_rotate++;
      }
      //If image 7
      if (Object==7) {
        pushMatrix();
        translate(Rec_xrotate+startupimage7.width/2, Rec_yrotate+startupimage7.height/2);
        rotate(angle2);
        translate(-Black.width/2, -Black.height/2);
        noTint();
        image(Black, 0, 0);
        popMatrix();   
        pushMatrix();
        translate(Rec_xrotate+startupimage7.width/2, Rec_yrotate+startupimage7.height/2);
        angle = angle + .2;
        rotate(angle);
        angle2 = angle;
        translate(-startupimage7.width/2, -startupimage7.height/2);
        noTint();
        image(startupimage7, 0, 0 );
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
      if (mouseX>=(width-.153*width) && mouseX<=(width-.033*width) && mouseY>=(height-.52*height)&& mouseY<=(height-.39*height) && Status<1 && Permanent1 < 1) {
        Object = 1; //signifies that object 1 has been chosen
        Status = 1; //signifies that an object is in use (a second object can not be moved simultaneously)
        //sets initial values for blackout to the image startup location
        Rec_x2 = width-.153*width;
        Rec_y2 = height-.52*height;
      }
      if (mouseX>=(width-.08741*width) && mouseX<=(width-.03261*width) && mouseY>=(height-.3834*height) && mouseY<=(height-.32483*height) && Status<1 && Permanent2 < 1) {
        Object = 2; //signifies that object 2 has been chosen
        Status = 1; //signifies that an object is in use (a second object can not be used simultaneously)
        //sets initial values for blackout to the image startup location
        Rec_x2 = width-.08741*width;
        Rec_y2 = height-.3834*height;
      }
      if (mouseX>=(width-.08741*width) && mouseX<=(width-.03261*width) && mouseY>=(height-.3194*height) && mouseY<=(height-.25783*height) && Status<1 && Permanent3 < 1) {
        Object = 3; //signifies that object 3 has been chosen
        Status = 1; //signifies that an object is in use (a second object can not be used simultaneously)
        //sets initial values for blackout to the image startup location
        Rec_x2 = width-.08741*width;
        Rec_y2 = height-.3194*height;
      }
      if (mouseX>=(width-.08741*width) && mouseX<=(width-.03261*width) && mouseY>=(height-.2554*height) && mouseY<=(height-.19683*height) && Status<1 && Permanent4 < 1) {
        Object = 4; //signifies that object 3 has been chosen
        Status = 1; //signifies that an object is in use (a second object can not be used simultaneously)
        //sets initial values for blackout to the image startup location
        Rec_x2 = width-.08741*width;
        Rec_y2 = height-.2554*height;
      }
      if (mouseX>=(width-.08741*width) && mouseX<=(width-.05411*width) && mouseY>=(height-.1914*height) && mouseY<=(height-.15711*height) && Status<1 && Permanent5 < 1) {
        Object = 5; //signifies that object 3 has been chosen
        Status = 1; //signifies that an object is in use (a second object can not be used simultaneously)
        //sets initial values for blackout to the image startup location
        Rec_x2 = width-.08741*width;
        Rec_y2 = height-.1914*height;
      }
      if (mouseX>=(width-.8741*width) && mouseX<=(width-.05411*width) && mouseY>=(height-.1504*height) && mouseY<=(height-.11611*height) && Status<1 && Permanent6 < 1) {
        Object = 6; //signifies that object 3 has been chosen
        Status = 1; //signifies that an object is in use (a second object can not be used simultaneously)
        //sets initial values for blackout to the image startup location
        Rec_x2 = width-.08741*width;
        Rec_y2 = height-.1504*height;
      }
      if (mouseX>=(width-.08741*width) && mouseX<=(width-.03261*width) && mouseY>=(height-.1114*height) && mouseY<=(height-.05543*height) && Status<1 && Permanent7 < 1) {
        Object = 7; //signifies that object 3 has been chosen
        Status = 1; //signifies that an object is in use (a second object can not be used simultaneously)
        //sets initial values for blackout to the image startup location
        Rec_x2 = width-.08741*width;
        Rec_y2 = height-.1114*height;
      }

      angle = 0;
      Black.resize((int)(width*.0548),(int)(height*.05857));
      Black2.resize((int)(width*.0333),(int)(height*.03429));
      Black3.resize((int)(width*.12),(int)(height*.13));
      temp_x = mouseX;
      temp_y = mouseY;

      //If image 1  
      if (Object==1 && temp_x > (width*.591) && temp_y > (height*.55) && temp_x < (width*.844) && temp_y < (height*.7585)) {
        //captures mouse data into variables 
        Rec_x = mouseX; 
        Rec_y = mouseY;
        pushMatrix();
        translate(Rec_x2+Black3.width/2, Rec_y2+Black3.height/2);
        rotate(angle2);
        translate(-Black3.width/2, -Black3.height/2);
        noTint();
        image(Black3, 0, 0);
        popMatrix(); 
        Rec_x2 = Rec_x;
        Rec_y2 = Rec_y;
        pushMatrix();
        translate(Rec_x+startupimage1.width/2, Rec_y+startupimage1.height/2);
        rotate(angle2);
        translate(-startupimage1.width/2, -startupimage1.height/2);
        image(startupimage1, 0, 0);
        popMatrix();
        counterObj1++;
      }
      //If image 2
      if (Object==2 && temp_x > (width*.585) && temp_y > (height*.518) && temp_x < (width*.914) && temp_y < (height*.86)) {
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
        pushMatrix();
        translate(Rec_x+startupimage2.width/2, Rec_y+startupimage2.height/2);
        rotate(angle2);
        translate(-startupimage2.width/2, -startupimage2.height/2);
        image(startupimage2, 0, 0);
        popMatrix();
        counterObj2++;
      }
      //If image 3
      if (Object==3 && temp_x > (width*.585) && temp_y > (height*.518) && temp_x < (width*.914) && temp_y < (height*.86)) {
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
        pushMatrix();
        translate(Rec_x+startupimage3.width/2, Rec_y+startupimage3.height/2);
        rotate(angle2);
        translate(-startupimage3.width/2, -startupimage3.height/2);
        image(startupimage3, 0, 0);
        popMatrix();
        counterObj3++;
      }
      //If image 4 
      if (Object==4 && temp_x > (width*.585) && temp_y > (height*.518) && temp_x < (width*.914) && temp_y < (height*.86)) {
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
        pushMatrix();
        translate(Rec_x+startupimage4.width/2, Rec_y+startupimage4.height/2);
        rotate(angle2);
        translate(-startupimage4.width/2, -startupimage4.height/2);
        image(startupimage4, 0, 0);
        popMatrix();
        counterObj4++;
      }
      //If image 5 
      if (Object==5 && temp_x > (width*.585) && temp_y > (height*.5) && temp_x < (width*.935) && temp_y < (height*.895)) {
        //captures mouse data into variables 
        Rec_x = mouseX; 
        Rec_y = mouseY;
        pushMatrix();
        translate(Rec_x2+Black2.width/2, Rec_y2+Black2.height/2);
        rotate(angle2);
        translate(-Black2.width/2, -Black2.height/2);
        noTint();
        image(Black2, 0, 0);
        popMatrix(); 
        Rec_x2 = Rec_x;
        Rec_y2 = Rec_y;
        pushMatrix();
        translate(Rec_x+startupimage5.width/2, Rec_y+startupimage5.height/2);
        rotate(angle2);
        translate(-startupimage5.width/2, -startupimage5.height/2);
        image(startupimage5, 0, 0);
        popMatrix();
        counterObj5++;
      }
      //If image 6
      if (Object==6 && temp_x > (width*.585) && temp_y > (height*.5) && temp_x < (width*.935) && temp_y < (height*.895)) {
        //captures mouse data into variables 
        Rec_x = mouseX; 
        Rec_y = mouseY;
        pushMatrix();
        translate(Rec_x2+Black2.width/2, Rec_y2+Black2.height/2);
        rotate(angle2);
        translate(-Black2.width/2, -Black2.height/2);
        noTint();
        image(Black2, 0, 0);
        popMatrix(); 
        Rec_x2 = Rec_x;
        Rec_y2 = Rec_y;
        pushMatrix();
        translate(Rec_x+startupimage6.width/2, Rec_y+startupimage6.height/2);
        rotate(angle2);
        translate(-startupimage6.width/2, -startupimage6.height/2);
        image(startupimage6, 0, 0);
        popMatrix();
        counterObj6++;
      }
      //If image 7
      if (Object==7 && temp_x > (width*.585) && temp_y > (height*.518) && temp_x < (width*.914) && temp_y < (height*.86)) {
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
        pushMatrix();
        translate(Rec_x+startupimage7.width/2, Rec_y+startupimage7.height/2);
        rotate(angle2);
        translate(-startupimage7.width/2, -startupimage7.height/2);
        image(startupimage7, 0, 0);
        popMatrix();
        counterObj7++;
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


