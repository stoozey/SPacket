///@desc Creates a new definition for a packet
///@param {real} packetId
///@returns {PacketDefinition}
function spacket_define(_packetId)
{
	var _definitions = __spacket_get_definitions();
	var _packetInfo = new PacketDefinition();
	_definitions[$ string(_packetId)] = _packetInfo;
	
	return _packetInfo;
}

///@desc Gets an existing packet definition
///@param {real} packetId
///@returns {PacketDefinition}
function spacket_get_definition(_packetId)
{
	var _definitions = __spacket_get_definitions();
	return _definitions[$ string(_packetId)];
}

#region internal

function __spacket_get_definitions()
{
	static definitions = { };
	return definitions;
}

#endregion