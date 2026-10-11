function autoexec __init__hud__registration__(){

    level.str_used_huds = []; // This to make runs easier to verify, at the end of the game, we will display all HuDs that were used on the run!
    level._huds = []; // Hold HuDs data here

    // register_hud( str_hud_name, a_str_names, visibility_function, update_function, label, per_player, map, b_is_cheat_protected ){

    register_shared_huds();

    if( IS_ZOMBIES ){
        register_zm_huds();
    }
    
    level.hud_registration_completed = true;
}

function wait_for_hud_registration(){

    while( !isdefined( level.hud_registration_completed ) ) wait 0.05;
}

function register_hud( str_hud_name, a_str_names, visibility_function, update_function, label, per_player, map, b_is_cheat_protected ){

    // Error checks

    // Undefined hud_name
    if( !Isdefined( str_hud_name ) ){
        level thread debug_message( text_error()+"Can't register hud, Undefined str_hud_name..." );
        return;
    }
    /* Undefined visibility_function NOT AN ERROR ANYMORE, JUST GIVE DEFAULT VISIBILITY FUNCTION
    if( !Isdefined( visibility_function ) ){
        level thread debug_message( text_error()+"Can't register hud "+str_hud_name+", Undefined visibility_function..." );
        return;
    }*/

    // Undefined update_function
    if( !Isdefined( update_function ) ){
        level thread debug_message( text_error()+"Can't register hud "+str_hud_name+", Undefined update_function..." );
        return;
    }

    // Undefined label
    if( !Isdefined( label ) ){
        level thread debug_message( text_error()+"Can't register hud "+str_hud_name+", Undefined label..." );
        return;
    }

    // Undefined per_player
    if( !Isdefined( per_player ) ){
        level thread debug_message( text_error()+"Can't register hud "+str_hud_name+", Undefined per_player..." );
        return;
    }

    // Undefined map
    if( !Isdefined( map ) ){
        level thread debug_message( text_error()+"Can't register hud "+str_hud_name+", Undefined map..." );
        return;
    }

    // Undefined b_is_cheat_protected
    if( !Isdefined( b_is_cheat_protected ) ){
        level thread debug_message( text_error()+"Can't register hud "+str_hud_name+", Undefined b_is_cheat_protected..." );
        return;
    }


    // Give default visibility function if not defined
    if( !isdefined( visibility_function ) )
        visibility_function = ::hud_default_visibility;
    
    // First make sure the command name is NOT already on other level.custom_commands[ str_command ].a_str_names
    // Second make the same for the rest of a_str_names to register AND check they are NOT duplicated within the same array
    str_hud_name = ToLower( str_hud_name );
    str_duplicated = hud_name_already_exist( str_hud_name );

    // We can not even register the command
    if( isdefined( str_duplicated ) ){
        level thread debug_message( text_error()+"^5"+str_hud_name+" ^1is already registered in huds ^2"+str_duplicated );
        return;
    }

    // Add the full and proper name of the command as the first one always
    a_all_str_names = [];
    ArrayInsert(a_all_str_names, str_hud_name, a_all_str_names.size);

    // Maybe a command doesn't have extra names
    if( isdefined( a_str_names ) ){
        // Check if the names can be registered
        foreach( str_name in a_str_names ){
            str_name = ToLower( str_name );
            str_duplicated = hud_name_already_exist( str_name );
            if( isdefined( str_duplicated ) ){ // It's duplicated
                level thread debug_message( text_error()+"^1Ignoring name ^1"+str_name+" ^7 for command ^5"+str_hud_name+" ^1, already registered in ^2"+str_duplicated );
            }else if( IsInArray(a_all_str_names, str_name) ){ // Duplicated within the same command register...
                level thread debug_message( text_error()+"^1Ignoring name ^1"+str_name+" ^7 for command ^5"+str_hud_name+" ^1, it's duplicated..." );
            }else{ // Unique name ready to be added
                ArrayInsert(a_all_str_names, str_name, a_all_str_names.size);
            }
        }
    }

    // Create the HuD struct, we leave the proper name as the string key
    level._huds[ str_hud_name ] = SpawnStruct();

    // Where we store the HuD
    if( per_player ) level._huds[ str_hud_name ]._hud = []; // Make it an array so each player has its own hud
    else level._huds[ str_hud_name ]._hud = undefined; // Otherwise it will be shared by all players

    // All the HuD data
    level._huds[ str_hud_name ].a_str_names = a_all_str_names; // All the valid names for the HuD to be found when typed on console
    level._huds[ str_hud_name ].visibility_function = visibility_function; // Function that controls when should it be shown on screen with .alpha value
    level._huds[ str_hud_name ].update_function = update_function; // Function that updates the value of the HuD
    level._huds[ str_hud_name ].label = istring( label );
    level._huds[ str_hud_name ].map = map; // Indicates if the HuD is for a specific map, value is either general or map name
    level._huds[ str_hud_name ].b_is_cheat_protected = b_is_cheat_protected; // Checks if the HuD should only be allowed on practice mode
    level._huds[ str_hud_name ].per_player = per_player; // Easier way to know if it's a Global or Per player HuD | GLOBAL_HUD or PLAYER_HUD
}

function register_split( str_hud_name, a_str_names, display_name, map, ee_split, wait_split_function ){

    //register_hud( str_hud_name, a_str_names, visibility_function, update_function, label, map, )
    register_hud( str_hud_name, a_str_names, ::hud_ee_split_visibility, ::hud_split_default_update, display_name, GLOBAL_HUD, map, ALLOWED );

    s_split_hud = get_hud_by_name( str_hud_name );

    // HuD successfully registered check
    if( !isdefined( s_split_hud ) ){
        level thread debug_message("^1Error, couldn't find 'registered' SPLIT HuD?? ^5"+str_hud_name);
        return;
    }

    // Set basic split info
    s_split_hud.is_ee_split = ee_split;
    s_split_hud.splitted = false;

    // Not a split for this map
    if( ( map != ALL_MAPS ) && ( MAP_NAME != map ) ) return;

    level thread create_split_struct( s_split_hud, wait_split_function );
}

