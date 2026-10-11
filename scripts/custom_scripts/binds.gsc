// FOR compiler::getkey( int:key );
#ifdef getkey
function autoexec setup_host_key_values(){

    level.key_value = [];

    // Numbers
        level.key_value[BIND_0] = KEY_0;
        level.key_value[BIND_1] = KEY_1;
        level.key_value[BIND_2] = KEY_2;
        level.key_value[BIND_3] = KEY_3;
        level.key_value[BIND_4] = KEY_4;
        level.key_value[BIND_5] = KEY_5;
        level.key_value[BIND_6] = KEY_6;
        level.key_value[BIND_7] = KEY_7;
        level.key_value[BIND_8] = KEY_8;
        level.key_value[BIND_9] = KEY_9;

    // Letters
        level.key_value[BIND_A] = KEY_A;
        level.key_value[BIND_B] = KEY_B;
        level.key_value[BIND_C] = KEY_C;
        level.key_value[BIND_D] = KEY_D;
        level.key_value[BIND_E] = KEY_E;
        level.key_value[BIND_F] = KEY_F;
        level.key_value[BIND_G] = KEY_G;
        level.key_value[BIND_H] = KEY_H;
        level.key_value[BIND_I] = KEY_I;
        level.key_value[BIND_J] = KEY_J;
        level.key_value[BIND_K] = KEY_K;
        level.key_value[BIND_L] = KEY_L;
        level.key_value[BIND_M] = KEY_M;
        level.key_value[BIND_N] = KEY_N;
        level.key_value[BIND_O] = KEY_O;
        level.key_value[BIND_P] = KEY_P;
        level.key_value[BIND_Q] = KEY_Q;
        level.key_value[BIND_R] = KEY_R;
        level.key_value[BIND_S] = KEY_S;
        level.key_value[BIND_T] = KEY_T;
        level.key_value[BIND_U] = KEY_U;
        level.key_value[BIND_V] = KEY_V;
        level.key_value[BIND_W] = KEY_W;
        level.key_value[BIND_X] = KEY_X;
        level.key_value[BIND_Y] = KEY_Y;
        level.key_value[BIND_Z] = KEY_Z;

    // F + Number
        level.key_value[BIND_F1] = KEY_F1;
        level.key_value[BIND_F2] = KEY_F2;
        level.key_value[BIND_F3] = KEY_F3;
        level.key_value[BIND_F4] = KEY_F4;
        level.key_value[BIND_F5] = KEY_F5;
        level.key_value[BIND_F6] = KEY_F6;
        level.key_value[BIND_F7] = KEY_F7;
        level.key_value[BIND_F8] = KEY_F8;
        level.key_value[BIND_F9] = KEY_F9;
        level.key_value[BIND_F10] = KEY_F10;
        level.key_value[BIND_F11] = KEY_F11;
        level.key_value[BIND_F12] = KEY_F12;


    // Specials
        level.key_value[BIND_ESCAPE] = KEY_ESCAPE;

        level.key_value[BIND_APOSTROPHE] = KEY_APOSTROPHE;
        //level.key_value[BIND_INS] = KEY_INS; // Same as 1
        level.key_value[BIND_BACKSPACE] = KEY_BACKSPACE;

        level.key_value[BIND_TAB] = KEY_TAB;
        level.key_value[BIND_PLUS] = KEY_PLUS;
        level.key_value[BIND_ENTER] = KEY_ENTER;

        level.key_value[BIND_CAPSLOCK] = KEY_CAPSLOCK;
        level.key_value[BIND_ACCENT] = KEY_ACCENT;
        level.key_value[BIND_CEDILLA] = KEY_CEDILLA;

        level.key_value[BIND_SHIFT] = KEY_SHIFT;
        //level.key_value[BIND_LESSTHAN] = ; // Same as comma
        level.key_value[BIND_COMMA] = KEY_COMMA;
        level.key_value[BIND_DOT] = KEY_DOT;
        level.key_value[BIND_MINUS] = KEY_MINUS;

        level.key_value[BIND_CONTROL] = KEY_CONTROL;
        level.key_value[BIND_ALT] = KEY_ALT;
        level.key_value[BIND_SPACE] = KEY_SPACE;
        
        //level.key_value[BIND_PAUSE] = ;

        //level.key_value[BIND_HOME] = ;
        //level.key_value[BIND_PGUP] = ;

        //level.key_value[BIND_DEL] = ;
        //level.key_value[BIND_END] = ;
        //level.key_value[BIND_PGDN] = ;
}
#endif






