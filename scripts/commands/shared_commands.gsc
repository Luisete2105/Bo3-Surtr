// Shared commands are the ones that work for all modes
function register_shared_commands(){

    // General Game Settings
        // Enable or Disable practice mode to allow cheat protected commands
        level register_keyboard_console_command( "Toggle_Practice", array("TogglePractice", "Practice", "Pract", "Prac", "Pra", "cheats", "cheat"), ::gsc_practice, ALLOWED, ARGS_0 );

        // Disconnects from DemonWare, Uno and Umbrella online services.
        level register_keyboard_console_command( "Full_Offline", array("FullOffline", "True_Offline", "TrueOffline", "No_Demonware", "NoDemonware", "NoDW"), ::gsc_full_offline, ALLOWED, ARGS_0 );

        // Smite's Chat quick command mod
        level register_keyboard_console_command( "Smite_Chat", array("SmiteChat", "SC", "Smite"), ::smite_chat, ALLOWED, ARGS_0, PLAYER_TOGGLE );

        // Set current save state (check Docs/States.md)
        level register_keyboard_console_command( "Practice_State", array("PracticeState", "PS", "Set_State", "SetState", "State"), ::gsc_set_state, CHEAT_PROTECTED, ARGS_1 );
        // Save custom save state
        level register_keyboard_console_command( "Custom_Save_State", array("CustomSaveState", "CSS", "Save_State", "SaveState", "SS", "Save"), ::gsc_save, CHEAT_PROTECTED, ARGS_0 );

        // Change Dvars
        level register_keyboard_console_command( "Dvar", undefined, ::gsc_dvar, CHEAT_PROTECTED, ARGS_2 );
        // Restore changed Dvars
        level register_keyboard_console_command( "Restore_Dvars", array("RestoreDvars", "RD"), ::gsc_restore_dvars, CHEAT_PROTECTED, ARGS_0 );

        // Set game's engine time speed
        level register_keyboard_console_command( "Timescale", array("Time"), ::gsc_timescale, CHEAT_PROTECTED, ARGS_1 );

        // Enable/Disable a HuD Element
        level register_keyboard_console_command( "HuD", undefined, ::gsc_hud, ALLOWED, ARGS_1 );

        // Set the number of Bots for the game
        level register_keyboard_console_command( "Bot", array("bots"), ::gsc_bots, ALLOWED, ARGS_1 );


    // Timing Functionality
        // Enable or Disable RTA timing
        level register_keyboard_console_command( "Toggle_RTA", array("ToggleRTA", "RTA"), ::gsc_rta, ALLOWED, ARGS_0 );
        // Enable or Disable Autosplits
        level register_keyboard_console_command( "Livesplit_Autosplit", array("Toggle_Autosplit", "LivesplitAutosplit", "Autosplits", "Autosplit", "LA"), ::gsc_autosplits, ALLOWED, ARGS_0 );
        // Manually Split
        level register_keyboard_console_command( "Livesplit_Split", array("LivesplitSplit", "Split", "LS"), ::gsc_Livesplit_Split, ALLOWED, ARGS_0 );
        // Manually Unsplit
        level register_keyboard_console_command( "Livesplit_Unsplit", array("LivesplitUnsplit", "Unsplit", "LU"), ::gsc_Livesplit_Unsplit, ALLOWED, ARGS_0 );
        // Enable or Disable Game pause
        level register_keyboard_console_command( "Toggle_Pause", array("TogglePause", "Pause"), ::gsc_pause, ALLOWED, ARGS_0 );

    // Common Binds
        // Quickly restart the game
        level register_keyboard_console_command( "Fast_Restart", array("Fastrestart", "FRestart", "FR", "FastR"), ::gsc_fast_restart, ALLOWED, ARGS_0 );
        // Full map load
        level register_keyboard_console_command( "Map_Restart", array("MapRestart", "MRestart", "MR", "MapR"), ::gsc_map_restart, ALLOWED, ARGS_0 );
        // Switch to a different map
        level register_keyboard_console_command( "Map", undefined, ::gsc_map, ALLOWED, ARGS_1 );
        // Disconnect from the game
        level register_keyboard_console_command( "Disconnect", array("Dc"), ::gsc_disconnect, ALLOWED, ARGS_0 );

    // Player Toggles
        // Enable/Disable using Z axis value when calculating player speed
        level register_keyboard_console_command( "Toggle_Z_Speed_Values", array("ToggleZSpeedValues", "TZSV", "Toggle_Z_Speed", "ToggleZSpeed", "TZS"), ::gsc_toggle_z_speed_values, ALLOWED, ARGS_0, PLAYER_TOGGLE );
        // Toggle Invincibility
        level register_keyboard_console_command( "God", array("Godmode", "invulnerability"), ::gsc_god, CHEAT_PROTECTED, ARGS_0, PLAYER_TOGGLE );
        // Toggle zombies ignoring you
        level register_keyboard_console_command( "No_Target", array("NoTarget", "NT"), ::gsc_no_target, CHEAT_PROTECTED, ARGS_0, PLAYER_TOGGLE );
        // Toggle Free move mode
        level register_keyboard_console_command( "No_Clip", array("NoClip", "NC"), ::gsc_noclip, CHEAT_PROTECTED, ARGS_0, PLAYER_TOGGLE );
        // Toggle infinite Ammo
        level register_keyboard_console_command( "Infinite_Ammo", array("InfiniteAmmo", "IAmmo", "IA", "Ammo", "InfiniteA"), ::gsc_infinite_ammo, CHEAT_PROTECTED, ARGS_0, PLAYER_TOGGLE );
        // Toggle Load/Save position mod or KZ from Counter Strike movement servers
        level register_keyboard_console_command( "KZ", array("Load_Save_Position", "LoadSavePosition", "LSP"), ::gsc_kz, CHEAT_PROTECTED, ARGS_0, PLAYER_TOGGLE );
        // Toggle camera following nades and projectiles
        level register_keyboard_console_command( "Camera", array("Cam"), ::gsc_cam, CHEAT_PROTECTED, ARGS_0, PLAYER_TOGGLE );
        // Toggle Aimbot (currently only zombies)
        level register_keyboard_console_command( "Aimbot", undefined, ::gsc_aimbot, CHEAT_PROTECTED, ARGS_0, PLAYER_TOGGLE );

    // Set
        // Enable Third Person view
        level register_keyboard_console_command( "Third_Person", array("ThirdPerson", "ThirdP", "3p"), ::gsc_Third_Person, CHEAT_PROTECTED, ARGS_0 );
        // Enable First Person view
        level register_keyboard_console_command( "First_Person", array("FirstPerson", "FirstP", "1p"), ::gsc_First_Person, CHEAT_PROTECTED, ARGS_0 );

    // Player Character
        // Change player character
        level register_keyboard_console_command( "Character_Body_Type", array("Character_Type", "Body_Type",
                                                "CharacterBodyType", "CharacterType", "BodyType", "CharBT", "CBT",
                                                "Player_Body_Type", "PlayerBT", "PBT"), ::gsc_character_body_type, CHEAT_PROTECTED, ARGS_1 );
        // Change player body skin
        level register_keyboard_console_command( "Character_Body_Style", array("Character_Style", "Body_Style",
                                                "CharacterBodyStyle", "CharacterStyle", "BodyStyle", "CharBS", "CBS",
                                                "Player_Body_Style", "PlayerBS", "PBS"), ::gsc_character_body_style, CHEAT_PROTECTED, ARGS_1 );
        // Change player head skin
        level register_keyboard_console_command( "Character_Helmet_Style", array("Character_Helmet", "Helmet_Style",
                                                "CharacterHelmetStyle", "CharacterHelmet", "HelmetStyle", "CharHS", "CHS",
                                                "Player_Helmet_Style", "PlayerHS", "PHS"), ::gsc_character_helmet_style, CHEAT_PROTECTED, ARGS_1 );

    // Player Items
        // Toggle a Perk
        level register_keyboard_console_command( "Perk", array("specialty"), ::gsc_perk, CHEAT_PROTECTED, ARGS_1 );
        // Give a weapon
        level register_keyboard_console_command( "Weapon", array("Weap", "Gun"), ::gsc_weapon, CHEAT_PROTECTED, ARGS_1 );
        // Change weapon's camo
        level register_keyboard_console_command( "Weapon_Camo", array("WeaponCamo", "Gun_Camo", "GunCamo", "Camo"), ::gsc_camo, CHEAT_PROTECTED, ARGS_1 );

    // Misc
        // Force to load a Scene
        level register_keyboard_console_command( "Play_Scene", array("PlayScene", "Scene"), ::gsc_play_scene, CHEAT_PROTECTED, ARGS_1 );

    #ifdef dev
        // Function to debug/test
        level register_keyboard_console_command( "Test", array("dev", "t"), ::gsc_test, CHEAT_PROTECTED, ARGS_0 );
    #endif

}


#ifdef dev
// JUST TO TEST THING
function gsc_test( args ){
    self notify( "test" );
    self endon( "test" );

    self IPrintLnBold("Gsc_test");

    foreach(index, craftable in level.zombie_include_craftables ){

        if( isdefined( craftable.name ) )
            level thread debug_message( sprintf("Index {0} | Name {1}", index, craftable.name ) );
        else
            level thread debug_message( sprintf("Index {0} ", index ) );

    }

    return;
    //self IPrintLnBold( self.origin );

    //str_build_zone = "zone_nml_9";
    str_build_zone = undefined;
    if( !is_object_crafted( "equip_dieseldrone" ) ) craft_open_table_object( "equip_dieseldrone", str_build_zone );
    wait 0.5;
    self grab_crafted_item( "equip_dieseldrone" );

    return;

	self phono_egg_init( "phono_one", "phono_one_origin" );
	self phono_egg_init( "phono_two", "phono_two_origin" );
	self phono_egg_init( "phono_three", "phono_three_origin" );

    level.meteor_counter = 0;
	self meteor_egg( "meteor_one" );
	self meteor_egg( "meteor_two" );
	self meteor_egg( "meteor_three" );

    self IPrintLnBold( "Test" );
}

