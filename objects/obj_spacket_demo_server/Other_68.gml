var _type = async_load[? "type"];
var _id = async_load[? "id"];
switch (_type)
{
	case network_type_connect:
	{
		var _ghost = instance_create_depth(irandom(room_width), irandom(room_height), 0, obj_spacket_demo_client_ghost);
		_ghost.socketId = _id;
		
		sockets[$ _id] = _ghost;
		
		__spacket_print("sending socket id");
		new Packet(PACKET_ID.S_SET_SOCKET_ID)
			.set("socketId", _id)
			.send(_id);
		
		__spacket_print("sending update position");
		new Packet(PACKET_ID.S_UPDATE_POSITION)
			.set("socketId", _id)
			.set("x", _ghost.x)
			.set("y", _ghost.y)
			.send(_id);
	}
	
	case network_type_data:
	{
		var _buffer = async_load[? "buffer"];
		var _packet = new Packet();
		_packet.deserialize(_buffer);

		switch (_packet.get_packet_id())
		{
			case PACKET_ID.C_SEND_INPUTS:
			{
				var _ghost = sockets[$ _id];
				_ghost.x += _packet.get("horizontal");
				_ghost.y += _packet.get("vertical");
				
				var _response = new Packet(PACKET_ID.S_UPDATE_POSITION)
					.set("socketId", _id)
					.set("x", _ghost.x)
					.set("y", _ghost.y);
				
				var _socketIds = variable_struct_get_names(sockets);
				var i = 0;
				repeat (array_length(_socketIds))
				{
					var _socketId = _socketIds[i++];
					_response.send(_socketId);
				}
				break;
			}
		}
		break;
	}
}