// Register a key with its binds for the cfg
function add_key_bind( keybind = undefined, bind1 = undefined, bind2 ){

    a_config = self;    

    // No keybind
    if( !isdefined( keybind ) ){
        level thread debug_message("^1Error, undefined keybind to add...");
        return a_config;
    }

    // Invalid keybind
    if( !IsString( keybind ) ){
        level thread debug_message("^1Error, invalid keybind to add...");
        return a_config;
    }

    // If none of the binds is valid then just return
    if( !is_keybind_valid( bind1 ) && !is_keybind_valid( bind2 ) ){

        msg1 = "";
        // No bind1
        if( !isdefined( bind1 ) ) msg1 = "^1Error, undefined bind1 to add...";
        // Invalid bind1
        else if( !IsString( bind1 ) ) msg1 = "^1Error, invalid bind1 to add... key ^5"+keybind;
        // Undetectable bind1
        else msg1 = "^1Error, Undetectable bind1 to add... ^5"+bind1+" ^1for key ^5"+keybind;

        msg2 = "";
        // Invalid bind2
        if( isdefined( bind2 ) && !IsString( bind2 ) ) msg2 = "^1Error, invalid bind2 to add... key ^5"+keybind;
        // Undetectable bind2
        else msg2 = "^1Error, Undetectable bind2 to add... ^5"+bind2+" ^1for key ^5"+keybind;

        // Print error messages
        if( msg1 != "" ) level thread debug_message( msg1 );
        if( msg2 != "" ) level thread debug_message( msg2 );

        return a_config;
    }

    // keybind already exists
    if( isdefined( a_config[ keybind ] ) ){
        level thread debug_message("^1Error, keybind already exists ^5"+keybind);
        return a_config;        
    }
    
    // Initialize the keybind data
    //self[ keybind ] = SpawnStruct();
    //self[ keybind ].pressed_binds = [];
    //self[ keybind ].unpressed_binds = [];

    s_bind = SpawnStruct();
    s_bind.pressed_binds = [];
    s_bind.unpressed_binds = [];

    //level thread debug_message( "^8A defined After create? "+isdefined( self[ keybind ] ) );

    // Add Bind1 to Keybind
    if( isdefined( bind1 ) && IsString( bind1 ) && is_keybind_detectable( bind1 )  ){

        #ifdef dev
            //level thread debug_message( "Adding KEY ^5"+keybind+" ^7 with BIND ^5"+bind1 );
        #endif

        //ArrayInsert(self[ keybind ].pressed_binds, bind1, self[ keybind ].pressed_binds.size);
        ArrayInsert(s_bind.pressed_binds, bind1, s_bind.pressed_binds.size);
    }

    // Add Bind2 to Keybind
   if( isdefined( bind2 ) && IsString( bind2 ) && is_keybind_detectable( bind2 )  ){

        #ifdef dev
            //level thread debug_message( "Adding KEY ^5"+keybind+" ^7 with BIND ^5"+bind2 );
        #endif

        //ArrayInsert(self[ keybind ].pressed_binds, bind2, self[ keybind ].pressed_binds.size);
        ArrayInsert(s_bind.pressed_binds, bind2, s_bind.pressed_binds.size);
    }


    a_config[ keybind ] = s_bind;
    return a_config;

    // Avoid Developer 2 error
    //self[ keybind ] = s_bind;

    

    return self;
}

function is_keybind_valid( keybind ){

    // Undefined keybind check
    if( !isdefined( keybind ) ) return false;

    // Invalid keybind check
    if( !IsString( keybind ) ) return false;

    return is_keybind_detectable( keybind );
}

function is_keybind_detectable( keybind ){

    // No keybind
    if( !isdefined( keybind ) ){
        //level thread debug_message("^1Error, undefined keybind to check if detectable...");
        return false;
    }

    // No keybind
    if( !IsString( keybind ) ){
        level thread debug_message("^1Error, invalid keybind to check if detectable...");
        return false;
    }

    return IsInArray(DETECTABLE_BINDS, keybind);
}

function assign_key_command( keybind = undefined, command = undefined ){

    // No keybind
    if( !isdefined( keybind ) ){
        level thread debug_message("^1Error, undefined keybind to assign...");
        return self;
    }

    // Invalid keybind
    if( !IsString( keybind ) ){
        level thread debug_message("^1Error, invalid keybind to assign...");
        return self;
    }

    // No command
    if( !isdefined( command ) ){
        level thread debug_message("^1Error, undefined command to assign...");
        return self;
    }

    // Invalid command
    if( !IsString( command ) ){
        level thread debug_message("^1Error, invalid command to assign...");
        return self;
    }

    // No keybind
    if( !isdefined( self.keys[ keybind ] ) ){
        level thread debug_message("^1Error, Unregistered keybind to assign... ^5"+keybind);
        return self;
    }

    self.key_commands[ keybind ] = command;
    return self;
}

function watch_key_commands(){
    self endon("disconnect");

    // Give some time for keybinds to load
    wait 0.1;

    // Avoid involuntary commands, especially right after a fast_restart
    foreach( key, command in self.key_commands ){
        //level thread debug_message( "^1Beginning Key ^5"+key+"^1 Command ^5"+command );
        //if( !self is_key_pressed( key ) ) continue;

        //level thread debug_message( "^1Key SUPER pressed ^5"+key );
        while( self is_key_pressed( key ) ) wait 0.1;
    }

    //level thread debug_message( "^2key_commands detected! ^5"+self.key_commands);
    //foreach( key, command in self.key_commands ) level thread debug_message( "Key ^5"+key+" ^7command ^5"+command );

    for(;;){
        wait 0.05;
        foreach( key, command in self.key_commands ){

            // Key is not pressed
            if( !self is_key_pressed( key ) ) continue;
            // Special menu open
            if( self has_special_menu_open() ) continue;

            self thread execute_command( command );

            while( self is_key_pressed( key ) ) wait 0.05;
        }
    }
}


