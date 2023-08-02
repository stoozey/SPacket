function __spacket_class_packet_info() constructor
{
	static get_values = function()
	{
		return __values;
	}
	
	static set = function(_valueName, _bufferType)
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
		
		var _value = new __spacket_class_packet_info_value(_valueName, _bufferType);
		__values[_totalValues] = _value;
		return self;
	}
	
	__values = [ ];
}