function create_split_struct( s_split_hud, wait_split_function ){

    // HuD successfully registered check
    if( !isdefined( s_split_hud ) ){
        level thread debug_message("^1Error, undefined split struct ^5");
        return;
    }

    // Wait for split to happen
    [[ wait_split_function ]]();
    
    // Set split data
    s_split_hud.HudElemTime = GetTime() - level.n_gameplay_start_time;
    s_split_hud.HudElemTime_pause = GetTotalServerPauseTime();
    // Subtract paused time before game start
    if( isdefined( level.wait_time_before_game_start ) ) s_split_hud.HudElemTime_pause -= level.wait_time_before_game_start;

    // Check if splits are automatic for this game
    if( isdefined( level.autosplits ) ){
        s_split_hud.splitted = true;

        // Check that the HUD for this split is active
        if( !is_hud_created( s_split_hud ) ) return; // There is no HuD to notify
        s_split_hud._hud notify( "splitted" );
    }
}



function hud_name_already_exist( str_hud ){

    foreach( s_hud in level._huds ){
        if( IsInArray( s_hud.a_str_names, str_hud ) ) return s_hud.a_str_names[0];
    }

    return undefined;
}

function gsc_hud( args ){

    if( !isdefined( level.hud_registration_completed ) ){
        self iPrintLnBold("^1Wait for ^5Hud registration^1 to be completed...");
        return;
    }

    hud_name = args[ 0 ];

    // Find the HuD
    s_hud = get_hud_by_name( hud_name );

    // Not found
    if( !isdefined( s_hud ) ){
        self IPrintLnBold("^1Couldn't find HuD ^5"+hud_name+"^1...");
        return;
    }

    // Cheat protected?
    if( is_hud_cheat_protected( s_hud ) && !is_practice_enabled() ){
        self IPrintLnBold("HuD ^5"+basic_parser( s_hud.a_str_names[0] )+" ^7is ^1cheat protected");
        return;
    }

    // Unavailable HuD
    if( is_hud_moving(s_hud) ){
        level thread debug_message( sprintf("^1Wait for HuD ^5{0} ^1to stop moving!", basic_parser( s_hud.a_str_names[0] ) ) );
        return;
    }

    if( self is_hud_saved( s_hud ) ) self remove_hud( s_hud ); // Remove the HuD if it's already Created? NO, remove it if it's not saved!
    else self create_new_hud( s_hud ); // Otherwise create it
}

#region hud basic utility
function is_hud_per_player( s_hud ){

    // Undefined check
    if( !isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Undefined s_hud in is_hud_per_player" );
        return false;
    }

    return s_hud.per_player;
}

function is_hud_created( s_hud ){

    // Undefined check
    if( !isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Undefined s_hud in is_hud_created" );
        return false;
    }

    if( is_hud_per_player( s_hud ) ) return isdefined( s_hud._hud[ MY_XUID ] );
    else return isdefined( s_hud._hud );
}

function is_hud_saved( s_hud ){

    // Undefined check
    if( !isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Undefined s_hud in is_hud_saved" );
        return false;
    }

    if( is_hud_per_player( s_hud ) ){
        
        // We didn't create the array of saved HuDs for that map
        if( !isdefined( world.player_huds[ s_hud.map ] ) ) return false;
        if( !isdefined( world.player_huds[ s_hud.map ][ MY_XUID ] ) ) return false;

        foreach( hud_key in world.player_huds[ s_hud.map ][ MY_XUID ] ) if( hud_key == s_hud.a_str_names[0] ) return true; // HuD found!
        return false; // Hud NOT found...
    }

    // We didn't create the array of saved HuDs for that map
    if( !isdefined( world.global_huds[ s_hud.map ] ) ) return false;

    foreach( hud_key in world.global_huds[ s_hud.map ] ) if( hud_key == s_hud.a_str_names[0] ) return true; // HuD found!
    return false; // Hud NOT found...
}

function is_hud_moving( s_hud ){

    // Undefined check
    if( !isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Undefined s_hud in is_hud_moving" );
        return true;
    }

    // If the HuD doesn't exist it can't be being moved
    if( !is_hud_created( s_hud ) ) return false;

    level thread debug_message( "Checking moving HuD "+basic_parser( s_hud.a_str_names[0]) );

    if( is_hud_per_player( s_hud ) ) return s_hud._hud[ MY_XUID ].is_moving;
    else return s_hud._hud.is_moving;
}

function is_hud_cheat_protected( s_hud ){

    // Undefined check
    if( !isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Undefined s_hud in is_hud_cheat_protected" );
        return true;
    }

    return s_hud.b_is_cheat_protected;
}

function is_hud_for_current_map( s_hud ){

    // Undefined check
    if( !isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Undefined s_hud in is_hud_for_current_map" );
        return false;
    }

    return ( s_hud.map == ALL_MAPS ) || ( s_hud.map == MAP_NAME );
}

function is_hud_split( s_hud ){

    // Undefined check
    if( !isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Undefined s_hud in is_hud_split" );
        return false;
    }

    return isdefined( s_hud.is_ee_split );
}

function is_hud_ee_split( s_hud ){

    // Undefined check
    if( !isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Undefined s_hud in is_hud_ee_split" );
        return false;
    }

    return is_hud_split( s_hud ) ? s_hud.is_ee_split : false;
}

function is_hud_splitted( s_hud ){

    // Undefined check
    if( !isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Undefined s_hud in is_hud_splitted" );
        return false;
    }

    return is_hud_ee_split( s_hud ) ? s_hud.splitted : false;
}