// Add the binds that shouldn't be active for the keys with a bind in common
function resolve_conflicting_binds(){

    #ifdef dev
        //level thread debug_message( "Total CFG keys: ^5"+self.keys.size );
    #endif

    a_keys = GetArrayKeys( self.keys );

    for( i=0; i<a_keys.size; i++){

        //level thread debug_message( "I loop: ^5"+i+" / "+a_keys.size );

        b_conflicted_key = true;

        // Check if Key has available keybinds
        foreach( keybind in self.keys[ a_keys[ i ] ].pressed_binds ){
            // Keybind is still useful
            if( !IsInArray(self.keys[ a_keys[ i ] ].unpressed_binds, keybind ) ){
                b_conflicted_key = false;
                //break;
            }
        }

        // Don't even try to check this key since it's already useless, its keybinds are being used by other keys
        if( b_conflicted_key ){
            level thread debug_message( sprintf("Key ^5{0} ^1is conflicted...^7 Please change it to use it!", self.keys[ a_keys[ i ] ] ) );
            continue;
        }


        for( j=i; j<a_keys.size; j++){

            // Skip checking against same key
            if( i == j ){
                //level thread debug_message( "Continue: "+a_keys[ i ]+" => "+a_keys[ j ] );
                continue;
            }

            //level thread debug_message( "J loop: ^5"+j+" / "+a_keys.size );
            //level thread debug_message( "Checking: ^5"+a_keys[ i ]+" => "+a_keys[ j ] );


            // Key not defined
            if( !isdefined( self.keys[ a_keys[ i ] ] ) ){
                level thread debug_message( "^1UNDEFINED ^5pressed_binds ^7for A key ^5"+a_keys[ i ]+" "+i  );
                continue;
            }

            // Actions for key not defined
            if( !isdefined( self.keys[ a_keys[ i ] ].pressed_binds ) ){
                level thread debug_message( "^1UNDEFINED A ^5pressed_binds ^5"+a_keys[ i ] );
                continue;
            }

            // Actions for key are not an array
            if( !IsArray( self.keys[ a_keys[ i ] ].pressed_binds ) ){
                level thread debug_message( "^1NOT ARRAY ^5A pressed_binds "+a_keys[ i ] );
                continue;
            }

            // Key not defined
            if( !isdefined( self.keys[ a_keys[ j ] ] ) ){
                level thread debug_message( "^1UNDEFINED ^5pressed_binds ^7for B ^7key ^5"+a_keys[ j ] );
                continue;
            }

            // Actions for key not defined
            if( !isdefined( self.keys[ a_keys[ j ] ].pressed_binds ) ){
                level thread debug_message( "^1UNDEFINED A ^5pressed_binds ^5B" );
                continue;
            }

            // Actions for key are not an array
            if( !IsArray( self.keys[ a_keys[ j ] ].pressed_binds ) ){
                level thread debug_message( "^1NOT ARRAY ^5B pressed_binds" );
                continue;
            }

            //level thread debug_message( "Continue END" );

            foreach( bind_index, bind_value in self.keys[ a_keys[ j ] ].pressed_binds ){

                // If the binds are not conflicting then there is nothing to do
                if( !IsInArray( self.keys[ a_keys[ i ] ].pressed_binds, bind_value ) ){
                    //level thread debug_message( "^2Keybinds not conflicted! ^7| ^5"+bind_value+" ^7-> ^5"+a_keys[ i ] );
                    continue;
                }

                //level thread debug_message( "^!Keybinds conflicted... ^7| ^5"+bind_value+" ^7-> ^5"+a_keys[ i ] );

                /* Possible cases?
                    A_Key   1 Keybind   2 Keybind   1 Keybind   2 Keybind
                    B_Key   1 Keybind   1 Keybind   2 Keybind   2 Keybind
                */


                // Key_A
                for( k=0; k<self.keys[ a_keys[ i ] ].pressed_binds.size; k++){
                    new_bind_to_check = self.keys[ a_keys[ i ] ].pressed_binds[ k ];

                    // Both Keys have this bind already...
                    if( bind_value == new_bind_to_check ){
                        //level thread debug_message( "^1Skipping the conflicting bind ^7| ^5"+new_bind_to_check+" ^7-> ^5"+a_keys[ j ] );
                        continue;
                    }

                    // The bind of the conflicted key is already added
                    if( IsInArray( self.keys[ a_keys[ j ] ].unpressed_binds, new_bind_to_check ) ){
                        //level thread debug_message( "^2Conflicting Keybind already added! ^7| ^5"+new_bind_to_check+" ^7-> ^5"+a_keys[ j ] );
                        continue;
                    }

                    // Adding keybind to check not being pressed
                    ArrayInsert( self.keys[ a_keys[ j ] ].unpressed_binds, new_bind_to_check, self.keys[ a_keys[ j ] ].unpressed_binds.size);
                    //level thread debug_message( "^2!Keybind added to be unpressed! ^7| ^5"+new_bind_to_check+" ^7-> ^5"+a_keys[ i ]+" ^7 Conflicted with ^5"+a_keys[ j ] );
                }

                // Key_B
                for( k=0; k<self.keys[ a_keys[ j ] ].pressed_binds.size; k++){
                    new_bind_to_check = self.keys[ a_keys[ j ] ].pressed_binds[ k ];

                    // Both Keys have this bind already...
                    if( bind_value == new_bind_to_check ){
                        //level thread debug_message( "^1Skipping the conflicting bind ^7| ^5"+new_bind_to_check+" ^7-> ^5"+a_keys[ j ] );
                        continue;
                    }

                    // The bind of the conflicted key is already added
                    if( IsInArray( self.keys[ a_keys[ i ] ].unpressed_binds, new_bind_to_check ) ){
                        //level thread debug_message( "^2Conflicting Keybind already added! ^7| ^5"+new_bind_to_check+" ^7-> ^5"+a_keys[ i ] );
                        continue;
                    }

                    // Adding keybind to check not being pressed
                    ArrayInsert( self.keys[ a_keys[ i ] ].unpressed_binds, new_bind_to_check, self.keys[ a_keys[ i ] ].unpressed_binds.size);
                    //level thread debug_message( "^2!Keybind added to be unpressed! ^7| ^5"+new_bind_to_check+" ^7-> ^5"+a_keys[ i ]+" ^7 Conflicted with ^5"+a_keys[ j ] );
                }

            }


            //level thread debug_message( sprintf("Keybinds ^5 A and ^6 B ^1 ARE CONFLICTED!" ) );
            // Check if Key has available keybinds
            foreach( keybind in self.keys[ a_keys[ i ] ].pressed_binds ){
                // Keybind is still useful
                if( !IsInArray(self.keys[ a_keys[ i ] ].unpressed_binds, keybind) ){
                    b_conflicted_key = false;
                    //break;
                }
            }

            if( b_conflicted_key ){
                level thread debug_message( sprintf("Key ^5{0} ^7and ^5{1} ^1are conflicted...^7 Please change it to use it!", self.keys[ a_keys[ i ] ], self.keys[ a_keys[ j ] ] ) );
                //level thread debug_message( sprintf("Keybinds ^5{0} and ^6{1} ^1ARE CONFLICTED!", a_keys[ i ], a_keys[ j ] ) );
            }

        }

    }

    //level thread debug_message( "^2Resolve end!" );
    return self;
}

