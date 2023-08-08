function PacketDefinition() constructor
{
	///@desc Returns an array containing all the current defitions
	static get_values = function()
	{
		return __values;
	}
	
	///@desc Adds a value to the packet definition
	///@param {string} valueName The name of the value
	///@param {buffer_type} bufferType The buffer type (buffer_X) of the value
	///@param {bool} [isArray] Whether or not the value is an array of bufferType
	///@param {buffer_type} [arraySizeBufferType] The buffer type (buffer_X) to use for the array's size (defaults to SPACKET_ARRAY_SIZE_BUFFER_TYPE_DEFAULT)
	static set = function(_valueName, _bufferType, _isArray = false, _arraySize = SPACKET_ARRAY_SIZE_BUFFER_TYPE_DEFAULT)
	{
		var _totalValues = array_length(__values);
		var i = 0;
		repeat (_totalValues)
		{
			var _value = __values[i++];
			if (_value.get_name() != _valueName) continue;
			
			__spacket_print("tried to add packet value of name \"", _valueName, "\" but it already exists!");
			return self;
		}
		
		array_resize(__values, (_totalValues + 1));
		
		var _value = new __spacket_class_packet_info_value(_valueName, _bufferType, _isArray, _arraySize);
		__values[_totalValues] = _value;
		return self;
	}
	
	__values = [ ];
}