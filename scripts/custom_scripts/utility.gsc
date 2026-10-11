// IS_TRUE
function is_true( value ){

	if( !isdefined( value ) ) return false;
	return !!value;
}

// RETURNS
function return_false(){
    return false;
}

function return_true(){
    return true;
}

// Efficient color. Thanks Serious
function color(value)
{
    /*
        Size constraints comment:
        
        Why is this better than rgb = (r,g,b) => return (r/255, g/255, b/255)?
        
        This will emit PSC, GetInt, align(4), value, SFT, align(1 + pos, 4), 4
        rgb... emits PSC, {GetInt, align(4), value}[3], SFT, align(1 + pos, 4), 4
        Vector emits Vec, align(4), r as float, b as float, g as float 
        
        color:  Min: 14, Max: 17
        rgb:    Min: 30, Max: 33
        vector: Min: 13, Max: 16
    */

    return
    (
    (value & 0xFF0000) / 0xFF0000,
    (value & 0x00FF00) / 0x00FF00,
    (value & 0x0000FF) / 0x0000FF
    );
}

// CHARACTERS
function is_beast_character( playerbodytype ){

	return getcharacterdisplayname( playerbodytype, SESSION_MODE ) == "ZM_BEAST";
}

function is_soe_character( playerbodytype ){

	return IsInArray( StrTok( getcharacterassetname( playerbodytype, SESSION_MODE ), "_" ), "zod");
}

// GAME STARTED
function has_game_started(){

	if( IS_ZOMBIES ){
		return isdefined( level.n_gameplay_start_time );
	}

	return GetDvarInt(DVAR_CG_ISGAMEPLAYACTIVE);
}

function wait_for_game_start(){

	if( IS_ZOMBIES ){
		while( !isdefined( level.n_gameplay_start_time ) ) wait 0.05;
		return;
	}

	while( !GetDvarInt(DVAR_CG_ISGAMEPLAYACTIVE, false) ) wait 0.05;
}

function set_n_gameplay_start_time(){

	// Set to true whenever gameplay starts on all 3 gamemodes
	setdvar( DVAR_CG_ISGAMEPLAYACTIVE, false );
    wait_for_game_start();
	level.wait_time_before_game_start = GetTotalServerPauseTime(); // Get paused time before game starts
    level.n_gameplay_start_time = gettime();
	SetDvar( DVAR_LIVESPLIT_PAUSED, "0");
}

// Core Surtr
function init_is_map_load(){

	if( GetDvarString(DVAR_NEXTMAP) == "map_restart" ){
		SetDvar(DVAR_SHOW_SURTR, true); // Display Surtr message, will be true until the message is displayed
		SetDvar(DVAR_MAP_LOAD, true); // True only for this very map load
		SetDvar(DVAR_CURRENT_MAP_LOAD_TIMESTAMP, GetUTC() );
		SetDvar(DVAR_NEXTMAP, "surtr"); // Not updated on fast restarts
	}else{
		SetDvar(DVAR_MAP_LOAD, false);
	}
}

