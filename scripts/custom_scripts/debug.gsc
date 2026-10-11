// DEBUG MESSAGES
function debug_message_instant( msg = "ERROR, FORGOT TO ADD MESSAGE", player = undefined){

	if( IsPlayer( self ) || ( isdefined( player ) && isPlayer( player ) ) ){
		player iPrintLnBold( msg );
	}else if( isdefined(level.host) ){
		level.host iPrintLnBold(msg);
	}else if( isdefined( getplayers()[0] ) ){
		getplayers()[0] iPrintLnBold(msg);
	}

	logprint( sprintf("[Surtr] {0}\n", msg) ); // Prints to gameserver.log
}

function debug_message( msg ){

	if( !isdefined(level.debug_messages) ){
		level.debug_messages = [];
		level thread debug_messages_watcher();
	}

	logprint( sprintf("[Surtr] {0}\n", msg) ); // Prints to gameserver.log

	level.debug_messages[level.debug_messages.size] = msg;

}

function debug_messages_watcher(){
	level notify( "debug_messages_watcher" );
	level endon( "debug_messages_watcher" );

	n_messages = 0;
	debug_msg_speed = GetDvarFloat(DVAR_DEBUG_MSG_SPEED);

	// Don't send messages while blackscreen is active
	wait_for_game_start();

	while( level.debug_messages.size == 0 ) wait 0.05;

	for(;;){
		wait 0.55;

		if( n_messages >= level.debug_messages.size) continue;

		level.host iPrintLnBold( level.debug_messages[n_messages] );
		n_messages++;
		wait debug_msg_speed;
	}

}

function IPrintLnBoldAllPlayers( text = undefined ){
	
	if( !isdefined( text ) || !IsString( text ) ){
		level thread debug_message( text_error()+"invalid text in ^5IPrintLnBoldAllPlayers" );
		return;
	}
	
	foreach( player in getplayers() ) player IPrintLnBold( text );
}

function log_menu_responses(){
	if( IsPlayer( self ) ){
		self endon( "disconnect" );
		info_text = "^1"+self.name+" ^7| ";
	}else{
		self = level;
		level endon( "game_ended") ;
		info_text = "^1Level ^7| ";
	}

	for(;;)
	{
		self waittill( "menuresponse", menu, response);

        if( isdefined( menu ) && isdefined( response ) ){
            level thread debug_message(info_text+"^5Menu ^7'"+menu+"'^2 | ^5 response ^7'"+response+"'");
        }else if( isdefined( menu ) ){
            level thread debug_message(info_text+"^5Menu ^7'"+menu+"'");
        }else if( isdefined( response ) ){
            level thread debug_message(info_text+"^5Response ^7'"+response+"'");
        }else{
            level thread debug_message(info_text+"^1UNKNOWN MENU");
        }

    }

}

// Skip initial blackscreen on ZM
function avoid_initial_blackscreen(){

    level waittill( "initial_players_connected" );

    // Wait for blackscreen fade out
    while( !level flag::exists( "initial_blackscreen_passed" ) ) wait 0.05;

    foreach(player in getplayers()){

        player FreezeControls( false ); // Unfreeze
        player closemenu("InitialBlack"); // Close 3arc logo waiting menu

        // Check if player has blackscreen menu
        if( !isdefined( player.screen_fade_menus ) || !isdefined( player.screen_fade_menus["default"] ) || !isdefined( player.screen_fade_menus["default"].lui_menu ) ) continue;

        // Set menu target time
        player.screen_fade_menus["default"].n_target_time = gettime();
        lui_menu = player.screen_fade_menus["default"].lui_menu;

        // Set new menu data
        player SetLUIMenuData(lui_menu, "startAlpha", 0);
        player SetLUIMenuData(lui_menu, "endAlpha", 0);
        player SetLUIMenuData(lui_menu, "fadeOverTime", 0);
    }

    // Wait for blackscreen fade in
    while( !level clientfield::get("sndZMBFadeIn") ) wait 0.05;

    foreach(player in getplayers()){

        // Check if player has blackscreen menu
        if( !isdefined( player.screen_fade_menus ) || !isdefined( player.screen_fade_menus["default"] ) || !isdefined( player.screen_fade_menus["default"].lui_menu ) ) continue;

        // Set menu target time
        player.screen_fade_menus["default"].n_target_time = gettime();
        lui_menu = player.screen_fade_menus["default"].lui_menu;

        // Set new menu data
        player SetLUIMenuData(lui_menu, "startAlpha", 0);
        player SetLUIMenuData(lui_menu, "endAlpha", 0);
        player SetLUIMenuData(lui_menu, "fadeOverTime", 0);
    }
}

// Print notifications whenever they happen and the caller
function print_notifications( a_notifications ){

    foreach( str_notify in a_notifications ){
        self thread debug_notify( str_notify );
    }

}

