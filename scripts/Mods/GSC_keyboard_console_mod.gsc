function autoexec init_keyboard_menu(){

    level.custom_commands = [];

    // Game commands
    // Commands for all gamemodes
    level register_shared_commands();

    if( IS_ZOMBIES ){
        level register_zombie_commands();
    }

    level.commands_register_completed = true;
}

function register_keyboard_console_command( str_command, a_str_names, func_command, b_is_cheat_protected, n_max_args, b_is_player_toggle = false ){

    // Error checks

    // Commands not defined? commented or deleted its creation?
    if( !isdefined( level.custom_commands ) ){
        level thread debug_message( text_error()+"custom_commands is not defined..." );
        return;
    }

    // Commands are not an array? level.custom_comands assigned to something else?
    if( !IsArray( level.custom_commands ) ){
        level thread debug_message( text_error()+"custom_commands is not an array..." );
        return;
    }

    // No command name
    if( !isdefined( str_command ) ){
        level thread debug_message( text_error()+"Undefined ^5str_command ^7 in register_keyboard_console_command..." );
        return;
    }

    // Invalid command name
    if( StrTok(str_command, " ").size > 1 ){
        level thread debug_message( text_error()+"Invalid ^5str_command ^7 in register_keyboard_console_command..." );
        return;
    }

    // No function
    if( !isdefined( func_command ) ){
        level thread debug_message( text_error()+"Undefined ^1func_command ^7 for ^5"+str_command+" ^7 in register_keyboard_console_command..." );
        return;
    }

    // Invalid function
    if( !IsFunctionPtr( func_command ) ){
        level thread debug_message( text_error()+"Invalid ^1func_command ^7 for ^5"+str_command+" ^7 in register_keyboard_console_command..." );
        return;
    }

    // No cheat protected
    if( !isdefined( b_is_cheat_protected ) ){
        level thread debug_message( text_error()+"Undefined ^1b_is_cheat_protected ^7 for ^5"+str_command+" ^7 in register_keyboard_console_command..." );
        return;
    }

    // No max args
    if( !isdefined( n_max_args ) ){
        level thread debug_message( text_error()+"Undefined ^1n_max_args ^7 for ^5"+str_command+" ^7 in register_keyboard_console_command..." );
        return;
    }

    // Invalid max args
    if( !IsInt( n_max_args ) ){
        level thread debug_message( text_error()+"Invalid ^1n_max_args ^7 for ^5"+str_command+" ^7 in register_keyboard_console_command..." );
        return;
    }


    // First make sure the command name is NOT already on other level.custom_commands[ str_command ].a_str_names
    // Second make the same for the rest of a_str_names to register AND check they are NOT duplicated within the same array
    str_command = ToLower( str_command );
    str_duplicated = command_name_already_exist( str_command );

    // We can not even register the command
    if( isdefined( str_duplicated ) ){
        level thread debug_message( text_error()+"^5"+str_command+" ^1is already registered in command ^2"+str_duplicated );
        return;
    }

    // Add the full and proper name of the command as the first one always
    a_all_str_names = [];
    ArrayInsert(a_all_str_names, str_command, a_all_str_names.size);

    // Maybe a command doesn't have extra names
    if( isdefined( a_str_names ) ){
        // Check if the names can be registered
        foreach( str_name in a_str_names ){
            str_name = ToLower( str_name );
            str_duplicated = command_name_already_exist( str_name );
            if( isdefined( str_duplicated ) ){ // It's duplicated
                level thread debug_message( text_error()+"^1Ignoring name ^1"+str_name+" ^7 for command ^5"+str_command+" ^1, already registered in ^2"+str_duplicated );
            }else if( IsInArray(a_all_str_names, str_name) ){ // Duplicated within the same command register...
                level thread debug_message( text_error()+"^1Ignoring name ^1"+str_name+" ^7 for command ^5"+str_command+" ^1, it's duplicated..." );
            }else{ // Unique name ready to be added
                ArrayInsert(a_all_str_names, str_name, a_all_str_names.size);
            }
        }
    }

    // Create the command struct, we leave the proper command name as string key to make it easier to create binds
    level.custom_commands[ str_command ] = SpawnStruct();
    level.custom_commands[ str_command ].a_str_names = a_all_str_names; // All the valid names for the command to be found when typed on console
    level.custom_commands[ str_command ].func_command = func_command; // The function pointer
    level.custom_commands[ str_command ].b_is_cheat_protected = b_is_cheat_protected; // Checks if the command should only be allowed on practice mode
    level.custom_commands[ str_command ].n_max_args = n_max_args; // N of args expected, if more, then it's meant to be run to another player
    level.custom_commands[ str_command ].b_is_player_toggle = b_is_player_toggle; // Commands that are the same to activate AND deactivate. Used to track if we should re-enable it after a fast_restart.
    
}

