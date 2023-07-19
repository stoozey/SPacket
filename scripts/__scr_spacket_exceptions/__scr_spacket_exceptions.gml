function __spacket_class_exception(_message, _longMessage = undefined) constructor
{
	message = ("SPacket: " + _message);
	longMessage = _longMessage;
}

function __spacket_class_exception_generic(_errorMessage)
	: __spacket_class_exception("Generic", _errorMessage) constructor {}

function __spacket_class_exception_invalid_packet_signature()
	: __spacket_class_exception("Invalid packet signature") constructor {}

function __spacket_class_exception_invalid_packet_data(_valueName, _bufferType)
	: __spacket_class_exception("Invalid packet data") constructor 
{
	longMessage = __spacket_string_build("Value ", _valueName, "'s bufferType was not of index ", _bufferType);
}

function __spacket_class_exception_mismatched_packet_version(_packetId, _otherPacketVersion)
	: __spacket_class_exception("Mismatched packet version") constructor
{
	longMessage = __spacket_string_build("Got packet #", _packetId, " with mismatched SPACKET_PACKET_VERSION (we are ", __SPACKET_PACKET_VERSION, ", they are ", _otherPacketVersion, ")");
}