enum PACKET_ID
{
	S_PLAYER_UPDATE_IDS,
	S_PLAYER_GET_MY_ID,
	S_PLAYER_UPDATE_POSITION,
	
	C_PLAYER_REQUEST_POSITION,
	C_PLAYER_UPDATE_MOVEMENT_INPUT,
}

#region server

spacket_define(PACKET_ID.S_PLAYER_UPDATE_IDS)
	.set("playerIds", buffer_string);

spacket_define(PACKET_ID.S_PLAYER_GET_MY_ID)
	.set("playerId", buffer_u8);

spacket_define(PACKET_ID.S_PLAYER_UPDATE_POSITION)
	.set("playerId", buffer_u8)
	.set("x", buffer_s32)
	.set("y", buffer_s32);

#endregion

#region client

spacket_define(PACKET_ID.C_PLAYER_REQUEST_POSITION)
	.set("playerId", buffer_u8);

spacket_define(PACKET_ID.C_PLAYER_UPDATE_MOVEMENT_INPUT)
	.set("horizontal", buffer_s8)
	.set("vertical", buffer_s8);

#endregion