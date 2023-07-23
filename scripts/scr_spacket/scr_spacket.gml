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
		
		// read header
		var _signatureSize = string_length(__SPACKET_PACKET_SIGNATURE);
		var _signatureBuffer = buffer_create(_signatureSize, buffer_fixed, 1);
		buffer_copy(_buffer, 0, _signatureSize, _signatureBuffer, 0);
		
		var _signature = buffer_read(_signatureBuffer, buffer_text);
		buffer_seek(_buffer, 0, _signatureSize);
		buffer_delete(_signatureBuffer);
		if (_signature != __SPACKET_PACKET_SIGNATURE)
			throw new __spacket_class_exception_invalid_packet_signature();
		
		var _packetVersion;
		try
			_packetVersion = buffer_read(_buffer, SPACKET_PACKET_VERSION_BUFFER_TYPE);
		catch (_)
			throw new __spacket_class_exception_invalid_packet_data("packetVersion", SPACKET_PACKET_VERSION_BUFFER_TYPE);
		
		var _packetId;
		try
			_packetId = buffer_read(_buffer, SPACKET_PACKET_ID_BUFFER_TYPE);
		catch (_)
			throw new __spacket_class_exception_invalid_packet_data("packetId", SPACKET_PACKET_ID_BUFFER_TYPE);
		
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
		
		var _compressed;
		try
			_compressed = buffer_read(_buffer, buffer_bool);
		catch (_)
			throw new __spacket_class_exception_invalid_packet_data("compressed", buffer_bool);
			
		__packetVersion = _packetVersion;
		__set_packet_id(_packetId);
		
		// get data buffer, and decompress if neccesary
		var _bufferSize = (buffer_get_size(_buffer) - __SPACKET_HEADER_SIZE);
		var _dataBuffer = buffer_create(_bufferSize, buffer_fixed, 1);
		buffer_copy(_buffer, __SPACKET_HEADER_SIZE, _bufferSize, _dataBuffer, 0);
		buffer_delete(_buffer);
		
		if (_compressed)
		{
			var _uncompressedBuffer = buffer_decompress(_dataBuffer);
			buffer_delete(_dataBuffer);
			
			_dataBuffer = _uncompressedBuffer;
		}
		
		// read data
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
				var _value = buffer_read(_dataBuffer, _bufferType);
				set(_name, _value);
			}
		}
		catch (_e)
		{
			_errorMessage = __spacket_string_build("Failed to deserialize packet #", __packetId, " with reason: ", _e.longMessage);
		}
		
		if (_deleteBuffer)
			buffer_delete(_dataBuffer);
		
		if (_errorMessage != undefined)
			throw new __spacket_class_exception_packet_deserialization_failed(_errorMessage);
		
		return self;
	}
	
	static serialize = function()
	{
		__check_is_initialized();
		
		var _uncompressedBuffer = buffer_create(1024, buffer_grow, 1);
		try
		{
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
				buffer_write(_uncompressedBuffer, _bufferType, _value);
			}
		}
		catch (_e)
		{
			buffer_delete(_uncompressedBuffer);
			throw new __spacket_class_exception_packet_serialization_failed(_e.longMessage);
		}
		
		// compress buffer and see if size can be reduced
		var _dataBuffer, _dataSize;
		var _uncompressedSize = buffer_tell(_uncompressedBuffer);
		var _compressedBuffer = buffer_compress(_uncompressedBuffer, 0, _uncompressedSize);
		var _compressedSize = buffer_get_size(_compressedBuffer);
		var _isCompressed = (_compressedSize < _uncompressedSize);
		if (_isCompressed)
		{
			_dataBuffer = _compressedBuffer;
			_dataSize = _compressedSize;
			buffer_delete(_uncompressedBuffer);
		}
		else
		{
			_dataBuffer = _uncompressedBuffer;
			_dataSize = _uncompressedSize;
			buffer_delete(_compressedBuffer);
		}
		
		// create final buffer
		var _bufferSize = (__SPACKET_HEADER_SIZE + _dataSize);
		var _buffer = buffer_create(_bufferSize, buffer_fixed, 1);
		
		// write header
		var _headerBuffer = __generate_header_buffer(_isCompressed);
		buffer_copy(_headerBuffer, 0, __SPACKET_HEADER_SIZE, _buffer, 0);
		buffer_delete(_headerBuffer);
		
		// write compressd data
		buffer_copy(_dataBuffer, 0, _dataSize, _buffer, __SPACKET_HEADER_SIZE);
		buffer_delete(_dataBuffer);
		
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
	
	static __generate_header_buffer = function(_isCompressed)
	{
		__check_is_initialized();
		
		var _headerBuffer = buffer_create(__SPACKET_HEADER_SIZE, buffer_fixed, 1);
		buffer_write(_headerBuffer, buffer_text, __SPACKET_PACKET_SIGNATURE);
		buffer_write(_headerBuffer, SPACKET_PACKET_VERSION_BUFFER_TYPE, __packetVersion);
		buffer_write(_headerBuffer, SPACKET_PACKET_ID_BUFFER_TYPE, __packetId);
		buffer_write(_headerBuffer, buffer_bool, _isCompressed);

		return _headerBuffer;
	}
	
	__packetVersion = __SPACKET_PACKET_VERSION;
	__packetId = undefined;
	__definition = undefined;
	__values = { };
	
	if (_packetId != undefined)
		__set_packet_id(_packetId);
}

// hello 😎