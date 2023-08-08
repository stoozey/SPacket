function __spacket_class_packet_info_value(_name, _bufferType, _usesArray, _arraySizeBufferType) constructor
{
	static get_name = function()
	{
		return __name;
	}
	
	static get_buffer_type = function()
	{
		return __bufferType;
	}
	
	static uses_array = function()
	{
		return __usesArray;
	}
	
	static get_array_size_buffer_type = function()
	{
		return __arraySizeBufferType;
	}
	
	__name = _name;
	__bufferType = _bufferType;
	__usesArray = _usesArray;
	__arraySizeBufferType = _arraySizeBufferType;
}