function add_hud_name_to_active_huds_list( s_hud ){

    // Undefined check
    if( !isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Undefined s_hud in add_hud_name_to_active_huds_list" );
        return false;
    }

    // This HuD is being created from the saved HuDs list
    if( is_hud_saved( s_hud ) ){
        #ifdef dev
            //if( is_hud_per_player( s_hud ) ) level thread debug_message( sprintf("Adding Saved Player HuD ^5{0} ^6{1}",s_hud.a_str_names[0], self.name ) );
            //else level thread debug_message( sprintf("Adding Saved Global HuD ^5{0}",s_hud.a_str_names[0] ) );
        #endif
        return;
    }

    // Print added HuD. We check if it was stored beforehand to avoid printing when the Saved HuDs are being created
    self thread print_hud_added( s_hud );

    if( is_hud_per_player( s_hud ) ){
        if( !isdefined( world.player_huds[ s_hud.map ] ) ) world.player_huds[ s_hud.map ] = [];
        if( !isdefined( world.player_huds[ s_hud.map ][ MY_XUID ] ) ) world.player_huds[ s_hud.map ][ MY_XUID ] = [];

        ArrayInsert( world.player_huds[ s_hud.map ][ MY_XUID ], s_hud.a_str_names[0], world.player_huds[ s_hud.map ][ MY_XUID ].size );
        return;
    }
    
    if( !isdefined( world.global_huds[ s_hud.map ] ) ) world.global_huds[ s_hud.map ] = [];

    ArrayInsert( world.global_huds[ s_hud.map ], s_hud.a_str_names[0], world.global_huds[ s_hud.map ].size ); 

    return;
    if( is_hud_per_player( s_hud ) ){

        foreach( hud_key in world.player_huds[ s_hud.map ][ MY_XUID ] ) if( hud_key == s_hud.a_str_names[0] ) return;
        #ifdef dev
            level thread debug_message( sprintf("Adding active Player HuD ^5{0} ^6{1}",s_hud.a_str_names[0], self.name ) );
        #endif

        // Print added Per Player HuD. We check if it was stored beforehand to avoid printing when the Saved HuDs are being created
        self thread print_hud_added( s_hud );

        ArrayInsert( world.player_huds[ s_hud.map ][ MY_XUID ], s_hud.a_str_names[0], world.player_huds[ s_hud.map ][ MY_XUID ].size );
        return;
    }

    foreach( hud_key in world.global_huds[ s_hud.map ] ) if( hud_key == s_hud.a_str_names[0] ) return;

    #ifdef dev
        level thread debug_message( sprintf("Adding active Global HuD ^5{0}",s_hud.a_str_names[0] ) );
    #endif

    // Print added Global HuD. We check if it was stored beforehand to avoid printing when the Saved HuDs are being created
    self thread print_hud_added( s_hud );

    ArrayInsert( world.global_huds[ s_hud.map ], s_hud.a_str_names[0], world.global_huds[ s_hud.map ].size );  
}

function get_hud_by_name( str_hud_name ){

    // Undefined check
    if( !isdefined( str_hud_name ) ){
        level thread debug_message( text_error()+"Undefined str_hud_name in get_hud_by_name" );
        return undefined;
    }

    foreach( s_hud in level._huds ) if( IsInArray(s_hud.a_str_names, ToLower( str_hud_name )) ) return s_hud;

    return undefined;
}

function print_hud_added( s_hud ){

    if( is_hud_ee_split( s_hud ) ) msg = sprintf("Easter Egg Split ^5{0}^7 {1} ^2Added!", basic_parser( s_hud.a_str_names[0] ), basic_parser( s_hud.map ) );
    else if( is_hud_split( s_hud ) ) msg = sprintf("Split ^5{0} ^2Added!", basic_parser( s_hud.a_str_names[0] ) );
    else if( is_hud_per_player( s_hud ) ) msg = sprintf("HuD for {0}{1} ^5{2} ^2Added!",self get_player_text_color(), self.name, basic_parser( s_hud.a_str_names[0] ) );
    else msg = sprintf("Global HuD ^5{0} ^2Added!", basic_parser( s_hud.a_str_names[0] ) );

    level thread DisplayFeedMessage( msg ); 
}

function print_hud_removed( s_hud ){

    if( is_hud_ee_split( s_hud ) ) msg = sprintf("Easter Egg Split ^5{0}^7 {1} ^1Removed!", basic_parser( s_hud.a_str_names[0] ), basic_parser( s_hud.map ) );
    else if( is_hud_split( s_hud ) ) msg = sprintf("Split ^5{0} ^1Removed!", basic_parser( s_hud.a_str_names[0] ) );
    else if( is_hud_per_player( s_hud ) ) msg = sprintf("HuD for {0}{1} ^5{2} ^1Removed!",self get_player_text_color(), self.name, basic_parser( s_hud.a_str_names[0] ) );
    else msg = sprintf("Global HuD ^5{0} ^1Removed!", basic_parser( s_hud.a_str_names[0] ) );

    level thread DisplayFeedMessage( msg ); 
}

function create_hud( _x = undefined, _y = undefined, _alignment = undefined ){

    if( IsPlayer( self ) ) hud = NewClientHudElem( self );
    else hud = NewHudElem();

    hud.alpha = 0;
    //hud.fontscale = 2; // TDOT

    // X
    if( isdefined( _x ) ){
        hud.x = _x;
    }else{
        hud.x = self._x;
        //self._x += 10;
    }

    // Y
    if( isdefined( _y ) ){
        hud.y = _y;
    }else{
        hud.y = self._y;
        self._y += 10;
    }

    // Set HUD Alignment
    hud hud_set_alignment( _alignment );

    //level thread debug_message( "X ^5"+hud.x+"^7 | Y ^5"+hud.y );

    return hud;
}

