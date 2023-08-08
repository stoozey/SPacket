#macro SPACKET_PACKET_VERSION 1														// A ID attached to every packet, used to determine if two sockets are on the same "version" of packets
#macro SPACKET_ON_WRONG_PACKET_VERSION __SPACKET_ON_WRONG_PACKET_VERSION.ERROR		// What to do when an SPacket is received which has a different SPACKET_PACKET_VERSION

#macro SPACKET_AUTOMATIC_COMPRESSION true	// If compressing a packet would increase it's size, it will be automatically compressed

#macro SPACKET_ARRAY_SIZE_BUFFER_TYPE_DEFAULT buffer_u16	// The max size of an array stored in a packet, if not supplied manually

/*
	What *numeric* buffer type to use for the header information. Do not use buffer_string/text.
	Reduce/increase these as you need to for packet size management.
	
	A potential gotcha would be changing this and having SPACKET_ON_WRONG_PACKET_VERSION set to IGNORE;
	if you change this after an already released version of your game exists, you *need* ERROR enabled.
	
	TL;DR - For future proofing, maybe add an extra byte if you think the number has any possibility of increasing later on.
*/
#macro SPACKET_PACKET_VERSION_BUFFER_TYPE buffer_u16
#macro SPACKET_PACKET_ID_BUFFER_TYPE buffer_u16