var _xAxis = ((keyboard_check(vk_right)) - (keyboard_check(vk_left)));
var _yAxis = ((keyboard_check(vk_down)) - (keyboard_check(vk_up)));

if ((_xAxis != 0) || (_yAxis != 0))
{
	new Packet(PACKET_ID.C_SEND_INPUTS)
		.set("horizontal", _xAxis)
		.set("vertical", _yAxis)
		.send(socket);
}