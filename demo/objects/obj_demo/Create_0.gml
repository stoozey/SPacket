var _isServer = get_integer("Server (1) or client (0)?", 1);
var _objectIndex = ((_isServer == 1) ? obj_server : obj_client);
instance_create_depth(0, 0, 0, _objectIndex);