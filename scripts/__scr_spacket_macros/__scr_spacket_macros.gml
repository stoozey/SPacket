#macro __SPACKET_VERSION "1.0.0"

#macro __SPACKET_PACKET_SIGNATURE "SP"

#macro __SPACKET_HEADER_SIZE (string_length(__SPACKET_PACKET_SIGNATURE) + buffer_sizeof(SPACKET_PACKET_VERSION_BUFFER_TYPE) + buffer_sizeof(SPACKET_PACKET_ID_BUFFER_TYPE) + buffer_sizeof(buffer_bool)) // signature + packet version + packet id + is compressed

#macro __SPACKET_PACKET_VERSION string(SPACKET_PACKET_VERSION)

enum __SPACKET_ON_WRONG_PACKET_VERSION
{
	ERROR,	// throws an error
	ACCEPT	// accepts the packet anyway
}