function create_per_player_hud( s_hud ){

    // Not needed to be created, just added
    if( !is_hud_for_current_map( s_hud ) ) return;

    // Add the HuD to the list of used HuDs to display at the end of the game
    if( !IsInArray(level.str_used_huds, s_hud.a_str_names[0])) arrayinsert(level.str_used_huds, s_hud.a_str_names[0], level.str_used_huds.size);

    #ifdef dev
        // level thread debug_message( "Creating player hud, ^5"+basic_parser(s_hud.a_str_names[0]) );
    #endif

    _alignment = "right_top";
    s_hud._hud[ MY_XUID ] = self create_hud( undefined, undefined, _alignment );
    s_hud._hud[ MY_XUID ].owner = self;
    s_hud._hud[ MY_XUID ].label = s_hud.label;
    s_hud._hud[ MY_XUID ].is_moving = false;
    s_hud._hud[ MY_XUID ].hud_name = s_hud.a_str_names[0];

    s_hud._hud[ MY_XUID ] thread [[ s_hud.visibility_function ]]();
    s_hud._hud[ MY_XUID ] thread [[ s_hud.update_function ]]();
}

function create_global_hud( s_hud ){

    // Not needed to be created, just added
    if( !is_hud_for_current_map( s_hud ) ) return;

    // Add the HuD to the list of used HuDs to display at the end of the game
    if( !IsInArray(level.str_used_huds, s_hud.a_str_names[0])) arrayinsert(level.str_used_huds, s_hud.a_str_names[0], level.str_used_huds.size);

    #ifdef dev
        // level thread debug_message( "Creating global hud, ^5"+basic_parser(s_hud.a_str_names[0]) );
    #endif

    _alignment = "left_top";
    s_hud._hud = level create_hud( undefined, undefined, _alignment );
    s_hud._hud.label = s_hud.label;
    s_hud._hud.is_moving = false;
    s_hud._hud.hud_name = s_hud.a_str_names[0];

    s_hud._hud thread [[ s_hud.visibility_function ]]();
    s_hud._hud thread [[ s_hud.update_function ]]();
}

function create_new_hud( s_hud ){

    //level thread debug_message_instant( sprintf("Creating new hud ^5{0}", basic_parser( s_hud.a_str_names[0] ) ) );

    // Check if we should add this hud to the global list
    self add_hud_name_to_active_huds_list( s_hud );

    if( is_hud_per_player( s_hud ) ) self create_per_player_hud( s_hud ); // Create the HuD only for the player
    else self create_global_hud( s_hud ); // Create the global HuD for everyone
}

function remove_per_player_hud( s_hud_remove ){

    // Move Height of the already created HuDs
    foreach( s_hud in level._huds ){
        wait 0.05;
        if( s_hud == s_hud_remove ) continue; // This hud is the one we want to remove
        if( !is_hud_per_player( s_hud ) ) continue; // We are only dealing with player huds
        if( !is_hud_created( s_hud ) ) continue; // This hud isn't created
        if( s_hud._hud[ MY_XUID ].y < s_hud_remove._hud[ MY_XUID ].y ) continue; // This hud is below the one we want to remove

        self thread hud_decrease_y_position( s_hud );
    }
    
    self thread hud_decrease_x_position( s_hud_remove );

    s_hud_remove._hud[ MY_XUID ] FadeOverTime( 3 );
    s_hud_remove._hud[ MY_XUID ].alpha = 0;
    wait 3;

    s_hud_remove._hud[ MY_XUID ] Destroy();
    self._y -= 10;

    #ifdef dev
        level thread debug_message( "Deleting Player "+basic_parser(s_hud_remove.map)+" hud ^5"+basic_parser( s_hud_remove.a_str_names[0] ) );
    #endif
    ArrayRemoveValue( world.player_huds[ s_hud_remove.map ][ MY_XUID ], s_hud_remove.a_str_names[0] );
}

function remove_global_hud( s_hud_remove ){

    // Move Height of the already created HuDs
    foreach( s_hud in level._huds ){
        wait 0.05;
        if( s_hud == s_hud_remove ) continue; // This hud is the one we want to remove
        if( is_hud_per_player( s_hud ) ) continue; // We are only dealing with player huds
        if( !is_hud_created( s_hud ) ) continue; // This hud isn't created
        if( s_hud._hud.y < s_hud_remove._hud.y ) continue; // This hud is below the one we want to remove

        level thread hud_decrease_y_position( s_hud );
    }

    level thread hud_decrease_x_position( s_hud_remove );

    s_hud_remove._hud FadeOverTime( 3 );
    s_hud_remove._hud.alpha = 0;
    wait 3;

    s_hud_remove._hud Destroy();
    level._y -= 10; 

    #ifdef dev
        level thread debug_message( "Deleting Global "+basic_parser(s_hud_remove.map)+" hud ^5"+basic_parser( s_hud_remove.a_str_names[0] ) );
    #endif
    ArrayRemoveValue( world.global_huds[ s_hud_remove.map ], s_hud_remove.a_str_names[0] );
}

function remove_hud( s_hud_remove ){

    // Undefined check
    if( !Isdefined( s_hud_remove ) ){
        level thread debug_message( text_error()+"Can't remove hud, Undefined s_hud_remove..." );
        return;
    } 

    // HuDs that are meant to be removed don't need to check anything beforehand
    self thread print_hud_removed( s_hud_remove );
    
    // Just remove it from the saved HuDs list
    if( !is_hud_for_current_map( s_hud_remove ) ){

        if( is_hud_per_player( s_hud_remove ) ) ArrayRemoveValue( world.player_huds[ s_hud_remove.map ][ MY_XUID ], s_hud_remove.a_str_names[0] );
        else ArrayRemoveValue( world.global_huds[ s_hud_remove.map ], s_hud_remove.a_str_names[0] );
        return;
    }

    if( is_hud_per_player( s_hud_remove ) ) self remove_per_player_hud( s_hud_remove );
    else self remove_global_hud( s_hud_remove );
}


