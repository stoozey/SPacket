function __spacket_class_packet_info_value(_name, _bufferType) constructor
{
	static get_name = function()
	{
		return __name;
	}
	
	static get_buffer_type = function()
	{
		return __bufferType;
	}
	
	__name = _name;
	__bufferType = _bufferType;
}