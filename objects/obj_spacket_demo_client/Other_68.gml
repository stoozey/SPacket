var _type = async_load[? "type"];
switch (_type)
{
	case network_type_data:
	{
		var _buffer = async_load[? "buffer"];
		var _packet = new Packet();
		_packet.deserialize(_buffer);
		
		__spacket_print("received server packet");
		
		switch (_packet.get_packet_id())
		{
			case PACKET_ID.S_SET_SOCKET_ID:
			{
				socketId = _packet.get("socketId");
				break;
			}
			
			case PACKET_ID.S_UPDATE_POSITION:
			{
				var _socketId = _packet.get("socketId");
				if (socketId != _socketId) break;
				
				x = _packet.get("x");
				y = _packet.get("y");
				break;
			}
		}
		break;
	}
}