// returns undefined if it doesn't exist, otherwise it returns the name of the command that already has that name registered
function command_name_already_exist( str_command ){

    foreach( s_command in level.custom_commands ){
        if( IsInArray( s_command.a_str_names, str_command ) ) return s_command.a_str_names[0];
    }

    return undefined;
}


// COMMANDS CORE FUNCTIONALITY
function execute_command( command = "" ){


    if( !isPlayer( self ) ){
        thread debug_message("^1Error, not a player in ^7'^5execute_command^7'");
        return;
    }

    if( !IsString( command ) ){
        self IPrintLnBold( "^1command in execute_command is not a string..." );
        return;
    }


    /* How should it work?
        -First token should ALWAYS be the name of the command
        -Command name should be checked against the a_str_names of every command registered
        -Nº of str_tokens must be checked! and extra arg is expected in case a command is called for another player!
            * str_tokens.size > n_max_args: Give error, too many args
            * str_tokens.size == n_max_args: Call the function for the meant player which will ALWAYS be the last arg
            * str_tokens.size < n_max_args: Normal function call for Self

        // Example for God command to another player
        fast_restart n_max_args = 0;

        // We need to subtract 2 from the n of args cause 1 is the player name and the other one is the possible player to call the function on

        // invalid rule
        str_tokens.size -2 > n_max_args 

        -Finally, we create the args (str_tokens WITHOUT command name)
    */

    str_tokens = strTok(command, " ");
    str_command = str_tokens[ 0 ]; // Command name is ALWAYS first arg

    // Search for the command
    s_command = get_command_by_name( str_command );

    // Not found
    if( !isdefined( s_command ) ){
        self IPrintLnBold("^1Couldn't find command ^5"+str_command+"^1...");
        return;
    }

    // Cheat protected
    if( s_command.b_is_cheat_protected && !is_practice_enabled() ){
        self IPrintLnBold("Command ^5"+basic_parser( s_command.a_str_names[0] )+" ^7is ^1cheat protected.");
        return;
    }

    n_args = str_tokens.size -2; // First one is the name, not an arg

    // Too many args
    if( n_args > s_command.n_max_args ){
        self IPrintLnBold( "Too many args for command ^5" + basic_parser( s_command.a_str_names[0] ) + " ^7max is ^2" + s_command.n_max_args );
        return;
    }

    // Call the function to another player
    if( n_args == s_command.n_max_args ){

        n_player = str_tokens[ str_tokens.size -1 ]; // Player to call the func for is always the last one

        // Not a number to call the function to a player
        if( !StrIsInt( n_player ) ){
            self IPrintLnBold("^1Not a player number ^5"+n_player+" ^1to call command ^2"+basic_parser( s_command.a_str_names[0] )+"^1...");
            return;
        }

        // Check the player number is valid
        a_players = getplayers();
        n_player = int( n_player );
        if( n_player < 1 || n_player > a_players.size ){ // Make it more human by setting host as 1 instead of 0
            self IPrintLnBold("^1Player number out of index "+n_player+" to call command ^5"+basic_parser( s_command.a_str_names[0] )+"^1...");
            return;
        }
        n_player--;
        player = a_players[ n_player ];

        // Start the loop on 1 to skip command name and don't add the last arg since it's the player to call the function to
        args = [];
        for( i=1; i<str_tokens.size -1; i++) ArrayInsert( args, str_tokens[ i ], args.size );

        #ifdef dev
            //self IPrintLnBold( sprintf("Calling command ^2{0} ^7with args ^6{1} ^7to player ^5{2}", basic_parser( s_command.a_str_names[0] ), args.size, player.name ) );
            //wait 1;
        #endif

        // Save or Remove the toggle command
        if( s_command.b_is_player_toggle ){

            // Toggles are not initialized yet
            if( !( isdefined( self.toggles_completed ) && self.toggles_completed ) ){
                ArrayInsert(level.toggles[ PLAYER_XUID ], s_command.a_str_names[0], level.toggles[ PLAYER_XUID ].size);
            // Save the toggle as used
            }else if( !IsInArray(world.toggles[ PLAYER_XUID ], s_command.a_str_names[0] ) ){
                ArrayInsert(world.toggles[ PLAYER_XUID ], s_command.a_str_names[0], world.toggles[ PLAYER_XUID ].size);
            // Remove the toggle as used
            }else{
                ArrayRemoveValue(world.toggles[ PLAYER_XUID ], s_command.a_str_names[0]);
            }

            //level thread debug_message("Player Toggles: ^6"+world.toggles[ PLAYER_XUID  ].size );
        }

        // Add the command to the list of used commands to print at the end
        add_used_command_to_print_at_endgame( basic_parser( s_command.a_str_names[0] ) );

        // Successfully call the function to the player!
        player thread [[ s_command.func_command ]]( args );
        return;
    }

    // Create args
    args = [];
    for( i=1; i<str_tokens.size; i++) ArrayInsert( args, str_tokens[ i ], args.size );

    #ifdef dev
        //self IPrintLnBold( sprintf("Calling command ^5{0} with args ^2{1} ^7to myself! ^5{2}", basic_parser( s_command.a_str_names[0] ), args.size, self.name ) );
        //wait 1;
    #endif

    // Save or Remove the toggle command
    if( s_command.b_is_player_toggle){

        // Toggles are not initialized yet
        if( !( isdefined( self.toggles_completed ) && self.toggles_completed ) ){
            ArrayInsert(level.toggles[ MY_XUID ], s_command.a_str_names[0], level.toggles[ MY_XUID ].size);
        // Save the toggle as used
        }else if( !IsInArray(world.toggles[ MY_XUID ], s_command.a_str_names[0] ) ){
            ArrayInsert(world.toggles[ MY_XUID ], s_command.a_str_names[0], world.toggles[ MY_XUID ].size);
        // Remove the toggle as used
        }else{
            ArrayRemoveValue(world.toggles[ MY_XUID ], s_command.a_str_names[0]);
        }

        //level thread debug_message("Self Toggles: ^6"+world.toggles[ MY_XUID ].size );
    }

    // Add the command to the list of used commands to print at the end
    add_used_command_to_print_at_endgame( basic_parser( s_command.a_str_names[0] ) );

    // This command is for Self
    self thread [[ s_command.func_command ]]( args );
}

