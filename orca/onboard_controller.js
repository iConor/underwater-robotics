////////////////////////////
// Require/Import/Include //
////////////////////////////

var dgram = require('dgram');
var fs = require('fs');

///////////////
// Constants //
///////////////

var MY_IP = '192.168.1.101';

////////////////////
// Port Servo PWM //
////////////////////

var duty9_22 = fs.createWriteStream('/sys/devices/ocp.3/pwm_test_P9_22.15/duty');
var udp9_22 = dgram.createSocket('udp4');
udp9_22.bind(9022,MY_IP);
udp9_22.on("message", function (msg, rinfo) {
	console.log("Port 9022 received: " + msg + " from " +
		rinfo.address + ":" + rinfo.port);
	duty9_22.write(msg);
});
udp9_22.on("listening", function () {
	var address = udp9_22.address();
	console.log("Port 9022 listening on " +
		address.address + ":" + address.port);
});
udp9_22.on("close", function () {
	console.log("Port 9022 closed.");
});
udp9_22.on("error", function (err) {
	console.log("Port 9022 error:\n" + err.stack);
	udp9_22.close();
});

////////////////////
// Stbd Servo PWM //
////////////////////

var duty9_14 = fs.createWriteStream('/sys/devices/ocp.3/pwm_test_P9_14.16/duty');
var udp9_14 = dgram.createSocket('udp4');
udp9_14.bind(9014,MY_IP);
udp9_14.on("message", function (msg, rinfo) {
	console.log("Port 9014 received: " + msg + " from " +
		rinfo.address + ":" + rinfo.port);
	duty9_14.write(msg);
});
udp9_14.on("listening", function () {
	var address = udp9_14.address();
	console.log("Port 9014 listening on " +
		address.address + ":" + address.port);
});
udp9_14.on("close", function () {
	console.log("Port 9014 closed.");
});
udp9_14.on("error", function (err) {
	console.log("Port 9014 error:\n" + err.stack);
	udp9_14.close();
});

///////////////////
// Pan Servo PWM //
///////////////////

var duty8_19 = fs.createWriteStream('/sys/devices/ocp.3/pwm_test_P8_19.17/duty');
var udp8_19 = dgram.createSocket('udp4');
udp8_19.bind(8019,MY_IP);
udp8_19.on("message", function (msg, rinfo) {
	console.log("Port 8019 received: " + msg + " from " +
		rinfo.address + ":" + rinfo.port);
	duty8_19.write(msg);
});
udp8_19.on("listening", function () {
	var address = udp8_19.address();
	console.log("Port 8019 listening on " +
		address.address + ":" + address.port);
});
udp8_19.on("close", function () {
	console.log("Port 8019 closed.");
});
udp8_19.on("error", function (err) {
	console.log("Port 8018 error:\n" + err.stack);
	udp8_19.close();
});

////////////////////
// Titl Servo PWM //
////////////////////

var duty9_42 = fs.createWriteStream('/sys/devices/ocp.3/pwm_test_P9_42.18/duty');
var udp9_42 = dgram.createSocket('udp4');
udp9_42.bind(9042,MY_IP);
udp9_42.on("message", function (msg, rinfo) {
	console.log("Port 9042 received: " + msg + " from " +
		rinfo.address + ":" + rinfo.port);
	duty9_42.write(msg);
});
udp9_42.on("listening", function () {
	var address = udp9_42.address();
	console.log("Port 9042 listening on " +
		address.address + ":" + address.port);
});
udp9_42.on("close", function () {
	console.log("Port 9042 closed.");
});
udp9_42.on("error", function (err) {
	console.log("Port 9042 error:\n" + err.stack);
	udp9_42.close();
});

/////////////////
// Serial Port //
/////////////////

var ttySerial = fs.createWriteStream('/dev/ttyO1');
var udpSerial = dgram.createSocket('udp4');
udpSerial.bind(9024,MY_IP);

udpSerial.on("message", function (msg, rinfo){
	console.log("Port 9024 received: " + msg + " from " +
		rinfo.address + ":" + rinfo.port);
	var buf = new Buffer(msg.toString(),'hex');
	ttySerial.write(buf);
});
udpSerial.on("listening", function () {
	var address = udpSerial.address();
	console.log("Port 9024 listening on " +
		address.address + ":" + address.port);
});
udpSerial.on("close", function () {
	console.log("Port 9024 closed.");
});
udpSerial.on("error", function (err) {
	console.log("Port 9024 error:\n" + err.stack);
	udpSerial.close();
});
