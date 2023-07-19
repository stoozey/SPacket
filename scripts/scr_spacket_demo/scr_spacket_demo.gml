#macro SPACKET_DEMO_IP "127.0.0.1"
#macro SPACKET_DEMO_PORT 4736

enum PACKET_ID
{
	C_SEND_INPUTS,
	
	S_SET_CLIENT_ID,
	S_UPDATE_POSITION
}

spacket_define(PACKET_ID.S_SET_CLIENT_ID)
	.set("clientId", buffer_u8);

spacket_define(PACKET_ID.C_SEND_INPUTS)
	.set("horizontal", buffer_s8)
	.set("vertical", buffer_s8);

spacket_define(PACKET_ID.S_UPDATE_POSITION)
	.set("clientId", buffer_s8)
	.set("x", buffer_s8)
	.set("y", buffer_s8);