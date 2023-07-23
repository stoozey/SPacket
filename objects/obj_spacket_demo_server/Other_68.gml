//var _id = async_load[? "id"];
//var _type = async_load[? "type"];
//switch (_type)
//{
//	case network_type_connect:
//	{
//		var _clientId = clientIdNext++;
//		var _socket = async_load[? "socket"];
//		var _ghost = instance_create_depth(irandom(room_width), irandom(room_height), 0, obj_spacket_demo_client_ghost);
//		_ghost.clientId = _clientId;
	
//		clientIds[$ _ip] = _clientId;
//		ghosts[$ _clientId] = _ghost;
	
//		__spacket_print("sending S_SET_CLIENT_ID to client");
//		new Packet(PACKET_ID.S_SET_CLIENT_ID)
//			.set("clientId", _clientId)
//			.send(_clientId);
//		break;
//	}
	
//	case network_type_data:
//	{
//		if (_id == server) exit;
		
//		var _buffer = async_load[? "buffer"];
//		__spacket_print("SERVER got packet with buffer", _buffer, " id ", _id, " server ", server);
		
//		if (_buffer <= 0) break;
		
//		var _packet = new Packet();
//		_packet.deserialize(_buffer, false);
			
//		switch (_packet.get_packet_id())
//		{
//			case PACKET_ID.C_SEND_INPUTS:
//			{
//				__spacket_print("received C_SEND_INPUTS from client");
				
//				var _ghost = ghosts[$ _id];
//				_ghost.x += _packet.get("horizontal");
//				_ghost.y += _packet.get("vertical");
				
//				var _response = new Packet(PACKET_ID.S_UPDATE_POSITION)
//					.set("clientId", _id)
//					.set("x", _ghost.x)
//					.set("y", _ghost.y);
				
//				__spacket_print("sending S_UPDATE_POSITION from client");
//				var _clientIdNames = variable_struct_get_names(clientIds);
//				var i = 0;
//				repeat (array_length(_clientIdNames))
//				{
//					__spacket_print("sending back position");
//					var _clientIdName = _clientIdNames[i++];
//					var _clientId = clientIds[$ _clientIdName];
//					_response.send(_clientId);
//				}
//				break;
//			}
//		}
//		break;
//	}
//}
