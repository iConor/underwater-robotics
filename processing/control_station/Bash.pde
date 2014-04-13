String convertToString()
{
  
  String commandString = starboard_thruster_servo_angle+" "+port_thruster_servo_angle+" "+
                   aft_thruster_motor_power4+" "+aft_thruster_motor_powerB+" "+
                   motorControl(128,1,starboard_thruster_motor_power)+" "+
                   motorControl(128,2,port_thruster_motor_power);
   
   //println(commandString);
   
  return commandString;
  
}
String motorControl( int address_, int motor_, int power ) {
  byte thing1_;
  int speed_;
  int thing2_;
  if( motor_ == 1 ) {
    if( power >= 128 ) {
      thing1_ = ( byte ) 0;
      speed_ = power - 127;
      thing2_ = ( speed_ + address_ ) & 127;
    } 
    else {
      thing1_ = 1;
      speed_ = 127 - power;
      thing2_ = ( speed_ + address_ + 1 ) & 127;
    }
  }
  else { // motor_ == 2
    if( power >= 128 ) {
      thing1_ = 4;
      speed_ = power - 127;
      thing2_ = ( speed_ + address_ + 4 ) & 127;
    }
    else {
      thing1_ = 5;
      speed_ = 127 - power;
      thing2_ = ( speed_ + address_ + 5 ) & 127;
    }
  }
  
  byte speed__ =byte(speed_);
  byte address__=byte(address_);
  byte thing2__=byte(thing2_);
  
  String out = " \"\\x"+hex(address__)+"\" \"\\x"+hex(thing1_)+"\" \"\\x"+hex(speed__)+"\" \"\\x"+hex(thing2__)+"\"";
  
  return out;
}
