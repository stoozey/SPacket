function Packet(_packetId = undefined) constructor
{
	static get_packet_id = function()
	{
		return __packetId;
	}
	
	static get = function(_valueName)
	{
		// TODO add missing check
		return __values[$ _valueName];
	}
	
	static set = function(_valueName, _value)
	{
		__values[$ _valueName] = _value;
		return self;
	}
	
	static send = function(_socket)
	{
		if ((__packetId == undefined) || (__definition == undefined))
			throw ("SPacket: cannot send uninitialized packet (packetId is undefined)");
		
		var _buffer = serialize();
		var _bufferSize = buffer_tell(_buffer);
		network_send_packet(_socket, _buffer, _bufferSize);
		buffer_delete(_buffer);
		return self;
	}
	
	static deserialize = function(_buffer, _deleteBuffer = true)
	{
		buffer_seek(_buffer, buffer_seek_start, 0);
		
		var _packetVersion = buffer_read(_buffer, buffer_u16);
		var _packetId = buffer_read(_buffer, buffer_string);
		if (_packetVersion != SPACKET_PACKET_VERSION)
		{
			switch (SPACKET_ON_WRONG_PACKET_VERSION)
			{
				case __SPACKET_ON_WRONG_PACKET_VERSION.IGNORE:
					return false;
				
				case __SPACKET_ON_WRONG_PACKET_VERSION.ERROR:
					throw ("SPacket: got packet #" + _packetId + " with mismatched SPACKET_PACKET_VERSION (we are " + string(SPACKET_PACKET_VERSION) + ", they are " + string(_packetVersion) + ")");
				
				case __SPACKET_ON_WRONG_PACKET_VERSION.ACCEPT:
					break;
			}
		}
		
		__set_packet_id(_packetId);
		
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
			throw ("SPacket: failed to deserialize packet #" + __packetId + " with reason: " + _e.longMessage);
			return false;
		}
		
		if (_deleteBuffer)
			buffer_delete(_buffer);
		
		return true;
	}
	
	static serialize = function()
	{
		var _buffer = buffer_create(1024, buffer_grow, 1);
		
		try
		{
			buffer_write(_buffer, buffer_u16, SPACKET_PACKET_VERSION);
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
			throw ("SPacket: serialize failed on packet #" + __packetId + " with reason: " + string(_e));
		}
		
		return _buffer;
	}
	
	static __set_packet_id = function(_packetId)
	{
		__packetId = string(_packetId);
		__definition = spacket_get_definition(__packetId);
	}
	
	__packetId = undefined;
	__definition = undefined;
	__values = { };
	
	if (_packetId != undefined)
		__set_packet_id(_packetId);
}

// hello 😎