function add_used_command_to_print_at_endgame( str_command ){

    // HUDs have their own list
    if( str_command == basic_parser( "hud" ) ) return;

    // Create command list
    if( !isdefined( level.used_commands ) ) level.used_commands = [];

    // Add the new command
    if( !IsInArray( level.used_commands, str_command) ) ArrayInsert( level.used_commands, str_command, level.used_commands.size );
}

function Surtr_modvar(){

    ModVar( DVAR_SURTR, "" );
    while( !isdefined( level.commands_register_completed ) ) wait 0.05;

    for(;;){
        wait 0.05;
        str_command = GetDvarString( DVAR_SURTR );

        if( str_command == "" ) continue;

        level thread debug_message("Detected ^5Modvar ^6"+str_command);

        GetPlayers()[ 0 ] thread execute_command( str_command );
        if( IS_CUSTOM_CLIENT ) SetDvar( DVAR_SURTR, "" );
        else ModVar( DVAR_SURTR, "" );
    }

}

function init_player_toggles(){
    self endon("disconnect");

    // Init currently toggled commands
    level.toggles[ MY_XUID ] = [];

    // No toggles saved for me
    if( !isdefined( world.toggles[ MY_XUID ] ) ){
        world.toggles[ MY_XUID ] = [];
        self.toggles_completed = true;
        return;
    }

    // Wait for commands to be fully registered
    while( !isdefined( level.commands_register_completed ) ) wait 0.05;

    //level thread debug_message("Starting level toggles for player ^5"+self.name);

    counter = 0;
    foreach( str_toggle in world.toggles[ MY_XUID ] ){
        //level thread debug_message("Loading toggle: ^5"+str_toggle);
        s_command = get_command_by_name( str_toggle );

        // Invalid command?
        if( !isdefined( s_command ) ){
            level thread debug_message("^1Error, Couldn't find toggle command: ^5"+str_toggle);
            continue;
        }

        // Cheat protected
        if( s_command.b_is_cheat_protected && !is_practice_enabled() ){
            //level thread debug_message("^1Cheat Protected Toggle: ^5"+str_toggle);
            continue;
        }

        counter++;
        //level thread debug_message("Executing toggle: ^5"+str_toggle);
        self thread execute_command( str_toggle );
    }

    if( !counter ){
        self.toggles_completed = true;
        //level thread debug_message( sprintf("^5{0}^7 has completed all toggles ^2{1}", self.name, counter) );
        return;
    }

    // Wait for toggles to be enabled
    while( !isdefined( level.toggles ) || !isdefined( level.toggles[ MY_XUID ] ) || level.toggles[ MY_XUID ].size != counter ) wait 0.05;
    //level thread debug_message( sprintf("^5{0}^7 has completed all toggles ^2{1}", self.name, counter) );
    self.toggles_completed = true;

    //level thread debug_message("level toggles completed for player ^5"+self.name);

    /* How should this work?
        self.toggles_completed will tell us if the player has already enabled their saved commands
        level.toggles  is an array that says if the command has been used by the player already in the current fast_restart
        level.toggles also helps to say if we have already added a toggle while adding it on init_player_toggles
        world.toggles is an array that says the last state of the command in general

        if toggles_completed is NOT true, then we don't need to remove the value from world.toggles

    */
}