function radio_egg_init( trigger_name, origin_name )
{
    players = getplayers();
    radio_trig = getent( trigger_name, "targetname" );
    radio_origin = getent( origin_name, "targetname" );
    
    if( isdefined( radio_trig ) ){
        self IPrintLnBold( sprintf("Found ^2{0}", trigger_name) );
        self SetOrigin( radio_trig.origin );
    }else{
        self IPrintLnBold( sprintf("Missing ^1{0}", trigger_name) );
        return;
    }

    self waittill ( "weapon_fired" );

    if ( !isdefined( radio_trig ) || !isdefined( radio_origin ) )
    {
        self IPrintLnBold( sprintf("No ^1{0} ^7or ^1", "radio_trig", "radio_origin") );
        return;
    }
    
    radio_trig usetriggerrequirelookat();
    radio_trig setcursorhint( "HINT_NOICON" );
    radio_origin playloopsound( "amb_radio_static" );
    
    for ( i = 0; i < players.size ; i++ )
    {
        radio_trig waittill( "trigger", players );
        self IPrintLnBold( sprintf("^5{0} ^7Triggerd by ^2{1}", i, players.name) );
        radio_origin stoploopsound( 0.1 );
        radio_origin playsound( trigger_name );
    }
}

function meteor_egg(trigger_name)
{
	meteor_trig = getent ( trigger_name, "targetname");
	
	meteor_trig UseTriggerRequireLookAt();
	meteor_trig SetCursorHint( "HINT_NOICON" ); 
	meteor_trig PlayLoopSound( "zmb_meteor_loop" );

    if( isdefined( meteor_trig ) ){
        self IPrintLnBold( sprintf("Found ^2{0}", trigger_name) );
        self SetOrigin( meteor_trig.origin );
    }else{
        self IPrintLnBold( sprintf("Missing ^1{0}", trigger_name) );
        return;
    }

	meteor_trig waittill( "trigger", player );
	
	meteor_trig StopLoopSound( 1 );
	player PlaySound( "zmb_meteor_activate" );
	

	level.meteor_counter = level.meteor_counter + 1;
	
	if( level.meteor_counter == 3 )
	{ 
	    level thread play_music_easter_egg( player );
	}
}

function play_music_easter_egg( player ){

    level thread debug_message( sprintf("Last meteor activated by ^5{0}", player.name) );

    level notify( #"hash_a1b1dadb" );
}

function phono_egg_init( trigger_name, origin_name )
{
    if ( !isdefined( level.phono_counter ) )
    {
        level.phono_counter = 0;
    }
    
    players = getplayers();
    phono_trig = getent( trigger_name, "targetname" );
    if( isdefined( phono_trig ) ){
        self IPrintLnBold( sprintf("Found ^2{0}", trigger_name) );
        self SetOrigin( phono_trig.origin );
    }else{
        self IPrintLnBold( sprintf("Missing ^1{0}", trigger_name) );
        return;
    }

    self waittill ( "weapon_fired" );

    phono_origin = getent( origin_name, "targetname" );
    
    if ( !isdefined( phono_trig ) || !isdefined( phono_origin ) )
    {
        self IPrintLnBold( sprintf("No ^1{0} ^7or ^1", "phono_trig", "phono_origin") );
        return;
    }
    
    phono_trig usetriggerrequirelookat();
    phono_trig setcursorhint( "HINT_NOICON" );
    
    for ( i = 0; i < players.size ; i++ )
    {
        phono_trig waittill( "trigger", players );
        self IPrintLnBold( sprintf("^5{0} ^7Triggerd by ^2{1}", i, players.name) );
        level.phono_counter += 1;
        phono_origin play_phono_egg();
    }
}

function play_phono_egg()
{
    if ( !isdefined( level.phono_counter ) )
    {
        level.phono_counter = 0;
    }
    
    if ( level.phono_counter == 1 )
    {
        self playsound( "evt_phono_one" );
        level thread debug_message_instant( sprintf("Playing sound ^2", "evt_phono_one") );
    }
    
    if ( level.phono_counter == 2 )
    {
        self playsound( "evt_phono_two" );
        level thread debug_message_instant( sprintf("Playing sound ^2", "evt_phono_two") );
    }
    
    if ( level.phono_counter == 3 )
    {
        self playsound( "evt_phono_three" );
        level thread debug_message_instant( sprintf("Playing sound ^2", "evt_phono_three") );
    }
}

#endif


#region General Game Settings

// TOGGLE PRACTICE MODE
function gsc_practice( args ){

    setDvar( DVAR_PRACTICE, !getDvarInt( DVAR_PRACTICE ) );

    if( GetDvarInt(DVAR_PRACTICE) ) level thread DisplayFeedMessage( "Practice mode ^2Enabled" );
    else level thread DisplayFeedMessage( "Practice mode ^1Disabled" );
}

// Full offline
function gsc_full_offline( args ){

    // Only available to toggle while offline to avoid being kicked from the game
    if( IS_ONLINE ){
        self IPrintLnBold("You must be ^5Offline ^7to toggle ^6Full Offline");
        return;
    }

    setDvar( DVAR_NODW, !getDvarInt( DVAR_NODW ) );
    setDvar( DVAR_LIVE_USEUNO, !getDvarInt( DVAR_NODW ) );
    setDvar( DVAR_LIVE_USEUMBRELLA, !getDvarInt( DVAR_NODW ) );

    if( GetDvarInt(DVAR_NODW) ) level thread DisplayFeedMessage( "Full Offline ^2Enabled" );
    else level thread DisplayFeedMessage( "Full Offline ^1Disabled" );
}


// SET A PRACTICE STATE
function gsc_set_state( args ){

    practice_name = args[ 0 ];

    // TODO: Maybe make it a function so it can be easily reused for other functions?
    // Names to check if we want to disable state
    switch( practice_name ){
        // Disable values
        case "":
        case "0":
        case "false":
        case "disable":
        case "deactivate":
        case "stop":
        case "none":
        case "nan":
        case "no":
        case "default":
        case "reset":
        case "restart":
        case "normal":
        {
            // Already disabled
            if( GetDvarString( DVAR_PRACTICE_STATE ) == "" ){
                self iPrintLnBold("^2Practice ^5State ^2is already ^1disabled^2!");
                return;
            }

            // Disabling
            level thread DisplayFeedMessage( "Practice state ^1Disabled" );
            //self iPrintLnBold("^2Practice ^5State ^1disabled^2!");
            setDvar( DVAR_PRACTICE_STATE, "");
            return;
        }

    }

    #ifdef dev
        //foreach(index, str_name in GetArrayKeys( level.practice_modes )) self IPrintLnBold("^8"+index+" ^7=> ^5"+str_name);
    #endif

    // Undefined state
    if( !isdefined( level.practice_modes[ practice_name ] ) ){ // Practice state doesn't exist
        self iPrintLnBold( "^1Error^7, can't find ^5"+practice_name+"^7 Practice State, resetting state..." );
        setDvar( DVAR_PRACTICE_STATE, "");
        return;        
    }

    // Invalid state
    if( !IsFunctionPtr( level.practice_modes[ practice_name ] ) ){
        self iPrintLnBold( "^1Error^7, no funcPtr found" );
        setDvar( DVAR_PRACTICE_STATE, "");
        return;
    }

    // State already selected
    if( getdvarstring(DVAR_PRACTICE_STATE) == practice_name ){
        self iPrintLnBold( "State ^5"+practice_name+" ^7already selected!" );
        return;
    }

    setDvar( DVAR_PRACTICE_STATE, practice_name);
    level thread DisplayFeedMessage(sprintf("State set to ^6{0}", basic_parser( practice_name ) ) );
    //level [[ level.practice_modes[ practice_name ] ]]();
}


// Gets and Sets dvar values
function gsc_dvar( args ){

    str_dvar = args[ 0 ];

    // We only want to check a Dvar value, that's ok
    if( args.size == 1 ){
        current_val = getdvarstring( str_dvar );
        self IPrintLnBold( sprintf("Dvar '^5{0}^7' Value '^6{1}'", str_dvar, current_val ) );
        return;
    }

    // Value we want to change the Dvar to
    new_val = args[ 1 ];

    // No need to save or track client dvars since they are reset at the beginning of each game
    if( is_client_dvar( str_dvar ) ){
        self gsc_client_dvar( str_dvar, new_val );
        return;
    }

    // Don't allow changing Surtr Dvars
    if( IsInArray(SURTR_DVARS, ToLower( str_dvar ) ) ){
        self IPrintLnBold( sprintf("^1Error, you are NOT allowed to change Surtr Dvars... ^5{0}", str_dvar ) );
        return;
    }

    // Don't allow changing Setting Dvars
    if( IsInArray(GAME_SETTINGS_DVARS, ToLower( str_dvar ) ) ){
        self IPrintLnBold( sprintf("^1Please, change setting dvars from game menu... ^5{0}", str_dvar ) );
        return;
    }

    // Don't allow changing Game Dvars
    if( IsInArray(GAME_DVARS, ToLower( str_dvar ) ) ){
        self IPrintLnBold( sprintf("^1Basic game Dvars are not allowed to be changed... ^5{0}", str_dvar ) );
        return;
    }

    current_val = getdvarstring( str_dvar );

    // world.surtr_dvars is created at load_full_cfg();
    if( !isdefined( world.surtr_dvars[ ToLower( str_dvar ) ] ) ) world.surtr_dvars[ ToLower( str_dvar ) ] = current_val;

    new_val = args[ 1 ];
    setdvar( str_dvar, new_val );
    
    // Some Dvars have a limited list of possible values that may not be from 0 to N, recheck the new value after trying to change the Dvar
    new_val = getdvarstring( str_dvar );

    self IPrintLnBold( sprintf("Dvar '^5{0}^7' From '^6{1}^7' to '^2{2}'", str_dvar, current_val, new_val ) );
}

function gsc_client_dvar( str_dvar, new_val ){

    #ifdef dev
        self IPrintLnBold( sprintf("Script DVAR ^5{0} ^7trying value ^2{1}", str_dvar, new_val ) );
    #endif

    switch( ToLower( str_dvar ) ){

        case DVAR_CG_OBJECTIVETEXT:
        {
            self SetClientCGObjectiveText( new_val );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, new_val) );
            return;
        }
        case DVAR_COMPASS:
        {
            if( !StrIsNumber( new_val ) ){
                self IPrintLnBold( sprintf("^5{0} ^7needs a number! ^1{1}", str_dvar, new_val) );
                return;
            }

            self SetClientCompass( int( new_val ) );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, int( new_val )) );
            return;
        }
        case DVAR_CG_DRAWTALK:
        {
            if( !StrIsNumber( new_val ) ){
                self IPrintLnBold( sprintf("^5{0} ^7needs a number! ^1{1}", str_dvar, new_val) );
                return;
            }

            self SetClientDrawTalk( int( new_val ) );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, int( new_val )) );
            return;
        }
        case DVAR_CG_FOCALLENGTH:
        {
            if( !StrIsNumber( new_val ) ){
                self IPrintLnBold( sprintf("^5{0} ^7needs a number! ^1{1}", str_dvar, new_val) );
                return;
            }

            self SetClientFocalLength( Float( new_val ) );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, Float( new_val )) );
            return;
        }
        case DVAR_UI_HUD_HARDCORE:
        {
            if( !StrIsNumber( new_val ) ){
                self IPrintLnBold( sprintf("^5{0} ^7needs a number! ^1{1}", str_dvar, new_val) );
                return;
            }

            self SetClientHUDHardcore( Int( new_val ) );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, Int( new_val )) );
            return;
        }
        case DVAR_MINISCOREBOARDHIDE:
        {
            if( !StrIsNumber( new_val ) ){
                self IPrintLnBold( sprintf("^5{0} ^7needs a number! ^1{1}", str_dvar, new_val) );
                return;
            }

            self SetClientMiniScoreboardHide( Int( new_val ) );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, Int( new_val )) );
            return;
        }
        case DVAR_SCR_NUMLIVES:
        {
            if( !StrIsNumber( new_val ) ){
                self IPrintLnBold( sprintf("^5{0} ^7needs a number! ^1{1}", str_dvar, new_val) );
                return;
            }

            self SetClientNumLives( Int( new_val ) );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, Int( new_val )) );
            return;
        }
        case DVAR_PLAYERPUSHAMOUNT:
        {
            if( !StrIsNumber( new_val ) ){
                self IPrintLnBold( sprintf("^5{0} ^7needs a number! ^1{1}", str_dvar, new_val) );
                return;
            }

            self SetClientPlayerPushAmount( Int( new_val ) );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, Int( new_val )) );
            return;
        }
        case DVAR_PLAYER_SPRINTTIME:
        {
            if( !StrIsNumber( new_val ) ){
                self IPrintLnBold( sprintf("^5{0} ^7needs a number! ^1{1}", str_dvar, new_val) );
                return;
            }

            self SetClientPlayerSprintTime( Int( new_val ) );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, Int( new_val )) );
            return;
        }
        case DVAR_G_SCRIPTMAINMENU:
        {
            if( !is_game_menu( new_val ) ){
                self IPrintLnBold( sprintf("^5{0} ^7needs a valid menu... ^1{1}", str_dvar, new_val ) );
                return;
            }

            // TODO: Add a list of valid menus and a menu parser
            self SetClientScriptMainMenu( new_val );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, new_val ) );
            return;
        }
        case DVAR_CG_THIRDPERSON:
        {
            if( !StrIsNumber( new_val ) ){
                self IPrintLnBold( sprintf("^5{0} ^7needs a number! ^1{1}", str_dvar, new_val) );
                return;
            }

            self SetClientThirdPerson( Int( new_val ) );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, Int( new_val )) );
            return;
        }
        case DVAR_CG_THIRDPERSONANGLE:
        {
            if( !StrIsNumber( new_val ) ){
                self IPrintLnBold( sprintf("^5{0} ^7needs a number! ^1{1}", str_dvar, new_val) );
                return;
            }

            self SetClientThirdPersonAngle( Float( new_val ) );
            self IPrintLnBold( sprintf("^5{0} ^7set to ^2{1}", str_dvar, Float( new_val )) );
            return;
        }
    }

    self IPrintLnBold("^1Error, bad client Dvar...");
}