function display_surtr_msg(){

	// Create Watermark
		x = -250;
		y = -5;
		_alignment = "right_bottom";
		surtr_msg = level create_hud( x, y, _alignment );
		surtr_msg.alpha = 1.0;
		surtr_msg.fontscale = 2.5;
		surtr_msg.foreground = true;
		surtr_msg thread infinite_rgb(); // RBG

	// start initial black
		while( !isdefined( level.screen_fade_network_frame ) ) wait 0.05;
		level.screen_fade_network_frame = undefined;
	
	// Show text with typewriter effect (Damn you 3arc for removing glow effect...)
		duration = 50000;
		surtr_msg setcod7decodefx(200, duration, 600);
		surtr_msg SetText( sprintf("Surtr v{0}" , SURTR_VERSION) );


		surtr_msg MoveOverTime( 1.5 );
		surtr_msg.x = -150;
		wait 1.5;

		surtr_msg MoveOverTime( 0.7 );
		surtr_msg.x = -120;

		surtr_msg FadeOverTime( 4 );
		surtr_msg.alpha = 0.3;

		wait 0.7;

		surtr_msg MoveOverTime( 1 );
		surtr_msg.x = -80;
		wait 1;

		surtr_msg MoveOverTime( 2 );
		surtr_msg.x = -20;


	// end initial black
		while( !isdefined( level.screen_fade_network_frame ) ) wait 0.05;
		surtr_msg FadeOverTime( 1.5 );
		surtr_msg.alpha = 0.0;
		surtr_msg ChangeFontScaleOverTime( 1.5 );
		surtr_msg.fontscale = 1;
		
		wait 1.5;
		surtr_msg Destroy();
	
	// Custom clients SHOULD have security fixes, only check for latest exe
	if( IS_CUSTOM_CLIENT ){

		// Warn about Custom client version
		if( !GAME_IS_LAST_VERSION && GetDvarInt( DVAR_WARNING_VERSION ) ){
			// Create version warning
			x = -10;
			y = -70; // 10
			_alignment = "right_top";
			//_alignment = "right_center";
			version_msg = level create_hud( x, y, _alignment );
			//version_msg.fontscale = 2.5;
			version_msg.fontscale = 2;
			version_msg.font = "objective";
			version_msg.color = COLOR_BO3_WHITE;
			version_msg.foreground = true;
			version_msg.sort = 2;
			version_msg SetText( sprintf("Please, use a ^9Custom Client^7 that uses ^8{0}\n^7 or ^2{1}^7 version to ensure ^9maximum security^7!", str_game_version( VERSION_STEAM_2026 ), str_game_version( VERSION_MS_ENHANCED ) ) );
			version_msg.alpha = 1;

			x = 0;
			y = -80; // 0
			version_bg = level create_hud( x, y, _alignment );
			version_bg.font = "objective";
			version_bg.color = COLOR_DARK_BLACK; // Light Grey
			version_bg.foreground = true;
			version_bg.sort = 1;

			shader = "white";
			width = ( version_msg GetTextWidth() ) +35 ;
			height = 70;
			version_bg SetShader(shader, width, height);
			version_bg.alpha = 1;


			version_ol = level create_hud( x, y, _alignment );
			version_ol.font = "objective";
			version_ol.color = COLOR_DARK_ORANGE;
			version_ol.foreground = true;
			version_ol.sort = 0;

			shader = "white";
			width = ( version_msg GetTextWidth() ) +40 ;
			height = 75;
			version_ol SetShader(shader, width, height);
			version_ol.alpha = 1;
			wait 1;

			// MOVES

			// Move down fast
			version_msg MoveOverTime(1);
			version_msg.y += 50;
			version_bg MoveOverTime(1);
			version_bg.y += 50;
			version_ol MoveOverTime(1);
			version_ol.y += 50;
			wait 1;

			// Move down slow
			version_msg MoveOverTime(1);
			version_msg.y += 30;
			version_bg MoveOverTime(1);
			version_bg.y += 30;
			version_ol MoveOverTime(1);
			version_ol.y += 30;
			wait 3; // Give time to read the message

			// Move up slow
			version_msg MoveOverTime(1);
			version_msg.y -= 30;
			version_bg MoveOverTime(1);
			version_bg.y -= 30;
			version_ol MoveOverTime(1);
			version_ol.y -= 30;
			wait 1;

			// Move up fast
			version_msg MoveOverTime(0.5);
			version_msg.y -= 50;
			version_bg MoveOverTime(0.5);
			version_bg.y -= 50;
			version_ol MoveOverTime(0.5);
			version_ol.y -= 50;
			wait 0.5;

			// Destroy messages
			version_msg Destroy();
			version_bg Destroy();
			version_ol Destroy();

			// Don't show this message again
			setDvar( DVAR_WARNING_VERSION, "0" );
		}

	}
	// Playing on Retail game, make sure it's latest exe AND T7 patch are being used
	else{

		// Check Bo3 exe version
		if( !GAME_IS_LAST_VERSION && GetDvarInt( DVAR_WARNING_VERSION ) ){
			// Create version warning
			x = -10;
			y = -70; // 10
			_alignment = "right_top";
			//_alignment = "middle_center";
			version_msg = level create_hud( x, y, _alignment );
			//version_msg.fontscale = 2.5;
			version_msg.fontscale = 2;
			version_msg.font = "objective";
			version_msg.color = COLOR_BO3_WHITE;
			version_msg.foreground = true;
			version_msg.sort = 2;
			version_msg SetText( sprintf("Please update Bo3 exe to ^8{0}^7!\nOr use ^2{1}^7!", str_game_version( VERSION_STEAM_2026 ), str_game_version( VERSION_MS_ENHANCED ) ) );
			version_msg.alpha = 1;

			x = 0;
			y = -80; // 0
			version_bg = level create_hud( x, y, _alignment );
			version_bg.font = "objective";
			version_bg.color = COLOR_DARK_BLACK; // Light Grey
			version_bg.foreground = true;
			version_bg.sort = 1;

			shader = "white";
			width = ( version_msg GetTextWidth() ) +35 ;
			height = 70;
			version_bg SetShader(shader, width, height);
			version_bg.alpha = 1;


			version_ol = level create_hud( x, y, _alignment );
			version_ol.font = "objective";
			version_ol.color = COLOR_DARK_ORANGE;
			version_ol.foreground = true;
			version_ol.sort = 0;

			shader = "white";
			width = ( version_msg GetTextWidth() ) +40 ;
			height = 75;
			version_ol SetShader(shader, width, height);
			version_ol.alpha = 1;
			wait 1;

			// Moves

			// Move down fast
			version_msg MoveOverTime(1);
			version_msg.y += 50;
			version_bg MoveOverTime(1);
			version_bg.y += 50;
			version_ol MoveOverTime(1);
			version_ol.y += 50;
			wait 1;

			// Move down slow
			version_msg MoveOverTime(1);
			version_msg.y += 30;
			version_bg MoveOverTime(1);
			version_bg.y += 30;
			version_ol MoveOverTime(1);
			version_ol.y += 30;
			wait 3; // Give time to read the message

			// Move up slow
			version_msg MoveOverTime(1);
			version_msg.y -= 30;
			version_bg MoveOverTime(1);
			version_bg.y -= 30;
			version_ol MoveOverTime(1);
			version_ol.y -= 30;
			wait 1;

			// Move up fast
			version_msg MoveOverTime(0.5);
			version_msg.y -= 50;
			version_bg MoveOverTime(0.5);
			version_bg.y -= 50;
			version_ol MoveOverTime(0.5);
			version_ol.y -= 50;
			wait 0.5;

			// Destroy messages
			version_msg Destroy();
			version_bg Destroy();
			version_ol Destroy();
			wait 1;

			// Don't show this message again
			setDvar( DVAR_WARNING_VERSION, "0" );
		}
	
		// Check T7 patch
		if( !IS_T7_PATCH_ACTIVE && GetDvarInt( DVAR_WARNING_T7PATCH ) ){
			// Create T7 patch warning
			x = -10; // -10
			y = -80; // -70
			_alignment = "right_top";
			//_alignment = "middle_center";
			t7patch_msg = level create_hud( x, y, _alignment );
			//t7patch_msg.fontscale = 2.5;
			t7patch_msg.fontscale = 2;
			t7patch_msg.font = "objective";
			t7patch_msg.color = COLOR_BO3_WHITE;
			t7patch_msg.foreground = true;
			t7patch_msg.sort = 2;
			//t7patch_msg SetText( sprintf("Please, Use ^8T7 Patch^7!\nOr use ^2{1}!",str_game_version( VERSION_MS_ENHANCED ) ) );
			t7patch_msg SetText( sprintf("Please use ^8T7 Patch^7! Or use ^2{0}^7!",str_game_version( VERSION_MS_ENHANCED ) ) );
			t7patch_msg.alpha = 1;

			x = 0; // 0
			y = -80; // 0
			t7patch_bg = level create_hud( x, y, _alignment );
			t7patch_bg.font = "objective";
			t7patch_bg.color = COLOR_DARK_BLACK; // Light Grey
			t7patch_bg.foreground = true;
			t7patch_bg.sort = 1;

			shader = "white";
			width = ( t7patch_msg GetTextWidth() ) +15 ;
			height = 30; // 50
			t7patch_bg SetShader(shader, width, height);
			t7patch_bg.alpha = 1;


			t7patch_ol = level create_hud( x, y, _alignment );
			t7patch_ol.font = "objective";
			t7patch_ol.color = COLOR_DARK_ORANGE;
			t7patch_ol.foreground = true;
			t7patch_ol.sort = 0;

			shader = "white";
			width = ( t7patch_msg GetTextWidth() ) +20 ;
			height = 35; // 55
			t7patch_ol SetShader(shader, width, height);
			t7patch_ol.alpha = 1;
			wait 1;

			// Move down fast
			t7patch_msg MoveOverTime(1);
			t7patch_msg.y += 50;
			t7patch_bg MoveOverTime(1);
			t7patch_bg.y += 50;
			t7patch_ol MoveOverTime(1);
			t7patch_ol.y += 50;
			wait 1;

			// Move down slow
			t7patch_msg MoveOverTime(1);
			t7patch_msg.y += 30;
			t7patch_bg MoveOverTime(1);
			t7patch_bg.y += 30;
			t7patch_ol MoveOverTime(1);
			t7patch_ol.y += 30;
			wait 3; // Give time to read the message

			// Move up slow
			t7patch_msg MoveOverTime(1);
			t7patch_msg.y -= 30;
			t7patch_bg MoveOverTime(1);
			t7patch_bg.y -= 30;
			t7patch_ol MoveOverTime(1);
			t7patch_ol.y -= 30;
			wait 1;

			// Move up fast
			t7patch_msg MoveOverTime(0.5);
			t7patch_msg.y -= 50;
			t7patch_bg MoveOverTime(0.5);
			t7patch_bg.y -= 50;
			t7patch_ol MoveOverTime(0.5);
			t7patch_ol.y -= 50;
			wait 0.5;

			// Destroy messages
			t7patch_msg Destroy();
			t7patch_bg Destroy();
			t7patch_ol Destroy();
			wait 1;

			// Don't show this message again
			setDvar( DVAR_WARNING_T7PATCH, "0" );
		}

	}

	// All Surtr messages shown!
	SetDvar(DVAR_SHOW_SURTR, false);
}


