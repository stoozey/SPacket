var _id = async_load[? "id"];
var _type = async_load[? "type"];
switch (_type)
{
	case network_type_connect:
	{
		if (_id != server) break;
		
		var _socketId = async_load[? "socket"];
		AddPlayer(_socketId);
		break;
	}
	
	case network_type_disconnect:
	{
		if (_id != server) break;
		
		var _socketId = async_load[? "socket"];
		var _playerId = GetPlayerId(_socketId);
		RemovePlayer(_playerId);
		break;
	}
	
	case network_type_data:
	{
		var _sendingPlayerId = GetPlayerId(_id);
		if (_sendingPlayerId == undefined) break;
		
		var _buffer = async_load[? "buffer"];
		var _packet = new Packet().deserialize(_buffer);
		switch (_packet.get_packet_id())
		{
			case PACKET_ID.C_PLAYER_REQUEST_POSITION:
			{
				var _playerId = _packet.get("playerId");
				var _position = GetPlayerPosition(_playerId);
				new Packet(PACKET_ID.S_PLAYER_UPDATE_POSITION)
					.set("playerId", _playerId)
					.set("x", _position.x)
					.set("y", _position.y)
					.send(_id);
				break;
			}
			
			case PACKET_ID.C_PLAYER_UPDATE_MOVEMENT_INPUT:
			{
				var _horizontal = _packet.get("horizontal");
				var _vertical = _packet.get("vertical");
				var _position = GetPlayerPosition(_sendingPlayerId);
				var _x = (_position.x + sign(_horizontal));
				var _y = (_position.y + sign(_vertical));
				_position.x = _x;
				_position.y = _y;
				
				var _socketIds = GetSocketIds();
				new Packet(PACKET_ID.S_PLAYER_UPDATE_POSITION)
					.set("playerId", _sendingPlayerId)
					.set("x", _x)
					.set("y", _y)
					.send(_socketIds);
				break;
			}
		}
		break;
	}
	
}