function refresh_pausable_huds(){

    level notify("refresh_huds");
    level endon("refresh_huds");

    // HuDs have not been initiated
    if( !isdefined( world.global_huds ) ) return;
    if( !isdefined( world.global_huds[ ALL_MAPS ] ) ) return;
    if( !isdefined( world.global_huds[ MAP_NAME ] ) ) return;

    // Global HuDs
    a_str_globnal_huds = ArrayCombine(world.global_huds[ ALL_MAPS ], world.global_huds[ MAP_NAME ], false, false);
    foreach( str_global_hud in a_str_globnal_huds ){
        s_global_hud = get_hud_by_name( str_global_hud );

        // Undefined error
        if( !isdefined( s_global_hud ) ){
            level thread debug_message( sprintf("^1Error, can't get global hud to refresh ^5{0}", basic_parser( str_global_hud ) ) );
            continue;
        }

        // Skip non created HuD
        if( !is_hud_created( s_global_hud ) ) {
            //level thread debug_message( sprintf("^1Error, can't refresh a no created global hud ^5{0}", basic_parser( str_global_hud ) ) );
            continue;
        }

        if( !isdefined( s_global_hud._hud.reset_on_pause ) ){
            level thread debug_message( sprintf("^2NOT Refreshing global hud ^5{0}", basic_parser( str_global_hud ) ) );
            continue;
        }

        //level thread debug_message( sprintf("^2Refreshing global hud ^5{0}", basic_parser( str_global_hud ) ) );
        s_global_hud._hud thread [[ s_global_hud.update_function ]]();
    }

    // HuDs have not been initiated
    if( !isdefined( world.player_huds ) ) return;
    if( !isdefined( world.player_huds[ ALL_MAPS ] ) ) return;
    if( !isdefined( world.player_huds[ MAP_NAME ] ) ) return;

    // Player HuDs
    foreach( player in GetPlayers() ){

        if( !isdefined( world.player_huds[ ALL_MAPS ][ PLAYER_XUID ] ) ) continue; // This player doesn't have initiated Player HuDs
        if( !isdefined( world.player_huds[ MAP_NAME ][ PLAYER_XUID ] ) ) continue; // This player doesn't have initiated Player HuDs

        a_str_player_huds = ArrayCombine(world.player_huds[ ALL_MAPS ][ PLAYER_XUID ], world.player_huds[ MAP_NAME ][ PLAYER_XUID ], false, false);
        foreach( str_player_hud in a_str_player_huds ){
            s_player_hud = get_hud_by_name( str_player_hud );

            // Undefined error
            if( !isdefined( s_player_hud ) ){
                level thread debug_message( sprintf("^1Error, can't get {1} player hud to refresh ^5{0}", basic_parser( str_player_hud ), player.name ) );
                continue;
            }

            // Skip non created HuD
            if( !player is_hud_created( s_player_hud ) ) {
                //level thread debug_message( sprintf("^1Error, can't refresh {1} a no created player hud ^5{0}", basic_parser( str_player_hud ), player.name ) );
                continue;
            }

            if( !isdefined( s_player_hud._hud[ PLAYER_XUID ].reset_on_pause ) ){
                continue;
            }

            //level thread debug_message( sprintf("^2Refreshing {1} player hud ^5{0}", basic_parser( str_player_hud ), player.name ) );
            s_player_hud._hud[ PLAYER_XUID ] thread [[ s_player_hud.update_function ]]();
        }

    }

}

function refresh_huds_on_game_pause(){

    old_pauseTime = GetTotalServerPauseTime();

    for(;;){
        wait 0.05;
        new_pauseTime = GetTotalServerPauseTime();

        if( old_pauseTime == new_pauseTime ) continue; // There was no pause

        old_pauseTime = new_pauseTime;

        #ifdef dev
            //level thread debug_message("^2Pause time updated");
        #endif

        // Refresh all HuDs that need to be updated on pause
        refresh_pausable_huds();
    }

}


#endregion

#region hud alignments
function is_valid_horzalign( _align ){
    return _align == "left" || _align == "center" || _align == "right";
}

function is_valid_alignx( _align ){
    return _align == "left" || _align == "center" || _align == "right";
}

function is_valid_vertalign( _align ){
    return _align == "top" || _align == "center" || _align == "bottom";
}

function is_valid_aligny( _align ){
    return _align == "top" || _align == "middle" || _align == "bottom";
}



function hud_set_alignment( _alignment = undefined ){

    // Default alignment values
    if( !isdefined( _alignment ) ){

        // X
        self.horzalign = "user_center";
        self.alignx = "center";

        // Y
        self.vertalign = "user_top";
        self.alignx = "top";

        return;
    }

    alignments = strTok( _alignment, "_" );

    // X 
    if( is_valid_horzalign( alignments[0] ) ){
        self.horzalign = "user_"+alignments[0];

        // We give priority to horzalign
        if( is_valid_alignx( alignments[0] ) ) self.alignx = alignments[0];
        else self.alignx = "center";
    }
    else{
        level thread debug_message_instant( "^1Invalid horizontal alignment: ^5"+alignments[0] );
        self.horzalign = "user_center";
        self.alignx = "center";
    }


    // Y
    if( is_valid_vertalign( alignments[1] ) ){
        self.vertalign = "user_"+alignments[1];

        // We give priority to vertalign
        if( is_valid_aligny( alignments[1] ) ) self.aligny = alignments[1];
        else self.aligny = "top";
    }
    else{
        level thread debug_message_instant( "^1Invalid vertical alignment: ^5"+alignments[1] );
        self.vertalign = "user_top";
        self.aligny = "top";
    }

}
#endregion

#region hud init