function is_client_dvar( str_dvar ){
    
    return IsInArray(CLIENT_DVARS, tolower(str_dvar));
}

function is_game_menu( str_menu ){

    return IsInArray(GAME_MENUS, str_menu);
}



function is_any_dvar_changed(){

    // Loop through all changed Dvars
    foreach( str_dvar, initial_value in world.surtr_dvars ){
        // Check if the value is NOT the initial one
        if( GetDvarString(str_dvar) != initial_value ) return true;
    }

    return false;
}

function gsc_restore_dvars( args ){

    if( !is_any_dvar_changed() ){
        self IPrintLnBold("^2All Dvars already have their initial values!");
        return;
    }

    if( is_true( level.restoring_dvars ) ){
        self IPrintLnBold("^1Dvars are already being restored!");
        return;
    }

    level.restoring_dvars = true;

    foreach( str_dvar, initial_value in world.surtr_dvars ){
        if( GetDvarString(str_dvar) == initial_value ) continue;
        SetDvar(str_dvar, initial_value);
        self IPrintLnBold( sprintf("Restored ^5{0} ^7=> ^2{1}", str_dvar, initial_value) );
        wait 1;
    }

    level.restoring_dvars = undefined;
}


// Timescale
function gsc_timescale( args ){

    new_val = args[0];

    // Invalid input
    if( !StrIsNumber( new_val ) ){
        self iPrintLnBold( sprintf("^1Error, ^5Timescale ^1must be a number ^6{0}", new_val) );
        return;
    }

    // Get the value
    new_val = Float( new_val );

    // Invalid value
    if( new_val <= 0 ){
        self iPrintLnBold( sprintf("^1Error, ^5Timescale value ^1must be greater than 0 ^6{0}", new_val) );
        return;
    }

    current = getDvarFloat( DVAR_TIMESCALE );

    // Already desired value
    if( new_val == current ){
        self iPrintLnBold( sprintf("^5Timescale ^7 is already ^6{0}", new_val) );
        return;
    }

    setdvar( DVAR_TIMESCALE, new_val );
    self iPrintLnBold( sprintf("^5Timescale ^7changed to ^6{0}", getDvarFloat( DVAR_TIMESCALE )) );
}

// Spawn bot
function gsc_bots( args ){

    n_bots = get_n_bots();

    // no arg means we just want to know the n of bots currently on the game
    if( args.size < 1 ){

        if( !n_bots ){
            self IPrintLnBold("There are ^1no^7 bots in the game" );
        }else if( n_bots == 1 ){
            self IPrintLnBold("There is^5 1^7 bot in the game" );
        }else{
            self IPrintLnBold( sprintf("There are ^5{0}^7 bots in the game", n_bots) );
        }
        return;
    }

    n_add_bots = args[ 0 ];

    // Invalid
    if( !StrIsInt( n_add_bots ) ){
        self IPrintLnBold( sprintf("^1Invalid Bots amount ^5{0}", n_add_bots) );
        return;
    }

    n_add_bots = int( n_add_bots );

    // No need to do anything
    if( n_add_bots == n_bots ){

        if( !n_bots ){
            self IPrintLnBold("There are already ^1no^7 bots in the game" );
        }else if( n_bots == 1 ){
            self IPrintLnBold("There is already^5 1^7 bot in the game" );
        }else{
            self IPrintLnBold( sprintf("There are already ^5{0}^7 bots in the game", n_bots) );
        }
        return;
    }

    n_players = get_n_players();

    n_clients = n_players +n_bots;
    n_max_clients = GetDvarInt("com_maxclients");
    if( n_players+n_add_bots > n_max_clients ){
        self IPrintLnBold( sprintf("^1Invalid Bots to add amount ^1{0}^7, max is ^2{1}", n_add_bots, n_max_clients-n_players) );
        return;        
    }


    // if players + bots are greater than 4 game is ended due to level.player_too_many_players_chec and level.player_too_many_players_check_func
    if( n_add_bots > n_bots ){

        n_total = get_n_players() + n_add_bots;
        b_over_limit = n_total > 4;

        n_new_max_clients = n_players + n_add_bots;

        if( IS_ZOMBIES ){
            max_bots = 4;
        }else{
            max_bots = 18;
        }

        b_over_limit = n_new_max_clients > max_bots;

        if( b_over_limit ){
            self IPrintLnBold("b_over_limit^6 "+n_total);
            /*level.player_too_many_players_chec = undefined;
            level.player_too_many_players_check_func = undefined;
            if( n_total > cur_max_clients){
                SetDvar("com_maxclients", n_total);
                #ifdef dev
                    self IPrintLnBold( sprintf("^5com_maxclients ^2{0}", GetDvarInt("com_maxclients") ) );
                #endif
            }*/
        }else{
            self IPrintLnBold("^1NO b_over_limit");
        }

        for(i=n_bots; i<n_add_bots; i++){

            bot = addtestclient();
            if( !isdefined( bot ) ){
                level thread debug_message("^1Error, couldn't create bot N ^5"+i);
                continue;
            }

            if( !isdefined( bot.pers ) ){
                self IPrintLnBold("Creating bot.pers");
                bot.pers = [];
            }

            // From zm::zbot_spawn()
            bot.pers["isBot"] = 1;
            bot.equipment_enabled = 0;
            
            // From devgui_bot_spawn::devgui_bot_spawn()
            bot.team = self.team;
            if( isdefined( bot.team ) ){
                bot.pers["team"] = bot.team;
                self IPrintLnBold("bot.team ^2"+bot.team);
            }
            bot._player_entnum = bot getentitynumber();
            if( isdefined( bot._player_entnum ) ){
                self IPrintLnBold("bot._player_entnum ^2"+bot._player_entnum);
            }

            // From bot::add_bot()
            if( isdefined( self.pers["class"] ) ){
                self IPrintLnBold("self.pers[class] ^2"+self.pers["class"]);
                bot.pers["class"] = self.pers["class"];
            }

            if( isdefined( self.curclass ) ){
                self IPrintLnBold("self.curclass ^2"+self.curclass);
                bot.curclass = self.curclass;
            }

            //bot.pers["class"] = level.defaultclass;
		    //bot.curclass = level.defaultclass;


            //bot.pers["team"] = team;


            // Check if they can be insta spawned
            if( !isdefined( level.spawnPlayer ) ){
                level thread debug_message_instant("^1missing ^5level.spawnPlayer ^1to spawn bots...");
                continue;
            }

            bot [[level.spawnPlayer]]();
            self IPrintLnBold("Bot spawned?");
        }

        // From zm::add_bots()
        setdvar("bot_AllowMovement", "1");
	    setdvar("bot_PressAttackBtn", "1");
	    setdvar("bot_PressMeleeBtn", "1");
        level.numberbotsadded = true;

    }else{

        for(i=n_bots; i>n_add_bots; i--){

            foreach(player in GetPlayers() ){
                if( !player IsTestClient() ) continue;

                if( isdefined( level.onbotremove ) ){
                    #ifdef dev
                        level thread debug_message("onbotremove");
                    #endif
                    bot [[level.onbotremove]]();
                }

	            bot botdropclient();
                //bot notify("disconnect");
                //kick(bot getentitynumber());
                //break;
            }
        }

        if( get_n_bots() == 0 ){

            #ifdef dev
                level thread debug_message("^1Disabled Bot Dvars");
            #endif

            setdvar("bot_AllowMovement", "0");
            setdvar("bot_PressAttackBtn", "0");
            setdvar("bot_PressMeleeBtn", "0");
            level.numberbotsadded = false;            
        }


    }

}