function get_game_version(){

	switch( GetDvarString("version") ){
		case BO3_MS_ENHANCED: return VERSION_MS_ENHANCED;
		case BO3_STEAM_2023: return VERSION_STEAM_2023;
		case BO3_STEAM_2026: return VERSION_STEAM_2026;
	}

	// Unknown game version or dvar has been tampered?
	return VERSION_UNKNOWN;
}

function str_game_version( n_version ){

	if( !isdefined( n_version ) ) return "^1Error, Undefined n_version...";

	switch( n_version ){
		case VERSION_MS_ENHANCED: return STR_BO3_ENHANCED;
		case VERSION_STEAM_2023: return STR_STEAM_2023;
		case VERSION_STEAM_2026: return STR_STEAM_2026;
	}

	// Unknown game version or dvar has been tampered?
	return "Unknown Bo3 version";
}

function wait_all_players_connected(){

	if( !level flag::exists("all_players_connected") ) level waittill( "all_players_connected" );
	else level flag::wait_till("all_players_connected");
} 

function check_cfg_state(){

    if( !is_practice_enabled() ){

        #ifdef dev
            //level thread debug_message( "^1Practice State is not set | "+is_practice_enabled() );
        #endif

        current_state = GetDvarString( DVAR_PRACTICE_STATE );
        SetDvar(DVAR_PRACTICE_STATE, "");

        // Show on screen that state has been reset
        if( current_state != "" ){
            wait_for_game_start();
            level thread DisplayFeedMessage( "Practice state ^1Disabled" );
        }
        return;
    }

    // Wait for practice modes to load
    while( !isdefined( level.lui_practice_loaded ) ) wait 0.05;

	#ifdef dev
        //level thread debug_message( "^2Practice State Loaded!" );
	#endif

    // No practice state
    practice_mode = GetDvarString( DVAR_PRACTICE_STATE );
    if( !isdefined( practice_mode ) || practice_mode == "" ){
        //level thread debug_message( "^1Restarting practice state..." );
        return;
    }

    // Requested practice state doesn't exist
    if( !isdefined( level.practice_modes[ practice_mode ] ) ){
        level thread debug_message( "^1Practice State ^7'^5"+practice_mode+"^7'^1 doesn't exist, resetting Practice State..." );
        setDvar( DVAR_PRACTICE_STATE, "");
        return;
    }

    // PT is not a function pointer
    if( !IsFunctionPtr( level.practice_modes[ practice_mode ] ) ){
        level thread debug_message( "^1Error, not a funcPtr on practice ^5"+practice_mode );
        setDvar( DVAR_PRACTICE_STATE, "");
        return;
    }
	
    #ifdef dev
        //level thread debug_message( "^2Executing ^5"+practice_mode+" ^2practice!" );
    #endif

    // if it's a custom Save State, make sure it actually exists for the current map
    if( practice_mode == "custom" && ( !isdefined( world.save_state ) || !isdefined( world.save_state[ MAP_NAME ] ) ) ){
        return;
    }

    level.loading_custom_state = true;
    wait_all_players_connected();
    level thread DisplayFeedMessage( sprintf("Loading State ^2{0}", practice_mode) );

    // Give God to players that don't have it
    a_god_players = [];
    foreach( player in GetPlayers() ){

        // Player doesn't even have a toggle mod active
        if( !isdefined( world.toggles ) || !isdefined( world.toggles[ PLAYER_XUID ] ) ) continue;

        while( !is_true( player.toggles_completed ) ) wait 0.05;

        #ifdef dev
            //foreach( index, str_toggle in world.toggles[ PLAYER_XUID ] ) level thread debug_message( sprintf("{0}) ^5{1}", index, str_toggle));
        #endif

        // Save XUID in case player disconnects during save state load
        if( IsInArray(world.toggles[ PLAYER_XUID ], "god") ){
            ArrayInsert(a_god_players, PLAYER_XUID, a_god_players.size);
            //level thread debug_message("^2GOD FOUND");
        }
        // Give God
        else{
            player thread execute_command( "god" );
            //level thread debug_message("^1NO GOD");
        }
    }

    // Load the save state
    level [[ level.practice_modes[ practice_mode ] ]]();

    // Take God from players that didn't have it
    foreach(player in GetPlayers()){

        // Player had God before hand, no need to take it from him
        if(IsInArray(a_god_players, PLAYER_XUID) ) continue;

        // Take God
        player thread deactivate_god_in_3_seconds();
    }

    // Save State load finished!
    level.loading_custom_state = undefined;
}