function init_global_huds(){
    level endon( "game_ended" );

    // Initiate default HUD positions
    level._x = 10;
    level._y = 10;

    // World HuDs init
    if( !isdefined( world.global_huds ) ){
        world.global_huds = [];
        //level thread debug_message( "world global huds is not defined..." );
    }
    
    if( !isdefined( world.global_huds[ ALL_MAPS ] ) ){
        world.global_huds[ ALL_MAPS ] = [];
        //level thread debug_message( "world global huds general is not defined..." );
    }

    if( !isdefined( world.global_huds[ MAP_NAME ] ) ){
        world.global_huds[ MAP_NAME ] = [];
        //level thread debug_message( sprintf("world global huds for map ^5{0} ^7is not defined...", MAP_NAME )  );
    }

    // Player HuDs init
    if( !isdefined( world.player_huds ) ){
        world.player_huds = [];
        //level thread debug_message( "player huds is not defined..." );
    }

    if( !isdefined( world.player_huds[ ALL_MAPS ] ) ){
        world.player_huds[ ALL_MAPS ] = [];
        //level thread debug_message( "world player huds general is not defined..." );
    }

    if( !isdefined( world.player_huds[ MAP_NAME ] ) ){
        world.player_huds[ MAP_NAME ] = [];
        //level thread debug_message( sprintf("world player huds for map ^5{0} ^7is not defined...", MAP_NAME )  );
    }


    a_str_huds = ArrayCombine(world.global_huds[ ALL_MAPS ], world.global_huds[ MAP_NAME ], false, false);

    // Wait for all huds to get registered
    wait_for_hud_registration();

    // Enable General HuDs that were active in last game
    foreach( str_hud_name in a_str_huds ){
        s_hud = get_hud_by_name( str_hud_name ); // Lets assume HuDs are correctly saved

        // Not found
        if( !isdefined( s_hud ) ){
            level thread debug_message("^1Couldnt find SAVED HuD ^5"+str_hud_name+"^1...");
            continue;
        }

        // Don't run it and remove it from saved HuDs list!
        if( is_hud_cheat_protected( s_hud ) && !is_practice_enabled() ){

            level thread debug_message( "Deleting World "+basic_parser(s_hud.map)+" HuD ^5"+basic_parser( s_hud.a_str_names[0] )+"^7 because it's ^1Cheat Protected!" );
            ArrayRemoveValue( world.global_huds[ s_hud.map ], s_hud.a_str_names[0] );
            continue;
        }

        // Already Created???
        if( is_hud_created( s_hud ) ){
            level thread debug_message( "World "+"^6"+basic_parser(s_hud.map)+" HuD `^5"+basic_parser( s_hud.a_str_names[0] )+"^7`^1 is already created????" );
            continue;            
        }

        // Unavailable HuD
        if( is_hud_moving( s_hud ) ){
            level thread debug_message( text_error()+"Can't create World "+basic_parser(s_hud.map)+" HuD AT START `^5"+basic_parser( s_hud.a_str_names[0] )+"^7` already moving????" );
            continue;
        }

        // Finally run it!
        self create_new_hud( s_hud );
        wait 0.05;
    }
}

function init_player_huds(){
    level endon( "game_ended" );
    self endon( "disconnect" );

    // Initiate default HUD positions
    self._x = -10;
    self._y = 30;
    self._huds = [];


    // Player HuD init
    if( !isdefined( world.player_huds[ ALL_MAPS ][ MY_XUID ] ) ){
        world.player_huds[ ALL_MAPS ][ MY_XUID ] = [];
        //level thread debug_message( "world player "+self.name+" huds "+ALL_MAPS+" is not defined..." );

        #ifdef dev
            //ArrayInsert(world.player_huds[ ALL_MAPS ][ MY_XUID ], "XUID", world.player_huds[ ALL_MAPS ][ MY_XUID ].size);
        #endif
    }

    if( !isdefined( world.player_huds[ MAP_NAME ][ MY_XUID ] ) ){
        world.player_huds[ MAP_NAME ][ MY_XUID ] = [];
        //level thread debug_message( "world player "+self.name+" huds "+MAP_NAME+" general is not defined..." );
    }

    a_str_huds = ArrayCombine(world.player_huds[ ALL_MAPS ][ MY_XUID ], world.player_huds[ MAP_NAME ][ MY_XUID ], false, false);

    // Wait for all huds to get registered
    wait_for_hud_registration();

    // Enable General HuDs that were active in last game
    foreach( str_hud_name in a_str_huds ){
        s_hud = get_hud_by_name( str_hud_name ); // Lets assume HuDs are correctly saved

        // level thread debug_message( "Testing player HuD ^6"+basic_parser(s_hud.a_str_names[0]) );

        // Not found
        if( !isdefined( s_hud ) ){
            level thread debug_message("^1Couldnt find SAVED HuD ^5"+str_hud_name+"^1...");
            continue;
        }

        // Don't run it and remove it from saved HuDs list!
        if( is_hud_cheat_protected( s_hud ) && !is_practice_enabled() ){

            level thread debug_message( "Deleting Player "+basic_parser(s_hud.map)+" HuD ^5"+basic_parser( s_hud.a_str_names[0] )+"^7 because it's ^1Cheat Protected!" );
            ArrayRemoveValue( world.player_huds[ s_hud.map ][ MY_XUID ], s_hud.a_str_names[0] );
            continue;
        }

        // Already created???
        if( self is_hud_created( s_hud ) ){
            level thread debug_message( text_error()+"^6"+basic_parser(s_hud.map)+" Player HuD `^5"+basic_parser( s_hud.a_str_names[0] )+"^7`^1 is already created????" );
            continue;            
        }

        // Unavailable HuD
        if( self is_hud_moving( s_hud ) ){
            level thread debug_message( text_error()+"Can't create "+basic_parser(s_hud.map)+" Player HuD AT START ^5"+basic_parser( s_hud.a_str_names[0] )+"^7 already moving????" );
            continue;
        }

        // Finally run it!
        self create_new_hud( s_hud );
        wait 0.05;
    }
}

function remove_active_player_huds( _xuid ){

    // HUDs haven't been initiated yet
    if( !isdefined( level.hud_registration_completed ) ) return;

    // Avoid undefined
    if( !isdefined( world.player_huds[ ALL_MAPS ][ _xuid ] ) ) world.player_huds[ ALL_MAPS ][ _xuid ] = [];
    if( !isdefined( world.player_huds[ MAP_NAME ][ _xuid ] ) ) world.player_huds[ MAP_NAME ][ _xuid ] = [];

    a_str_huds = ArrayCombine(world.player_huds[ ALL_MAPS ][ _xuid ], world.player_huds[ MAP_NAME ][ _xuid ], false, false);

    // Enable General HuDs that were active in last game
    foreach( str_hud_name in a_str_huds ){

        #ifdef dev
            //level thread debug_message("Checking DISCONNECTED player HUD: ^5"+str_hud_name);
        #endif

        s_hud = get_hud_by_name( str_hud_name ); // Lets assume HuDs are correctly saved

        // Not found
        if( !isdefined( s_hud ) ){
            level thread debug_message("DISCONNECT ^1Couldnt find SAVED HuD ^5"+str_hud_name+"^1...");
            continue;
        }

        // HUD is not created
        if( !isdefined( s_hud._hud[ _xuid ] ) ) continue;

        // Finally run it!
        s_hud._hud[ _xuid ] Destroy();
        
        #ifdef dev
            //level thread debug_message("Removing DISCONNECTED player HUD: ^5"+str_hud_name);
        #endif
    }
}

