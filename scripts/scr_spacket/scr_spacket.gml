function Packet(_packetId = undefined) constructor
{
	static get_packet_version = function()
	{
		return __packetVersion;
	}
	
	static get_packet_id = function()
	{
		return __packetId;
	}
	
	static get = function(_valueName)
	{
		if (!variable_struct_exists(__values, _valueName))
			throw new __spacket_class_exception_packet_value_doesnt_exist(__packetId, _valueName);
		
		return __values[$ _valueName];
	}
	
	static set = function(_valueName, _value)
	{
		__values[$ _valueName] = _value;
		return self;
	}
	
	static send = function(_socket)
	{
		__check_is_initialized();
		
		var _buffer = serialize();
		var _bufferSize = buffer_tell(_buffer);
		network_send_packet(_socket, _buffer, _bufferSize);
		buffer_delete(_buffer);
		return self;
	}
	
	static deserialize = function(_buffer, _deleteBuffer = true)
	{
		buffer_seek(_buffer, buffer_seek_start, 0);
		
		var _signature = buffer_read(_buffer, buffer_string);
		if (_signature != __SPACKET_PACKET_SIGNATURE)
			throw new __spacket_class_exception_invalid_packet_signature();
		
		var _packetVersion;
		try
			_packetVersion = buffer_read(_buffer, buffer_string);
		catch (_)
			throw new __spacket_class_exception_invalid_packet_data("packetVersion", buffer_string);
		
		var _packetId;
		try
			_packetId = buffer_read(_buffer, buffer_string);
		catch (_)
			throw new __spacket_class_exception_invalid_packet_data("packetId", buffer_string);
		
		if (_packetVersion != __SPACKET_PACKET_VERSION)
		{
			switch (SPACKET_ON_WRONG_PACKET_VERSION)
			{
				case __SPACKET_ON_WRONG_PACKET_VERSION.ERROR:
					throw new __spacket_class_exception_mismatched_packet_version(_packetId, _packetVersion);
				
				case __SPACKET_ON_WRONG_PACKET_VERSION.ACCEPT:
					break;
			}
		}
		
		__packetVersion = _packetVersion;
		__set_packet_id(_packetId);
		
		var _errorMessage = undefined;
		try
		{
			var _valueDefinitions = __definition.get_values();
			var i = 0;
			repeat (array_length(_valueDefinitions))
			{
				var _valueDefinition = _valueDefinitions[i++];
				var _name = _valueDefinition.get_name();
				var _bufferType = _valueDefinition.get_buffer_type();
				var _value = buffer_read(_buffer, _bufferType);
				set(_name, _value);
			}
		}
		catch (_e)
		{
			_errorMessage = __spacket_string_build("Failed to deserialize packet #", __packetId, " with reason: ", _e.longMessage);
		}
		
		if (_deleteBuffer)
			buffer_delete(_buffer);
		
		if (_errorMessage != undefined)
			throw new __spacket_class_exception_packet_deserialization_failed(_errorMessage);
		
		return self;
	}
	
	static serialize = function()
	{
		__check_is_initialized();
		
		var _buffer = buffer_create(1024, buffer_grow, 1);
		
		try
		{
			buffer_write(_buffer, buffer_string, __SPACKET_PACKET_SIGNATURE);
			buffer_write(_buffer, buffer_string, __packetVersion);
			buffer_write(_buffer, buffer_string, __packetId);
			
			var _valueDefinitions = __definition.get_values();
			var i = 0;
			repeat (array_length(_valueDefinitions))
			{
				var _valueDefinition = _valueDefinitions[i++];
				var _name = _valueDefinition.get_name();
				if (!variable_struct_exists(__values, _name))
					throw ("value name \"" + _name + "\" is missing from packet #" + __packetId);
			
				var _bufferType = _valueDefinition.get_buffer_type();
				var _value = __values[$ _name];
				buffer_write(_buffer, _bufferType, _value);
			}
		}
		catch (_e)
		{
			buffer_delete(_buffer);
			throw new __spacket_class_exception_packet_serialization_failed(_e.longMessage);
		}
		
		buffer_save(_buffer, "poop.bin");
		return _buffer;
	}
	
	static __set_packet_id = function(_packetId)
	{
		__packetId = string(_packetId);
		__definition = spacket_get_definition(__packetId);
	}
	
	static __check_is_initialized = function()
	{
		if ((__packetId == undefined) || (__definition == undefined))
			throw new __spacket_class_exception_uninitialized_packet();
	}
	
	__packetVersion = __SPACKET_PACKET_VERSION;
	__packetId = undefined;
	__definition = undefined;
	__values = { };
	
	if (_packetId != undefined)
		__set_packet_id(_packetId);
}

// hello 😎