function deactivate_god_in_3_seconds(){
    self endon("disconnect");

    self IPrintLnBold("^1Deactivating ^5God ^1in 3 seconds...");
    wait 3;
    if( IsInArray(world.toggles[ MY_XUID ], "god") ) self thread execute_command( "god" );
}

// Fix some clients not detecting all players are ready at game start
function fix_game_client_connect(){
    self endon("disconnect");

	// Avoid Dev2 error
	while( !level flag::exists("initial_players_connected") ) wait 0.05;

    while( !level flag::get("initial_players_connected") ){
        wait 0.5;

        if( self IsHost() && isdefined( self.sessionstate ) && self.sessionstate != "playing" ) self.sessionstate = "playing";
        else if( !self IsHost() && isdefined( self.sessionstate ) && self.sessionstate != "dead" ) self.sessionstate = "dead";
    }

    self.sessionstate = "playing";
}

// Used HUDs
function print_mods_huds_usage(){

	// Make sure we display the accurate times at game end
	level force_automatic_split_times_at_game_end();

	// First say Surtr version the Host's Game version
	level thread DisplayFeedMessage( sprintf("^8Surtr{0} ^9{1}", SURTR_VERSION, STR_CURRENT_GAME_VERSION ) );
	wait 3;

	// No gum category assigned means there were no gums used in the game
	if( !isdefined( level.gum_category ) ) level thread DisplayFeedMessage( "Gum category: ^5"+CATEGORY_NO_GUM );
	// At least one gum was taken from the Gum Machine
	else level thread DisplayFeedMessage( "Gum category: ^5"+level.gum_category );
	wait 2;

	// Print used HUDs
	if( !isdefined( level.str_used_huds ) || level.str_used_huds.size < 1  ){
		#ifdef dev
			//level thread DisplayFeedMessage( "No ^5HUD ^7 has been used" );
			//wait 3;
		#endif
	}else if( level.str_used_huds.size == 1 ){
		level thread DisplayFeedMessage( sprintf("^5HUD ^7used: ^2{0}", basic_parser( level.str_used_huds[ 0 ] ) ) );
		wait 2;
	}else{
		level thread DisplayFeedMessage( "^5HUDs ^7 used:" );
		wait 2;
		foreach(index, str_hud in level.str_used_huds ){
			level thread DisplayFeedMessage( sprintf("^5{0}^7) ^2{1}", index+1, basic_parser( str_hud ) ) );
			wait 1;
		}		
	}

	// Print used toggles
	if( !isdefined( level.used_commands ) || level.used_commands.size < 1 ){
		#ifdef dev
			//level thread DisplayFeedMessage( "No ^5Command ^7 has been used" );
			//wait 3;
		#endif		
	}else if( level.used_commands.size == 1 ){
		level thread DisplayFeedMessage( sprintf("^5Command ^7used: ^2{0}", basic_parser( level.used_commands[ 0 ] ) ) );
		wait 2;
		/*foreach(index, str_command in level.used_commands ){
			level thread DisplayFeedMessage( sprintf("^5{0}^7) ^2{1}", index+1, basic_parser( str_command ) ) );
			wait 1;
		}*/
	}else{
		level thread DisplayFeedMessage( "^5Commands ^7 used:" );
		wait 2;
		foreach(index, str_command in level.used_commands ){
			level thread DisplayFeedMessage( sprintf("^5{0}^7) ^2{1}", index+1, basic_parser( str_command ) ) );
			wait 1;
		}		
	}

	// Weapon's attachments settings
	if( is_weapon_setting_bit_active( FLAG_NO_MP_ATTACHMENTS ) ){
		level thread DisplayFeedMessage( "^5MP Attachments ^1Disabled" );
		wait 1;
	}
	if( is_weapon_setting_bit_active( FLAG_AUTOMATIC_ATTACHMENTS ) ){
		level thread DisplayFeedMessage( "^5MP Automatic Attachments ^2Enabled" );
		wait 1;
	}
	if( is_weapon_setting_bit_active( FLAG_ADD_STATTRAK ) ){
		level thread DisplayFeedMessage( "^5StatTrak Attachment ^2Enabled" );
		wait 1;
	}
	if( is_weapon_setting_bit_active( FLAG_GIVE_CAMO ) ){
		level thread DisplayFeedMessage( "^5Random Camo ^2Enabled" );
		wait 1;
	}
	if( is_weapon_setting_bit_active( FLAG_INITIAL_PISTOL_ATTACHMENTS ) ){
		level thread DisplayFeedMessage( "^5Initial Pistol Attachments ^1Disabled" );
		wait 1;
	}

	// Custom compiler
	#ifdef getkey
		level thread DisplayFeedMessage( "^1Custom Compiler Function Used^6 #getkey" );
		wait 2;
	#endif

	// Forced full easter egg on any N of players
	if( isdefined( level.full_ee_forced ) ){
		level thread DisplayFeedMessage( "^2Forced ^5Full Easter Egg" );
		wait 2;
	}

	// Forced full easter egg on any N of players
	if( ( MAP_NAME == DER_EISENDRACHE ) && isdefined( level.de_ee_ranked ) ){
		level thread DisplayFeedMessage( "^2Forced Full Der Eisendrache ^6Easter Egg" );
		wait 2;
	}
	

	// Automatically splitting
	if( isdefined( level.autosplits ) ) level thread DisplayFeedMessage( "^5Splitting Method ^1Automatic" );
	// Manually splitting
	else level thread DisplayFeedMessage( "^5Splitting Method ^2Manual" );

	wait 3;
}

