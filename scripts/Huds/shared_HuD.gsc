function register_shared_huds(){

    // register_hud( str_hud_name, a_str_names, visibility_function, update_function, label, per_player, map, b_is_cheat_protected ){

    // Shows Surtr Game Identifier
    register_hud( "Game_Identifier", array("GameIdentifier", "AntiSplice", "AntiCheat"), HUD_DEFAULT_VISIBILITY, ::game_identifier_update, "", GLOBAL_HUD, ALL_MAPS, ALLOWED );
    
    #ifdef dev
        // Match data
            // Shows if gamemode uses XP
            register_hud( "Game_Mode_Using_XP", array("GameModeUsingXP", "UsingXP"), HUD_DEFAULT_VISIBILITY, ::is_gamemode_using_xp, "Game Mode Using XP: ^1", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Display level.rankedmatch var value
            register_hud( "Ranked_Match", array("RankedMatch"), HUD_DEFAULT_VISIBILITY, ::ranked_match, "level.rankedmatch: ^1", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );

        // Game data
            // Display "version" Dvar value
            register_hud( "Dvar_Version", array("DvarVersion", "Build_Version", "BuildVersion"), HUD_DEFAULT_VISIBILITY, ::Dvar_Version, "Dvar `Version`: ^5", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows Game Version detected by Surtr
            register_hud( "Game_Version", array("GameVersion"), HUD_DEFAULT_VISIBILITY, ::Game_Version, "Str Game Version: ^8", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows if Surtr detects we are on the last version of the game
            register_hud( "Game_Is_Last_Version", array("GameIsLastVersion"), HUD_DEFAULT_VISIBILITY, ::Game_Is_Last_Version, "Game Is Last Version: ", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows if Surtr detects we are on a Custom Client
            register_hud( "Game_Is_Custom_Client", array("GameIsCustomClient"), HUD_DEFAULT_VISIBILITY, ::Game_Is_Custom_Client, "Game Is Custom Client : ", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Display "cg_thirdpersonangle" Dvar value
            register_hud( "Dvar_Cg_Thirdpersonangle", array("Cg_Thirdpersonangle", "Thirdpersonangle"), HUD_DEFAULT_VISIBILITY, ::Dvar_cg_thirdpersonangle, "Dvar `Cg_ThirdPersonAngle`: ^5", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
    #endif

    // Timers
        // Display current Game time
        register_hud( "Game_Time", array("GameTime", "Game", "Game_Timer", "GameTimer", "Time"), HUD_DEFAULT_VISIBILITY, ::game_time_update, "Game Time: ^9", GLOBAL_HUD, ALL_MAPS, ALLOWED );
        // Displays current Session Time
        // register_hud( "Session_Time", array("SessionTime", "Session"), HUD_DEFAULT_VISIBILITY, ::game_time_update, "Session Time: ^5", GLOBAL_HUD, ALL_MAPS, ALLOWED ); // TODO: Current Session time, I need to make practice detection properly before doing this
        // Displays Current Date
        register_hud( "UTC_Date", array("UTCDate", "Date"), HUD_DEFAULT_VISIBILITY, ::utc_date_update, "UTC Date: ^5", GLOBAL_HUD, ALL_MAPS, ALLOWED );
        // Displays Current Time
        register_hud( "UTC_Time", array("UTCTime"), HUD_DEFAULT_VISIBILITY, ::game_time, "UTC Time: ^5", GLOBAL_HUD, ALL_MAPS, ALLOWED );

    #ifdef dev
        // Shows time left to refresh UTC Date
        register_hud( "UTC_Refresh", array("UTCRefresh", "Refresh"), HUD_DEFAULT_VISIBILITY, ::game_utc, "UTC Time For New Day: ^5", GLOBAL_HUD, ALL_MAPS, ALLOWED );
        // Displays the current Paused Time
        register_hud( "GetTotalServerPauseTime", array("GTSPT"), HUD_DEFAULT_VISIBILITY, ::game_GetTotalServerPauseTime, "GetTotalServerPauseTime: ^5", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
        // Displays the time paused BEFORE the gameplay started
        register_hud( "Pause_Before_Game_Start", array("PauseBeforeGameStart", "PBGS"), HUD_DEFAULT_VISIBILITY, ::game_pause_before_game_starts, "Pause Before Game Start: ^5", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
        // Displays the time paused AFTER the gameplay started
        register_hud( "Pause_After_Game_Start", array("PauseAfterGameStart", "PAGS"), HUD_DEFAULT_VISIBILITY, ::game_pause_after_game_starts, "Pause After Game Start: ^5", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
    #endif

    // Player HuDs
        // Shows current speed from Api method
        register_hud( "Speed_Meter", array("SpeedMeter", "Velocity_Meter", "VelocityMeter", "Velocity", "Speed"), HUD_DEFAULT_VISIBILITY, ::speed_update, "Speed: ^6", PLAYER_HUD, ALL_MAPS, ALLOWED );
        // Shows current speed from speed math calculation
        register_hud( "Speed_Meter_Old", array("SpeedMeterOld", "Velocity_Meter_Old", "VelocityMeterOld","Velocity_Old",  "VelocityOld", "Speed_Old", "SpeedOld"), HUD_DEFAULT_VISIBILITY, ::speed_old_update, "Old Speed: ^6", PLAYER_HUD, ALL_MAPS, ALLOWED );
        // Displays the XUID value of the player
        register_hud( "XUID", undefined, HUD_DEFAULT_VISIBILITY, ::xuid_update, "XUID: ^5", PLAYER_HUD, ALL_MAPS, ALLOWED );
        // Displays the GUID value of the player
        register_hud( "GetGuid", array("Guid"), HUD_DEFAULT_VISIBILITY, ::getguid_update, "getguid: ^1", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );

    #ifdef dev
        // Movement
            // Shows whenever a FORWARD movement is happening
            register_hud( "Forward", array("W"), HUD_DEFAULT_VISIBILITY, ::forward_update, "Forward: ^5", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows whenever a LEFT movement is happening
            register_hud( "Left", array("A"), HUD_DEFAULT_VISIBILITY, ::left_update, "Left: ^5", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows whenever a BACKWARD movement is happening
            register_hud( "Backward", array("S"), HUD_DEFAULT_VISIBILITY, ::backward_update, "Backward: ^5", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows whenever a RIGHT movement is happening
            register_hud( "Right", array("D"), HUD_DEFAULT_VISIBILITY, ::right_update, "Right: ^5", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows whenever a SLIDE movement is happening
            register_hud( "Slide", undefined, HUD_DEFAULT_VISIBILITY, ::slide_update, "Slide: ^5", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows whenever an ACTION movement is happening
            register_hud( "action", undefined, HUD_DEFAULT_VISIBILITY, ::action, "Action: ^1", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows whenever a JUMP movement is happening
            register_hud( "jump", undefined, HUD_DEFAULT_VISIBILITY, ::jump, "Jump: ^1", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );

        // Weapon info
            // Shows current weapon list
            register_hud( "Weapons_List", array("WeaponsList", "W_List", "WList"), HUD_DEFAULT_VISIBILITY, ::Weapons_List, "Weapons List: \n", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows current weapon attachments
            register_hud( "Attachments", array("Attachs"), HUD_DEFAULT_VISIBILITY, ::hud_attachments, "Attachments: \n", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows supported attachments for current weapon
            register_hud( "Supported_Attachments", array("SupportedAttachments", "SA"), HUD_DEFAULT_VISIBILITY, ::hud_supported_attachments, "Supported Attachments: \n", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows supported Optics for current weapon
            register_hud( "Supported_Optics", array("SupportedOptics", "SO"), HUD_DEFAULT_VISIBILITY, ::hud_optics, "Supported Optics: \n", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows Alt weapon info for current weapon
            register_hud( "alt", undefined, HUD_DEFAULT_VISIBILITY, ::alt_weapon, "Alt Weapon Info: ^1", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );

        // Surtr Toggles Data
            // Shows saved Surtr toggles data
            register_hud( "World_Toggles", array("WorldToggles", "WT"), HUD_DEFAULT_VISIBILITY, ::world_toggles, "World Toggles: ^1", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
            // Shows active Surtr toggles data
            register_hud( "Level_Toggles", array("LevelToggles", "LT"), HUD_DEFAULT_VISIBILITY, ::level_toggles, "Level Toggles: ^1", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
    #endif

}

// This one is gonna be different, label is gonna be updated as well to set all the numbers (converted to string) and then the UTC time will be a Date on the label AND a timerUp
function game_identifier_update(){
    self endon( "death" );
    self notify( "hud_reset" );
    self endon( "hud_reset" );

    self.reset_on_pause = true;
    self.alpha = 0.5;
    self.foreground = true;

    // Wait for Systems to be fully registered to do the Hashes
    system::wait_till("all"); // parameter is ignored on function, just copy pasting from scripts/zm/_load.gsc
    #ifdef dev
        // level thread debug_message_instant("^2system_init_complete !");
    #endif

    // Reset HUD with updated UTC value whenever a pause occurs
    //self thread watch_for_new_paused_server_time( ::game_time );

    old_label = "";

    while( self.is_moving  ) wait 0.05;

    old_label += get_game_identifier();
    self.label = istring( old_label );

    wait_time = self GetTimeForNextUtcDay();
    timer = SECONDS_IN_A_DAY - wait_time;
    self SetTimerUp( 0 - timer );

    // self thread refresh_game_identifier_timeup( wait_time );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05;
        
        new_label = get_game_identifier();
        if( old_label == new_label ) continue;

        #ifdef dev
            level thread debug_message_instant("^6Updated ^5Game Identifier ^8Label!");
        #endif

        old_label = new_label;
        self.label = istring( old_label );


        wait_time = self GetTimeForNextUtcDay();
        timer = SECONDS_IN_A_DAY - wait_time;
        self SetTimerUp( 0 - timer );
    }

}

function get_game_identifier(){

    utc = GetUTC();

    client_version = "^8";

    // Client version
    client_version += STR_CURRENT_GAME_VERSION;

    // Surtr version
    client_version += "^9 Surtr."+SURTR_VERSION+"^7";
    
    // Hash the systems
    str_gsc_checksum = "";

    //level.system_funcs[str_system] // Detect if a new GSC system has been injected and added
    foreach( str_system, s_system in level.system_funcs )
        str_gsc_checksum += str_system + isdefined( s_system.prefunc ) + isdefined( s_system.postfunc ) +s_system.ignore;

    // Hash the event callbacks
    foreach( hash_event, a_callbacks in level._callbacks )
        str_gsc_checksum += hash_event+a_callbacks.size;
    
    // Current map-load timestamp => GetDvarInt( DVAR_CURRENT_MAP_LOAD_TIMESTAMP);

    // Randomly generated value on process start
    if( GetDvarString( DVAR_PROCESS_START ) == "" ){
        a_possible_chars = "abcdefghijklmnopqrstuvwxyz0123456789!·$%&()=?¡@#%";
        str_process_start = "";
        for(i=0; i<4; i++)
            str_process_start += a_possible_chars[ RandomInt( a_possible_chars.size ) ];
        SetDvar( DVAR_PROCESS_START, str_process_start );
    }

    // Randomly generated value on map-load/restart
    if( !isdefined( level.str_rand ) ){
        a_possible_chars = "abcdefghijklmnopqrstuvwxyz0123456789!·$%&()=?¡@#%";
        level.str_rand = "";
        for(i=0; i<4; i++)
            level.str_rand += a_possible_chars[ RandomInt( a_possible_chars.size ) ];
    }

    // Session's Unique ID, refreshes every map-load/restart
    str_session_id = "";
    str_session_id += level.str_rand + MAP_NAME;

    // Users ID
    str_user_id = "Surtr";

    a_sorted_players = [];
    foreach( player in GetPlayers() ){

        // Sort by biggest XUID
        for( index=0; index<a_sorted_players.size; index++ ){
            if( !a_sorted_players[ index ] getxuid(1) < player getxuid(1) ) continue;

            break;
        }

        // Add player on its position
        ArrayInsert(a_sorted_players, player, index);
    }

    // Form the string to hash the Users ID
    foreach( player in a_sorted_players )
        str_user_id += player getguid() + player getxuid(1);

    #ifdef dev
        //return "ClientVersion:"+client_version+"-GSCChecksum:"+int_to_hex( hashstring( str_gsc_checksum ) )+"-MapLoadTimeStamp:"+GetDvarInt( DVAR_CURRENT_MAP_LOAD_TIMESTAMP )+"-ProcessStart:"+GetDvarString( DVAR_PROCESS_START )+"-StrRand:"+level.str_rand+"-SessionID:"+int_to_hex( hashstring( str_session_id ) )+"-UserID:"+int_to_hex( hashstring( str_user_id ) )+" ^5";
    #endif
  
    return ""+client_version+"-"+int_to_hex( hashstring( str_gsc_checksum ) )+"-"+GetDvarInt( DVAR_CURRENT_MAP_LOAD_TIMESTAMP )+"-"+GetDvarString( DVAR_PROCESS_START )+"-"+level.str_rand+"-"+int_to_hex( hashstring( str_session_id ) )+"-"+int_to_hex( hashstring( str_user_id ) )+" | "+GetUtcDate()+" ^5";
}


#ifdef dev
function is_gamemode_using_xp(){
    self endon( "death" );

    while( self.is_moving ) wait 0.05;
    self SetValue( gamemodeisusingxp() );
}

function ranked_match(){
    self endon( "death" );

    for(;;){
        wait 0.05;
        
        if( self.is_moving  ) continue;

        val = isdefined( level.rankedmatch ) ? level.rankedmatch : false;
        self SetValue( val );
    }
}

function Dvar_Version(){
    self endon( "death" );

    while( self.is_moving ) wait 0.05;
    self SetText( GetDvarString("version", "Undefined" ) );
}

function Game_Version(){
    self endon( "death" );

    while( self.is_moving ) wait 0.05;
    self SetText( STR_CURRENT_GAME_VERSION );
}

function Game_Is_Last_Version(){
    self endon( "death" );

    while( self.is_moving ) wait 0.05;

    if( GAME_IS_LAST_VERSION )
        self SetText( "^2Last version!" );
    else
        self SetText( "^1Not the last version..." );
}

function Game_Is_Custom_Client(){
    self endon( "death" );

    while( self.is_moving ) wait 0.05;

    if( IS_CUSTOM_CLIENT )
        self SetText( "^2Custom Client!" );
    else
        self SetText( "^1Retail Version..." );
}

function Dvar_cg_thirdpersonangle(){
    self endon( "death" );

    while( self.is_moving ) wait 0.05;
    old_val = GetDvarFloat(DVAR_CG_THIRDPERSONANGLE);
    self SetValue( old_val );

    for(;;){
        wait 0.05;
        while( self.is_moving ) wait 0.05;

        new_val = GetDvarFloat(DVAR_CG_THIRDPERSONANGLE);
        if( old_val == new_val ) continue;
        old_val = new_val;
        self SetValue( old_val );
    }

}
#endif

#region timers
function game_time_update(){
    self endon( "death" );

    self notify( "hud_reset" );
    self endon( "hud_reset" );

    self.color = COLOR_LIGHT_GREY;
    //self.color = COLOR_DARK_ORANGE;


    self.reset_on_pause = true;

    // Maybe we can set Tenths Timer
    if( !has_game_started() ){
        wait_for_game_start();

        // HUD is being managed
        if( self.is_moving ){
            // Wait for HUD to be available to set a value
            while( self.is_moving ) wait 0.05;

            time = gettime() - level.n_gameplay_start_time;
            self SetTimerUp( (0 - time ) / 1000 );
        // Available to set tenths timer
        }else{
            wait 0.05;
            self SetTenthsTimerUp( 0.05 ); // Tenths timer can't start at 0.00
            self.timer_tenths_set = true;
        }
    }else{

        time = gettime() - level.n_gameplay_start_time;
        // Add pause time
        if( IS_RTA ){
            pause_time = GetTotalServerPauseTime();
            if( isdefined( level.wait_time_before_game_start ) ) pause_time -= level.wait_time_before_game_start;

            // There has been a pause
            if( pause_time > 0 ) self SetTimerUp( (0 - ( time + pause_time ) ) / 1000 );

        // Only update if necessary
        }else{
            // Only change it when tenths timer is NOT set!
            // Tenths Timer active means timer was running since game start and RTA has been always OFF
            if( !isdefined( self.timer_tenths_set ) ) self SetTimerUp( (0 - time ) / 1000 ); 
        }

    }

}

function utc_date_update(){
    self endon( "death" );

    self notify( "hud_reset" );
    self endon( "hud_reset" );

    self.reset_on_pause = true;

    // Reset HUD with updated UTC value whenever a pause occurs
    //self thread watch_for_new_paused_server_time( ::utc_date_update ); // Maybe this should be always called and therefore be multipurpose?

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05;
        
        dateString = self GetUtcDate();
        self SetText( dateString );

        wait_time = self GetTimeForNextUtcDay();
        #ifdef dev
            level thread debug_message("Time for next UTC day: ^5"+wait_time);
        #endif
        wait wait_time;

        #ifdef dev
            level thread debug_message("^2Time to change the date!");
        #endif

        while( dateString == self GetUtcDate()  ) wait 0.05; // TODO: Instead of constant 0.05s inf loop, we can just wait for a Server Pause or a new UTC day?

        #ifdef dev
            level thread debug_message("^2Setting new date!");
        #endif
    }

}

function game_time(){
    self endon( "death" );

    self notify( "hud_reset" );
    self endon( "hud_reset" );

    self.reset_on_pause = true;
    // Reset HUD with updated UTC value whenever a pause occurs
    //self thread watch_for_new_paused_server_time( ::game_time );

    for(;;){
        wait 0.05;
        while( self.is_moving ) wait 0.05;

        wait_time = self GetTimeForNextUtcDay();
        timer = SECONDS_IN_A_DAY - wait_time;
        self SetTimerUp( 0 - timer );
        
        #ifdef dev
            level thread debug_message("Time for next UTC day: ^5"+wait_time);
        #endif

        wait wait_time;

        while( self GetTimeForNextUtcDay() <= SECONDS_IN_A_DAY  ) wait 0.05;
        #ifdef dev
            level thread debug_message("^2Restarting UTC Time");
        #endif
    }

}

#ifdef dev
function game_utc(){
    self endon( "death" );

    self notify( "hud_reset" );
    self endon( "hud_reset" );

    self.reset_on_pause = true;
    // Reset HUD with updated UTC value whenever a pause occurs
    //self thread watch_for_new_paused_server_time( ::game_utc );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05;
        
        wait_time = SECONDS_IN_A_DAY - GetTimeForNextUtcDay();  // 23:59:59 max
        self SetTimer( wait_time );

        wait wait_time;

    }

}

function game_pause_before_game_starts(){
    self endon( "death" );

    self notify( "hud_reset" );
    self endon( "hud_reset" );

    self.reset_on_pause = true;

    // Undefined
    if( !isdefined( level.wait_time_before_game_start ) ){
        self setText("Undefined");

        while( !isdefined( level.wait_time_before_game_start ) ) wait 0.05;
    }

    // Wait for HUD to be available
    while( self.is_moving  ) wait 0.05;

    self setValue( level.wait_time_before_game_start );
}

function game_GetTotalServerPauseTime(){
    self endon( "death" );

    for(;;){
        wait 0.05;
        // Wait for HUD to be available
        if( self.is_moving  ) continue;  

        self setValue( GetTotalServerPauseTime() );
    }

}

function game_pause_after_game_starts(){
    self endon( "death" );

    self notify( "hud_reset" );
    self endon( "hud_reset" );

    self.reset_on_pause = true;

    // Undefined
    if( !isdefined( level.wait_time_before_game_start ) ){
        self setText("Undefined");

        while( !isdefined( level.wait_time_before_game_start ) ) wait 0.05;
    }

    // Wait for HUD to be available
    while( self.is_moving  ) wait 0.05;

    self setValue( GetTotalServerPauseTime() - level.wait_time_before_game_start );
}

#endif

#endregion

#region player huds

// Speedmeter
function speed_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;
    old_val = self.owner get_n_speed();
    self SetValue( old_val );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05;

        new_val = self.owner get_n_speed();

        if( new_val == old_val ) continue; // Don't update

        old_val = new_val;
        self SetValue( old_val );
    }
}

function speed_old_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;
    old_val = 0;
    self SetValue( old_val );

    for(;;){
        origin = self.owner GetOrigin();
        wait 0.05;
        while( self.is_moving  ) continue;

        new_val = self.owner old_get_n_speed( origin );

        if( new_val == old_val ) continue; // Don't update

        old_val = new_val;
        self SetValue( old_val );
    }
}

function get_n_speed(){
    self endon("disconnect");

    // Avoid errors
    if( !IsAlive( self ) ) return 0;

    v_speed = self GetVelocity();

    // Check if player wants to ignore Z values
    if( self player_counts_z_value() ) return int( Length( v_speed ) );

    return int( Length( ( v_speed[AXIS_X], v_speed[AXIS_Y], 0 ) ) );
}

function old_get_n_speed( v_prev_position ){
    self endon("disconnect");

    // Avoid errors
    if( !IsAlive( self ) ) return 0;

    // There is no previous point to calculate speed
    if( !isdefined( v_prev_position ) ) return 0;

    v_curr_position = self GetOrigin();

    // Check if player wants to ignore Z values
    if( self player_counts_z_value() ){
        distance = Distance(v_prev_position, v_curr_position);
        return int( distance / 0.05 );
    }

    v_prev_position = ( v_prev_position[AXIS_X], v_prev_position[AXIS_Y], 0);
    v_curr_position = ( v_curr_position[AXIS_X], v_curr_position[AXIS_Y], 0);

    distance = Distance(v_prev_position, v_curr_position);

    return int( distance / 0.05 );
}

// Player account ID
function xuid_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;
    self SetText( self.owner getxuid( 1 ) );
}

// Player account GUID
function getguid_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;
    self SetText( self.owner getguid() );
}

// DEV
#ifdef dev
// Movement vectors
function forward_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;
    old_val = self.owner getnormalizedmovement()[ 0 ];
    if( old_val < 0 ) old_val = 0;
    self SetValue( old_val );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05;

        new_val = self.owner getnormalizedmovement()[ 0 ];
        if( new_val < 0 ) new_val = 0;

        if( new_val == old_val ) continue;

        old_val = new_val;
        self setValue( new_val );
    }

}

function left_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;
    old_val = self.owner getnormalizedmovement()[ 1 ];
    if( old_val > 0 ) old_val = 0;
    else old_val = Abs( old_val );
    self SetValue( old_val );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05;

        new_val = self.owner getnormalizedmovement()[ 1 ];
        if( new_val > 0 ) new_val = 0;
        else new_val = Abs( new_val );

        if( new_val == old_val ) continue;

        old_val = new_val;
        self setValue( new_val );
    }

}

function backward_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;
    old_val = self.owner getnormalizedmovement()[ 0 ];
    if( old_val > 0 ) old_val = 0;
    else old_val = Abs( old_val );
    self SetValue( old_val );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05;

        new_val = self.owner getnormalizedmovement()[ 0 ];
        if( new_val > 0 ) new_val = 0;
        else new_val = Abs( new_val );

        if( new_val == old_val ) continue;

        old_val = new_val;
        self setValue( new_val );
    }

}

function right_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;
    old_val = self.owner getnormalizedmovement()[ 1 ];
    if( old_val < 0 ) old_val = 0;
    self SetValue( old_val );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05;

        new_val = self.owner getnormalizedmovement()[ 1 ];
        if( new_val < 0 ) new_val = 0;

        if( new_val == old_val ) continue;

        old_val = new_val;
        self setValue( new_val );
    }

}

function slide_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;
    old_val = self.owner ButtonBitState( BIT_SLIDE );
    if( old_val < 0 ) old_val = 0;
    self SetValue( old_val );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05;

        new_val = self.owner ButtonBitState( BIT_SLIDE );
        if( new_val < 0 ) new_val = 0;

        if( new_val == old_val ) continue;

        old_val = new_val;
        self setValue( new_val );
    }
}


function hud_attachments(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;

    old_text = "";
    self SetText( old_text );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

        text = "";
        weapon = get_nonalternate_weapon( self.owner GetCurrentWeapon() );
        text += sprintf("N of Attachments: {0}\n", weapon.attachments.size );
        foreach( index, attachment in weapon.attachments ){

            text += sprintf("^2{0} ^5{1} \n", index +1, attachment );
        }

        if( text == old_text ) continue;

        old_text = text;
        self SetText( old_text );
    }
}

function hud_supported_attachments(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;

    old_text = "";
    self SetText( old_text );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

        text = "";
        weapon = get_nonalternate_weapon( self.owner GetCurrentWeapon() );
        supported_attachments = weapon.rootweapon.supportedattachments;

        foreach( index, attachment in weapon.rootweapon.supportedattachments ){
            if( !isdefined( attachment ) || attachment == "") continue;
            //text += sprintf("^2{0} ^5{1} \n", index +1, attachment );
            text += sprintf("^5{1}\n", index +1, attachment );
        }

        if( text == old_text ) continue;

        old_text = text;
        self SetText( old_text );
    }
}

function hud_optics(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;

    old_text = "";
    self SetText( old_text );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch


        weapon = self.owner GetCurrentWeapon();

        // This weapon doesn't support any attachment...
        if( weapon.supportedattachments.size == 0 ){
            self settext("No supported attachments...");
            continue;
        }

        a_valid_optics = []; // Valid optics for the weapon
        a_give_attachments = []; // Attachments we decided that we are going to give
        a_best_optics = array("ir", "dualoptic", "reddot");

        // Get the Attachments that the weapon can use
        foreach( attach in weapon.rootweapon.supportedattachments ){
            if( is_optic( attach ) ) ArrayInsert(a_valid_optics, attach, a_valid_optics.size);
        }

        // Get max amount
        if( IsInArray(array("smg","rifle","spread","mg"), weapon.rootweapon.weapclass)) n_max_attachments = 5;
        else if( IsInArray(array("sniper"), weapon.rootweapon.weapclass)) n_max_attachments = 4;
        else if( IsInArray(array("pistol"), weapon.rootweapon.weapclass)) n_max_attachments = 2;

        // Give optic
        if( a_valid_optics.size > 0 ){

            b_optic = false;
            foreach( optic in a_best_optics){
                if( !IsInArray(a_valid_optics, optic)) continue;
                b_optic = true;
                ArrayInsert(a_give_attachments, optic, a_give_attachments.size);
                break;
            }

            // If preferred optics are not available, just give the first available one
            if( !b_optic )
                ArrayInsert(a_give_attachments, a_valid_optics[0], a_give_attachments.size);
        }

        text = "";

        foreach( index, optic in a_valid_optics ){
            if( IsInArray(a_give_attachments, optic) ) text += sprintf("^2{0}\n^7", optic);
            else if( index == 0 ) text += sprintf("^5{0}\n^7", optic);
            else text += sprintf("{0}\n", optic);
        }

        if( text == old_text ) continue;

        old_text = text;
        self SetText( old_text );
    }
}


