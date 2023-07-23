#macro SPACKET_PACKET_VERSION 1														// A ID attached to every packet, used to determine if two sockets are on the same "version" of packets
#macro SPACKET_ON_WRONG_PACKET_VERSION __SPACKET_ON_WRONG_PACKET_VERSION.ERROR		// What to do when an SPacket is received which has a different SPACKET_PACKET_VERSION

// What--numeric--buffer type to use for the header information.
// Reduce/increase these as you need to for packet size management.
// Do not use strings/text.
#macro SPACKET_PACKET_VERSION_BUFFER_TYPE buffer_u16
#macro SPACKET_PACKET_ID_BUFFER_TYPE buffer_u16