function debug_notify( str_notify ){

    if( self == level ) caller = "^5Level ";
    else if( IsPlayer( self ) ) caller = "^5"+self.name+" ";
    else if( isdefined( self.targetname) ) caller = "^5"+self.targetname+" ";
    else caller = "^5Unknown ";

    str_print = caller+"^2"+str_notify;

    for(;;){
        self waittill( str_notify );

        level thread debug_message_instant( str_print );
    }

}

// Debug flags
function debug_flags(){

    level.debug_flags = [];
    level.players_debug_flags = [];

    while( !isdefined( level.flag ) ) wait 0.05;

    for(;;){
        wait 0.05;

        // Check for new flags or changed values
        foreach(str_flag, value in level.flag){

            // Deleted flag?
            if( !isdefined( str_flag ) || !isdefined( value ) ) continue;

            // Value didn't change
            if( isdefined(level.debug_flags[ str_flag ]) && value ==  level.debug_flags[ str_flag ] ) continue;

            // Get time of flag check
            if( !has_game_started() ) time = "Before Blackscreen";
            else time = get_time_string_from_ms( gettime() - level.n_gameplay_start_time );

            // New flag
            if( !isdefined( level.debug_flags[ str_flag ] ) ){

                // Log
                level thread debug_message_instant( sprintf( "{0} | New flag '{1}' = {2}\n", time, str_flag, value ) );

                // Register new flag
                level.debug_flags[ str_flag ] = value;
			
			// Updated flag
            }else{

                // Log
                level thread debug_message_instant( sprintf( "{0} | Updated flag '{1}' {2} => {3}\n", time, str_flag, level.debug_flags[ str_flag ], value ) );

                // Update flag
                level.debug_flags[ str_flag ] = value;
            }

            //wait 0.05;
        }

        a_updated_flags = [];

        // Check for deleted flags
        foreach(str_flag, value in level.debug_flags){

            // Not a deleted flag
            if( isdefined( level.flag[ str_flag ] ) ){
                a_updated_flags[ str_flag ] = value;
                continue;
            }

            if( !isdefined( value ) ) value = "Undefined";

            // Get time of flag check
            if( !has_game_started() ) time = "Before Blackscreen";
            else time = get_time_string_from_ms( gettime() - level.n_gameplay_start_time );

            // Log
            level thread debug_message_instant( sprintf( "{0} | Deleted flag '{1}' = {2}", time, str_flag, value ) );
            //wait 0.05;
        }

        level.debug_flags = a_updated_flags;



        // Check for players flags
        foreach(player in getplayers()){
            xuid = PLAYER_XUID;

            // New player flags
            if( !isdefined( level.players_debug_flags[ xuid ] ) ) level.players_debug_flags[ xuid ] = [];

            // Check for new flags or changed values
            foreach(str_flag, value in player.flag){

                // Deleted flag?
                if( !isdefined( str_flag ) || !isdefined( value ) ) continue;

                // Value didn't change
                if( isdefined(level.players_debug_flags[ xuid ][ str_flag ]) && value ==  player.flag[ str_flag ] ) continue;

                // Get time of flag check
                if( !has_game_started() ) time = "Before Blackscreen";
                else time = get_time_string_from_ms( gettime() - level.n_gameplay_start_time );

                // New flag
                if( !isdefined( player.flag[ str_flag ] ) ){

                    // Log
                    level thread debug_message_instant( sprintf( "{0} | New player {3} flag '{1}' = {2}\n", time, str_flag, value, player.name ) );

                    // Register new flag
                    level.players_debug_flags[ xuid ][ str_flag ] = value;
                
                // Updated flag
                }else{

                    // Log
                    level thread debug_message_instant( sprintf( "{0} | Updated player {4} flag '{1}' {2} => {3}\n", time, str_flag, level.players_debug_flags[ xuid ][ str_flag ], value, player.name ) );

                    // Update flag
                    level.players_debug_flags[ xuid ][ str_flag ] = value;
                }

                //wait 0.05;
            }

            a_updated_flags = [];

            // Check for deleted flags
            foreach(str_flag, value in level.players_debug_flags[ xuid ]){

                // Not a deleted flag
                if( isdefined( player.flag[ str_flag ] ) ){
                    a_updated_flags[ str_flag ] = value;
                    continue;
                }

                if( !isdefined( value ) ) value = "Undefined";

                // Get time of flag check
                if( !has_game_started() ) time = "Before Blackscreen";
                else time = get_time_string_from_ms( gettime() - level.n_gameplay_start_time );

                // Log
                level thread debug_message_instant( sprintf( "{0} | Deleted flag '{1}' = {2}", time, str_flag, value ) );
                //wait 0.05;
        }

        level.players_debug_flags[ xuid ] = a_updated_flags;
        }

    }

}