function Weapons_List(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;

    old_text = "";
    self SetText( old_text );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

        text = "";
        foreach( index, weapon in self.owner GetWeaponsListPrimaries() ){

            text += sprintf("^2{0} ^7) ^5{1} ^6{2} \n", index +1, MakeLocalizedString( weapon.rootweapon.displayname ), weapon.rootweapon.name );

        }

        if( text == old_text ) continue;

        old_text = text;
        self SetText( old_text );
    }
}

function alt_weapon(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

        if( !isdefined( level.host ) ) self SetText( "^1Undefined host..." );
        else{
            w_current = level.host GetCurrentWeapon();
            
            if( !isdefined( w_current ) ) self SetText( "^1Undefined current weapon..." );
            else{
                
                if( !IsWeapon( w_current ) ) self SetText( "^1Not a weapon" );
                else{
                    if( !isdefined( w_current.isaltmode ) ) self SetText( "^1Undefined alt mode ^5"+w_current.name );
                    else{
                        
                        if( !isdefined( w_current.altweapon ) ) self SetText( "^1Undefined alt weapon ^5"+w_current.name );
                        else{
                            
                            self SetText( basic_parser(w_current.rootweapon.name)+": ^7Alt mode ^2"+w_current.isaltmode+" ^7AltWeapon: ^5"+w_current.altweapon.name+" ^7| is_w_none ^1"+( w_current.rootweapon.altweapon == level.weaponnone ) );
                        }
                    }
                }
            }
        }

    }
}