// Add the cfg to the surtr_cfgs list
function register_surtr_config( cfg = undefined ){

    // Undefined ids
    if( !isdefined( cfg ) ){
        level thread debug_message( "^1Error, UNDEFINED cfg in ^5register_surtr_config" );
        return;
    }

    // Automatically adds the binds that should not be pressed on 
    cfg = cfg resolve_conflicting_binds();

    // if there are no cfg
    if( !isdefined( level.surtr_cfgs ) ) level.surtr_cfgs = [];

    // Add new cfg
    ArrayInsert( level.surtr_cfgs, cfg, level.surtr_cfgs.size );
}

// Inf loop checking for players connecting to give them a surtr cfg in case there is one registered for them (Supports hot join!)
function watch_surtr_players(){

    // Init surtr configs
    level.surtr_cfgs = [];

    // Check for current players
    foreach( player in getplayers() ){

        // Player already has a surtr config active
        if( isdefined( player.surtr ) ){
            level thread debug_message( "^1PLAYER ALREADY HAS SURTR CONFIG" );
            continue;
        }

        // Give a surtr cfg to the player
        player thread assign_surtr_cfg();
        //level thread debug_message("Surtr already connected check ^5"+player.name);
    }

    // Check for future players
    for(;;){
        level waittill( "connecting", player);
        //level waittill( "connected", player);

        // Give surtr cfg to the new player
        player thread assign_surtr_cfg();

        //level thread debug_message("Surtr connecting check ^5"+player.name);
    }

}

function assign_surtr_cfg(){

    #ifdef getkey
        // Give custom compiler stuff
        if( self IsHost()){
            self.surtr = true; // Avoid other surtr cfgs to be checked for this player
            self notify( "surtr_cfg" ); // Disable non surtr cfg stuff like fast restart
            self.keys = level.key_value; // Assign which keys are available to check
            self thread open_keyboard_menu(); // Enables custom console
        }
    #endif

    xuid0 = MY_XUID;
    xuid1 = self getxuid(1);

    for(i=0; i<level.surtr_cfgs.size; i++){

        if( !isdefined( level.surtr_cfgs[ i ].ids ) ){
            level thread debug_message( "^1Error, missing Surtr cfg ID..." );
            continue;
        }

        if( !isdefined( level.surtr_cfgs[ i ].keys ) ){
            level thread debug_message( "^1Error, missing Surtr cfg KEYS..." );
            continue;
        }


        foreach( id in level.surtr_cfgs[ i ].ids ){

            if( id != xuid0 && id != xuid1 ) continue;

            #ifdef dev
                // +level thread debug_message("ID found ^5"+xuid1+" ^6"+self.name);
            #endif

            // Check again in case another assign surtr func has already assigned one to this player
            if( isdefined( self.surtr ) ) return;

            //level thread debug_message( "^2Surtr cfg found! ^5"+self.name );
            self.surtr = true; // This is to avoid a potential different thread to assign a surtr cfg to this player again
            self notify( "surtr_cfg" ); // Disable non surtr cfg stuff like fast restart

            // Assign the Surtr CFG keys to the player
            self.keys = level.surtr_cfgs[ i ].keys;

            // If there are key commands assigned then run them
            if( isdefined( level.surtr_cfgs[ i ].key_commands ) && level.surtr_cfgs[ i ].key_commands.size ){
                self.key_commands = level.surtr_cfgs[ i ].key_commands;
                self thread watch_key_commands();
            }
            #ifdef dev
                else{
                    level thread debug_message( "^1No assigned commands detected...");
                }
            #endif

            self thread open_keyboard_menu(); // Enables custom console

            #ifdef dev
                //self thread test_new_bind_system();
                //self thread test_button_bits();
            #endif

            return;
        }

    }

}