// BOTS
function get_n_bots(){
	count = 0;
	foreach(player in getplayers()) {
		if (player istestclient()) {
			count++;
		}
	}
	return count;
}

function get_n_players(){
	count = 0;
	foreach(player in getplayers()) {
		if (IsPlayer(player)) {
			count++;
		}
	}
	return count;
}

// PRACTICE MODE
function check_for_practice_mode(){

	for(;;){
		wait 0.05;

		// Wait for practice mode to be enabled
		if( !is_practice_enabled() ) continue;

		// Once practice mode is enabled, it stays as such for the rest of the game
		level.practice = true;
		level notify("practice"); // TODO: is this really needed? | Yes it is, we need to deactivate previously loaded states

		#ifdef dev
			//foreach(player in GetPlayers()) player IPrintLnBold("^5Practice ^2enabled^7!");
		#endif

		// Activate practice state
		level thread on_practice_enable();
		return;
	}
}

function is_practice_enabled(){
	
	return isdefined( level.practice ) || GetDvarInt( DVAR_PRACTICE ) || is_any_dvar_changed();
}

function on_practice_enable(){

	// Create HUD to show Practice is enabled
    _alignment = "center_top";
	x = 0;
	y = 10;
    _hud = level create_hud( x, y, _alignment );
    _hud.label = &"Practice Enabled!";
	_hud.alpha = 0.33;
	//_hud.alpha = 0;
	_hud.fontscale = 1.5;
	//_hud.hidewheninmenu = false; // This is the default value
	_hud.sort = 7; // Make sure its above any other HuD
	_hud.foreground = true;
	_hud thread infinite_rgb();


	// Make God and Noclip invulnerable to OOBC and enable flashing and timing of OOBC HUD
	level thread hook_poopamc(); // Player Out Of Playable Area Monitor Callback
	level thread hook_poopao(); // Player Out Of Playable Area Override

    // Hook to this so we change the round number when using gsc_round to make the timing the same as the game
	level thread hook_round_number_functions();

}

