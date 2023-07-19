socket = network_create_socket(network_socket_tcp);
server = network_connect(socket, SPACKET_DEMO_IP, SPACKET_DEMO_PORT);

clientId = -1;

var _buffer = buffer_load("poop.bin");
new Packet().deserialize(_buffer);