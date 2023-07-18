var _id = async_load[? "id"];
var _type = async_load[? "type"];
var _ip = async_load[? "ip"];
switch (_type)
{
	case network_type_connect:
	{
		with (obj_spacket_demo_server)
		{
			var _socketId = async_load[? "socket"];
			var _ghost = instance_create_depth(irandom(room_width), irandom(room_height), 0, obj_spacket_demo_client_ghost);
			_ghost.socketId = _socketId;
		
			socketIds[$ _ip] = _socketId;
			ghosts[$ _socketId] = _ghost;
		
			__spacket_print("sending socket id from ", server, " to ", _socketId);
			new Packet(PACKET_ID.S_SET_SOCKET_ID)
				.set("socketId", _socketId)
				.send(_socketId);
		}
		break;
	}
	
	case network_type_data:
	{
		var _buffer = async_load[? "buffer"];
		var _packet = new Packet();
		_packet.deserialize(_buffer);
		
		__spacket_print("id ", _id, " | server ", obj_spacket_demo_server.server, " | socket ", obj_spacket_demo_client.socket);
		
		if (_id == obj_spacket_demo_server.server)
		{
			__spacket_print("received client packet");
			
			with (obj_spacket_demo_server)
			{
				var _sendingSocketId = async_load[? "ip"];
				switch (_packet.get_packet_id())
				{
					case PACKET_ID.C_SEND_INPUTS:
					{
				
						var _ghost = ghosts[$ _sendingSocketId];
						_ghost.x += _packet.get("horizontal");
						_ghost.y += _packet.get("vertical");
				
						var _response = new Packet(PACKET_ID.S_UPDATE_POSITION)
							.set("socketId", _sendingSocketId)
							.set("x", _ghost.x)
							.set("y", _ghost.y);
				
						var _socketIdNames = variable_struct_get_names(socketIds);
						var i = 0;
						repeat (array_length(_socketIdNames))
						{
							__spacket_print("sending back position");
							var _socketIdName = _socketIdNames[i++];
							var _socketId = socketIds[$ _socketIdName];
							_response.send(_socketId);
						}
						break;
					}
				}
			}
		}
		else
		{
			__spacket_print("received server packet");
		
			with (obj_spacket_demo_client)
			{
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
			}
		}		
		break;
	}
}