// infinite RGB colours for self HUD
function infinite_rgb()
{
	self endon("death"); // Stop when HUD is deleted

	// Default values
    r = 255;
    g = 0;
    b = 0;

    for(;;)
    {
        wait 0.05;

        // Red -> Yellow
        if (r == 255 && b == 0 && g < 255)
            g += 5;

        // Yellow -> Green
        else if (g == 255 && b == 0 && r > 0)
            r -= 5;

        // Green -> Cyan
        else if (g == 255 && r == 0 && b < 255)
            b += 5;

        // Cyan -> Blue
        else if (b == 255 && r == 0 && g > 0)
            g -= 5;

        // Blue -> Magenta
        else if (b == 255 && g == 0 && r < 255)
            r += 5;

        // Magenta -> Red
        else if (r == 255 && g == 0 && b > 0)
            b -= 5;

		self.color =  ( (r & 0xFF) / 0xFF, (g & 0xFF) / 0xFF, (b & 0xFF) / 0xFF );
        // self.color = (r / 255.0, g / 255.0, b / 255.0);
    }
}

/* Why this should NEVER be hooked on legit games:
	-These functions happen before the game round change functions
	-To make effective the round change number fix, we must change the number AND wait a server frame (2 frames to avoid glitching for non host players)
	-These functions could potentially change the timing of players respawn at round end, some rounds notifications and when the zombies start spawning
	(Yes, it would only delay a Server Frame but still, game stock behaviour should be kept intact)
*/
function hook_round_number_functions(){
	// Change the number with whatever event happens first, round initial or round end
	thread hook_initial_round_wait_func();
    thread hook_round_end_custom_logic();
}

// PLAYER INDEX TO COLOR
function get_player_text_color(){


	if( !isPlayer(self)){
		thread debug_message("not a player in 'get_player_text_color'");
		return "^7";
	}


	text = "^"; // Start with circumflex

	if( !isdefined(self.entity_num)){
		for(i=0; i<level.players.size; i++) if( level.players[i] == self ) break;
		self.entity_num = i;
	}


	switch( self.entity_num ){ // Add the number of the color depending on which player we are checking
		case 0:
		{
			text += 7; // White
			break;
		}

		case 1:
		{
			text += 5; // Blue
			break;
		}

		case 2:
		{
			text += 3; // Yellow
			break;
		}
		case 3:
		{
			text += 2; // Green
			break;
		}

		default:
		{
			thread debug_message("unknown player color in 'get_player_text_color' | "+self.name+"("+self.entity_num+")");
			return "^7"; // Just give White in case of Error
		}
	}

	return text; // Return the colored text
}

