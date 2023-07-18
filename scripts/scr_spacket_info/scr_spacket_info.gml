global.__spacket_definitions = { };

function spacket_define(_packetId)
{
	var _packetInfo = new __spacket_class_packet_info();
	global.__spacket_definitions[$ string(_packetId)] = _packetInfo;
	
	return _packetInfo;
}

function spacket_get_definition(_packetId)
{
	return global.__spacket_definitions[$ string(_packetId)];
}