// Check if the desired key is pressed
function is_key_pressed( Key ){

    // No player
    if( !IsPlayer( self ) ){
        level thread debug_message("^1Error, Not a player in is_key_pressed...");
        return false;
    }

    // No keybind
    if( !isdefined( Key ) ){
        level thread debug_message("^1Error, undefined Key to press... ^5"+self.name);
        return false;
    }

    #ifdef getkey
        if( self IsHost() ){

            if( !isdefined( level.key_value ) ){
                self IPrintLnBold("^1NO KEY_VALUE TABLE...");
                return false;
            }
            if( !isdefined( level.key_value[ key ] ) ){
                self IPrintLnBold("^1NO KEY_VALUE FOR ^5"+key);
                return false;
            }

            //self IPrintLnBold("^5 COMPILER GETKEY VALUE");
            return compiler::getkey( level.key_value[ key ] );
        }
    #endif

    // Invalid keybind
    if( !IsString( Key ) ){
        level thread debug_message("^1Error, invalid Key to press... ^5"+self.name);
        return false;
    }

    // Undefined Key
    if( !isdefined( self.keys ) ){
        level thread debug_message("^1Error, No keys registered  ^5"+self.name+" "+Key);
        return false;        
    }

    // Undefined Key
    if( !isdefined( self.keys[ Key ] ) ){
        level thread debug_message("^1Error, Unregistered key to press...  ^5"+self.name+" "+Key);
        return false;        
    }

    // Check all the binds that should be active
    foreach( bind in self.keys[ Key ].pressed_binds ){

        // They should be pressed!
        if( !is_button_pressed( bind ) ){
            //level thread debug_message_instant("^5"+Key+" ^1should be pressed... ^5"+bind);
            return false;
        }
    }

    // Check all the binds that should NOT be active
    foreach( bind in self.keys[ Key ].unpressed_binds ){

        // They should NOT be pressed!
        if( is_button_pressed( bind ) ){
            //level thread debug_message_instant("^5"+Key+" ^1should NOT be pressed... ^5"+bind);
            return false;
        }
    }

    return true;
}

// Check if the button is being pressed based on its binds
function is_button_pressed( button_name = undefined ){

    if( !isPlayer( self ) ){
        thread debug_message("Error, not a player on 'is_button_pressed'");
        return;        
    }

    if( !isdefined( button_name ) ){
        thread debug_message("Error, UNDEFINED button_name on 'is_button_pressed'");
        return;  
    }

    if( !IsString( button_name ) ){
        thread debug_message("Error, not a string button_name on 'is_button_pressed'");
        return;  
    }


    switch( button_name ){

        // COMBAT
            case BIND_ATTACK: return self ButtonBitState( BIT_ATTACK );
            case BIND_WEAPHERO: return self ButtonBitState( BIT_OFFHAND_SPECIAL );
            case BIND_SPEED: return self ButtonBitState( BIT_WALKING );
            case BIND_SPEED_THROW: return self ButtonBitState( BIT_WALKING, BIT_THROW );
            case BIND_TOGGLEADS: return self ButtonBitState( BIT_WALKING );
            case BIND_ACTIVATE: return self ButtonBitState( BIT_ACTIVATE );
            case BIND_FRAG: return self ButtonBitState( BIT_FRAG );
            case BIND_SMOKE: return self ButtonBitState( BIT_OFFHANDSECONDARY );
            case BIND_MELEE: return self ButtonBitState( BIT_MELEE );
            case BIND_MELEE_ZOOM: return self ButtonBitState( BIT_MELEE );
            case BIND_RELOAD: return self ButtonBitState( BIT_RELOAD );
            case BIND_USERELOAD: return self ButtonBitState( BIT_USE_RELOAD );
            case BIND_WEAPNEXT_INVENTORY: return self ButtonBitState( BIT_WEAPON_SWITCH );

        // MOVEMENT
            case BIND_STANCE: return self ButtonBitState( BIT_STANCE );
            case BIND_GOSTAND: return self ButtonBitState( BIT_ACTION );
            case BIND_PRONE: return self ButtonBitState( BIT_TEMPSTANCE );
            case BIND_SPRINT: return self ButtonBitState( BIT_JUKE );
            case BIND_BREATH_SPRINT: return self ButtonBitState( BIT_BREATH, BIT_JUKE );
            case BIND_HOLDBREATH: return self ButtonBitState( BIT_BREATH );
            case BIND_MOVEUP: return self ButtonBitState( BIT_ACTION );
            case BIND_MOVEDOWN: return self ButtonBitState( BIT_TEMPSTANCE );
            case BIND_FORWARD: return self getnormalizedmovement()[ 0 ] > 0;
            case BIND_BACK: return self getnormalizedmovement()[ 0 ] < 0;
            case BIND_MOVELEFT:return self getnormalizedmovement()[ 1 ] < 0;
            case BIND_MOVERIGHT: return self getnormalizedmovement()[ 1 ] > 0;
            case BIND_LEANLEFT: return self ButtonBitState( BIT_LEANLEFT );
            case BIND_LEANRIGHT: return self ButtonBitState( BIT_LEANRIGHT );

        // ACTION SLOTS
            case BIND_ACTIONSLOT1: return self ButtonBitState( BIT_ACTIONSLOT_1 );
            case BIND_ACTIONSLOT2: return self ButtonBitState( BIT_ACTIONSLOT_2 );
            case BIND_ACTIONSLOT3: return self ButtonBitState( BIT_ACTIONSLOT_3 );
            case BIND_ACTIONSLOT4: return self ButtonBitState( BIT_ACTIONSLOT_4 );

        // VEHICLE
            case BIND_VEHICLEBOOST: return self ButtonBitState( BIT_VEHICLE_BOOST );
            case BIND_GAS: return self ButtonBitState( BIT_GAS );
            case BIND_REVERSE: return self ButtonBitState( BIT_REVERSE );
            case BIND_HANDBRAKE: return self ButtonBitState( BIT_HANDBRAKE );
            case BIND_SWITCHSEAT: return self ButtonBitState( BIT_CHANGE_SEAT );
            case BIND_VEHICLEATTACK: return self ButtonBitState( BIT_VEHICLE_ATTACK );
            case BIND_VEHICLEATTACKSECOND: return self ButtonBitState( BIT_VEHICLE_ATTACK2 );
            case BIND_VEHICLEMOVEUP: return self ButtonBitState( BIT_VEHICLE_MOVEUP );
            case BIND_VEHICLEMOVEDOWN: return self ButtonBitState( BIT_VEHICLE_MOVEDOWN );

        default:
        {
            thread debug_message( "^1Error, unknown action bind ^5"+button_name );
            return false;     
        }
    }

}