#endregion


#region Timing Functionality
// Toggle RTA
function gsc_rta( args ){

    setDvar( DVAR_RTA, !getDvarInt( DVAR_RTA ) );

    if( GetDvarInt(DVAR_RTA) ) level thread DisplayFeedMessage( "RTA ^2Enabled" );
    else level thread DisplayFeedMessage( "RTA ^1Disabled" );

    refresh_pausable_huds();
}

// Toggle Autosplits
function gsc_autosplits( args ){

    setDvar( DVAR_AUTOSPLITS, !getDvarInt( DVAR_AUTOSPLITS ) );

    if( GetDvarInt(DVAR_AUTOSPLITS) ) level thread DisplayFeedMessage( "Autosplits ^2Enabled" );
    else level thread DisplayFeedMessage( "Autosplits ^1Disabled" );
}

// Manual Split
function gsc_Livesplit_Split( args ){

    // Don't allow manual splits while autosplits are active
    if( isdefined( level.autosplits ) ){
        self IPrintLnBold("^1Can't do ^5Manual Splits^1 while ^6Autosplits ^1is active...");
        return;
    }

    // Game has started check
    if( !has_game_started() ){
        self IPrintLnBold("^1Can't do ^5Manual Splits^1 before game starts");
        return;
    }

    a_str_huds = ArrayCombine(world.global_huds[ ALL_MAPS ], world.global_huds[ MAP_NAME ], false, false);
    /*  Why do we start from the end?
        A split may have happened already and a player can add a new split that should have happened earlier. if that's the case, we ignore it
        by finding the latest split that has been split
    */

    // Find latest split hud
    for(i = a_str_huds.size-1; i > 0; i--){

        s_hud = get_hud_by_name( a_str_huds[ i ] );
        
        // We only want EE splits
        if( !is_hud_ee_split( s_hud ) ) continue;

        // This split is not active
        if( !is_hud_created( s_hud ) ) continue;

        // This split is not split
        if( !is_hud_splitted( s_hud ) ) continue;

        // We found the latest split!
        break;
    }

    // Maybe there are no HuDs active
    if( isdefined( i ) ) n_latest_split = i;
    else n_latest_split = 0;

    #ifdef dev
        //level thread debug_message("Latest splitted hud is: ^2"+a_str_huds[ i ]);
    #endif

    // Find earliest non split hud
    for(i = n_latest_split+1; i < a_str_huds.size; i++){
        s_hud = get_hud_by_name( a_str_huds[ i ] );
        
        // We only want EE splits
        if( !is_hud_ee_split( s_hud ) ) continue;

        // This split is not active
        if( !is_hud_created( s_hud ) ) continue;

        // This shouldn't happen?
        if( is_hud_splitted( s_hud ) ){
            level thread debug_message("^1Error, splitted hud after searching for non splitted hud?");
            return;
        }

        // We found the latest split! now set split data
        s_hud.HudElemTime_manual = GetTime() - level.n_gameplay_start_time;
        s_hud.HudElemTime_pause_manual = GetTotalServerPauseTime();
        // Substract paused time before game start
        if( isdefined( level.wait_time_before_game_start ) ) s_hud.HudElemTime_pause_manual -= level.wait_time_before_game_start;

        // Now we can set the hud as split!
        s_hud.splitted = true;
        s_hud._hud notify( "splitted" );

        #ifdef dev
            //level thread debug_message("Manually splitting hud: ^2"+a_str_huds[ i ]);
        #endif

        // We found the latest split!
        return;
    }

    self IPrintLnBold("^1There isn't any HUD to ^5Split^1...");
}

// Manual Split
function gsc_Livesplit_Unsplit( args ){

    // Don't allow manual splits while autosplits are active
    if( isdefined( level.autosplits ) ){
        self IPrintLnBold("^1Can't do ^5Manual Unsplits^1 while ^6Autosplits ^1is active...");
        return;
    }

    // Game has started check
    if( !has_game_started() ){
        self IPrintLnBold("^1Can't do ^5Manual Unsplits^1 before game starts");
        return;
    }

    a_str_huds = ArrayCombine(world.global_huds[ ALL_MAPS ], world.global_huds[ MAP_NAME ], false, false);
    /*  Why do we start from the end?
        A split may have happened already and a player can add a new split that should have happened earlier. if that's the case, we ignore it
        by finding the latest split that has been split
    */

    // Find latest split hud
    for(i = a_str_huds.size-1; i > 0; i--){

        s_hud = get_hud_by_name( a_str_huds[ i ] );
        
        // We only want EE splits
        if( !is_hud_ee_split( s_hud ) ) continue;

        // This split is not active
        if( !is_hud_created( s_hud ) ) continue;

        // This split is not split
        if( !is_hud_splitted( s_hud ) ) continue;

        // We found the latest split!
        break;
    }

    // Maybe there are no HuDs active
    if( i < 0 ) n_latest_split = 0;
    else n_latest_split = i;

    #ifdef dev
        //level thread debug_message("Latest splitted hud is: ^2"+a_str_huds[ i ]);
    #endif

    // Find earliest non split hud
    for(i = n_latest_split; i < a_str_huds.size; i++){
        
        s_hud = get_hud_by_name( a_str_huds[ i ] );
        
        // We only want EE splits
        if( !is_hud_ee_split( s_hud ) ) continue;

        // This split is not active
        if( !is_hud_created( s_hud ) ) continue;

        // There is no split hud yet...
        if( !is_hud_splitted( s_hud ) ) return;
  

        // We found the latest split!
        // Set split data
        s_hud.HudElemTime_manual = undefined;
        s_hud.HudElemTime_pause_manual = undefined;

        // Set the hud as non split
        s_hud.splitted = false;

        // Wait again for the hud to be set
        s_hud._hud thread [[ s_hud.update_function ]]();

        #ifdef dev
            //level thread debug_message("Manually unsplitting hud: ^2"+a_str_huds[ i ]);
        #endif

        // We found the latest split!
        return;
    }

    self IPrintLnBold("^1There isn't any HUD to ^5Unsplit^1...");
}

// Toggle pause
function gsc_pause( args ){

    setDvar( DVAR_COM_PAUSESUPPORTED, !getDvarInt( DVAR_COM_PAUSESUPPORTED ) );

    if( GetDvarInt(DVAR_COM_PAUSESUPPORTED) ) level thread DisplayFeedMessage( "Pause ^2Enabled" );
    else level thread DisplayFeedMessage( "Pause ^1Disabled" );
}
#endregion


#region Common Binds

// Fast restart
function gsc_fast_restart( args = undefined ){

    Map_restart();
}

// Map restart
function gsc_map_restart( args = undefined ){

    Map( MAP_NAME );
}

// Change to desired map
function gsc_map( args = undefined ){

    // Check there is a map to do the change
    if( args.size < 1){
        self IPrintLnBold("^1Missing ^5Map name to change");
        return;
    }

    str_map = args[0];
    map = get_map_name( str_map );

    if( !isdefined( map ) ){
        self IPrintLnBold( sprintf("^1Can't find map: ^5", str_map) );
        return;
    }

    map( map );
}

// Disconnect
function gsc_disconnect( args ){

    if( self IsHost() ){
        level thread debug_message( sprintf("Exiting game in 1s.", self.name) );
        wait 1;
        ExitLevel();
    }else{
        level thread debug_message( sprintf("Player ^8{0} ^7disconnected.", self.name) );
        kick( self getentitynumber(), "Kicked from Surtr game" );
    }

}

#endregion


#region Player Toggles

// Enable/Disable Z axis for Speed HUD calculations
function gsc_toggle_z_speed_values( args ){

    if( isdefined( self.toggle_z_speed_values ) ){
        self.toggle_z_speed_values = undefined;
        self IPrintLnBold("^1Untoggling Z Speed Values ^7for ^5Speed HUDs");
        return;
    }

    self.toggle_z_speed_values = true;
    self IPrintLnBold("^2Toggling Z Speed Values ^7for ^5Speed HUDs");
}

function player_counts_z_value(){

    return isdefined( self.toggle_z_speed_values );
}

// God
function gsc_god( args = undefined ){

    if( is_true(self.god_lui) ){ // if it's already activated, we have to disable it

        self disableInvulnerability();

        self.god_lui = undefined;
        self iPrintLnBold("^5God ^1deactivated");
        self notify( "god_lui" );
        return;
    }

    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "god_lui" );


    self iPrintLnBold("^5God ^2activated");
    //self notify("stop_player_out_of_playable_area_monitor");
    self.god_lui = true;

    for(;;){
        wait 0.05;
        self enableInvulnerability();
        self.health = self.maxhealth;
    }

}

