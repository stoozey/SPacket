var _ip = get_string("IP to connect to", "localhost");
var _port = get_integer("Port to connect to", 43786);
client = network_create_socket(network_socket_tcp);
network_connect(client, _ip, _port);

clientPlayerId = -1;
players = { };