function has_key( key ){

    // Error checks
    if( !isplayer( self )){
        thread debug_message("Error, not a player in 'has_key'");
        return false;
    }

    if( !isdefined( key )){
        thread debug_message("Error, no key defined on 'has_key'");
        return false;
    }

    //level thread debug_message("^5"+self.name+" ^7Has Key ^5"+key+" ^7? ^5"+( isdefined( self.keys ) && isdefined( self.keys[ key ] ) ) );

    #ifdef getkey
        if( self IsHost() ) return isdefined( level.key_value ) && isdefined( level.key_value[ key ] );
    #endif

    // Player doesn't have Surtr keybinds registered
    if( !isdefined( self.keys ) ) return false;

    return isdefined( self.keys[ key ] );
}

function isLetter( char )
{
    if( !isdefined(char) || char.size != 1 )
        return false;

    return (char[0] >= "a" && char[0] <= "z") || (char[0] >= "A" && char[0] <= "Z");
}

function test_button_bits(){
    
    self.testing_keys_huds = [];
    
    button_bits = array(BIT_ATTACK, BIT_CAMERALOCK, BIT_GESTURESHIFT, BIT_CHANGE_SEAT, BIT_VEHICLE_ATTACK, BIT_VEHICLE_ATTACK2, BIT_VEHICLE_MOVEUP, BIT_VEHICLE_MOVEDOWN, BIT_LASING);

    for(i=0; i<button_bits.size; i++){

        self.testing_keys_huds[ button_bits[ i ] ] = self create_hud( undefined, undefined, "left_top" );
        self.testing_keys_huds[ button_bits[ i ] ].x = 10;
        self.testing_keys_huds[ button_bits[ i ] ].y = 10 * i;
        self.testing_keys_huds[ button_bits[ i ] ].alpha = 1;
        self.testing_keys_huds[ button_bits[ i ] ].label = istring( button_bits[ i ] );
        self.testing_keys_huds[ button_bits[ i ] ] SetText( "^1Unpressed...");
    }   

    for(;;){
        wait 0.05;
        for(i=0; i<button_bits.size; i++){
            if( self buttonbitstate( button_bits[ i ] ) ) self.testing_keys_huds[ button_bits[ i ] ] SetText( " ^2Pressed!");
            else self.testing_keys_huds[ button_bits[ i ] ] SetText( " ^1Unpressed...");
        }
    }

}


function test_new_bind_system(){

    self.testing_keys_huds = [];
    
    binded_keys = GetArrayKeys( self.keys );

    for(i=0; i<binded_keys.size; i++){

        self.testing_keys_huds[ binded_keys[ i ] ] = self create_hud( undefined, undefined, "left_top" );
        self.testing_keys_huds[ binded_keys[ i ] ].x = 10;
        self.testing_keys_huds[ binded_keys[ i ] ].y = 10 * i;
        self.testing_keys_huds[ binded_keys[ i ] ].alpha = 1;
        self.testing_keys_huds[ binded_keys[ i ] ].label = istring( binded_keys[ i ] );
        self.testing_keys_huds[ binded_keys[ i ] ] SetText( "^1Unpressed...");
    }

    for(;;){
        wait 0.05;
        for(i=0; i<binded_keys.size; i++){
            if( self is_key_pressed( binded_keys[ i ] ) ) self.testing_keys_huds[ binded_keys[ i ] ] SetText( " ^2Pressed!");
            else self.testing_keys_huds[ binded_keys[ i ] ] SetText( " ^1Unpressed...");
        }
    }

}