// Taken from Scrappy's Practice Tool
function DisplayFeedMessage( text )
{
	if( !isDefined( text ) ){
		thread debug_message("Error, text not defined");
		return;		
	}

    if(!IsDefined(level.messages_feed)) level.messages_feed = [];

	feed_message = hud::createServerFontString("objective", 1);

	if(!isDefined(feed_message)){
		thread debug_message("Error, feed_message could not be created");
		return;
	}

	// Destroy the message if there is no spam
	feed_message thread natural_destroy( text );

	// Delete the oldest message if there are too many
	if(level.messages_feed.size > FEED_MESSAGES_MAX )
    {
        //level.messages_feed[0] Destroy();
		hud_oldest = level.messages_feed[0];
		ArrayRemoveIndex(level.messages_feed, 0, 0);
		hud_oldest hud::destroyElem();
		//level thread debug_message_instant("Early HUD destroy");
    }

    level.messages_feed[ level.messages_feed.size ] = feed_message;

	// Avoid Dev 2 errors
	waittillframeend;

	counter = 0;

	if( level.messages_feed.size ){
		for(i = level.messages_feed.size; i > 0; i--)
		{
			level.messages_feed[i-1] hud::setPoint("BOTTOM_LEFT", "BOTTOM_LEFT", 10, ( (-100 - (25 * getplayers().size  ) )  - ( 15 * counter ) ) );
			counter++;
		}
	}
}

function natural_destroy( text ){
	self endon( "death" );

	self.foreground = true;
	self SetText(text);
	self.alpha = 1;

	wait 5.25;
    //wait 2.25;

	self FadeOverTime(2);
	self.alpha = 0;

	wait 2;
    //wait 2.25;

	// self Destroy();
	ArrayRemoveValue(level.messages_feed, self, 0);
	self hud::destroyElem();

	#ifdef dev
		level thread debug_message_instant("Naturally Destroyed HUD");
	#endif
}

// KEYBOARD FOCUS NEEDED
function has_special_menu_open(){


	if( !isPlayer(self) ){
		level thread debug_message( "Error, not a player on '^5has_special_menu_open^7'" );
		return true; // this is to assume I have something open so it doesn't break the script too much
	}


	// Checks if anything that requires keyboard focus is opened

	// Smite
	if( isdefined( self.smite_chat ) && isdefined( self.smite_chat["open"] ) && self.smite_chat["open"] ) return true;

	// GSC keyboard
	if( isdefined( self.gsc_keyboard ) && isdefined( self.gsc_keyboard["open"] ) && self.gsc_keyboard["open"] ) return true;

	return false;
}

// MELEE WEAPONS FIX
function surtr_register_melee_weapon( weapon_name ){

	weapon = getweapon( weapon_name );

	if( !isdefined(weapon) || !IsWeapon(weapon) )
	{
		thread debug_message( "Invalid weapon to register as melee" );
		return;
	}

	if( weapon.type != "melee" )
	{
		thread debug_message( "Error, not a melee weapon | "+weapon.name+" => ^5"+weapon.type );
		return;
	}

	if( !isdefined( level.zombie_melee_weapon_list ) ) level.zombie_melee_weapon_list = [];

	if( isdefined( level.zombie_melee_weapon_list[ weapon ] ) ){
		thread debug_message( "Error, melee weapon already registered! | ^5"+weapon.name );
		return;		
	}

	level.zombie_melee_weapon_list[ weapon ] = weapon;
}

function get_ent_by_model( str_model = undefined ){

	if( !isdefined( str_model ) ){
		level.host iPrintLnBold("^1Error, no model name to search...");
		return undefined;
	}

	ents = getEntArray( "script_model", "classname" );
	foreach( ent in ents ){
		if( ent.model == str_model ){
			//level.host iPrintLnBold("^5Ent with model found! | ^2"+str_model);
			return ent;
		}
	}

	//level.host iPrintLnBold("^1Error, couldn't find ent with specific model");
	return undefined;
}

// TODO: Maybe a define?
function is_custom_map(){

	return !IsInArray(TREYARCH_MAPS, MAP_NAME);
}

// MESSAGES
// TODO: define would be way better
function text_error(){

	return "^1Error^7, ";
}

function text_completed(){

    return " ^7step ^2completed!";
}

function text_already_completed(){

    return " ^7step ^2already completed!";
}

// TP PLAYER TO CLOSEST ABH
function tp_player_to_closest_respawn_point( location = "Undefined_Location" ){

	if( IsString( location ) ){

		// Invalid zone name
		if( !isdefined( level.zones[ location ] ) ){
			level thread debug_message( "^1Invalid zone ^5"+location+"^1 in ^2tp_player_to_closest_respawn_point");
			return;
		}

		a_s_respawn_points = struct::get_array("player_respawn_point", "targetname");
		desired_location = level.zones[ location ];

		temp_ent = spawn("script_origin", self.origin);

		a_abh_location = undefined;

		// Search a respawn point in the desired zone
		foreach(s_respawn_point in a_s_respawn_points){

			if( isdefined( a_abh_location ) ) break;

			foreach( e_volume in desired_location.volumes ){
				temp_ent.origin = s_respawn_point.origin;
				if( !temp_ent istouching( e_volume ) ) continue;

				a_abh_location = struct::get_array(s_respawn_point.target, "targetname");
				break;
			}

		}

		temp_ent delete();

		if( !isdefined( a_abh_location ) ) a_abh_location = ArrayGetClosest( desired_location.volumes[0].origin, a_s_respawn_points );
		if( !isdefined( a_abh_location ) ){
			level thread debug_message("^1Couldn't find proper ABH in ^5player_respawn_point ^1for location ^5"+location);
			return;
		}

		// Search the specific player location from this respawn point
		n_script_int = self getentitynumber() + 1;
		foreach(abh_location in a_abh_location)
		{
			// Location is NOT for this player
			if(abh_location.script_int != n_script_int) continue;

			s_player_respawn = abh_location;
			break;
		}

		// Couldn't find location for this player
		if( !isdefined( s_player_respawn ) ){
			level thread debug_message("^1Couldn't find player ABH in ^5player_respawn_point ^1for location ^5"+location);
			return;
		}

		// TP the player
		self setvelocity((0, 0, 0));
		self setorigin(s_player_respawn.origin);
		self playsound("zmb_bgb_abh_teleport_in");
		playfx(level._effect["teleport_splash"], self.origin);
		playfx(level._effect["teleport_aoe"], self.origin);
	}

}

