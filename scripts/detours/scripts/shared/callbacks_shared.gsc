/*
	Name: codecallback_preinitialization
	Namespace: callback
	Checksum: 0xD96BE601
	Offset: 0xF50
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
/*detour system<scripts\shared\system_shared.gsc>::codecallback_preinitialization()
{
    level thread debug_message( "run_pre_systems" );
    callback::callback(#"hash_ecc6aecf");
    [[ @system<scripts\shared\callbacks_shared.gsc>::run_pre_systems ]]();
}


detour system<scripts\shared\system_shared.gsc>::codecallback_finalizeinitialization()
{
    level thread debug_message( "codecallback_finalizeinitialization" );
	system::run_post_systems();
	callback::callback(#"hash_36fb1b1a");
}

detour system<scripts\shared\system_shared.gsc>::codecallback_startgametype()
{
    level thread debug_message( "codecallback_startgametype" );
	if(!isdefined(level.gametypestarted) || !level.gametypestarted)
	{
		[[level.callbackstartgametype]]();
		level.gametypestarted = 1;
	}
}*/