#endregion

#region hud move

function hud_player_decrease_y_position( s_hud, amount = 10, time = 3 ){

    // Undefined check
    if( !Isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Can't lower hud, Undefined s_hud in hud_player_decrease_y_position" );
        return;
    }

    s_hud._hud[ MY_XUID ].is_moving = true;
    wait 0.05;

    s_hud._hud[ MY_XUID ] MoveOverTime( time );
    s_hud._hud[ MY_XUID ].y -= amount;

    wait time;
    s_hud._hud[ MY_XUID ].is_moving = false;
}

function hud_global_decrease_y_position( s_hud, amount = 10, time = 3 ){

    // Undefined check
    if( !Isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Can't lower hud, Undefined s_hud in hud_global_decrease_y_position" );
        return;
    }

    s_hud._hud.is_moving = true;
    wait 0.05;

    s_hud._hud MoveOverTime( time );
    s_hud._hud.y -= amount;

    wait time;
    s_hud._hud.is_moving = false;
}

function hud_decrease_y_position( s_hud = undefined ){

    // Undefined check
    if( !Isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Can't lower hud, Undefined s_hud in hud_decrease_y_position" );
        return;
    }

    if( is_hud_per_player( s_hud ) ) self hud_player_decrease_y_position( s_hud );
    else self hud_global_decrease_y_position( s_hud );
}


function hud_player_decrease_x_position( s_hud, amount = 100, time = 3 ){

    // Undefined check
    if( !Isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Can't lower hud, Undefined s_hud in hud_player_decrease_x_position" );
        return;
    }

    s_hud._hud[ MY_XUID ].is_moving = true;
    wait 0.05;

    s_hud._hud[ MY_XUID ] MoveOverTime( time );
    s_hud._hud[ MY_XUID ].x -= amount;

    wait time;
    s_hud._hud[ MY_XUID ].is_moving = false;
}

function hud_global_decrease_x_position( s_hud, amount = 100, time = 3 ){

    // Undefined check
    if( !Isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Can't lower hud, Undefined s_hud in hud_global_decrease_x_position" );
        return;
    }

    s_hud._hud.is_moving = true;
    wait 0.05;

    s_hud._hud MoveOverTime( time );
    s_hud._hud.x -= amount;

    wait time;
    s_hud._hud.is_moving = false;
}

function hud_decrease_x_position( s_hud = undefined ){

    // Undefined check
    if( !Isdefined( s_hud ) ){
        level thread debug_message( text_error()+"Can't lower hud, Undefined s_hud in hud_decrease_x_position" );
        return;
    }

    if( is_hud_per_player( s_hud ) ) self hud_player_decrease_x_position( s_hud );
    else self hud_global_decrease_x_position( s_hud );
}

#endregion


function hud_default_visibility(){
    self endon( "death" );

    // Wait for game start
    wait_for_game_start();

    // Show the split
    self FadeOverTime( 3 );
    self.alpha = 1;
}

function hud_ee_split_visibility(){
    self endon( "death" );

    // Wait for game start
    wait_for_game_start();

    // We are not showing the EE HUDs
    if( !FLAG_ACTIVE_SHOW_EE_SPLITS ) return;

    // Not splitted yet
    if( !is_hud_splitted( get_hud_by_name( self.hud_name ) ) ){
        
        // Wait for HUD split
        self waittill( "splitted" );
    }

    // Show the split
    self FadeOverTime( 3 );
    self.alpha = 1;
}


function hud_split_default_update(){
    self endon( "death" );

    self notify( "hud_reset" );
    self endon( "hud_reset" );

    self.color = COLOR_DARK_GREY;

    self.reset_on_pause = true;

    if( is_hud_splitted( get_hud_by_name( self.hud_name ) ) ){
        #ifdef dev
            level thread debug_message_instant("^2Already Split HuD ^6"+self.hud_name );
        #endif
        self set_timer_va();
        return;
    }

    #ifdef dev
        self SetText("Waiting for split...");
    #else
        self SetText("");
    #endif


    self waittill( "splitted" );
    level livesplit( LIVESPLIT_SPLIT );

    #ifdef dev
        level thread debug_message_instant("Split HuD ^6"+self.hud_name );
    #endif

    self set_timer_va();
}

function set_timer_va(){
    self endon( "death" );

    s_split_hud = get_hud_by_name( self.hud_name );

    // Wrong hud?
    if( !is_hud_split( s_split_hud ) ){
        level thread debug_message( "^1Error, can't set timer VA ^5"+self.hud_name );
        return;
    }


    // Automatic Split
    if( isdefined( level.autosplits ) || isdefined( level.force_automatic_times ) ){

        // Missing split time
        if( !isdefined( s_split_hud.HudElemTime ) ){
            level thread debug_message_instant( "^1Missing HudElemTime..." );
            return;
        }

        HudElemTime = s_split_hud.HudElemTime;
        if( IS_RTA ) HudElemTime += s_split_hud.HudElemTime_pause;
    // Manual Split
    }else{

        // Missing split time
        if( !isdefined( s_split_hud.HudElemTime_manual ) ){
            level thread debug_message_instant( "^1Missing HudElemTime_manual..." );
            return;
        }

        HudElemTime = s_split_hud.HudElemTime_manual;
        if( IS_RTA ) HudElemTime += s_split_hud.HudElemTime_pause_manual;
    }

    #ifdef dev
         //level thread debug_message_instant( "HudElemTime "+HudElemTime );
         //level thread debug_message_instant( "Practice Tool time: "+CalcTime( HudElemTime ) );
    #endif

    /* Taken from 3arc code
        ms = int(HudElemTime / 10) % 100;
        seconds = int(HudElemTime / 10 / 100) % 60;
        minutes = int(HudElemTime / 10 / 6000) % 60;
        hour = int(HudElemTime / 10 / 360000);
    */

    self SetText( get_time_string_from_ms( HudElemTime ) );
}

