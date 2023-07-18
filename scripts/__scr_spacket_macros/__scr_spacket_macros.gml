#macro __SPACKET_VERSION "1.0.0"

enum __SPACKET_ON_WRONG_PACKET_VERSION
{
	IGNORE,	// ignores the packet
	ERROR,	// throws an error
	ACCEPT	// accepts the packet anyway
}