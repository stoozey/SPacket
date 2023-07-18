enum PACKET_ID
{
	CMSG_SEND_MESSAGE,
	SMSG_SEND_MESSAGE
}

spacket_define(PACKET_ID.CMSG_SEND_MESSAGE)
	.add("message", buffer_string);

spacket_define(PACKET_ID.SMSG_SEND_MESSAGE)
	.add("message", buffer)