/* Button bits

    BUTTON_BIT_INVALID
    BUTTON_BIT_ATTACK                       "+attack"
    BUTTON_BIT_SPRINT                       [(not when moving back)"+sprint", "+breath_sprint"]
    BUTTON_BIT_MELEE                        "+melee", "+melee_zoom"
    BUTTON_BIT_ACTIVATE                     "+activate"
    BUTTON_BIT_RELOAD                       "+reload"
    BUTTON_BIT_USE_RELOAD                   "+usereload"
    BUTTON_BIT_LEANLEFT                     "+leanleft"
    BUTTON_BIT_LEANRIGHT                    "+leanright"
    BUTTON_BIT_PRONE                        [(when proning)"+prone", "+stance", "toggleprone", "goprone"], [(when prone) "+movedown", "raisestance"], [(when crouch)"lowerstance"]
    BUTTON_BIT_CROUCH                       [(when crouching)"+stance", "togglecrouch", "gocrouch"], [(when prone)"+moveup"],[(when stand)"lowerstance"], [(when prone OR stand)"+movedown"]
    BUTTON_BIT_JUMP                         [(when already stand)"+gostand", "+moveup"]
    BUTTON_BIT_WALKING                      "+speed_throw", "toggleads", "+speed", [(only when aiming too)"+melee_zoom"]
    BUTTON_BIT_TEMPSTANCE                   "+prone", "+movedown"
    BUTTON_BIT_BREATH                       "+holdbreath", "+breath_sprint"
    BUTTON_BIT_FRAG                         "+frag"
    BUTTON_BIT_OFFHANDSECONDARY             "+smoke"
    BUTTON_BIT_CONFIRM_LOCATION
    BUTTON_BIT_CANCEL_LOCATION
    BUTTON_BIT_GAS                          "+gas"
    BUTTON_BIT_REVERSE                      "+reverse"
    BUTTON_BIT_HANDBRAKE                    "+handbrake"
    BUTTON_BIT_THROW                        "+speed_throw", [(only when aiming too)"+melee_zoom"]
    BUTTON_BIT_CAMERALOCK
    BUTTON_BIT_GESTURESHIFT
    BUTTON_BIT_LOOKSPRING
    BUTTON_BIT_CHANGE_SEAT                  "+switchseat"
    BUTTON_BIT_TALK
    BUTTON_BIT_RED
    BUTTON_BIT_GREEN
    BUTTON_BIT_BLUE
    BUTTON_BIT_YELLOW
    BUTTON_BIT_VEHICLE_ATTACK               "+vehicleattack"
    BUTTON_BIT_VEHICLE_ATTACK2              "+vehicleattacksecond"
    BUTTON_BIT_VEHICLE_MOVEUP               "+vehiclemoveup"
    BUTTON_BIT_VEHICLE_MOVEDOWN             "+vehiclemovedown"
    BUTTON_BIT_JAM
    BUTTON_BIT_SLIDE                        
    BUTTON_BIT_DIVE_TO_PRONE                
    BUTTON_BIT_ACTIONSLOT_1                 "+actionslot 1"
    BUTTON_BIT_ACTIONSLOT_2                 "+actionslot 2"
    BUTTON_BIT_ACTIONSLOT_3                 "+actionslot 3"
    BUTTON_BIT_ACTIONSLOT_4                 "+actionslot 4"
    BUTTON_BIT_OFFHAND_CANCEL               (when holding a nade and then switching weapons)
    BUTTON_BIT_USE_DOUBLE_TAP               (when pressing twice fast any or a combination of: "+activate", "+reload", "+usereload")
    BUTTON_BIT_AIRBURST
    BUTTON_BIT_LASING
    BUTTON_BIT_INVENTORY
    BUTTON_BIT_NUNCHUKSCOPE
    BUTTON_BIT_NUNCHUKTURRET
    BUTTON_BIT_ACTIONSLOT_CAROUSEL
    BUTTON_BIT_WEAPON_PICKUP
    BUTTON_BIT_ALT_WEAPON_PICKUP_ENABLED
    BUTTON_BIT_DOUBLETAPJUMP
    BUTTON_BIT_CCP_SHIFTGRENADE
    BUTTON_BIT_STANCE                       "+stance"
    BUTTON_BIT_VEHICLE_BOOST                "+vehicleboost"
    BUTTON_BIT_ACTION                       "+gostand", "+moveup"
    BUTTON_BIT_DOUBLEJUMP                   [(when already stand)"+gostand", "+moveup"]
    BUTTON_BIT_JUKE                         "+sprint", "+breath_sprint"
    BUTTON_BIT_SWIM_UP                      "+gostand", "+moveup"
    BUTTON_BIT_SWIM_DOWN                    "+stance"
    BUTTON_BIT_PLANT_SHIELD
    BUTTON_BIT_OFFHAND_SPECIAL              "+weaphero"
    BUTTON_BIT_WEAPON_SWITCH                "+weapnext_inventory"
*/

/* binds para usar que no se suelen usar y no molestan
    +weapnext_inventory
    +holdbreath
    +vehicleboost
    +leanleft
    +leanright
    +gas
    +reverse
    +handbrake
    +switchseat
    +vehicleattack
    +vehicleattacksecond
    +vehiclemoveup
    +vehiclemovedown
*/

