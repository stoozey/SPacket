//@returns Packet
function spacket_define(_packetId)
{
	var _definitions = __spacket_get_definitions();
	var _packetInfo = new __spacket_class_packet_info();
	_definitions[$ _packetId] = _packetInfo;
	
	return _packetInfo;
}

function spacket_get_definition(_packetId)
{
	var _definitions = __spacket_get_definitions();
	return _definitions[$ _packetId];
}

function __spacket_get_definitions()
{
	static definitions = { };
	return definitions;
}