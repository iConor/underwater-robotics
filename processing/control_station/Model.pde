public class Model {

  private float _yaw;
  private float _pitch;
  private float _roll;

  private float _depth_pressure;
  private float _depth_temperature;

  private byte _port_thruster_motor_power;
  private int _port_thruster_servo_angle;

  private byte _starboard_thruster_motor_power;
  private int _starboard_thruster_servo_angle;

  private byte _aft_thruster_motor_power;

  private int _camera_pan_servo_angle = 90;
  private int _camera_tilt_servo_angle = 90;

  public Model() {
  }

  //-------------------- get/set IMU --------------------//

  public float yaw() {
    return _yaw;
  }
  public void yaw( float yaw) {
    this._yaw = yaw;
  }
  public float pitch() {
    return _pitch;
  }
  public void pitch( float pitch) {
    this._pitch = pitch;
  }
  public float roll() {
    return _roll;
  }
  public void roll( float roll) {
    this._roll = roll;
  }

  //-------------------- get/set Depth --------------------//


  public float depth_pressure() {
    return _depth_pressure;
  }
  public void depth_pressure( float depth_pressure) {
    this._depth_pressure = depth_pressure;
  }
  public float depth_temperature() {
    return _depth_temperature;
  }
  public void depth_temperature( float depth_temperature) {
    this._depth_temperature = depth_temperature;
  }

  //-------------------- get/set Port Thruster --------------------//


  public byte port_thruster_motor_power() {
    return _port_thruster_motor_power;
  }
  public void port_thruster_motor_power( byte port_thruster_motor_power) {
    this._port_thruster_motor_power = port_thruster_motor_power;
  }
  public int port_thruster_servo_angle() {
    return _port_thruster_servo_angle;
  }
  public void port_thruster_servo_angle( int port_thruster_servo_angle) {
    this._port_thruster_servo_angle = port_thruster_servo_angle;
  }

  //-------------------- get/set Starboard Thruster --------------------//

  public byte starboard_thruster_motor_power() {
    return _starboard_thruster_motor_power;
  }
  public void starboard_thruster_motor_power( byte starboard_thruster_motor_power) {
    this._starboard_thruster_motor_power = starboard_thruster_motor_power;
  }
  public int starboard_thruster_servo_angle() {
    return _starboard_thruster_servo_angle;
  }
  public void starboard_thruster_servo_angle( int starboard_thruster_servo_angle) {
    this._starboard_thruster_servo_angle = starboard_thruster_servo_angle;
  }

  //-------------------- get/set Aft Thruster --------------------//

  public byte aft_thruster_motor_power() {
    return _aft_thruster_motor_power;
  }
  public void aft_thruster_motor_power( byte aft_thruster_motor_power) {
    this._aft_thruster_motor_power = aft_thruster_motor_power;
  }

  //-------------------- get/set Camera --------------------//

  public int camera_pan_servo_angle() {
    return _camera_pan_servo_angle;
  }
  public void camera_pan_servo_angle( int camera_pan_servo_angle) {
    _camera_pan_servo_angle = camera_pan_servo_angle;
  }
  public int camera_tilt_servo_angle() {
    return _camera_tilt_servo_angle;
  }
  public void camera_tilt_servo_angle( int camera_tilt_servo_angle) {
    this._camera_tilt_servo_angle = camera_tilt_servo_angle;
  }
  
}