/* Action binds

    "+moveup"
    "-moveup"
    "+movedown"
    "-movedown"
    "+speed"
    "-speed"
    "lowerstance"
    "raisestance"
    "centerview"

    "+red"
    "-red"
    "+green"
    "-green"
    "+blue"
    "-blue"
    "+yellow"
    "-yellow"


    "+attack"
    "-attack"
    "+melee"
    "-melee"
    "+frag"
    "-frag"
    "+smoke"
    "-smoke"
    "+breath_sprint"
    "-breath_sprint"
    "+usereload"
    "-usereload"
    "+speed_throw"
    "-speed_throw"
    "+toggleads_throw"
    "-toggleads_throw"

    "+actionslot 1"
    "-actionslot 1"
    "+actionslot 2"
    "-actionslot 2"
    "+actionslot 3"
    "-actionslot 3"
    "+actionslot 4"
    "-actionslot 4"
    "+actionslot 5"
    "-actionslot 5"
    "+actionslot 6"
    "-actionslot 6"
    "+actionslot 7"
    "-actionslot 7"

    "+stance"
    "-stance"
    "+gostand"
    "-gostand"
    "+specNext"
    "-specNext"
    "+specPrev"
    "-specPrev"
    "+togglePrev"
    "-togglePrev"
    "+melee_zoom"
    "-melee_zoom"
    "+changezoom"
    "-changezoom"
    "+weapnext_inventory"
    "-weapnext_inventory"

    "+gas"
    "-gas"
    "+reverse"
    "-reverse"
    "+handbrake"
    "-handbrake"
    "+vehicleattack"
    "-vehcileattack"
    "+vehicleattacksecond"
    "-vehicleattacksecond"
    "+vehicleboost"
    "-vehicleboost"
    "+vehiclemoveup"
    "-vehiclemoveup"
    "+vehiclemovedown"
    "-vehiclemovedown"
    "+switchseat"
    "-switchseat"

    "+forward"
    "-forward"
    "+back"
    "-back"
    "+moveleft"
    "-moveleft"
    "+moveright"
    "-moveright"
    "+movedown"
    "-movedown"

    "+left"
    "-left"
    "+right"
    "-right"
    "+lookup"
    "-lookup"
    "+lookdown"
    "-lookdown"

    "+strafe"
    "-strafe"
    "+holdbreath"
    "-holdbreath"
    "+activate"
    "-activate"
    "+reload"
    "-reload"
    "+prone"
    "-prone"
    "+mlook"
    "-mlook"
    "+sprint"
    "-sprint"
    "+scores"
    "-scores"

    "+leanleft"
    "-leanleft"
    "+leanright"
    "-leanright"

    "+weaphero"
    "-weaphero"
    "+talk"
    "-talk"
    "togglemenu"
    "weapnext"
    "pause"
    "inventory"
    "chatmodeparty"
    "chatmodepublic"
    "chatmodeteam"
    "weapprev"
    "slide"
    "centerview"
    "togglecrouch"
    "toggleprone"
    "goprone"
    "gocrouch"
    "toggleads"
    "leaveads"
    "vote yes"
    "vote no"
    "screenshotJpeg"
    "togglescores"
    "skip"
    "chooseclass_hotkey"
    "acceptLastGameInvite"

*/

/* Localized Key binds

    // Controller Buttons
        "KEY_BUTTON_A",
        "KEY_BUTTON_B",
        "KEY_BUTTON_X",
        "KEY_BUTTON_Y",

    // Controller Pads
        "KEY_DPAD_UP",
        "KEY_DPAD_DOWN",
        "KEY_DPAD_LEFT",
        "KEY_DPAD_RIGHT",

    // Controller Left
        "KEY_BUTTON_LSHLDR",
        "KEY_BUTTON_LTRIG",
        "KEY_BUTTON_LSTICK",

    // Controller Left
        "KEY_BUTTON_RSHLDR",
        "KEY_BUTTON_RTRIG",
        "KEY_BUTTON_RSTICK",

    // Controller Menus
        "KEY_BUTTON_START",
        "KEY_BUTTON_BACK",

    // Mouse
        "KEY_MOUSE1",
        "KEY_MOUSE2",
        "KEY_MOUSE3",
        "KEY_MOUSE4",
        "KEY_MOUSE5",
        "KEY_MWHEELUP",
        "KEY_MWHEELDOWN",


    // Arrows
        "KEY_UPARROW",
        "KEY_DOWNARROW",
        "KEY_LEFTARROW",
        "KEY_RIGHTARROW",

    // F+Number
        "KEY_F1",
        "KEY_F2",
        "KEY_F3",
        "KEY_F4",
        "KEY_F5",
        "KEY_F6",
        "KEY_F7",
        "KEY_F8",
        "KEY_F9",
        "KEY_F10",
        "KEY_F11",
        "KEY_F12",

    // Keyboard
        "KEY_TAB",
        "KEY_ENTER",
        "KEY_ESCAPE",
        "KEY_SPACE",
        "KEY_BACKSPACE",
        "KEY_ALT",
        "KEY_CTRL",
        "KEY_SHIFT",
        "KEY_CAPSLOCK",
        "KEY_INS",
        "KEY_DEL",
        "KEY_PGDN",
        "KEY_PGUP",
        "KEY_HOME",
        "KEY_END",
        "KEY_SEMICOLON",
        "KEY_PAUSE",

    // Numeric pad
        "KEY_KP_HOME",
        "KEY_KP_UPARROW",
        "KEY_KP_PGUP",
        "KEY_KP_LEFTARROW",
        "KEY_KP_5",
        "KEY_KP_RIGHTARROW",
        "KEY_KP_END",
        "KEY_KP_DOWNARROW",
        "KEY_KP_PGDN",
        "KEY_KP_ENTER",
        "KEY_KP_INS",
        "KEY_KP_DEL",
        "KEY_KP_SPLASH",
        "KEY_KP_MINUS",
        "KEY_KP_PLUS",
        "KEY_KP_NUMLOCK",
        "KEY_KP_STAR",
        "KEY_KP_EQUALS",

    // Aux
        "KEY_AUX1",
        "KEY_AUX2",
        "KEY_AUX3",
        "KEY_AUX4",
        "KEY_AUX5",
        "KEY_AUX6",
        "KEY_AUX7",
        "KEY_AUX8",
        "KEY_AUX9",
        "KEY_AUX10",
        "KEY_AUX11",
        "KEY_AUX12",
        "KEY_AUX13",
        "KEY_AUX14",
        "KEY_AUX15",
        "KEY_AUX16",

    // Misc
        "KEY_OR",
        "KEY_USE",
        "KEY_KP_COMMAND",
        "KEY_UNBOUND",
*/

/* Misc

    fast_restart
    mission_restart
    map_restrart

    drawLagometer

    kick
    killserver
    launchGame
    lobby_setmap
    m_mouseSensitivity
*/