function get_command_by_name( str_command ){

    // Undefined check
    if( !isdefined( str_command ) ){
        level thread debug_message( text_error()+"Undefined str_command in get_command_by_name" );
        return undefined;
    }

    // Search for the command
    foreach( s_command in level.custom_commands ) if( IsInArray(s_command.a_str_names, tolower( str_command )) ) return s_command;

    return undefined;
}



// COMMANDS CORE FUNCTIONALITY

function open_keyboard_menu(){
    self endon( "disconnect" );

    if( !self has_key( BIND_ENTER ) ){
        thread debug_message(self.name+" doesn't have button 'ENTER'");
        return;
    }

    if( !self has_key( BIND_BACKSPACE ) ){
        thread debug_message(self.name+" doesn't have button 'BACKSPACE'");
        return;
    }

    if( !self has_key( BIND_SPACE ) ){
        thread debug_message(self.name+" doesn't have button 'SPACE'");
        return;
    }

    self.gsc_keyboard = [];
    self.gsc_keyboard["open"] = false;
    self.gsc_keyboard_text = "";

    while( self is_key_pressed( BIND_ENTER )) wait 0.05; // Don't auto open when doing a fast restart

    for(;;){

        while( !self is_key_pressed( BIND_ENTER ) ) wait 0.05; // Wait for the player to press the Key
        while( self is_key_pressed( BIND_ENTER ) ) wait 0.05; // Now wait for player to unpress

        if( self has_special_menu_open() ){ // New method to detect anything that may require keyboard focus
            //if( is_true( self.smite_chat["open"] ) ){
            thread debug_message_instant("Can't open gsc keyboard rn", self);
            continue;
        }

        // Setup the initial menu settings
        self.gsc_keyboard["open"] = true;
        self.gsc_keyboard_text = "";

        // Create the HuD and check for the keys
        self create_gsc_keyboard_hud();
        self thread check_gsc_keyboard_input();

        while( self.gsc_keyboard["open"] ){

            self waittill( "gsc_keyboard_menu" );
            
            if( self.gsc_keyboard_text == ""){      // If it's empty we just close it
                self.gsc_keyboard["open"] = false;
            }else{                                  // Otherwise we execute the command
                self thread execute_command( self.gsc_keyboard_text );
                self.gsc_keyboard_text = "";
                self.gsc_keyboard["gsc_input"] setText( self.gsc_keyboard_text );
            }

        }

        self delete_keyboard_huds();
        self notify("stop_key_input");
        //thread debug_message_instant("Exited GSC keyboard menu!", self);

    }

}