function get_time_string_from_ms( ms_time ){

    ms_time -= 50;

    hour = int(ms_time / 3600000);
    ms_time -= (hour * 3600000);

    minutes = int(ms_time / 60000) % 60;
    ms_time -= (minutes * 60000);

    seconds = int(ms_time / 1000) % 60;
    ms_time -= (seconds * 1000);

    ms = ms_time;
    //ms = int(ms_time / 10) % 100; // In case we want to just show Hundreds instead of ms

    // Exceptions, show all numbers
    if( seconds < 10 && ( minutes > 0 || hour > 0 ) ) seconds = "0"+seconds;
    if( minutes < 10 && ( hour > 0 ) ) minutes = "0"+minutes;
    ms = ""+ms;
    // Fix ms size
    while( ms.size < 3 ) ms += "0";


    // At minimum, display seconds
    if( hour > 0 ) str_time = sprintf("{3}:{2}:{1}.{0}ms", ms, seconds, minutes, hour);
    else if( minutes > 0 ) str_time = sprintf("{2}:{1}.{0}ms", ms, seconds, minutes);
    else str_time = sprintf("{1}.{0}ms", ms, seconds);

    #ifdef dev
         //level thread debug_message_instant( "ms "+ms );
         //level thread debug_message_instant( "second "+seconds );
         //level thread debug_message_instant( "minute "+minutes );
         //level thread debug_message_instant( "hour "+hour );
         //level thread debug_message_instant( "Formatted time "+str_time );
    #endif

    return str_time;
}

function force_automatic_split_times_at_game_end(){

    // Make sure timers display accurate times since the game is over
    level.force_automatic_times = true;

    // Timers are already accurate
    if( isdefined( level.autosplits ) ) return;
    
    // If game hasn't started then there isn't any split to check
    if( !has_game_started() ) return;

    // HUDs not registered yet
    if( !isdefined( level.hud_registration_completed ) ) return;

    foreach( s_hud in level._huds ){
        // We only want splittable huds
        if( !is_hud_split( s_hud ) ) continue;

        // Maybe automatic split happened but not manual
        if( !is_hud_splitted( s_hud ) ){
            // Set Hud as splitted if it has automatic time
            if( isdefined( s_hud.HudElemTime ) ) s_hud.splitted = true;
        }

        // Refresh currently active splits
        if( is_hud_created( s_hud ) ) s_hud._hud thread [[ s_hud.update_function ]]();
    }
}



// Modified versions to suit Surtr
function createRectangle(x, y, alignment, color, sort, alpha, shader, width, height ){

	alignments = strTok(alignment, "_");

    // Create the HUD depending on the caller
	if( isPlayer( self ) ) rectangleHud = self hud::createicon(shader, width, height);
    else rectangleHud = hud::createservericon(shader, width, height);

    rectangleHud.hideWhenInMenu 	= true; 
	rectangleHud.hidden 			= false;
    rectangleHud.archived 			= false;

    rectangleHud.color 				= color;

    rectangleHud.sort           	= sort;
    rectangleHud.alpha          	= alpha;
    rectangleHud.shader         	= shader;

    rectangleHud hud::setpoint(alignments[0], alignments[1], x, y);

    rectangleHud.horzalign 			= "USER_"+alignments[0];
	rectangleHud.vertalign 			= "USER_"+alignments[1];

    return rectangleHud;
}

function createText(x, y, alignment, color, sort, alpha, text, font, fontScale ){

	alignments = strTok(alignment, "_");

    // Create the HUD depending on the caller
	if( isPlayer( self ) ) textHud = self hud::createfontstring(font, fontScale);
    else textHud = hud::createserverfontstring(font, fontScale);
    
    textHud.hideWhenInMenu  = true;
	textHud.hidden          = false;
    textHud.archived        = false;
    
	textHud.color          	= color;
    textHud.sort           	= sort;
    textHud.alpha          	= alpha;

    textHud hud::setpoint(alignments[0], alignments[1], x, y);

    textHud.horzalign    	= "USER_"+alignments[0];
    textHud.vertalign     	= "USER_"+alignments[1];

    textHud SetText( text );

    return textHud;
}




// Literally copy pasted from Scrappy's practice tool because zwr says that my timers "are not accurate enough"
function CalcTime(ms)
{
    min = 0;
    sec = 0;

    // Original

    // Get mins
    if(ms >= 60000)
    {
        min = Int(ms / 60000);
        ms -= min * 60000;
    }

    // Get secs
    if(ms >= 1000)
    {
        sec = Int(ms / 1000);
        ms -= sec * 1000;
    }

    
    // Lui

    // Get mins
    /*if(ms >= 60000)
    {
        min = Int(ms / 60000);
        ms = ms % 60000;
    }

    // Get secs
    if(ms >= 1000)
    {
        sec = Int(ms / 1000);
        ms = ms % 1000;
    }*/

    str_time = "";

    // Add mins if there is any
    if(min > 0)
    {
        str_time += min + ":";
    }

    // Add secs if there is any
    if(min || sec > 0)
    {
        if(sec < 10 && min) str_time += "0";
        str_time += sec + ".";
    }

    // Add decimals
    if(min || sec || ms > 0)
    {
        if(!min && !sec) str_time += "0.";
        if(ms <= 50) str_time += "0";
        ms /= 10;
        str_time += ms;
    }

    return str_time;
}