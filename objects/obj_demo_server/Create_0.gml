var _port = get_integer("Port to host server on", 43786);
server = network_create_server(network_socket_tcp, _port, 64);

playerId = 0;
socketIdToPlayerIds = { };
playerIdToSocketIds = { };

playerPositions = { };

Vector2 = function() constructor
{
	x = 0;
	y = 0;
}

#region util

GetSocketIds = function()
{
	return variable_struct_get_names(socketIdToPlayerIds);
}

GetPlayerIds = function()
{
	return variable_struct_get_names(playerIdToSocketIds);
}

GetSocketId = function(_playerId)
{
	return ((variable_struct_exists(playerIdToSocketIds, _playerId)) ? playerIdToSocketIds[$ _playerId] : undefined);
}

GetPlayerId = function(_socketId)
{
	return ((variable_struct_exists(socketIdToPlayerIds, _socketId)) ? socketIdToPlayerIds[$ _socketId] : undefined);
}

GetPlayerPosition = function(_playerId)
{
	return ((variable_struct_exists(playerPositions, _playerId)) ? playerPositions[$ _playerId] : undefined);
}

#endregion

#region player management

AddPlayer = function(_socketId)
{
	var _playerId = playerId++;
	socketIdToPlayerIds[$ _socketId] = _playerId;
	playerIdToSocketIds[$ _playerId] = _socketId;
	
	playerPositions[$ _playerId] = new Vector2();
	
	new Packet(PACKET_ID.S_PLAYER_GET_MY_ID)
		.set("playerId", _playerId)
		.send(_socketId);
	
	UpdatePlayers();
}

RemovePlayer = function(_playerId)
{
	var _socketId = GetSocketId(_playerId);
	variable_struct_remove(socketIdToPlayerIds, _socketId);
	variable_struct_remove(playerIdToSocketIds, _playerId);
	variable_struct_remove(playerPositions, _playerId);
	
	UpdatePlayers();
}

UpdatePlayers = function()
{
	var _socketIds = GetSocketIds();
	var _playerIds = GetPlayerIds();
	new Packet(PACKET_ID.S_PLAYER_UPDATE_IDS)
		.set("playerIds", _playerIds)
		.send(_socketIds);
}

#endregion