function create_gsc_keyboard_hud(){

	options = [];
	options[options.size] = options.size;
	options[options.size] = options.size;

    self.gsc_keyboard["top_border"]	        = self createRectangle(50, -90,                                                                                 "LEFT_CENTER", SMITE_COLOR_BORDERS, 3, 1,   "white", 255, 10);
    self.gsc_keyboard["top_shadow"]	        = self createRectangle(50, -85,                                                                                 "LEFT_CENTER", SMITE_COLOR_SHADOW,  4, 0.5, "white", 255, 3);

    self.gsc_keyboard["void_background"]	= self createRectangle(50, ( (-95 + (20 * options.size)) + (20 * ((15 -options.size)) / 2) ),                   "LEFT_CENTER", SMITE_COLOR_VOID, 1, 0.8, "white", 250, ( 300 - (20 * options.size)) );
    self.gsc_keyboard["text_background"]	= self createRectangle(50, ( -88 + (20 * options.size) - (10 * options.size) ),                                 "LEFT_CENTER", SMITE_COLOR_BACKGROUND,  2, 1,   "white", 250, ( (20 * options.size) -5) );
    self.gsc_keyboard["text_shadow"]	    = self createRectangle(50, ( (-45 + (19 * 0)) -5),                                                              "LEFT_CENTER", SMITE_COLOR_SHADOW, 4, 0.5, "white", 250, 3);

    self.gsc_keyboard["gsc_input"]	        = self createText(60, -70, "LEFT_CENTER", SMITE_COLOR_TEXT, 3, 1, "", "objective", 1.8);

    self.gsc_keyboard["bottom_border"]	    = self createRectangle(50, 210,                                                                                 "LEFT_CENTER", SMITE_COLOR_BORDERS, 3, 1,   "white", 250, 10);
    self.gsc_keyboard["bottom_shadow"]	    = self createRectangle(50, 205,                                                                                 "LEFT_CENTER", SMITE_COLOR_SHADOW,  4, 0.5, "white", 250, 3);

    self.gsc_keyboard["left_shadow"]	    = self createRectangle(50,  65,                                                                                 "LEFT_CENTER", SMITE_COLOR_SHADOW, 3, 1,   "white", 5,   300);
    self.gsc_keyboard["right_shadow"]	    = self createRectangle(300, 65,                                                                                 "LEFT_CENTER", SMITE_COLOR_SHADOW,  3, 1,   "white", 5,   300);

}

function delete_keyboard_huds(){

    self.gsc_keyboard["top_border"] hud::destroyelem();
    self.gsc_keyboard["top_shadow"] hud::destroyelem();

    self.gsc_keyboard["void_background"] hud::destroyelem();
    self.gsc_keyboard["text_background"] hud::destroyelem();
    self.gsc_keyboard["text_shadow"] hud::destroyelem();

    self.gsc_keyboard["gsc_input"] hud::destroyelem();

    self.gsc_keyboard["bottom_border"] hud::destroyelem();
    self.gsc_keyboard["bottom_shadow"] hud::destroyelem();

    self.gsc_keyboard["left_shadow"] hud::destroyelem();
    self.gsc_keyboard["right_shadow"] hud::destroyelem();

}



