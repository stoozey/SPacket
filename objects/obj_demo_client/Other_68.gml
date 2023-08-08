var _id = async_load[? "id"];
if (_id != client) exit;

var _type = async_load[? "type"];
switch (_type)
{
	case network_type_data:
	{
		var _buffer = async_load[? "buffer"];
		var _packet = new Packet().deserialize(_buffer);
		switch (_packet.get_packet_id())
		{
			case PACKET_ID.S_PLAYER_UPDATE_IDS:
			{
				var _newPlayerIds = _packet.get("playerIds");
				var _totalNewPlayerIds = array_length(_newPlayerIds);
				
				// remove any old players
				var _playerIds = variable_struct_get_names(players);
				var i = 0;
				repeat (array_length(_playerIds))
				{
					var _playerId = _playerIds[i++];
					var _existsInNewIds = false;
					var j = 0;
					repeat (_totalNewPlayerIds)
					{
						var _newPlayerId = _newPlayerIds[j++];
						if (_newPlayerId != _playerId) continue;
						
						_existsInNewIds = true;
						break;
					}
					
					if (!_existsInNewIds)
					{
						var _player = players[$ _playerId];
						variable_struct_remove(players, _playerId);
						instance_destroy(_player);
					}
				}
				
				// add any new players
				var i = 0;
				repeat (_totalNewPlayerIds)
				{
					var _playerId = _newPlayerIds[i++];
					var _exists = false;
					with (obj_demo_client_player)
					{
						if (playerId != _playerId) continue;
						
						_exists = true;
						break;
					}
					
					if (!_exists)
					{
						var _player = instance_create_depth(0, 0, 0, obj_demo_client_player);
						with (_player)
							playerId = _playerId;
						
						players[$ _playerId] = _player;
						
						new Packet(PACKET_ID.C_PLAYER_REQUEST_POSITION)
							.set("playerId", _playerId)
							.send(client);
					}
				}
				break;
			}
			
			case PACKET_ID.S_PLAYER_GET_MY_ID:
			{
				var _playerId = _packet.get("playerId");
				clientPlayerId = _playerId;
				break;
			}
			
			case PACKET_ID.S_PLAYER_UPDATE_POSITION:
			{
				var _playerId = _packet.get("playerId");
				var _x = _packet.get("x");
				var _y = _packet.get("y");
				
				var _player = players[$ _playerId];
				with (_player)
				{
					x = _x;
					y = _y;
				}
				break;
			}
		}
		break;
	}
}