// No_Target
function gsc_no_target( args = undefined ){

    if( is_true(self.no_target_lui) ){ // if it's already activated, we have to disable it

        self.ignoreme = false;

        self.no_target_lui = undefined;
        self iPrintLnBold("^5No Target ^1deactivated");
        self notify( "no_target_lui" );
        return;
    }

    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "no_target_lui" );

    self.no_target_lui = true;
    self iPrintLnBold("^5No Target ^2activated");

    for(;;){
        wait 1;
        self.ignoreme = true;
    }


}

// Noclip
function gsc_noclip( args = undefined ){

    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "noclip_lui" );

    if( is_true(self.noclip_lui) ){ // if it's already activated, we have to disable it

        if( isdefined( self.clip ) ){
            self.clip unlink();
            self.clip delete();
        }

        self show();
        self enableWeapons();
        self enableOffHandWeapons();
        self.noclip = false;

        self.noclip_lui = undefined;
        self iPrintLnBold("^5Noclip ^1deactivated");
        self notify( "noclip_lui" );
        return;
    }

    //self notify("stop_player_out_of_playable_area_monitor");
    self.noclip_lui = true;
    self.noclip = false;

    noclip_bind = undefined;

    if( isdefined( self.binds ) ){
        foreach( key in getArrayKeys( self.binds) ){
            if( self.binds[ key ]  == "noclip" ){
                noclip_bind = key;
                break;
            }
        }        
    }

    self iPrintLnBold("^5Noclip ^2activated");


    for(;;){
        wait 0.1;

        if( self has_special_menu_open() ){
            //self iPrintLnBold("ignoring noclip");
            wait 0.2;
            continue;
        }

        if( self adsButtonPressed() && self meleeButtonPressed() )
            {
                //self iPrintLnBold("^5Noclip ^2activated");
                self disableWeapons();
                self disableOffHandWeapons();
                self.clip = spawn("script_model", self.origin);
                self playerLinkTo(self.clip);
                self Hide();
                self.noclip = true;
                
                // TODO: add a helping controls text
                //self.noclip_buttons fadeOverTime(1);
                //self.noclip_buttons.alpha = 1;

                while( self adsButtonPressed() && self meleeButtonPressed() ) wait 0.05;
                for(;;)
                {
                    wait .05;

                    if( self has_special_menu_open() ){
                        //self iPrintLnBold("ignoring noclip");
                        wait 0.2;
                        continue;
                    }
                    
                    vec = anglesToForward(self getPlayerAngles());

                    if(self SprintButtonPressed())
                        end = ( (vec[0] * 60)/2, (vec[1] * 60)/2, (vec[2] * 60)/2);
                    else
                        end = (vec[0] * 60, vec[1] * 60, vec[2] * 60);

                    if( self attackButtonPressed() )
                        self.clip.origin = self.clip.origin + end;

                    if( self adsButtonPressed() )
                        self.clip.origin = self.clip.origin - end;

                    if( self adsButtonPressed() && self meleeButtonPressed() )
                        break;
                }

                self.clip unlink();
                self.clip delete();
                self show();
                self enableWeapons();
                self enableOffHandWeapons();
                //self iPrintLnBold("^5Noclip ^1deactivated");
                self.noclip = false;
                //self.noclip_buttons fadeOverTime(1);
                //self.noclip_buttons.alpha = 0;

                while( self adsButtonPressed() && self meleeButtonPressed() ) wait 0.05;
            }
            wait .05;
    }


    self disableWeapons();
    self disableOffHandWeapons();
    self.clip = spawn("script_model", self.origin);
    self playerLinkTo(self.clip);
    self Hide();
    self.noclip = true;
    //self.noclip_buttons fadeOverTime(1);
    //self.noclip_buttons.alpha = 1;
}

// Infinite Ammo
function gsc_infinite_ammo( args = undefined ) {

    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "ammo_lui" );

    if( is_true(self.ammo_lui) ){ // if it's already activated, we have to disable it

        self.ammo_lui = undefined;
        self iPrintLnBold("^5Ammo ^1deactivated");
        self notify( "ammo_lui" );
        return;
    }

    self.ammo_lui = true;
    self iPrintLnBold("^5Ammo ^2activated");

    for(;;)
    {
        w_current  = self GetCurrentWeapon();
        w_offhand = self GetCurrentOffhand();
        if( !( !isdefined( w_current ) || w_current === level.weaponNone || !isdefined(w_current.clipSize) || w_current.clipSize < 1) )
        {
            self SetWeaponAmmoClip(w_current, 1337);
            self givemaxammo(w_current);
        }

        self gadgetpowerset(2, 100);
        self gadgetpowerset(1, 100);
        self gadgetpowerset(0, 100);

        if(isdefined(w_offhand) && w_offhand !== level.weaponNone){

            //self IPrintLnBold( sprintf("Offhand Weapon: ^6{0}", w_offhand.displayname) );
            self givemaxammo(w_offhand);
        }
        self util::waittill_any("weapon_fired", "grenade_fire", "missile_fire", "weapon_change", "melee");
        wait 0.05;
    }
}

// KZ | I keep this name because that's how movement maps are called in Counter-Strike
function gsc_kz( args = undefined ){

    if( is_true( self.kz_lui ) ){ // if it's already activated, we have to disable it

        self.kzOrigin = undefined;
        self.kzAngles = undefined;
        self.kzStance = undefined;
        self.kzWeapon = undefined;
        self.kzName = undefined;

        self.kz_lui = undefined;
        self iPrintLnBold("^5KZ ^1deactivated");
        self notify( "kz_lui" );
        return;
    }

    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "kz_lui" );

    self.kzOrigin = undefined;
    self.kzAngles = undefined;
    self.kzStance = undefined;
    self.kzWeapon = undefined;
    self.kzName = undefined;
    self.kzSpeed = undefined;

    self iPrintLnBold("^5KZ ^2activated");
    self.kz_lui = true;

    for(;;){
        wait 0.05;

        if(self adsButtonPressed() && self FragButtonPressed()){
            self.kzOrigin   = self getOrigin();
            self.kzAngles   = self getPlayerAngles();
            self.kzStance   = self getStance();
            self.kzWeapon   = self getCurrentWeapon();
            //self.kzName     = self.zone_name;
            self.kzName     = basic_parser( self.zone_name );
            self.kzSpeed    = self getVelocity();

            if( isdefined( self.kzName ) && self.kzName != "")  self iPrintLnBold("^2Saved position at ^5"+self.kzName+" ^2!");
            else self iPrintLnBold("^2Saved position!");

            while(self adsButtonPressed() && self FragButtonPressed()) wait 0.05;
        }
        else if(self adsButtonPressed() && self useButtonPressed()){
            if( !isdefined( self.kzOrigin ) ){
                self iPrintLnBold("^1Save a position first...");
                while(self adsButtonPressed() && self useButtonPressed()) wait 0.05;
                continue;
            }

            self setOrigin( self.kzOrigin);
            self setPlayerAngles( self.kzAngles);
            self setStance( self.kzStance);
            if(self hasWeapon( self.kzWeapon ) ) self SwitchToWeaponImmediate( self.kzWeapon );

            if( isdefined( self.kzName ) && self.kzName != "")  self iPrintLnBold("^2Loaded position at ^5"+self.kzName+" ^2!");
            else self iPrintLnBold("^2Loaded position!");

            self setVelocity( self.kzSpeed );

            while(self adsButtonPressed() && self useButtonPressed()) wait 0.05;
        }

	}

}

// CAM to follow projectiles
function gsc_cam( args ){

    if( !isDefined( args ) ){
        self IPrintLnBold("^1Error, missing args in ^5gsc_cam" );
        return; // it's for another player
    }

    if( is_true( self.cam_lui ) ){ // if it's already activated, we have to disable it

        if( isDefined( self.camera ) ){
            self freezeControls(0);
            self CameraActivate(0);
            self.camera delete();
        }
        self.can_activate_cam = undefined;
        self.cam_lui = undefined;

        self iPrintLnBold("^5Cam ^1deactivated");
        self notify( "cam_lui" );
        return;
    }

    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "cam_lui" );

    self.cam_lui = true;
    self iPrintLnBold("^5Cam ^2activated");

    self.can_activate_cam = true;
    self thread nade_monitor();
    self thread missile_monitor();

}

function nade_monitor(){

    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "cam_lui" );

    for(;;){
        wait 0.1;
        self waittill( "grenade_fire", grenade/*, weapName*/ );
        
        if( is_true( !self.can_activate_cam ) ) continue;
        if( self has_special_menu_open() ) continue;
        //if( non_desired_weapons(weapName) ) continue;
        if( self meleeButtonPressed() ) continue;

        #ifdef dev
            if( isdefined( grenade.targetname ) ) self iPrintLnBold( sprintf("Targetname {0}", grenade.targetname) );
            if( isdefined( grenade.classname ) ) self iPrintLnBold( sprintf("Classname {0}", grenade.classname) );

            if( IsWeapon( grenade.weapon ) ){
                level thread debug_message_instant( "ENT.WEAPON is weapon "+MakeLocalizedString( grenade.weapon.displayname )+" | "+grenade.weapon.name );
            }
            
            if( isdefined( grenade.weapon ) && IsWeapon( grenade.weapon ) ) self iPrintLnBold( sprintf("grenade.weapon is weapon {0} | {1}",MakeLocalizedString( grenade.weapon.displayname ),  grenade.weapon.name ) );
        #endif
        
        self.can_activate_cam = false;

        self.camera = spawn("script_model", grenade.origin );
	    self.camera SetModel("tag_origin");
		self.camera.angles = self.angles;

        //camera linkTo(grenade);
        self freezeControls(1);
        self CameraSetPosition( self.camera );
        self CameraSetLookAt( grenade );
        self CameraActivate(1);
        
        while( isDefined(grenade) && !self meleeButtonPressed() && is_true( self.cam_lui ) )
        {
            wait 0.05;
            dist = Abs( distance(grenade.origin , self.camera.origin) );

            if( dist > 150 ){
                pos = (grenade.origin + self.camera.origin)/2;
                self.camera moveTo(pos, 0.25);
            }

        }

        wait 0.5;
        distance = undefined;

        self freezeControls(0);
        self CameraActivate(0);
        self.camera delete();

        self.can_activate_cam = true;

    }

}