function should_ignore_keyboard_key( key ){

    return IsInArray( array(
            // F + Number
            BIND_F1, BIND_F2, BIND_F3, BIND_F4, BIND_F5, BIND_F6, BIND_F7, BIND_F8, BIND_F9, BIND_F10, BIND_F11, BIND_F12,
            // Controller buttons
            BIND_BUTTON_A, BIND_BUTTON_B, BIND_BUTTON_X, BIND_BUTTON_Y, BIND_LSHLDR, BIND_RSHLDR, BIND_LTRIG, BIND_RTRIG, BIND_START, BIND_BACK, BIND_LSTICK, BIND_RSTICK, BIND_DPAD_UP, BIND_DPAD_DOWN, BIND_DPAD_LEFT, BIND_DPAD_RIGHT,
            // Arrow keys
            BIND_UPARROW, BIND_DOWNARROW, BIND_LEFTARROW, BIND_RIGHTARROW,
            // Mouse buttons
            BIND_M1, BIND_M2, BIND_M3, BIND_M4, BIND_M5, BIND_MWHEELDOWN, BIND_MWHEELUP,
            // Special
            BIND_ESCAPE, BIND_SHIFT, BIND_CONTROL, BIND_ALT,
            // Others
            BIND_PAUSE, BIND_HOME, BIND_PGUP, BIND_DEL, BIND_PGDN, BIND_END

        ), key );
}


function check_gsc_keyboard_input(){
    self endon( "disconnect" );
    self endon( "stop_key_input" );

    a_keys = GetArrayKeys( self.keys );

    for(;;){
        wait 0.05;

        // Checking option's buttons
        foreach(key in a_keys){

            // Some keys like F1, F2... etc don't have actions or type anything on the keyboard
            if( should_ignore_keyboard_key( key ) ) continue;

            // Close console
            if(
                ( key == BIND_CAPSLOCK && self has_key( BIND_CAPSLOCK ) && self is_key_pressed( BIND_CAPSLOCK ) ) ||
                ( key == BIND_TAB && self has_key( BIND_TAB ) && self is_key_pressed( BIND_TAB ) )
            )
            {
                self.gsc_keyboard_text = ""; // Remove all text
                self.gsc_keyboard["gsc_input"] setText( self.gsc_keyboard_text ); // Apply visual change
                self notify("gsc_keyboard_menu"); // Enter the empty command which is the same as closing the console
            }
            // Delete
            else if( key == BIND_BACKSPACE && self has_key( BIND_BACKSPACE ) && self is_key_pressed( BIND_BACKSPACE ) ){

                backspace_ticks = 0;
                while( self is_key_pressed( BIND_BACKSPACE ) ){
                    wait 0.05;

                    // If player holds backspace start auto deleting
                    if( ( backspace_ticks == 0 ) || ( backspace_ticks > int(5 * GetDvarFloat(DVAR_TIMESCALE) )&& ( backspace_ticks % int(2 * GetDvarFloat(DVAR_TIMESCALE) ) == 0 ) ) ){

                        text = "";
                        for(i=0; i<self.gsc_keyboard_text.size -1; i++){
                            text += self.gsc_keyboard_text[i];
                        }
                        self.gsc_keyboard_text = text;
                        self.gsc_keyboard["gsc_input"] setText( self.gsc_keyboard_text );
                    }

                    backspace_ticks++;
                }
            }
            // Execute command
            else if( key == BIND_ENTER && self has_key( BIND_ENTER ) && self is_key_pressed( BIND_ENTER ) ){

                while( self is_key_pressed( BIND_ENTER ) ) wait 0.05;
                self notify("gsc_keyboard_menu");
            // Add to console
            }else if( self is_key_pressed( key ) ){

                if( self.gsc_keyboard_text.size >= 51 ){
                    thread debug_message_instant("Character limit reached!", self);
                }else if( key == BIND_SPACE ){
                    self.gsc_keyboard_text += " ";
                    self.gsc_keyboard["gsc_input"] setText( self.gsc_keyboard_text );
                }else{

                    if( isLetter( key ) ){
                        if( self has_key( BIND_SHIFT ) && self is_key_pressed( BIND_SHIFT ) ) self.gsc_keyboard_text += ToUpper( key );
                        else self.gsc_keyboard_text += toLower( key );
                    }else{
                        if( self has_key( BIND_SHIFT ) && self is_key_pressed( BIND_SHIFT ) ) self.gsc_keyboard_text += get_no_letter_char_shift( key );
                        else if( self has_key( BIND_ALT ) && self is_key_pressed( BIND_ALT ) ) self.gsc_keyboard_text += get_no_letter_char_alt( key );
                        else self.gsc_keyboard_text += get_no_letter_char( key );
                    }

                    self.gsc_keyboard["gsc_input"] setText( self.gsc_keyboard_text );
                }

                while( self is_key_pressed( key ) ) wait 0.05;
            }

        }


    }

}