function action(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch


        self SetValue( self.owner ActionButtonPressed() );
    }
}

function jump(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    while( self.is_moving  ) wait 0.05;

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch


        self SetValue( self.owner JumpButtonPressed() );
    }
}

function world_toggles(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    xuid = self.owner getxuid(0);

    while( self.is_moving  ) wait 0.05;

    old_text = "";
    self SetText( old_text );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch


        if( !isdefined( world.toggles ) || !isdefined( world.toggles[ xuid ] ) ){
            text = "World Toggles not created for player yet...";
        }else{
            text = "";

            foreach(index, toggle in world.toggles[ xuid ]){
                text += sprintf("^5{0}^7) ^2{1}\n", index, toggle);
            }
        }

        if( text == old_text ) continue;

        old_text = text;
        self SetText( old_text );
    }
}

function level_toggles(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    xuid = self.owner getxuid(0);

    while( self.is_moving  ) wait 0.05;

    old_text = "";
    self SetText( old_text );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch


        if( !isdefined( level.toggles ) || !isdefined( level.toggles[ xuid ] ) ){
            text = "Level Toggles not created for player yet...";
        }else{
            text = "";

            foreach(index, toggle in level.toggles[ xuid ]){
                text += sprintf("^5{0}^7) ^2{1}\n", index, toggle);
            }
        }

        if( text == old_text ) continue;

        old_text = text;
        self SetText( old_text );
    }
}
#endif

#endregion

