var _port = get_integer("Port to host server on", 43786);
server = network_create_server(network_socket_udp, _port, 12);