function missile_monitor(){

    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "cam_lui" );

    for(;;){
        wait 0.1;
        self waittill( "missile_fire", missile/*, weapName*/ );
        
        if( is_true( !self.can_activate_cam ) ) continue;
        if( self has_special_menu_open() ) continue;
        //if( non_desired_weapons(weapName) ) continue;
        if( self meleeButtonPressed() ) continue;
        
        self.can_activate_cam = false;

        self.camera = spawn("script_model", missile.origin );
	    self.camera SetModel("tag_origin");
		self.camera.angles = self.angles;

        //camera linkTo(grenade);
        self freezeControls(1);
        self CameraSetPosition( self.camera );
        self CameraSetLookAt( missile );
        self CameraActivate(1);
        
        while( isDefined(missile) && !self meleeButtonPressed() && is_true( self.cam_lui ) )
        {
            wait 0.05;
            dist = Abs( distance(missile.origin , self.camera.origin) );

            if( dist > 150 ){
                pos = (missile.origin + self.camera.origin)/2;
                self.camera moveTo(pos, 0.25);
            }

        }

        wait 0.5;
        distance = undefined;

        self freezeControls(0);
        self CameraActivate(0);
        self.camera delete();

        self.can_activate_cam = true;

    }

}

// Aimbot
function gsc_aimbot( args = undefined ){

    if( is_true( self.aimbot_lui ) ){ // if it's already activated, we have to disable it

        self.aimbot_lui = undefined;
        self iPrintLnBold("^5Aimbot ^1deactivated");
        self notify( "aimbot_lui" );
        return;
    }

    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "aimbot_lui" );

    self iPrintLnBold("^5Aimbot ^2activated");
    self.aimbot_lui = true;

    for(;;){ 
        wait 0.05;

        // Check if the player is doing some invalid action
        if( self isMeleeing() || self isThrowingGrenade() || self IsReloading() || self.sessionstate == "spectator" || ( isdefined( self.is_drinking ) && self.is_drinking ) ) continue;

        // Only do aimbot while aimming
        if( !self adsButtonPressed() ) continue;

        //self SetPlayerAngles( VectortoAngles( GetEnt("t_lookat_doppleganger_enable", "targetname").origin - self GetTagOrigin("j_head") ) );
        //continue;

        // TODO: What if it's a vehicle-type enemy?
        zombies = GetAISpeciesArray("axis");

        // No zombies alive
        if( !zombies.size ) continue;

        // Sort zombies by closest
        zombies = ArraySortClosest( zombies, self.origin );

        closest = undefined;
        foreach( zombie in zombies ){
            // Invalid zombie
            if( !isalive( zombie ) ) continue;

            closest = zombie;
            break;
        }

        // There isn't any alive zombie
        if( !isdefined( closest ) ) continue;

        // TODO: What if it's a Margwa?
        
        // Headshot
        self setPlayerAngles( vectorToAngles( ( closest getEye() ) - ( self getEye() ) ) );

        // Abdomen
        //self setPlayerAngles( vectorToAngles( ( closest gettagorigin( "j_spinelower" ) ) - ( self getEye() ) ) );

        // Wrist
        //self setPlayerAngles( vectorToAngles( ( closest gettagorigin( "j_wrist_ri" ) ) - ( self getEye() ) ) );

        // Knee
        //self setPlayerAngles( vectorToAngles( ( closest gettagorigin( "j_knee_le" ) ) - ( self getEye() ) ) );

        // Ankle
        //self setPlayerAngles( vectorToAngles( ( closest gettagorigin( "j_ankle_le" ) ) - ( self getEye() ) ) );
    }

    // TODO: Add a command to change aimbot tag
    /* Tags

        tag_eye

        j_neck
        j_spineupper

        tag_weapon_right
        tag_weapon_left

        j_wrist_ri
        j_wrist_le

        j_ankle_le
        j_ankle_ri

        j_knee_le
        j_knee_ri

    */
}

#endregion


#region Set

// Third Person
function gsc_Third_Person( args = undefined ){

    self SetClientThirdPerson( true );
    self IPrintLnBold( "^5Third Person ^2activated!" );
}

// First person
function gsc_First_Person( args = undefined ){

    self SetClientThirdPerson( false );
    self IPrintLnBold( "^5First Person ^2activated!" );
}


#endregion


#region Player Character

// Character Body Type
function gsc_character_body_type( args = undefined ){

    // Check there is a Character Body Type arg
    if( args.size < 1){
        self IPrintLnBold("^1Missing ^5Character Body Type");
        return;
    }

    character_Body_Type = args[ 0 ];

    // Invalid character_Body_Type
    if( !StrIsInt( character_Body_Type )){
        self iPrintLnBold( sprintf("^1Invalid Character Body Type ^5{0}", character_Body_Type ) );
        return;
    }

    character_Body_Type = int( character_Body_Type );

    // Already set this Character Body Type
    if( character_Body_Type == self GetCharacterBodyType() ){
        self iPrintLnBold( sprintf("^1Already have Character Body Type ^5{0} ^6{1}", character_Body_Type, makelocalizedstring( getcharacterdisplayname(character_Body_Type, SESSION_MODE) ) ) );
        return;
    }    

    a_bodies = getallcharacterbodies( SESSION_MODE );

    // Out of Index
    if( ( character_Body_Type < 0 ) || ( character_Body_Type >= a_bodies.size ) ){
        self iPrintLnBold( sprintf("^1Out of index Character Body Type ^5{0} ^1 max is ^2{1}", character_Body_Type, a_bodies.size-1 ) );
        return;
    }

    // Zombies have their own way to give custom characters
    if( SESSION_MODE == SESSIONMODE_ZOMBIES ){

        // On custom maps, we just give the character index
        if( is_custom_map() ){

            self.characterindex = character_Body_Type;

            // Check the mapper created a give custom character function, give it manually otherwise
            if( isdefined( level.givecustomcharacters ) ){ // Check the mapper created a give custom character function
                self [[level.givecustomcharacters]]();
            }else{
                self setcharacterbodytype( character_Body_Type );
            }
            self playsound("zmb_bgb_abh_teleport_in");
            playfx(level._effect["teleport_splash"], self.origin);
            playfx(level._effect["teleport_aoe"], self.origin);
        }else{

            // If you want to get the beast you are just trolling/having fun, ignore it
            if( is_beast_character( character_Body_Type ) ){
                self setcharacterbodytype( character_Body_Type );

                if( MAP_NAME == "zm_zod" ){
                    self playsound("evt_beastmode_enter");
                    playfx(level._effect["human_disappears"], self.origin);
                    playfx(level._effect["beast_return_aoe"], self.origin);
                }else{
                    self playsound("zmb_bgb_abh_teleport_in");
                    playfx(level._effect["teleport_splash"], self.origin);
	                playfx(level._effect["teleport_aoe"], self.origin);
                }

            }else{
                // Custom effect if we are on Shadows and we were beast
                b_was_beast = is_beast_character( self GetCharacterBodyType() );

                // Give the voices ONLY if you are getting a character used by the map
                if( ( MAP_NAME == "zm_zod" ) && is_soe_character( character_Body_Type ) ){
                    self.characterindex = character_Body_Type -5;
                    // This way voices and ui player character identity
                    self [[level.givecustomcharacters]]();

                }else if( ( MAP_NAME != "zm_zod" ) && !is_soe_character( character_Body_Type ) ){
                    self.characterindex = character_Body_Type;
                    // This way voices and ui player character identity
                    self [[level.givecustomcharacters]]();

                }else{
                    // Just give character body type
                    self setcharacterbodytype( character_Body_Type );
                }

                // Body change FX
                if( MAP_NAME == "zm_zod" && b_was_beast ){
                    self playsound("evt_beastmode_exit");
                    playsoundatposition("zmb_player_disapparate", self.origin);
                    self playlocalsound("zmb_player_disapparate_2d");
                    playfx(level._effect["human_disappears"], self.origin);
                    playfx(level._effect["beast_return_aoe"], self.origin);
                }else{
                    self playsound("zmb_bgb_abh_teleport_in");
                    playfx(level._effect["teleport_splash"], self.origin);
	                playfx(level._effect["teleport_aoe"], self.origin);
                }
            }


        }

    }else{

        // TODO: How does the game change your voice on campaign or multiplayer?
        self setcharacterbodytype( character_Body_Type );
    }

    #ifdef dev
        str_char_display_name = getcharacterdisplayname(character_Body_Type, SESSION_MODE);
        str_localized_char_display_name = makelocalizedstring( getcharacterdisplayname(character_Body_Type, SESSION_MODE) );
        str_char_asset_name = getcharacterassetname( character_Body_Type, SESSION_MODE );
        self IPrintLnBold( sprintf("PlayerBodyType ^2{0}^7 | Display Name ^5{1}^7 | Localized Name ^6{2}^7 | Asset Name ^8{3}", character_Body_Type, str_char_display_name, str_localized_char_display_name, str_char_asset_name ) );
    #else
        self IPrintLnBold( sprintf("^2Changed to Body Type ^5{0} ^6{1}", character_Body_Type, makelocalizedstring( getcharacterdisplayname(character_Body_Type, SESSION_MODE) ) ) );
    #endif
}

