var b = require('bonescript');

var dgram = require('dgram');

var fs = require('fs');

var tty = require('tty');

var assert = require('assert');

var state = b.LOW;

var ip = '192.168.7.2';

b.pinMode("USR0", b.OUTPUT);
b.pinMode("USR1", b.OUTPUT);
b.pinMode("USR2", b.OUTPUT);
b.pinMode("USR3", b.OUTPUT);
setInterval(toggle, 1000);



var serial = dgram.createSocket("udp4");
var pwm_server9_14 = dgram.createSocket("udp4");
var pwm_server9_22 = dgram.createSocket("udp4");
var pwm_server9_42 = dgram.createSocket("udp4");
var pwm_server8_19 = dgram.createSocket("udp4");

var serial_4 = fs.createWriteStream('/dev/ttyO4');

var 
pwm9_14=fs.createWriteStream('/sys/devices/ocp.2/pwm_test_P9_14.15/duty');

var 
pwm9_22=fs.createWriteStream('/sys/devices/ocp.2/pwm_test_P9_22.14/duty');

var 
pwm9_42=fs.createWriteStream('/sys/devices/ocp.2/pwm_test_P9_42.17/duty');

var 
pwm8_19=fs.createWriteStream('/sys/devices/ocp.2/pwm_test_P8_19.16/duty');

serial.on("error", function(err) {
	console.log("server error:\n" + err.stack);
	server.close();
});

serial.on("message", function(msg, rinfo) {
    b.digitalWrite("USR2",b.HIGH);
    console.log('message: '+msg);


serial_4.write( msg );
b.digitalWrite("USR2", b.LOW);

});


serial.on("listening", function() {
	var address = serial.address();
	console.log("server listening " + address.address + ":" + 
address.port);
});

serial.bind(41234, ip);

pwm_server9_14.on("error", function(err) {
        console.log("server error:\n" + err.stack);
        server.close();
});

pwm_server9_14.on("message", function(msg, rinfo) {
    b.digitalWrite("USR1",b.HIGH);
    console.log('message: '+msg);


pwm9_14.write( msg );
b.digitalWrite("USR1", b.LOW);

});

pwm_server9_14.on("listening", function () {
        var address = pwm_server9_14.address();
        console.log("server listening " + address.address + ":" +
address.port);
});

pwm_server9_14.bind(41235, ip);

pwm_server9_22.on("error", function(err) {
        console.log("server error:\n" + err.stack);
        server.close();
});

pwm_server9_22.on("message", function(msg, rinfo) {
    b.digitalWrite("USR1",b.HIGH);
    console.log('message: '+msg);


pwm9_22.write( msg );
b.digitalWrite("USR1", b.LOW);

});

pwm_server9_22.on("listening", function () {
        var address = pwm_server9_22.address();
        console.log("server listening " + address.address + ":" +
address.port);
});

pwm_server9_22.bind(41236, ip);

pwm_server9_42.on("error", function(err) {
        console.log("server error:\n" + err.stack);
        server.close();
});

pwm_server9_42.on("message", function(msg, rinfo) {
    b.digitalWrite("USR1",b.HIGH);
    console.log('message: '+msg);


pwm9_42.write( msg );
b.digitalWrite("USR1", b.LOW);

});

pwm_server9_42.on("listening", function () {
        var address = pwm_server9_42.address();
        console.log("server listening " + address.address + ":" +
address.port);
});

pwm_server9_42.bind(41237, ip);

pwm_server8_19.on("error", function(err) {
        console.log("server error:\n" + err.stack);
        server.close();
});

pwm_server8_19.on("message", function(msg, rinfo) {
    b.digitalWrite("USR1",b.HIGH);
    console.log('message: '+msg);


pwm8_19.write( msg );
b.digitalWrite("USR1", b.LOW);

});

pwm_server8_19.on("listening", function () {
        var address = pwm_server8_19.address();
        console.log("server listening " + address.address + ":" +
address.port);
});

pwm_server8_19.bind(41238, ip);

function toggle() {
	if (state == b.LOW) state = b.HIGH;
	else state = b.LOW;
	b.digitalWrite("USR3", state);
}
