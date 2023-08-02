draw_set_colour((playerId == obj_client.clientPlayerId) ? c_lime : c_white);
	var _size = 32;
	draw_rectangle(x, y, (x + _size), (y + _size), false);
draw_set_colour(c_black);
	draw_text(x, y, string(playerId));
draw_set_colour(c_white);