// Character Body Style
function gsc_character_body_style( args = undefined ){

    // Check there is a Character Body Style arg
    if( args.size < 1){
        self IPrintLnBold("^1Missing ^5Character Body Style");
        return;
    }

    character_Body_Style = args[ 0 ];

    // Invalid character_Body_Style
    if( !StrIsInt( character_Body_Style )){
        self iPrintLnBold( sprintf("^1Invalid Character Body Style ^5{0}", character_Body_Style ) );
        return;
    }

    character_Body_Style = int( character_Body_Style );

    /* THERE IS NO WAY TO CHECK FOR CHARACTER BODY STYLE?
        self IPrintLnBold( sprintf("self GetCharacterHeadModel() = {0}", self GetCharacterHeadModel() ) ); // "tag_origin"
        self IPrintLnBold( sprintf("self GetCharacterHelmetModel() = {0}", self GetCharacterHelmetModel() ) ); // "tag_origin;

        str_bodystyledisplayname = getcharacterdisplayname(self GetCharacterBodyType(), SESSION_MODE);
        b_gender = self getplayergendertype(SESSION_MODE) == "female";
        GetCharacterBodyStyleIndex(b_gender, str_bodystyledisplayname);
        self IPrintLnBold( sprintf("GetCharacterBodyStyleIndex(b_gender, str_bodystyledisplayname) = {0}", GetCharacterBodyStyleIndex(b_gender, str_bodystyledisplayname) ) ); // Gives character display name

        Already set this Character Body Style
        if( character_Body_Style == GetCharacterBodyStyleIndex(b_gender, str_bodystyledisplayname) ){
            self iPrintLnBold( sprintf("^1Already have Character Body Style ^5{0} ^1 for ^6{1}", character_Body_Style, makelocalizedstring( getcharacterdisplayname(character_Body_Style, SESSION_MODE) ) ) );
            return;
        }
    */

    n_character_body_styles = getcharacterbodymodelcount(self GetCharacterBodyType(), SESSION_MODE);
    str_bodystyledisplayname = makelocalizedstring( getcharacterdisplayname(self GetCharacterBodyType(), SESSION_MODE) );

    // Out of Index
    if( ( character_Body_Style < 0 ) || ( character_Body_Style >= n_character_body_styles ) ){
        self iPrintLnBold( sprintf("^1Out of index Character Body Style ^5{0} ^1 max is ^2{1} ^1for ^6{2}", character_Body_Style, n_character_body_styles-1, str_bodystyledisplayname ) );
        return;
    }

    self SetCharacterBodyStyle(character_Body_Style);

    if( SESSION_MODE == SESSIONMODE_ZOMBIES ){

        if( ( MAP_NAME == "zm_zod" ) && is_beast_character( self GetCharacterBodyType() ) ){
            self playsound("evt_beastmode_enter");
            playfx(level._effect["human_disappears"], self.origin);
            playfx(level._effect["beast_return_aoe"], self.origin);
        }else{
            self playsound("zmb_bgb_abh_teleport_in");
            playfx(level._effect["teleport_splash"], self.origin);
            playfx(level._effect["teleport_aoe"], self.origin);
        }
    }

    self IPrintLnBold( sprintf("^2Character Body Style ^7 set to ^5{0} ^7 for Character ^6{1}", character_Body_Style, str_bodystyledisplayname) );
}

// Character Body Style
function gsc_character_helmet_style( args = undefined ){

    // Check there is a Character Helmet Style arg
    if( args.size < 1){
        self IPrintLnBold("^1Missing ^5Character Helmet Style");
        return;
    }

    character_Helmet_Style = args[ 0 ];

    // Invalid character_Helmet_Style
    if( !StrIsInt( character_Helmet_Style )){
        self iPrintLnBold( sprintf("^1Invalid Character Helmet Style ^5{0}", character_Helmet_Style ) );
        return;
    }

    character_Helmet_Style = int( character_Helmet_Style );

    /* THERE IS NO WAY TO CHECK FOR CHARACTER HELMET STYLE?
        self IPrintLnBold( sprintf("self GetCharacterHeadModel() = {0}", self GetCharacterHeadModel() ) ); // "tag_origin"
        self IPrintLnBold( sprintf("self GetCharacterHelmetModel() = {0}", self GetCharacterHelmetModel() ) ); // "tag_origin;

        str_bodystyledisplayname = getcharacterdisplayname(self GetCharacterBodyType(), SESSION_MODE);
        b_gender = self getplayergendertype(SESSION_MODE) == "female";
        GetCharacterBodyStyleIndex(b_gender, str_bodystyledisplayname);
        self IPrintLnBold( sprintf("GetCharacterBodyStyleIndex(b_gender, str_bodystyledisplayname) = {0}", GetCharacterBodyStyleIndex(b_gender, str_bodystyledisplayname) ) ); // Gives character display name

        Already set this Character Body Style
        if( character_Body_Style == GetCharacterBodyStyleIndex(b_gender, str_bodystyledisplayname) ){
            self iPrintLnBold( sprintf("^1Already have Character Body Style ^5{0} ^1 for ^6{1}", character_Body_Style, makelocalizedstring( getcharacterdisplayname(character_Body_Style, SESSION_MODE) ) ) );
            return;
        }
    */

    n_character_helmet_styles = getcharacterhelmetmodelcount(self GetCharacterBodyType(), SESSION_MODE);
    str_bodystyledisplayname = makelocalizedstring( getcharacterdisplayname(self GetCharacterBodyType(), SESSION_MODE) );

    // Out of Index
    if( ( character_Helmet_Style < 0 ) || ( character_Helmet_Style >= n_character_helmet_styles ) ){
        self iPrintLnBold( sprintf("^1Out of index Character Helmet Style ^5{0} ^1 max is ^2{1} ^1for ^6{2}", character_Helmet_Style, n_character_helmet_styles-1, str_bodystyledisplayname ) );
        return;
    }

    self SetCharacterHelmetStyle(character_Helmet_Style);

    character_Body_Type = self GetCharacterBodyType();

    if( SESSION_MODE == SESSIONMODE_ZOMBIES ){

        if( ( MAP_NAME == "zm_zod" ) && is_beast_character( self GetCharacterBodyType() ) ){
            self playsound("evt_beastmode_enter");
            playfx(level._effect["human_disappears"], self.origin);
            playfx(level._effect["beast_return_aoe"], self.origin);
        }else{
            self playsound("zmb_bgb_abh_teleport_in");
            playfx(level._effect["teleport_splash"], self.origin);
            playfx(level._effect["teleport_aoe"], self.origin);
        }
    }


    self IPrintLnBold( sprintf("^2Character Helmet Style ^7 set to ^5{0} ^7 for Character ^6{1}", character_Helmet_Style, str_bodystyledisplayname) );
}

#endregion


#region Player Items

// Perks
function gsc_perk( args = undefined ){

    if( args.size < 1 ){
        self iPrintLnBold("^1Error, missing ^5perk name");
        return;
    }

    str_perk = args[0];

    // PERK
    perk = get_perk_name( str_perk );

    // Invalid Perk name
    if( !isdefined( perk ) ){
        self IPrintLnBold( sprintf("^1Invalid Perk name ^5{0}", str_perk) );
        return;
    }

    // Take perk
    if( self HasPerk( perk ) ){
        if( IS_ZOMBIES ){
            self notify( perk+"_stop" );
        }else{
            self UnSetPerk( perk );
        }

        str_text = sprintf("^6Taking Perk {0}", parse_perk_name( perk ) );
    }
    // Give perk
    else{
        if( IS_ZOMBIES ){
            self thread [[ @zm_perks<scripts\zm\_zm_perks.gsc>::give_perk ]]( perk, 0);
        }else{
            self SetPerk( perk );
        }

        str_text = sprintf("^6Giving Perk {0}", parse_perk_name( perk ) );
    }


    self IPrintLnBold( str_text );
}

