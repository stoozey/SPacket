function __spacket_print()
{
	var _string = "########## SPacket: ";
    var _i = 0;
    repeat (argument_count)
        _string += string(argument[_i++]);
	
    show_debug_message(_string);
}

function __spacket_string_build()
{
	var _string = "";
    var _i = 0;
    repeat (argument_count)
        _string += string(argument[_i++]);
	
	return _string;
}

function __spacket_ds_list_to_array(_list, _destroyList = true)
{
	var _listSize = ds_list_size(_list);
	var _array = array_create(_listSize);
	var i = 0;
	repeat (_listSize)
	{
		_array[i] = _list[| i];
		i++;
	}
	
	if (_destroyList)
		ds_list_destroy(_list);
	
	return _array;
}

function __spacket_string_to_buffer(_string)
{
	var _buffer = buffer_create(string_byte_length(_string), buffer_fixed, 1);
    buffer_write(_buffer, buffer_text, _string);
	
	return _buffer;
}