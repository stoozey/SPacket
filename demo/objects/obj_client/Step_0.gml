var _xAxis = (keyboard_check(ord("D")) - keyboard_check(ord("A")));
var _yAxis = (keyboard_check(ord("S")) - keyboard_check(ord("W")));
if ((_xAxis == 0) && (_yAxis == 0)) exit;

new Packet(PACKET_ID.C_PLAYER_UPDATE_MOVEMENT_INPUT)
	.set("horizontal", _xAxis)
	.set("vertical", _yAxis)
	.send(client);