// TODO: what if we are not on sessionmode zm?
// Weapons
function gsc_weapon( args = undefined ){

    if( args.size < 1 ){
        self iPrintLnBold("^1Error, missing argument on gsc_weapon");
        return;
    }

    //strtok
    str_weapon = args[0];

    weapon = getweapon( str_weapon );

    // Check the weapon is valid
    if( !IsWeapon(weapon) || weapon == level.weaponnone  ){
        self iPrintLnBold("Error, not a weapon "+str_weapon);
        return;
    }

    // If you already have the weapon
    if( self [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::has_weapon_or_upgrade]]( weapon ) ){
        self iPrintLnBold("You already have "+str_weapon);

        foreach( w in self getWeaponsList()){
            if( w.rootweapon.name == str_weapon ){

                self iPrintLnBold("You already have the weapon!");

                self giveMaxAmmo( w );
                self setWeaponAmmoClip( w, w.clipsize);
                return;
            }
        }


        self iPrintLnBold("Failed to find weapon "+str_weapon);
        // Doesn't work if weapon has attachment
        self giveMaxAmmo( weapon );
        self setWeaponAmmoClip( weapon, weapon.clipsize);
        return;
    }

    // Tactical grenade
    if( isdefined( level.zombie_tactical_grenade_list[ weapon ] ) ){

        self iPrintLnBold("Tactical grenade detected "+str_weapon);

        if( isdefined( self.current_tactical_grenade ) && self.current_tactical_grenade != weapon)
        {
            self iPrintLnBold( self.current_tactical_grenade.name+" => "+str_weapon );
            self setweaponammoclip( self.current_tactical_grenade, 0 );
            self takeweapon( self.current_tactical_grenade );
            self.current_tactical_grenade = weapon;
        }else{
            self iPrintLnBold("Giving "+str_weapon);
        }

        self [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::weapon_give]]( weapon );
        return;
    }
    // Lethal grenade
    else if( isdefined( level.zombie_lethal_grenade_list[ weapon ] ) ){

        self iPrintLnBold("Lethal grenade detected "+str_weapon);

        if( isdefined( self.current_lethal_grenade ) && self.current_lethal_grenade != weapon)
        {
            self iPrintLnBold( self.current_lethal_grenade.name+" => "+str_weapon );
            self setweaponammoclip( self.current_lethal_grenade, 0 );
            self takeweapon( self.current_lethal_grenade );
            self.current_lethal_grenade = weapon;
        }else{
            self iPrintLnBold("Giving "+str_weapon);
        }

        self [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::weapon_give]]( weapon );
        return;
    }
    // Equipment
    else if( isdefined( level.zombie_equipment_list[ weapon ] ) ){

        self iPrintLnBold("Equipment detected "+str_weapon);

        if( self.current_equipment == weapon){
            self iPrintLnBold("You already have "+str_weapon);
        }else{
            self iPrintLnBold( self.current_equipment.name+" => "+str_weapon );
            self takeweapon( self.current_equipment );
            self.current_equipment = weapon;
        }

        self [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::weapon_give]]( weapon );
        self setactionslot(2, "weapon", weapon);
        return;

    }
    // Hero weapon
    else if( isdefined( level.zombie_hero_weapon_list[ weapon ] ) ){

        self iPrintLnBold("Hero Weapon detected "+str_weapon);

        if( self.current_hero_weapon == weapon){
            self iPrintLnBold("You already have "+str_weapon);
        }else{
            self iPrintLnBold( self.current_hero_weapon.name+" => "+str_weapon );
            self takeweapon( self.current_hero_weapon );
            self.current_hero_weapon = weapon;
        }

        self [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::weapon_give]]( weapon );
        self setactionslot(3, "weapon", weapon);
        self gadgetpowerset(0, 100);
        wait 0.05;
        self switchtoweapon( weapon );
        return;

    }
    // Placeable mine
    else if( isdefined( level.placeable_mines[ weapon ] ) ){

        self iPrintLnBold("placeable mine detected "+str_weapon);

        if( self.current_placeable_mine == weapon){
            self iPrintLnBold("You already have "+str_weapon);
        }else{
            self iPrintLnBold( self.current_placeable_mine.name+" => "+str_weapon );
            self takeweapon( self.current_placeable_mine );
            self.current_placeable_mine = weapon;
        }

        self [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::weapon_give]]( weapon );
        self setactionslot(4, "weapon", weapon);
        return;

    }
    // Melee weapon
    else if( isdefined( level.zombie_melee_weapon_list[ weapon ] ) ){

        self iPrintLnBold("melee weapon detected "+str_weapon);

        if( self.current_melee_weapon == weapon){
            self iPrintLnBold("You already have "+str_weapon);
        }else{
            self iPrintLnBold( self.current_melee_weapon.name+" => "+str_weapon );
            self takeweapon( self.current_melee_weapon );
            self.current_melee_weapon = weapon;
        }

        self [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::weapon_give]]( weapon );
        return;

    }

    // Special cases:
    switch( weapon.rootweapon.name ){

        // Origins
        case "equip_dieseldrone":
        {
            foreach( uts in level.a_uts_craftables ){
                if( uts.craftablestub.name != "equip_dieseldrone" ) continue;
                obj = spawnstruct();
                obj.stub = uts;
                obj [[level.zombie_custom_equipment_setup]](self);
                return;
            }
            self IPrintLnBold("Couldn't find UTS craftable for ^5"+weapon.rootweapon.name);
            return;
        }
    }

    // Normal weapon
    // Get weapon limit
	if(isdefined(self.get_player_weapon_limit))                 weapon_limit = [[ self.get_player_weapon_limit ]]  (self);
    else if(isdefined(level.get_player_weapon_limit))           weapon_limit = [[ level.get_player_weapon_limit ]] (self);
    else if(self hasperk("specialty_additionalprimaryweapon") && isdefined(level.additionalprimaryweapon_limit))  weapon_limit = level.additionalprimaryweapon_limit;
    else                                                        weapon_limit = 2;
    
    
    // Take a player weapon if needed TODO: make it a while loop until a valid weapon has been taken
    a_primary_weapons = self getWeaponsListPrimaries();
    if( a_primary_weapons.size >= weapon_limit ){
        take_weapon = self getCurrentWeapon();
        
        // Select a valid weapon to take if current selected one is invalid
        if( !isdefined( take_weapon ) || !IsInArray(a_primary_weapons, take_weapon) ) take_weapon = a_primary_weapons[0];
        
        if( !isdefined(take_weapon) ){
            self iPrintLnBold("Error, couldn't get a weapon to take");
            return;
        }

        self takeWeapon( take_weapon );
    }

    #ifdef dev
        level thread debug_message("gsc_weapon");
    #endif
    self GiveWeapon( weapon );
    self thread apply_weapon_settings( weapon );
}

function gsc_camo( args ){

    // Missing camo index
    if( args.size < 1 ){
        self IPrintLnBold( "^1Error, missing camo argument..." );
        return;
    }

    n_camo = args[0];

    if( !strisnumber(n_camo) ){
        self IPrintLnBold( "^1Error, camo must be a number..." );
        return;
    }

    n_camo = int( n_camo );

    if( n_camo < 1 ) n_camo = 1;
    else if( n_camo > 138 ) n_camo = 138;

    w_current = self GetCurrentWeapon();
    if( !isdefined( w_current ) ){
        self IPrintLnBold("^1Error, no weapon in hand...");
        return;
    }

    weapon_options = self calcweaponoptions( n_camo, 0, 0, 0, 0 );

    /* Why custom function for detecting if the weapon is an alt weapon?
        1) In theory we can use "GetCurrentWeaponAltWeapon" and check against "none" but maybe the player is in a custom map or with a mod that includes non official bo3 weapons and that may not work
        2) CI doesn't always happen just because weapon has altweapon, it also needs either main or alt weapon to have altmode true, so we need to check that too
    */
    
    if( is_altweapon( w_current ) ){

        // We need to know if player is holding the alt weapon to avoid bugs
        b_using_alt = is_true( w_current.isaltmode );

        // Always give non alternate weapon as main weapon
        if( b_using_alt ) w_updated = getweapon( w_current.rootweapon.altweapon.name );
        else w_updated = getweapon( w_current.rootweapon.name );

        if( b_using_alt ){
            // Base weapon is the alt!
            w_base_clip = self GetWeaponAmmoClip( w_current.altweapon );
            w_base_stock = self GetWeaponAmmoStock( w_current.altweapon );

            // Check for base alt dual wield
            w_base_dual = is_true( w_current.altweapon.isdualwield );
            if( w_base_dual ){
                w_base_lh_clip = self GetWeaponAmmoClip( w_current.altweapon.dualwieldweapon );
                w_base_lh_stock = self GetWeaponAmmoStock( w_current.altweapon.dualwieldweapon );
            }
            
            // Alt weapon is now the base!
            w_alt_clip = self GetWeaponAmmoClip( w_current );
            w_alt_stock = self GetWeaponAmmoStock( w_current );

            // Check for base dual wield
            w_alt_dual = is_true( w_current.isdualwield );
            if( w_alt_dual ){
                w_alt_lh_clip = self GetWeaponAmmoClip( w_current.dualwieldweapon );
                w_alt_lh_stock = self GetWeaponAmmoStock( w_current.dualwieldweapon );
            }   
        }else{
            // Base weapon
            w_base_clip = self GetWeaponAmmoClip( w_current );
            w_base_stock = self GetWeaponAmmoStock( w_current );

            // Check for base dual wield
            w_base_dual = is_true( w_current.isdualwield );
            if( w_base_dual ){
                w_base_lh_clip = self GetWeaponAmmoClip( w_current.dualwieldweapon );
                w_base_lh_stock = self GetWeaponAmmoStock( w_current.dualwieldweapon );
            }
            
            // Alt weapon
            w_alt_clip = self GetWeaponAmmoClip( w_current.altweapon );
            w_alt_stock = self GetWeaponAmmoStock( w_current.altweapon );

            // Check for alt dual wield
            w_alt_dual = is_true( w_current.altweapon.isdualwield );
            if( w_alt_dual ){
                w_alt_lh_clip = self GetWeaponAmmoClip( w_current.altweapon.dualwieldweapon );
                w_alt_lh_stock = self GetWeaponAmmoStock( w_current.altweapon.dualwieldweapon );
            }            
        }

        #ifdef dev
            /*level thread debug_message( "Weapon is Alt ^5"+b_using_alt+" weapon: ^5"+w_current.rootweapon.name );

            if( w_base_dual ){
                level thread debug_message( "Right Hand "+w_base_clip+" Right Hand Reserve "+w_base_stock );
                level thread debug_message( "Left Hand "+w_base_lh_clip+" Left Hand Reserve "+w_base_lh_stock );
            }else{
                level thread debug_message( "Base "+w_base_clip+" Reserve "+w_base_stock );
            }

            wait 5;

            level thread debug_message( "Alt weapon: ^5"+w_current.rootweapon.altweapon.name );

            if( w_alt_dual ){
                level thread debug_message( "Right Hand "+w_alt_clip+" Right Hand Reserve "+w_alt_stock );
                level thread debug_message( "Left Hand "+w_alt_lh_clip+" Left Hand Reserve "+w_alt_lh_stock );
            }else{
                level thread debug_message( "Alt "+w_alt_clip+" Reserve "+w_alt_stock );
            }*/
        #endif

        // Switch the weapon to the one with the new camo
        self TakeWeapon( w_current );
        self GiveWeapon( w_updated, weapon_options, 0 );
        self ShouldDoInitialWeaponRaise( w_updated, false );

        // Switch to the weapon the player was holding
        if( b_using_alt ) self SwitchToWeaponImmediate( w_updated.altweapon );
        else self SwitchToWeaponImmediate( w_updated );

        wait 0.05;

        self SetWeaponAmmoClip( w_updated, w_base_clip );
        self SetWeaponAmmoStock( w_updated, w_base_stock );

        if( w_base_dual ){
            self SetWeaponAmmoClip( w_updated.dualwieldweapon, w_base_lh_clip );
            self SetWeaponAmmoStock( w_updated.dualwieldweapon, w_base_lh_stock );
        }

        self SetWeaponAmmoClip( w_updated.altweapon, w_alt_clip );
        self SetWeaponAmmoStock( w_updated.altweapon, w_alt_stock );

        if( w_alt_dual ){
            self SetWeaponAmmoClip( w_updated.altweapon.dualwieldweapon, w_alt_lh_clip );
            self SetWeaponAmmoStock( w_updated.altweapon.dualwieldweapon, w_alt_lh_stock );
        }

    }else{

        #ifdef dev
            // self IPrintLnBold("^3Normal weapon detected!: ^5"+w_current.name);
        #endif

        self updateweaponoptions( w_current, weapon_options );
    }

    self IPrintLnBold("^1Camo changed to ^5"+n_camo+"^1 for weapon ^5"+w_current.rootweapon.name+"^1!");
}

#endregion


#region Misc

function gsc_play_scene( args ){

    // Missing scene name
    if( args.size < 1 ){
        self IPrintLnBold( "^1Error, missing scene argument..." );
        return;
    }

    str_scene = args[ 0 ];

    self IPrintLnBold("Playing scene: ^5"+str_scene);
    scene::init( str_scene );
    scene::play( str_scene );
}

#endregion