function get_no_letter_char( keybind ){

    switch( keybind ){
        // Numbers
            case BIND_1: return "1";
            case BIND_2: return "2";
            case BIND_3: return "3";
            case BIND_4: return "4";
            case BIND_5: return "5";
            case BIND_6: return "6";
            case BIND_7: return "7";
            case BIND_8: return "8";
            case BIND_9: return "9";
            case BIND_0: return "0";

        // Others
        case BIND_APOSTROPHE: return "'";
        case BIND_INS: return "¡";

        case BIND_PLUS: return "+";

        case BIND_ACCENT: return "´";
        case BIND_CEDILLA: return "ç";

        case BIND_LESSTHAN: return "<";
        case BIND_COMMA: return ",";
        case BIND_DOT: return ".";
        case BIND_MINUS: return "-";
    }

    level thread debug_message("^1Unknown keybind ^5"+keybind+"^1 in get_no_letter_char");
    return "a";
}

function get_no_letter_char_shift( keybind ){

    switch( keybind ){
        // Numbers
            case BIND_1: return "!";
            case BIND_2: return "2"; // Can't add quotes "
            case BIND_3: return "·";
            case BIND_4: return "$";
            case BIND_5: return "%";
            case BIND_6: return "&";
            case BIND_7: return "/";
            case BIND_8: return "(";
            case BIND_9: return ")";
            case BIND_0: return "=";

        // Others
        case BIND_APOSTROPHE: return "?";
        case BIND_INS: return "¿";

        case BIND_PLUS: return "*";

        case BIND_ACCENT: return "¨";
        case BIND_CEDILLA: return "Ç";

        case BIND_LESSTHAN: return ">";
        case BIND_COMMA: return ";";
        case BIND_DOT: return ":";
        case BIND_MINUS: return "_";
    }
    level thread debug_message("^1Unknown keybind ^5"+keybind+"^1 in get_no_letter_char_shift");
    return "a";
}

function get_no_letter_char_alt( keybind ){

    switch( keybind ){
        // Numbers
            case BIND_1: return "|";
            case BIND_2: return "@";
            case BIND_3: return "#";
            case BIND_4: return "~";
            case BIND_5: return "€";
            case BIND_6: return "¬";
            case BIND_7: return "7"; // My keyboard doesn't have anything
            case BIND_8: return "8"; // My keyboard doesn't have anything
            case BIND_9: return "9"; // My keyboard doesn't have anything
            case BIND_0: return "0"; // My keyboard doesn't have anything

        // Others
        case BIND_APOSTROPHE: return "'"; // My keyboard doesn't have anything
        case BIND_INS: return "¡"; // My keyboard doesn't have anything

        case BIND_PLUS: return "]";

        case BIND_ACCENT: return "{";
        case BIND_CEDILLA: return "}";

        case BIND_LESSTHAN: return "<"; // My keyboard doesn't have anything
        case BIND_COMMA: return ","; // My keyboard doesn't have anything
        case BIND_DOT: return "."; // My keyboard doesn't have anything
        case BIND_MINUS: return "-"; // My keyboard doesn't have anything
    }

    level thread debug_message("^1Unknown keybind ^5"+keybind+"^1 in get_no_letter_char_alt");
    return "a";
}