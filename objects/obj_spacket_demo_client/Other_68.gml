var _id = async_load[? "id"];
if (_id != socket) exit;

var _type = async_load[? "type"];
switch (_type)
{
	case network_type_data:
	{
		var _buffer = async_load[? "buffer"];
		__spacket_print("CLIENT got packet with buffer", _buffer);
		
		if (_buffer <= 0) break;
		
		var _packet = new Packet();
		_packet.deserialize(_buffer, false);
			
		switch (_packet.get_packet_id())
		{
			case PACKET_ID.S_SET_CLIENT_ID:
			{
				clientId = _packet.get("clientId");
				break;
			}
			
			case PACKET_ID.S_UPDATE_POSITION:
			{
				var _clientId = _packet.get("clientId");
				if (_clientId != clientId) break;
				
				x = _packet.get("x");
				y = _packet.get("y");
				break;
			}
		}
		break;
	}
}