// INT TO HEX STRING CONVERSION
function int_to_hex( num )
{
	// Invalid
    if( !isdefined( num ) )
        return "Undefined";
    
    if( IsString( num ) ){

        if( !StrIsNumber( num ) )
			return "Str is NOT a number...";

        if( StrIsInt( num ) )
			num = Int( num );
        else
			return "Float?";

    }else if( !IsInt( num ) )
		return "Invalid num";

    hex_chars = "0123456789ABCDEF";
    result = "0x";

    for( i = 7; i >= 0; i-- )
    {
        nibble = ( num >> (i * 4) ) & 0xF;
        result += hex_chars[nibble];

        #ifdef dev
            //self IPrintLnBold(sprintf("^2{0}) Nibble ^5{1}", i, nibble));
            //self IPrintLnBold(sprintf("^2{0}) result ^5{1}", i, result));
            //wait 1;
        #endif
    }

    return result;
}

// Check for mod
function is_mod_active( mod_id ){

	return GetDvarString("fs_game") == mod_id;
}


// Monitor between rounds
function monitor_between_rounds(){
    
    level.is_round_waiting = true; // For gsc_round
    level waittill( "zombie_total_set" );
    level.old_ztotal = getaiteamarray( "axis" ).size + level.zombie_total + level.zombie_respawns; // zsph
    //level thread debug_message_instant("^1old_ztotal ^5"+level.old_ztotal);

    //level wait_till("begin_spawning");
    //level debug_message_instant( "^2Can switch rounds!" );
    level.is_round_waiting = false; // For gsc_round
    level.round_start = level.n_gameplay_start_time; // zsph

    for(;;){
        level waittill( "end_of_round" );

        // Skip moon's earth TP
        if( level flag::exists("teleporter_used") && level flag::get("teleporter_used") ) continue;

        level.is_round_waiting = true; // For gsc_round
        level.round_start = gettime(); // zsph
        //level debug_message_instant( "^1Can NOT switch rounds..." );


        // Wait for round start notifications
        str_notify = level util::waittill_any_return("zombie_total_set", "special_round" );

        #ifdef dev
            if( !isdefined( str_notify ) ) level thread debug_message( "^1NO End notify..." );
            else{
                //level thread debug_message( "^2Round End notify" );
                //level thread debug_message( str_notify );
            }
        #endif
        //level waittill( "between_round_over" );
        //wait 2;
        level.is_round_waiting = false; // For gsc_rounds
        level.old_ztotal = getaiteamarray( "axis" ).size + level.zombie_total + level.zombie_respawns; // zsph
        //level thread debug_message_instant("^1old_ztotal ^5"+level.old_ztotal);
        //level debug_message_instant( "^2Can switch rounds!" );
    }
}

function is_waiting_between_rounds(){

    return level.is_round_waiting;
}


// Clones
function make_player_clone( index ){
	mdl_clone = spawn("script_model", self.origin);
	mdl_clone.angles = self.angles;
	
    if( isdefined( index ) && isdefined( level.mdl_char_bodies[ index % 4 ] ) ) mdl_body = level.mdl_char_bodies[ index % 4 ];
    else mdl_body = self getcharacterbodymodel();
    
	mdl_clone setmodel(mdl_body);
	bodyrenderoptions = self getcharacterbodyrenderoptions();
	mdl_clone setbodyrenderoptions(bodyrenderoptions, bodyrenderoptions, bodyrenderoptions);
	mdl_clone.health = 100;
	//mdl_clone setowner(self);
	//mdl_clone.team = self.team;
	mdl_clone solid();
	return mdl_clone;
}

function make_default_clone( s_respawn_point, model = "defaultactor" ){

    mdl_clone = spawn("script_model", s_respawn_point.origin);
    mdl_clone.angles = s_respawn_point.angles;
    mdl_clone setmodel( model );
    mdl_clone.health = 100;
    mdl_clone solid();

    return mdl_clone;
}