server = network_create_server(network_socket_tcp, SPACKET_DEMO_PORT, 4);

ghosts = { };
clientIds = { };

clientIdNext = 0;