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