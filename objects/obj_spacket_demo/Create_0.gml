enum PACKET_ID
{
	C_SEND_MESSAGE,
	S_SEND_MESSAGE,
	
	C_SEND_INPUTS,
	S_UPDATE_POSITION
}

spacket_define(PACKET_ID.C_SEND_MESSAGE)
	.set("message", buffer_string);

spacket_define(PACKET_ID.S_SEND_MESSAGE)
	.set("message", buffer_string);


spacket_define(PACKET_ID.C_SEND_INPUTS)
	.set("horizontal", buffer_s8)
	.set("vertical", buffer_s8);

spacket_define(PACKET_ID.S_UPDATE_POSITION)
	.set("x", buffer_s8)
	.set("y", buffer_s8);


var _buffer = new Packet(PACKET_ID.C_SEND_INPUTS)
	.set("horizontal", 1)
	.set("vertical", -1)
	.serialize();

buffer_save(_buffer, "poop.bin");

var _packet = new Packet();
_packet.deserialize(_buffer);

__spacket_print(_packet.get("horizontal"), ", ", _packet.get("vertical"));