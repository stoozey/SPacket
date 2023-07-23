socket = network_create_socket(network_socket_tcp);
network_connect(socket, SPACKET_DEMO_IP, SPACKET_DEMO_PORT);

clientId = -1;

var _packet = new Packet(PACKET_ID.C_SEND_INPUTS)
	.set("horizontal", 12)
	.set("vertical", -69)
	.set("poopy", "hey guys its stoozey here!")
	.set("idk", pi);

var _buffer = _packet.serialize();
buffer_save(_buffer, "poop.bin");