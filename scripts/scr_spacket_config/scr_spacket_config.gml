#macro SPACKET_PACKET_VERSION 1														// A ID attached to every packet, used to determine if two sockets are on the same "version" of packets
#macro SPACKET_ON_WRONG_PACKET_VERSION __SPACKET_ON_WRONG_PACKET_VERSION.ERROR		// What to do when an SPacket is received which has a different SPACKET_PACKET_VERSION


/*
	What--numeric--buffer type to use for the header information. Do not use buffer_string/text.
	Reduce/increase these as you need to for packet size management.
	
	A potential gotcha would be changing this and having SPACKET_ON_WRONG_PACKET_VERSION set to IGNORE;
	if you change this after an already released version of your game exists, you *need* ERROR enabled.
*/
#macro SPACKET_PACKET_VERSION_BUFFER_TYPE buffer_u16
#macro SPACKET_PACKET_ID_BUFFER_TYPE buffer_u16