function register_zombie_commands(){

    // General
        // Open all doors, debris, airlocks and activate all power.
        level register_keyboard_console_command( "Open_All", array("OpenAll"), ::gsc_open_all, CHEAT_PROTECTED, ARGS_0 );
        // Activate some triggers on the map with text and/or sound notification, for example: Wisps on Der Eisendrache
        level register_keyboard_console_command( "Enable_Special_Triggers", array("EnableSpecialTriggers", "EST"), ::gsc_enable_especial_triggers, CHEAT_PROTECTED, ARGS_0 );

        // Switch to desired round
        level register_keyboard_console_command( "Go_To_Round", array("GoToRound", "GTR", "Round"), ::gsc_round, CHEAT_PROTECTED, ARGS_1 );
        // Open all Zombie Barriers
        level register_keyboard_console_command( "Open_All_ZBarriers", array("Open_All_Barriers", "Open_Barriers", "OpenAllZBarriers", "OpenAllBarriers", "OpenBarriers", "OAZB", "OAB", "OB"), ::gsc_open_all_zbarriers, CHEAT_PROTECTED, ARGS_0 );
        // Close all Zombie Barriers
        level register_keyboard_console_command( "Close_All_ZBarriers", array("Close_All_Barriers", "Close_Barriers", "CloseAllZBarriers", "CloseAllBarriers", "CloseBarriers", "CAZB", "CAB", "CB"), ::gsc_close_all_zbarriers, CHEAT_PROTECTED, ARGS_0 );
        // Toggle Full Easter Egg on maps (you have to do all the steps)
        level register_keyboard_console_command( "Toggle_Force_Full_Easter_Egg", array("Force_Full_Easter_Egg", "Full_Easter_Egg", "ToggleForceFullEasterEgg", "ForceFullEasterEgg", "FullEasterEgg", "TFFEE", "FFEE", "FEE"), ::gsc_toggle_force_full_easter_egg, ALLOWED, ARGS_0 );
        // Toggle Forcing Der Eisendrache ranked bow logic for Easter Egg steps
        level register_keyboard_console_command( "Toggle_DE_Easter_Egg_Ranked", array("DE_Easter_Egg_Ranked", "DE_EasterEgg_Ranked", "ToggleDEEasterEggRanked", "DEEasterEggRanked", "TDEEER", "DEEER"), ::gsc_DE_Easter_Egg_Ranked, ALLOWED, ARGS_0 );

    // Timing Functionality
        // Manually Split the Round Timer
        level register_keyboard_console_command( "Livesplit_Round_Split", array("Livesplit_Split_Round", "LivesplitRoundSplit", "LivesplitSplitRound", "Round_Split", "Split_Round", "LRS", "LSR"), ::gsc_Livesplit_Round_Split, ALLOWED, ARGS_0 );

        // Allow Livesplit to automatically split on round splits
        level register_keyboard_console_command( "Split_Rounds", array("SplitRounds", "SR"), ::gsc_Split_Rounds, ALLOWED, ARGS_0 );

        // Enable all common EE splits instead of typing them 1 by 1 (No made-up splits, they show real EE progress)
        level register_keyboard_console_command( "Activate_Common_EE_Splits", array("ActivateCommonEESplits", "ACEES", "Common_EE_Splits", "CommonEESplits", "CEES"), ::gsc_activate_common_ee_splits, ALLOWED, ARGS_0 );

        // Toggle hiding in-game EE splits
        level register_keyboard_console_command( "Toggle_Hide_EE_Splits", array("ToggleHideEESplits", "THEES", "Hide_EE_Splits", "HideEESplits", "HEES"), ::gsc_toggle_hide_ee_splits, ALLOWED, ARGS_0 );

    // Stats
        // Toggle having completed the Super Easter Egg
        level register_keyboard_console_command( "Toggle_Super_EE", array("ToggleSuperEE", "TSEE"), ::gsc_toggle_super_ee, CHEAT_PROTECTED, ARGS_0 ); // Cheat protected to avoid someone starting with RK 5 and then disabling it on Revelations EE which saves some time

    // Weapon toggles
        // Remove Multiplayer attachments from weapons
        level register_keyboard_console_command( "Toggle_MP_Attachments", array("ToggleMPAttachments", "TMPA"), ::gsc_toggle_mp_attachments, ALLOWED, ARGS_0 );
        // Give attachments to weapons that support them when the player has none. (It's enabled by default when playing Offline or With a Mod)
        level register_keyboard_console_command( "Toggle_Automatic_Attachments", array("ToggleAutomaticAttachments", "TAA"), ::gsc_toggle_automatic_attachments, ALLOWED, ARGS_0 );
        // Add stattrak attachment to weapons
        level register_keyboard_console_command( "Toggle_StatTrak", array("ToggleStatTrak", "TS", "TST"), ::gsc_toggle_stattrak, ALLOWED, ARGS_0 );
        // Give a random camouflage to the weapons that don't have one assigned
        level register_keyboard_console_command( "Toggle_Random_Camo", array("ToggleRandomCamo", "Toggle_Camo", "TRC", "TC"), ::gsc_toggle_random_camo, ALLOWED, ARGS_0 );
        // Remove attachments only from the Initial Pistols
        level register_keyboard_console_command( "Toggle_Initial_Pistol_Attachments", array("ToggleInitialPistolAttachments", "TIPA"), ::gsc_toggle_initial_pistol_attachments, ALLOWED, ARGS_0 );

    // Player Items
        // Give the desired Gobblegum
        level register_keyboard_console_command( "Gum", array("BGB", "Gobble_Gum", "GobbleGum"), ::gsc_bgb, CHEAT_PROTECTED, ARGS_1 );
        // Set the desired AAT for the current weapon
        level register_keyboard_console_command( "Alternative_Ammo_Type", array("AAT", "AlternativeAmmoType"), ::gsc_aat, CHEAT_PROTECTED, ARGS_1 );
        // Set the score to the desired amount
        level register_keyboard_console_command( "Points", array("Score"), ::gsc_points, CHEAT_PROTECTED, ARGS_1 );

    // Respawn Points
        // Spawn player models on the Initial Player Spawns locations
        level register_keyboard_console_command( "Initial_Players_Spawns", array("InitialPlayersSpawns", "IPS"), ::gsc_initial_players_spawns, CHEAT_PROTECTED, ARGS_0 );
        // Remove spawned player models on the Initial player Spawns locations
        level register_keyboard_console_command( "Delete_Initial_Players_Spawns", array("DeleteInitialPlayersSpawns", "DIPS"), ::gsc_delete_initial_players_spawns, CHEAT_PROTECTED, ARGS_0 );

        // Spawn player models on the Player Respawn Points locations
        level register_keyboard_console_command( "Player_Respawn_Points", array("PlayerRespawnPoints", "PRP"), ::gsc_player_respawn_points, CHEAT_PROTECTED, ARGS_0 );
        // Remove spawned player models on the Player Respawn Points locations
        level register_keyboard_console_command( "Delete_Player_Respawn_Points", array("DeletePlayerRespawnPoints", "DPRP"), ::gsc_delete_player_respawn_points, CHEAT_PROTECTED, ARGS_0 );

    // Add EE autocomplete step commands (check Docs/EE_Autocomplete.md)
    level add_ee_commands();
    level register_keyboard_console_command( "Easter_Egg", array("EasterEgg", "EE"), ::gsc_ee, CHEAT_PROTECTED, ARGS_1 );

}

#region General
// GO TO DESIRED ROUND
function gsc_round( args ){

    if( args.size < 1 ){
        self iPrintLnBold("^1Error, missing ^2round");
        return;
    }

    n_round = args[ 0 ];

    // The parameter is not a number
    if( !StrIsInt( n_round ) ){
        self iPrintLnBold( "^1Error, not a valid ^5 round number ^7'^5"+args+"^7'" );
        return;
    }

    // We are already on the desired round
    if( int( n_round ) == level.round_number ){
        self iPrintLnBold( "^2Already on^5 Round ^2"+n_round );
        return;
    }

    // There is already a command trying to change the round
    if( is_true( level.lui_round ) ){
        self iPrintLnBold("^1A round command is already in progress");
        return;
    }

    // Prevent this command from running again until this one is finished
    level.lui_round = true;

    // Calculate a valid round to go
    n_round = int( n_round );
    n_round--;
    
    if(n_round < 0) n_round = 0;
    //else if(n_round > 255) n_round = 255;

    // TODO: maybe it would be better to let everybody know?
    self iPrintLnBold("^5Going to round ^2"+(n_round+1) );

    // Wait until round wait time is over
    if( is_waiting_between_rounds() ){
        #ifdef dev
            self iPrintLnBold("^1Waiting in between rounds...");
        #endif
        
        while( is_waiting_between_rounds() ) wait 0.05;
    }

    // Max round luielem will display is 255
    n_display = n_round >= 255 ? 255 : n_round;

    // Fix round number glitch
    str_current = ""+level.round_number;
    str_target = ""+(n_display+1);

    // Both should have same N of digits
    n_diff = str_current.size - str_target.size;
    if( n_diff > 0 ) for( i=0; i<n_diff; i++) str_target = "0"+str_target;

    n_diff = str_target.size - str_current.size;
    if( n_diff > 0 ) for( i=0; i<n_diff; i++) str_current = "0"+str_current;

    display_number = "";
    for( i=str_target.size-1; i>=0; i--){
        #ifdef dev
            level thread debug_message( sprintf("^5{0}^7) ^2{1} => ^1{2} ", i, str_current[i], str_target[i] ) );
        #endif
        if( str_current[i] == "0" && str_target[i] == "2" ) display_number = "1"+display_number; // in theory if you go Num 2 is because you are currently on Num 1
        else display_number = str_target[i]+display_number; // To make it as similar as possible to target round, keep it the same number
    }

    // Round 1 exception, Show Round 0
    if( display_number == "1" ) display_number = "0";

    level.lui_round = int( display_number );

    // Set global vars to desired round to go
    level.round_number = n_round;
	world.roundnumber = n_display ^ 115;


    // Kill all zombies and set vars
	level.zombie_total = 0;
    level.zombie_respawns = 0;
	ai_calculate_health( n_round );
	level notify( "kill_round" );
	wait(0.1);

	zombies = getaiteamarray(level.zombie_team);
	for(i = 0; i < zombies.size; i++) if( is_true(zombies[i].ignore_round_robbin_death) ) arrayremovevalue(zombies, zombies[i]);

    e_last = zombies[ zombies.size-1 ];
	level.last_ai_origin = e_last.origin;
	level notify("last_ai_down", e_last);

	util::wait_network_frame();
    foreach(zombie in zombies) zombie dodamage(zombie.health + 666, zombie.origin);

    // Moon calculates spawndelay differently
    if( MAP_NAME == "zm_moon" ){
        level.zombie_vars["zombie_spawn_delay"] = [[level.func_get_zombie_spawn_delay]]( n_round );
    }
}

// Toggle Forced Full Easter Eggs
function gsc_toggle_force_full_easter_egg( args ){

    setDvar( DVAR_FORCE_FULL_EASTER_EGG, !getDvarInt( DVAR_FORCE_FULL_EASTER_EGG ) );

    if( GetDvarInt(DVAR_FORCE_FULL_EASTER_EGG) ) level thread DisplayFeedMessage( "Forced Full Easter Egg ^2Enabled" );
    else level thread DisplayFeedMessage( "Forced Full Easter Egg ^1Disabled" );
}

// Toggle Forced Ranked EE on DE
function gsc_DE_Easter_Egg_Ranked( args ){

    setDvar( DVAR_DE_EE_RANKED, !getDvarInt( DVAR_DE_EE_RANKED ) );

    if( GetDvarInt(DVAR_DE_EE_RANKED) ) level thread DisplayFeedMessage( "Forced DE Easter Egg Ranked ^2Enabled" );
    else level thread DisplayFeedMessage( "Forced DE Easter Egg Ranked ^1Disabled" );
}


// Tear down all barriers
function gsc_open_all_zbarriers()
{
    b_barrier_opened = false;

	foreach(barrier in level.exterior_goals)
	{

		if(isdefined(barrier.zbarrier))
		{
			for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++)
			{
                // Barrier is already open
                if( barrier.zbarrier getzbarrierpiecestate(x) == "open" ) continue;

				barrier.zbarrier setzbarrierpiecestate(x, "opening");
                b_barrier_opened = true;
			}
		}
        if( !isdefined( barrier.clip ) ) continue;

        barrier.clip triggerenable(0);
        barrier.clip connectpaths();

	}

    // All barriers were open
    if( !b_barrier_opened ){
        self iPrintLnBold("^1All barriers were already open...");
        return;
    }

    level thread displayfeedmessage("All barriers ^2opened");
}

// Rebuild all barriers
function gsc_close_all_zbarriers()
{
    b_barrier_closed = false;

	foreach(barrier in level.exterior_goals)
	{

		if(isdefined(barrier.zbarrier))
		{
			for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++)
			{
                // Barrier is already closed
                if( barrier.zbarrier getzbarrierpiecestate(x) == "closed" ) continue;

				barrier.zbarrier setzbarrierpiecestate(x, "closing");
                b_barrier_closed = true;
			}
		}
		if( !isdefined(barrier.clip) ) continue;
		
        barrier.clip triggerenable(1);
        barrier.clip DisconnectPaths();
	}

    // All barriers were closed
    if( !b_barrier_closed ){
        self iPrintLnBold("^1All barriers were already closed...");
        return;
    }

    level thread displayfeedmessage("All barriers ^1closed");
}

#endregion

#region Timing Functionality
// Manual Split
function gsc_Livesplit_Round_Split( args ){

    // Don't allow manual splits while autosplits are active
    if( isdefined( level.autosplits ) ){
        self IPrintLnBold("^1Cant do ^5Manual Round Splits^1 while ^6Autosplits ^1is active...");
        return;
    }
    
    // Game has started check
    if( !has_game_started() ){
        self IPrintLnBold("^1Cant do ^5Manual Round Splits^1 before game starts");
        return;
    }

    s_hud = get_hud_by_name( "round_time" );

    // Can't get hud
    if( !isdefined( s_hud ) ){
        self IPrintLnBold("^1Error, can't find ^5Round Time^1 hud, not registered?");
        return;
    }

    // Round Time not active
    if( !is_hud_created( s_hud ) ){
        self IPrintLnBold("^1Can't split rounds without ^5Round Time ^1HUD");
        return;        
    }

    // Round Time is being created or removed
    if( is_hud_moving( s_hud ) ){
        self IPrintLnBold("^5Round Time ^1Not available, wait to stop moving animation");
        return;        
    }

    level notify("manual_round_split");
}

// Allow Livesplit to split on round splits
function gsc_Split_Rounds( args ){

    setDvar( DVAR_SPLIT_ROUNDS, !getDvarInt( DVAR_SPLIT_ROUNDS ) );

    if( GetDvarInt(DVAR_SPLIT_ROUNDS) ) level thread DisplayFeedMessage( "Splitting rounds ^2Enabled" );
    else level thread DisplayFeedMessage( "Splitting rounds ^1Disabled" );
}

// Enable all common EE splits instead of typing it 1 by 1
function gsc_activate_common_ee_splits( args ){

    // EE splits not registered yet
    if( !isdefined( level.hud_registration_completed ) ){
        self iPrintLnBold("^1Wait for ^5Hud registration^1 before enabling common EE splits...");
        return;
    }

    b_split_enabled = false;

    // Main Maps EE Splits
    foreach( map_group in MAIN_MAPS_COMMON_SPLITS ){
        foreach( str_split in map_group ){

            // Last shadows of evil split
            if( ( str_split == "Apocalypse_Averted" ) && ( ( GetPlayers().size < 4 ) && ( !isdefined( level.force_full_easter_egg ) ) ) ) continue;

            // Find the HuD
            s_hud = get_hud_by_name( str_split );

            // Not found
            if( !isdefined( s_hud ) ){
                self IPrintLnBold("^1Couldn't find common EE split ^5"+str_split+"^1...");
                continue;
            }

            // Already in use
            if( self is_hud_saved( s_hud ) ) continue;

            b_split_enabled = true;
            self execute_command( "hud "+str_split );
            wait 0.05;
        }
    }

    // Chronicle Maps EE Splits
    foreach( map_group in CHRONICLE_MAPS_COMMON_SPLITS ){
        foreach( str_split in map_group ){

            // Ascension or Shangri-La EE split
            if( ( IsInArray(ASC_COMMON_SPLITS, str_split) || IsInArray(SHANG_COMMON_SPLITS, str_split) ) && ( GetPlayers().size < 4 ) && !isdefined( level.force_full_easter_egg ) ) continue;

            // Find the HuD
            s_hud = get_hud_by_name( str_split );

            // Not found
            if( !isdefined( s_hud ) ){
                self IPrintLnBold("^1Couldn't find common EE split ^5"+str_split+"^1...");
                continue;
            }

            // Already in use
            if( self is_hud_saved( s_hud ) ) continue;

            b_split_enabled = true;
            self execute_command( "hud "+str_split );
            wait 0.05;
        }
    }

    // Error print, all EE splits are already active
    if( !b_split_enabled ) self iPrintLnBold("^1All common EE splits are already enabled...");
}

// Hide/Show EE Splits
function gsc_toggle_hide_ee_splits( args ){

    if( isdefined( level.updating_hud_positions ) ) {
        self IPrintLnBold( "^1Please wait until previous ^5Toggle Hide EE Splits ^1has finished" );
        return;
    }

    level.updating_hud_positions = true;

    // Toggle EE splits visibility
    FLAG_SAVED_SHOW_EE_SPLITS = !FLAG_SAVED_SHOW_EE_SPLITS;

    if( FLAG_SAVED_SHOW_EE_SPLITS ) level thread displayfeedmessage("^2Showing ^5Easter Egg splits^2!");
    else level thread displayfeedmessage("^1Hiding ^5Easter Egg splits^1...");

    level.updating_hud_positions = undefined;
    self IPrintLnBold( "^5Toggle Hide EE Splits ^2Completed!" );
}
#endregion

#region Stats
// Toggle Super EE Completed
function gsc_toggle_super_ee( args ){

    // Can't change stats while using a mod
    if( USING_MODS ){
        self IPrintLnBold("^1Can't change stats while using a mod...");
        return;
    }

    if( is_super_ee_completed() ){
        self set_super_ee_stat( false );
        self IPrintLnBold("^5Super EE ^1reset...");
    }else{
        self set_super_ee_stat( true );
        self IPrintLnBold("^5Super EE ^2Completed!");
    }

    uploadstats(self);
}
#endregion

#region Weapon
// Toggle MP Attachments
function gsc_toggle_mp_attachments( args ){

    val = is_weapon_setting_bit_enabled( FLAG_NO_MP_ATTACHMENTS );

    // Disable
    if( val ){
        disable_weapon_flag_bit( FLAG_NO_MP_ATTACHMENTS );
        level thread displayfeedmessage( "^1Not removing ^5MP Attachments^1..." );
        return;
    }

    enable_weapon_flag_bit( FLAG_NO_MP_ATTACHMENTS );
    level thread displayfeedmessage( "^2Removing ^5MP Attachments^2!" );
}

// Toggle Automatic Attachments
function gsc_toggle_automatic_attachments( args ){

    val = is_weapon_setting_bit_enabled( FLAG_AUTOMATIC_ATTACHMENTS );

    // Disable
    if( val ){
        disable_weapon_flag_bit( FLAG_AUTOMATIC_ATTACHMENTS );
        level thread displayfeedmessage( "^1Not giving ^5Attachments^1..." );
        return;
    }

    enable_weapon_flag_bit( FLAG_AUTOMATIC_ATTACHMENTS );
    level thread displayfeedmessage( "^2Giving ^5Attachments^2!" );
}

// Toggle Stattrak
function gsc_toggle_stattrak( args ){

    val = is_weapon_setting_bit_enabled( FLAG_ADD_STATTRAK );

    // Disable
    if( val ){
        disable_weapon_flag_bit( FLAG_ADD_STATTRAK );
        level thread displayfeedmessage( "^1Not adding ^5Stattrak^1..." );
        return;
    }

    enable_weapon_flag_bit( FLAG_ADD_STATTRAK );
    level thread displayfeedmessage( "^2Adding ^5Stattrak^2!" );
}

// Toggle Random Camo
function gsc_toggle_random_camo( args ){

    val = is_weapon_setting_bit_enabled( FLAG_GIVE_CAMO );

    // Disable
    if( val ){
        disable_weapon_flag_bit( FLAG_GIVE_CAMO );
        level thread displayfeedmessage( "^1Not giving ^5Random Camo^1..." );
        return;
    }

    enable_weapon_flag_bit( FLAG_GIVE_CAMO );
    level thread displayfeedmessage( "^2Giving ^5Random Camo^2!" );
}

// Toggle No Attachments For Initial Pistol
function gsc_toggle_initial_pistol_attachments( args ){

    val = is_weapon_setting_bit_enabled( FLAG_INITIAL_PISTOL_ATTACHMENTS );

    // Disable
    if( val ){
        disable_weapon_flag_bit( FLAG_INITIAL_PISTOL_ATTACHMENTS );
        level thread displayfeedmessage( "^1Not removing ^5Initial Pistol Attachments^1..." );
        return;
    }

    enable_weapon_flag_bit( FLAG_INITIAL_PISTOL_ATTACHMENTS );
    level thread displayfeedmessage( "^2Removing ^5Initial Pistol Attachments^2!" );
}


function is_initial_pistol( weapon ){

    return (weapon.rootweapon == level.default_laststandpistol ) || (weapon.rootweapon == level.default_solo_laststandpistol);
}

function pap_apply_weapon_settings(){
    level endon("game_end");

    for(;;){
        level waittill("weapon_paped", weapon, player);
        #ifdef dev
            level thread debug_message("pap_apply_weapon_settings");
        #endif
        player thread apply_weapon_settings( weapon );
    }
}

function apply_weapon_settings( weapon, ammo_stock, ammo_clip ){
    self endon("disconnect");

    #ifdef dev
        if( !isdefined( self ) ) str_self = "Undefined";
        else if( self == level ) str_self = "Level";
        else if( isPlayer( self ) ) str_self = "Player "+self.name;
        else str_self = "Unknown";

        if( !isdefined( weapon ) ) str_weapon = "Undefined";
        else if( IsWeapon( weapon ) ) str_weapon = sprintf("Weapon {0} ({1})", weapon.name, MakeLocalizedString(weapon.displayname));
        else str_weapon = "Unknown";

        if( !isdefined( ammo_stock ) ) str_stock = "Undefined";
        else str_stock = ""+ammo_stock;

        if( !isdefined( ammo_clip ) ) str_clip = "Undefined";
        else str_clip = ""+ammo_clip;

        //level thread debug_message( sprintf( "Start apply_weapon_settings: Self = {0} | weapon = {1} | ammo_stock = {2} | ammo_clip = {3}", str_self, str_weapon, str_stock, str_clip) );
    #endif

    b_ephemeral = false;

    // Save the ammo of the weapon
    if( !isdefined( ammo_stock ) || !isdefined( ammo_clip ) ){
        #ifdef dev
            //self iPrintLnBold("No Ephemeral Enhancement weapon give detected...");
        #endif

        // Wait for weapon to be received
        while( !self HasWeapon(weapon, true) ) wait 0.05;
        // We need to do this so WallPower weapons don't bug out
        //foreach( w_list in self GetWeaponsListPrimaries()){
        foreach( w_list in self GetWeaponsList()){
            // Weapon found
            if( w_list.rootweapon == weapon.rootweapon ){
                w_ammo = w_list;
                break;
            }
        }

        // Weapon instantly removed, maybe it's a weapon from a loadout like the beastmode?
        if( !isdefined( w_ammo ) ){
            #ifdef dev
                level thread debug_message("^1Instant weapon taken ^5"+weapon.name);
            #endif
            return;
        }
        
        // Get the ammo of the weapon
        ammo_stock = self GetWeaponAmmoStock( w_ammo );
        ammo_clip = self GetWeaponAmmoClip( w_ammo );             


    }else{
        b_ephemeral = true;
    }

    // Weapons AAT
    str_aat = self get_aat_for_weapon( weapon );
    #ifdef dev
        //if( isdefined( str_aat ) ) self IPrintLnBold("AAT to set:^5 "+str_aat);
        //else self IPrintLnBold("AAT to set:^5 None");
    #endif

    // Build the gun with the weapon kits settings
    weapon = self get_buildkit_Weapon( weapon );

    // Get current camo index
    camo = get_weapon_camo_index( weapon );


    // Get the weapon options and AttachmentCosmeticVariantIndexes
    b_upgraded = is_weapon_upgraded( weapon );
    acvi = self getbuildkitattachmentcosmeticvariantindexes(weapon, b_upgraded);
    weapon_options = self getbuildkitweaponoptions(weapon, camo);

    // Save the weapon kit build
    base_weapon = weapon;
    b_modified_weapon = false;
    
    #ifdef dev
        /*str_weapon = "";
        str_weapon += MakeLocalizedString( weapon.displayname )+": ";
        foreach( attachment in base_weapon.attachments ) str_weapon += attachment+" ";
        level thread debug_message("Weapon Settings: ^5"+str_weapon);*/
    #endif


    // Don't change weapons that have forced attachments
    if( has_weapon_forced_attachments( weapon.rootweapon ) ){

        // Weapons with forced attachments only allow StatTrak flag
        if( !(is_weapon_setting_bit_active( FLAG_ADD_STATTRAK ) && weapon_supports_sttattrak(weapon)) ) return;

        a_attachments = level.zombie_weapons[weapon.rootweapon].force_attachments;
        weapon = GetWeapon(base_weapon.rootweapon.name, a_attachments); // Don't change base_weapon, we need it to detect the ammo
        weapon = self add_stattrak_to_weapon( weapon );

        acvi = 0;
        camo = 0;
        weapon_options = self calcweaponoptions(camo, 0, 0);

        // Remove the old weapon
        while( !self HasWeapon( base_weapon ) ) wait 0.05;
        self TakeWeapon( base_weapon );

        // Give the new weapon
        self GiveWeapon( weapon, weapon_options, acvi );

        // Set the correct ammo
        self SetWeaponAmmoStock(weapon, ammo_stock);
        self SetWeaponAmmoClip(weapon, ammo_clip);

        // Switch back to it
        self SwitchToWeaponImmediate( weapon );

        // Set the correct AAT
        self acquire( weapon, str_aat );

        #ifdef dev
            //self IPrintLnBold("FORCED ATTACHMENTS Stattrak: "+a_attachments);
        #endif
        return;
    }


    // No MP Attachments settings enabled
    if( is_weapon_setting_bit_active( FLAG_NO_MP_ATTACHMENTS ) && has_weapon_mp_attachments( weapon ) ){
        weapon = self remove_mp_attachments_from_weapon( weapon );
        b_modified_weapon = true;

        #ifdef dev
            //self IPrintLnBold("No MP Attachments: "+str_weapon);
        #endif
    }

    // Automatic Attachments settings enabled AND weapon has no attachments (no mp attachments is also handled inside)
    if( is_weapon_setting_bit_active( FLAG_AUTOMATIC_ATTACHMENTS ) && weapon_has_no_attachments( weapon ) && weapon_supports_any_non_ignored_attachment( weapon )  ){
        weapon = self give_weapon_attachments( weapon );
        b_modified_weapon = true;

        #ifdef dev
            //self IPrintLnBold("^2YES ^7Automatic Attachments: "+str_weapon);
        #endif
    }

    // Remove Attachments For Initial Pistol
    if( is_weapon_setting_bit_active( FLAG_INITIAL_PISTOL_ATTACHMENTS ) && is_initial_pistol( weapon ) && weapon.attachments.size > 0 ){
        weapon = weapon.rootweapon;
        b_modified_weapon = true;

        #ifdef dev
            //self IPrintLnBold("Removing attachment for initial pistol: "+str_weapon);
        #endif
    }

    // Give Stattrak
    if( is_weapon_setting_bit_active( FLAG_ADD_STATTRAK ) && weapon_supports_sttattrak(weapon) ){
        weapon = self add_stattrak_to_weapon( weapon );
        b_modified_weapon = true;

        #ifdef dev
            //self IPrintLnBold("Add Stattrak: "+weapon.name);
        #endif
    }

    // Give random camo to weapon without camo
    if( is_weapon_setting_bit_active( FLAG_GIVE_CAMO ) && !is_offhand_weapon( weapon ) && ( camo == 0 ) ){

        if( !isdefined( world.random_weapon_camos ) ) world.random_weapon_camos = [];
        if( !isdefined( world.random_weapon_camos[ MY_XUID ] ) )  world.random_weapon_camos[ MY_XUID ] = [];
        if( !isdefined( world.random_weapon_camos[ MY_XUID ][ weapon.rootweapon.name ] ) )  world.random_weapon_camos[ MY_XUID ][ weapon.rootweapon.name ] = RandomInt(get_last_camo_index()+1);

        camo = world.random_weapon_camos[ MY_XUID ][ weapon.rootweapon.name ];
        weapon_options = self getbuildkitweaponoptions(weapon, camo ); // Give random camo
        b_modified_weapon = true;

        #ifdef dev
            //self IPrintLnBold("Give random camo: "+camo);
        #endif
    }
    
    // We made at least 1 change to the base gun
    if( b_modified_weapon ){

        // Take the old weapon
        while( !self HasWeapon( base_weapon, true ) ) wait 0.05; // Works?
        self TakeWeapon( base_weapon, true ); // We made changes to the weapon, take the old one

        #ifdef dev
            //self IPrintLnBold("Giving Weapon: "+weapon.name+" With camo: "+camo);
        #endif

        // Give the new weapon
        self GiveWeapon( weapon, weapon_options, acvi );

        // Special check for initial pistol
        if( is_initial_pistol( weapon ) && self is_super_ee_completed() ){

            // Set the correct amount of ammo
            if( weapon_has_any_non_ignored_attachment( weapon ) ){
                self GiveStartAmmo( weapon );
            }else{
                self GiveMaxAmmo( weapon );
            }

            // Don't switch to it and don't make the initial raise animation
            if( !b_ephemeral ) self ShouldDoInitialWeaponRaise(weapon, false);
            // Ephemeral Enhancement is an exception
            else self SwitchToWeaponImmediate( weapon );

        // Normal gun
        }else{

            // Give ammo
            self SetWeaponAmmoStock(weapon, ammo_stock);
            self SetWeaponAmmoClip(weapon, ammo_clip);

            // Switch to the weapon
            if( !is_offhand_weapon( weapon ) ) self SwitchToWeaponImmediate( weapon );

            #ifdef dev
                //str_aat_base = self get_aat_for_weapon( base_weapon );
                //str_aat_weapon = self get_aat_for_weapon( weapon );

                //if( isdefined( str_aat_base ) ) self IPrintLnBold("Base weapon AAT "+str_aat_base);
                //self IPrintLnBold("Base weapon "+base_weapon.name);
                //if( isdefined( str_aat_weapon ) ) self IPrintLnBold("New weapon AAT "+str_aat_weapon);
            #endif

            // Set the correct AAT
            if( isdefined( str_aat ) ) self acquire( weapon, str_aat );
        }
    }

}


function give_weapon_attachments( weapon ){

    // This weapon doesn't support any attachment...
    if( !isdefined( weapon.supportedattachments ) || weapon.supportedattachments.size == 0 ) return weapon;

    n_max_attachments = 0; // Max amount of non optic attachments we can give

    // Get max amount
    if( IsInArray(array("smg","rifle","spread","mg"), weapon.rootweapon.weapclass)) n_max_attachments = 5;
    else if( IsInArray(array("sniper"), weapon.rootweapon.weapclass)) n_max_attachments = 4;
    else if( IsInArray(array("pistol"), weapon.rootweapon.weapclass)) n_max_attachments = 2;

    // This weapon class doesn't support attachments
    if( n_max_attachments < 1 ) return weapon;

    a_valid_optics = []; // Valid optics for the weapon
    a_valid_non_optics = []; // Valid non optics for the weapon
    a_give_attachments = []; // Attachments we decided that we are going to give
    a_best_optics = get_best_optic_for_weapon( weapon );
    a_best_non_optics = get_best_non_optics_for_weapon( weapon ); // We already select non ignorable attachments and check if no mp attachments flag is set inside the function

    // Get the Attachments that the weapon can use
    foreach( attach in weapon.rootweapon.supportedattachments ){
        if( is_optic( attach ) ) ArrayInsert(a_valid_optics, attach, a_valid_optics.size);
        else ArrayInsert(a_valid_non_optics, attach, a_valid_non_optics.size);
    }

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

    // Maybe there are no optics?
    n_max_attachments += a_give_attachments.size;

    // Give non optic
    if( a_valid_non_optics.size > 0 ){
        
        // Try to give best attachments first
        foreach( attach in a_best_non_optics ){
            // First, we are trying to give best attachments
            if( !IsInArray(a_valid_non_optics, attach)) continue;
            // New attachment is not compatible with current ones...
            if( !is_attachment_compatible( attach, a_give_attachments ) ) continue;

            ArrayInsert(a_give_attachments, attach, a_give_attachments.size);
            // We have given the max amount of attachments
            if( a_give_attachments.size >= n_max_attachments ) break;
        }

        // Give whatever compatible attachments are left
        while( a_give_attachments.size < n_max_attachments ){
            foreach( attach in a_valid_non_optics ){
                // We already have this attachment...
                if( IsInArray(a_give_attachments, attach) ) continue;
                // New attachment is not compatible with current ones...
                if( !is_attachment_compatible( attach, a_give_attachments ) ) continue;
                // We don't want these specific attachments...
                if( IsInArray(IGNORED_ATTACHMENTS, attach) ) continue;
                // No MP Attachments is active
                if( is_weapon_setting_bit_active( FLAG_NO_MP_ATTACHMENTS ) && IsInArray(MP_ATTACHMENTS, attach) ) continue;

                // New attachment is not compatible with current ones...
                ArrayInsert(a_give_attachments, attach, a_give_attachments.size);
                 // We have given the max amount of attachments
                if( a_give_attachments.size >= n_max_attachments ) break;
            }
            
            // The rest of the attachments are NOT compatible...
            break;
        }
    }

    upgraded = is_weapon_upgraded( weapon );

    // Give PAP attachments if upgraded
    if( upgraded ){
        ArrayInsert(a_give_attachments, "fmj", a_give_attachments.size);
        ArrayInsert(a_give_attachments, "extclip", a_give_attachments.size);
    }

    new_weapon = GetWeapon( weapon.rootweapon.name, a_give_attachments );

    return new_weapon;
}

function remove_mp_attachments_from_weapon( weapon ){

    new_attachments = [];
    b_upgraded = is_weapon_upgraded( weapon );
    camo = -1;

    if( b_upgraded ){

		no_upgraded_weapon = self getbuildkitweapon(weapon, !b_upgraded);
        str_attachments = no_upgraded_weapon.attachments;

        foreach( attachment in str_attachments ){
            // Skip the MP attachment
            if( IsInArray(MP_ATTACHMENTS, attachment) ) continue;

            // Save the no MP attachment
            ArrayInsert(new_attachments, attachment, new_attachments.size);
        }

        ArrayInsert(new_attachments, "fmj", new_attachments.size);
        ArrayInsert(new_attachments, "extclip", new_attachments.size);

        // Let's get PAP camo
        camo = get_pack_a_punch_camo_index( weapon );

    }else{
        foreach( attachment in weapon.attachments ){
            // Skip the MP attachment
            if( IsInArray(MP_ATTACHMENTS, attachment) ) continue;

            // Save the no MP attachment
            ArrayInsert(new_attachments, attachment, new_attachments.size);
        }        
    }

    new_weapon = GetWeapon( weapon.rootweapon.name, new_attachments );

    return new_weapon;
}

function get_pack_a_punch_camo_index( upgrade_weapon ){
    
    upgrade_weapon = self getbuildkitweapon(upgrade_weapon, true);
    prev_pap_index = upgrade_weapon.pap_camo_to_use;

	if(isdefined(level.pack_a_punch_camo_index_number_variants))
	{
		if(isdefined(prev_pap_index))
		{
			camo_variant = prev_pap_index + 1;
			if(camo_variant >= (level.pack_a_punch_camo_index + level.pack_a_punch_camo_index_number_variants))
			{
				camo_variant = level.pack_a_punch_camo_index;
			}
			return camo_variant;
		}
		camo_variant = randomintrange(0, level.pack_a_punch_camo_index_number_variants);
		return level.pack_a_punch_camo_index + camo_variant;
	}

	return level.pack_a_punch_camo_index;
}


function add_stattrak_to_weapon( weapon ){

    // Give Stattrak
    new_attachments = weapon.attachments;

    // Give Stattrak
    ArrayInsert(new_attachments, ATTACHMENT_STATTRAK, new_attachments.size);

    new_weapon = GetWeapon( weapon.rootweapon.name, new_attachments );

    return new_weapon;
}

function give_random_camo_to_weapon( weapon ){

    attachments = weapon.attachments;

    b_upgraded = is_weapon_upgraded( weapon );
    new_weapon = GetWeapon( weapon.rootweapon.name, attachments );
    acvi = self getbuildkitattachmentcosmeticvariantindexes(new_weapon, b_upgraded);
    weapon_options = self getbuildkitweaponoptions(weapon, RandomInt(get_last_camo_index()+1) ); // Give random camo

    self TakeWeapon( weapon );
    self GiveWeapon( new_weapon, weapon_options, acvi );
    self SwitchToWeaponImmediate( new_weapon );      
}

function get_last_camo_index(){

    // Already calculated, no need to repeat
    if( isdefined( level.last_camo_index ) ) return level.last_camo_index;

    n_max = 0; // Start with max as 0 to avoid errors
    for(row=0;row<CSV_ATTACHMENTSTABLE_ROW_SIZE;row++){

        type = tablelookupcolumnforrow(CSV_ATTACHMENTSTABLE, row, CSV_ATTACHMENTSTABLE_ATTACHMENT_TYPE);

        // Not a camo
        if( type != "camo" ) continue;

        n_index = int(tablelookupcolumnforrow(CSV_ATTACHMENTSTABLE, row, CSV_ATTACHMENTSTABLE_ATTACHMENT_INDEX));
        //level thread debug_message_instant("Camo found!: ^2"+n_index);
        //if( IsString(n_index)) level thread debug_message_instant("Camo found!: ^2STRING");
        //else if( IsInt(n_index)) level thread debug_message_instant("Camo found!: ^2INT");
        //else level thread debug_message_instant("Camo found!: ^2NUSE");

        if( n_index > n_max ) n_max = n_index;
    }

    level.last_camo_index = n_max;

    #ifdef dev
        //level thread debug_message("Last Camo Index: ^5"+level.last_camo_index);
    #endif

    return n_max;
}


function get_weapon_camo_index( weapon ){

    // It's upgraded and PAP set a camo
    if( is_weapon_upgraded( weapon ) ){

        // Weapon has been PAPed and it's been assigned a camo
        if( isdefined( weapon.pap_camo_to_use ) ) return weapon.pap_camo_to_use;

        //level thread debug_message("Checking camo index for non papped weapon");

        if(isdefined(level.pack_a_punch_camo_index_number_variants))
        {
            camo_variant = randomintrange(0, level.pack_a_punch_camo_index_number_variants);
            return level.pack_a_punch_camo_index + camo_variant;
        }
        return level.pack_a_punch_camo_index;
    }

    weapon_options = self GetBuildKitWeaponOptions(weapon);
    n_max_camo_option = get_last_camo_index();

    for( index=0; index<n_max_camo_option; index++ ){
        test_options = self GetBuildKitWeaponOptions(weapon, index);

        // Camo index found!
        if( weapon_options == test_options ) return index;
    }

    // Not found???
    level thread debug_message("^1Couldnt find camo index for weapon ^2"+MakeLocalizedString(weapon.rootweapon.displayname));

    return 0;
}


function get_best_optic_for_weapon( weapon ){

    w_name = weapon.rootweapon.name;
    w_class = weapon.rootweapon.weapclass;

    #ifdef dev
        //level thread debug_message("w_name ^5"+w_name);
        //level thread debug_message("w_class ^6"+w_class);
    #endif

    // Exceptions
    switch( MAP_NAME ){
        case THE_GIANT:
        {
            // More zoom is better to hit out of bounds button
            switch( w_class ){
                case "pistol":
                    return array("reflex");
            }

            // It's easier to hit bones with Varix than Thermal
            switch( w_name ){
                case "ar_cqb":
                case "ar_cqb_upgraded":
                    return array("dualoptic", "ir");
            }
            
            break;
        }
        case ZETSUBOU_NO_SHIMA:
        {
            switch( w_name ){
                // HVK on zetsubou is closest weapon to check zipline altar symbol
                case "ar_cqb":
                case "ar_cqb_upgraded":
                    return array("dualoptic", "ir");
            }

            break;
        }
        case REVELATIONS:
        {
            // It's easier to hit bones with Varix than Thermal
            switch( w_name ){
                case "ar_longburst":
                case "ar_longburst_upgraded":
                case "ar_cqb":
                case "ar_cqb_upgraded":
                    return array("dualoptic", "ir");
            }

            break;
        }
    }

    // Defaults
    switch( w_class ){
        case "rifle":
        case "mg":
        case "sniper":
            return array("ir", "dualoptic");
        
        case "pistol":
        case "smg":
        case "spread":
            return array("reddot");
        
        default:
            return array("reddot");
    }

}

function get_best_non_optics_for_weapon( weapon ){

    w_name = weapon.rootweapon.name;
    w_class = weapon.rootweapon.weapclass;

    // Exceptions
    switch( MAP_NAME ){
        case THE_GIANT:
        {
            // Faster ADS is better to hit out of bounds button
            switch( w_class ){
                case "pistol":
                    return array("quickdraw", "steadyaim" );
            }

            // Faster ADS is better to hit out of bounds button
            switch( w_name ){
                case "ar_marksman":
                {
                    if( is_weapon_setting_bit_active( FLAG_NO_MP_ATTACHMENTS ) ) return array("rf", "fastreload", "grip", "quickdraw", "steadyaim" );
                    return array("rf", "fmj", "grip", "quickdraw", "steadyaim" );
                    break;
                }
            }

            break;
        }
    }

    // Defaults
    switch( w_class ){
        case "rifle":
        case "mg":
        case "smg":
            return array("rf", "fastreload", "grip", "quickdraw", "steadyaim" );

        case "sniper":
            return array("rf", "fastreload", "stalker", "swayreduc" );
        
        case "pistol":
            return array("fastreload", "steadyaim" );

        case "spread":
            return array("rf", "fastreload", "extbarrel", "quickdraw", "stalker" );
        
        default:
            return array("rf", "fastreload", "grip", "quickdraw", "staler", "extbarrel" );
    }

}

function has_weapon_mp_attachments( weapon ){

    // Not upgraded
    if( !is_weapon_upgraded( weapon ) ){

        foreach( attachment in weapon.attachments ){
            if( IsInArray(MP_ATTACHMENTS, attachment) ) return true;
        }
        return false;
    }   

    // Upgraded
    b_upgraded = true;
    no_upgraded_weapon = self getbuildkitweapon(weapon, !b_upgraded);
    str_attachments = no_upgraded_weapon.attachments;

    a_duplicate_tracker = [];

    foreach( attachment in str_attachments ){
        // PaP attachments don't count but they can't be duplicated
        if( IsInArray(PAP_ATTACHMENTS, attachment) ){
            if( IsInArray(a_duplicate_tracker, attachment) ) return true;
            ArrayInsert(a_duplicate_tracker, attachment, a_duplicate_tracker.size); // First time we encounter a PaP attachment
            continue;
        }

        // Other MP attachments
        if( IsInArray(MP_ATTACHMENTS, attachment) ) return true;
    }
    return false;
}

function weapon_has_no_attachments( weapon ){

    // Not upgraded, there should be 0 attachments
    if( !is_weapon_upgraded( weapon ) ){
        // Misc attachments don't count as real attachments
        foreach( attachment in weapon.attachments ) if( !IsInArray(IGNORED_ATTACHMENTS, attachment)){
            //self IPrintLnBold("Attachment detected: ^6"+attachment);
            return false;
        }
        return true;
    }

    b_upgraded = false;
    no_upgraded_weapon = self getbuildkitweapon(weapon, b_upgraded);

    foreach( attachment in no_upgraded_weapon.attachments ) if( !IsInArray(IGNORED_ATTACHMENTS, attachment) && !IsInArray(PAP_ATTACHMENTS, attachment)){
        //self IPrintLnBold("UPGRADED Attachment detected: ^6"+attachment);
        return false;
    }
    return true;
}

function has_weapon_forced_attachments( weapon ){

    // Maybe we are on a custom map that uses a different var or system?
    if( !isdefined( level.zombie_weapons ) ) return false;

    // Not a weapon in the array
    if( !isdefined( level.zombie_weapons[ weapon ] ) ) return false;

    // Attachments are not defined
    if( !isdefined( level.zombie_weapons[ weapon ].force_attachments ) ) return false;

    // Attachments are not an array
    if( !IsArray( level.zombie_weapons[ weapon ].force_attachments ) ) return false;

    // Attachments are not an array
    return level.zombie_weapons[ weapon ].force_attachments.size > 0;
}


function is_attachment_compatible( new_attachment, a_attachments ){

    // Find itemrow of the attachment
    itemrow = tablelookuprownum(CSV_ATTACHMENTSTABLE, CSV_ATTACHMENTSTABLE_ITEM_NAME, new_attachment);

    // Couldn't find itemrow, let's assume it's not compatible
    if( itemrow < 0 ) return false;


    csv_compatible_attachments = tablelookupcolumnforrow(CSV_ATTACHMENTSTABLE, itemrow, CSV_ATTACHMENTSTABLE_COMPATIBLE_ATTACHMENTS);
    a_compatible_attachments = strtok(csv_compatible_attachments, " ");

    // Check that all attachments are compatible with the new one
    foreach( attachment in a_attachments ){
        if( !IsInArray(a_compatible_attachments, attachment) ) return false;
    }

    return true;
}

/* Taken from scripts\shared\custom_class.csc
	Name: is_optic
	Namespace: customclass
	Checksum: 0xB71F6687
	Offset: 0xDE0
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function is_optic(attachmentname)
{
    //TableLookupRowNum(filename, search_column_num, search_value)
	row = tablelookuprownum(CSV_ATTACHMENTSTABLE, CSV_ATTACHMENTSTABLE_ITEM_NAME, attachmentname);
	// Couldn't find the file or attachment?
	if(row < 0){
        #ifdef dev
            level thread debug_message("Couldn't find rownum for attachment: "+attachmentname);
        #endif
        return false;
    }

	group = tablelookupcolumnforrow(CSV_ATTACHMENTSTABLE, row, CSV_ATTACHMENTSTABLE_ATTACHMENT_TYPE_NAME);
	return group == "optic";
}

#endregion

#region Player Items
// BGB
function gsc_bgb( args = undefined ){

    // Check there is a name arg
    if( args.size < 1){
        self IPrintLnBold("^1Missing ^5Gum name");
        return;
    }

    // GUM
    str_bgb = args[0];

    // Check if the player wants to have no gum at all
    switch( tolower( str_bgb ) ){
        case "none":
        case "nogum":
        case "empty":
        case "take":
        case "remove":
        {
            
            if( isdefined( self.bgb ) && self.bgb == "none" ){
                self IPrintLnBold( "^1You already don't have a gum!" );
                return;
            }

            self IPrintLnBold( sprintf("^1Taking your gum ^5{0}", parse_bgb_name( self.bgb ) ) );
            self [[ @bgb<scripts\zm\_zm_bgb.gsc>::give ]]( BGB_NO_GUM );
            return;
        }
    }

    // Valid gum?
    bgb = get_bgb_name( str_bgb );
    
    // Invalid BGB name
    if( !isdefined( bgb ) ){
        self IPrintLnBold( sprintf("^1Invalid Gum name ^5{0}", str_bgb) );
        return;
    }

    self IPrintLnBold( sprintf("^2Giving gum {0}", parse_bgb_name( bgb )) );

    self notify("bgb_gumball_anim_give", bgb); // Used for eye candy, flavor hexed and tone death gums
    self [[ @bgb<scripts\zm\_zm_bgb.gsc>::give ]]( bgb );
}

// Alternative Ammo Type
function gsc_aat( args = undefined ){

    // Check there is a name arg
    if( args.size < 1){
        self IPrintLnBold("^1Missing ^5AAT name");
        return;
    }

    // AAT
    str_aat = args[0];
    aat = get_aat_name( str_aat );
    
    // Invalid AAT name
    if( !isdefined( aat ) ){
        self IPrintLnBold( sprintf("^1Invalid Alternative Ammo Type name ^5{0}", str_aat) );
        return;
    }

    // Check for valid gum to give AAT
    w_current = self GetCurrentWeapon();
    if( !isdefined( w_current ) ){
        self IPrintLnBold( sprintf( "^1Can't find currently used weapon to give AAT ^2{0}",  parse_aat_name( aat ) ) );
        return;
    }

    // Weapon doesn't allow AATs
    if( is_exempt_weapon( get_nonalternate_weapon( w_current ) ) || !is_weapon_upgraded( w_current ) ){
        self IPrintLnBold( sprintf("^1Weapon ^5{0} ^1Doesn't allow ^5AATs", MakeLocalizedString( w_current.displayname ) ) );
        return;
    }

    // Get current aat
    old_aat =  get_aat_for_weapon( w_current );
    if( !isdefined( old_aat ) ) old_aat = "none";

    // Already have the AAT
    if( old_aat == aat ){
        self IPrintLnBold( sprintf("^1Weapon ^5{0} ^1Already has {1}", MakeLocalizedString( w_current.displayname ), parse_aat_name( aat ) ) );
        return;
    }
    
    if( aat == "none" ){
        self remove( w_current );
        self IPrintLnBold( sprintf("Taking {0} from weapon ^5{1}", parse_aat_name( old_aat ), MakeLocalizedString( w_current.displayname ) ) );
    }else{
        self acquire( w_current, aat );
        if( old_aat == "none" ) self IPrintLnBold( sprintf("^7Giving ^5{0} ^7 Alternative Ammo Type to weapon ^5{1}", parse_aat_name( aat ), MakeLocalizedString( w_current.displayname ) ) );
        else self IPrintLnBold( sprintf("Changing from {0}^7 Alternative Ammo Type to {1}^7 on weapon ^5{2}", parse_aat_name( old_aat ), parse_aat_name( aat ), MakeLocalizedString( w_current.displayname ) ) );
    }   

}

// Player Score
function gsc_points( args = undefined ){

    // Check there is a points arg
    if( args.size < 1){
        self IPrintLnBold("^1Missing ^5Score amount");
        return;
    }

    str_points = args[ 0 ];

    // Invalid points amount
    if( !StrIsInt( str_points ) ){
        self IPrintLnBold( sprintf("^1Invalid Points amount ^5{0}", str_points) );
        return;
    }

    // Convert to int
    int_points = int( str_points );

    // Already the desired amount of points?
    if( int_points == self.score ){
        self IPrintLnBold( sprintf("^1Your points amount is already ^5{0}", self.score) );
        return;
    }

    // Give or Take points?
    n_points_diff = int_points - self.score;

    if( n_points_diff > 0 ){ // Give

        self.score = self.score + n_points_diff;
        self.pers["score"] = self.score;
        //self incrementplayerstat("scoreEarned", n_points_diff);

        // Daily challenge
        level notify("earned_points", self, n_points_diff);

        // Fake it to total stats
        self.score_total = self.score_total + n_points_diff;
        level.score_total = level.score_total + n_points_diff;

        self IPrintLnBold( sprintf("Score ^2incremented to ^5{0}", self.score) );

    }else{ // Take

        self.score = self.score + n_points_diff;
        self.pers["score"] = self.score;
        //self incrementplayerstat("scoreSpent", n_points_diff);

        // Origins points spent challenge and daily challenge
        level notify("spent_points", self, n_points_diff);

        self IPrintLnBold( sprintf("Score ^1decremented to ^5{0}", self.score) );
    }
}
#endregion

#region Respawn Points
// Initial Players Spawns, spawns a model of the players on the starting spawn locations
function gsc_initial_players_spawns( args = undefined ){

    // TODO: check that the characters are in the order of the game when using the command to change character, so changing to character 0 is the first one of this
    // Initialize models for the clones
    if( !isdefined( level.mdl_char_bodies ) ){
        level.mdl_char_bodies = [];
        if( MAP_NAME == "zm_zod" ){
            level.mdl_char_bodies[0] = "c_zom_zod_boxer_mpc_fb";
            level.mdl_char_bodies[1] = "c_zom_zod_detective_mpc_fb";
            level.mdl_char_bodies[2] = "c_zom_zod_femme_mpc_fb";
            level.mdl_char_bodies[3] = "c_zom_zod_magician_mpc_fb";            
        }else{
            level.mdl_char_bodies[0] = "c_zom_der_dempsey_mpc_fb";
            level.mdl_char_bodies[1] = "c_zom_der_nikolai_mpc_fb";
            level.mdl_char_bodies[2] = "c_zom_der_richtofen_mpc_fb";
            level.mdl_char_bodies[3] = "c_zom_der_takeo_mpc_fb";            
        }

    }

    // Delete previous clones
    if( isdefined( level.ips_clones ) ) self gsc_delete_initial_players_spawns();

    level.ips_clones = [];

    a_new_origin = struct::get_array( "initial_spawn_points", "targetname" );

    if( !isdefined( a_new_origin ) ){
        level thread debug_message("^1Rarete, no new_origin...");
        return;
    }

    foreach( index, new_origin in a_new_origin){

        p_clone = make_player_clone( index );

        w_current = array::random( getarraykeys( level.zombie_weapons ) );
        #ifdef dev
            //if( isdefined( w_current ) ) level thread debug_message( "^5"+w_current.name );
        #endif

        // Weapon failsafe
        if( !isdefined( w_current ) || !IsWeapon( w_current ) || ( w_current == level.weaponnone ) ) w_current = self GetCurrentWeapon();

        // Set the weapon for the clone if valid
        if( isdefined( w_current ) && IsWeapon( w_current ) && ( w_current != level.weaponnone ) )
        {
            w_clone = [[ @zm_utility<scripts\zm\_zm_utility.gsc>::spawn_buildkit_weapon_model ]] (self, w_current, undefined, p_clone gettagorigin("tag_weapon_right"), p_clone gettagangles("tag_weapon_right"));
            w_clone linkto(p_clone, "tag_weapon_right");
            //w_clone setowner(self);
            p_clone.w_clone = w_clone;
        }

        v_return_pos = new_origin.origin;
        p_clone MoveTo(v_return_pos, 0.05);
        p_clone.angles = new_origin.angles;
        ArrayInsert(level.ips_clones, p_clone, level.ips_clones.size);
    }

    self IPrintLnBold("^2Created ^5Initial Player Spawns ^2clones");
}

// Delete Initial Players Spawns, Deletes already spawned models of the players on the starting spawn locations
function gsc_delete_initial_players_spawns( args = undefined ){

    // Check there are clones to remove
    if( !isdefined( level.ips_clones ) ){
        self IPrintLnBold("^1No clones to remove from Initial Player Spawns...");
        return;
    }

    // Delete previous clones
    foreach( clone in level.ips_clones ){
        // Delete clone's weapon
        if( isdefined( clone.w_clone ) ) clone.w_clone delete();
        clone delete();
    }
    level.ips_clones = undefined;

    self IPrintLnBold("^1Removed ^5Initial Player Spawns ^1clones");
}

// Player Respawn Points, spawns a model of the players on the player Respawn Point locations
function gsc_player_respawn_points( args = undefined ){


    // Initialize models for the clones
    if( !isdefined( level.mdl_char_bodies ) ){
        level.mdl_char_bodies = [];
        if( MAP_NAME == "zm_zod" ){
            level.mdl_char_bodies[0] = "c_zom_zod_boxer_mpc_fb";
            level.mdl_char_bodies[1] = "c_zom_zod_detective_mpc_fb";
            level.mdl_char_bodies[2] = "c_zom_zod_femme_mpc_fb";
            level.mdl_char_bodies[3] = "c_zom_zod_magician_mpc_fb";            
        }else{
            level.mdl_char_bodies[0] = "c_zom_der_dempsey_mpc_fb";
            level.mdl_char_bodies[1] = "c_zom_der_nikolai_mpc_fb";
            level.mdl_char_bodies[2] = "c_zom_der_richtofen_mpc_fb";
            level.mdl_char_bodies[3] = "c_zom_der_takeo_mpc_fb";            
        }

    }

    // Delete previous clones
    if( isdefined( level.prp_clones ) ) self gsc_delete_player_respawn_points();

    level.prp_clones = [];

    if( MAP_NAME == "zm_genesis" ){
        all_ents = getEntArray();
        self IPrintLnBold("Deleted things: ^5"+all_ents.size);
        //for(i=0;i<250;i++){
        for(i=0;i<all_ents.size;i++){
            if( !isdefined( all_ents[ i ] ) ) break;

            all_ents[ i ] delete();
        }
    }


    // All player respawn points
	a_s_respawn_point = struct::get_array("player_respawn_point", "targetname");

    // ABH respawn points
    a_abh_locations = [];

    avoid_zone = ( IsPlayer( self ) && isdefined( self.zone_name ) && self.zone_name != "" ) ? level.zones[ self.zone_name ] : undefined;
    
    if( isdefined( avoid_zone ) ) self IPrintLnBold("Zone to avoid ^1"+basic_parser(self.zone_name));

	foreach(s_respawn_point in a_s_respawn_point)
	{
        if( !is_point_inside_enabled_zone( s_respawn_point.origin, avoid_zone ) ){
            //self IPrintLnBold("^1ABH on disabled zone...");
            continue;
        }
        ArrayInsert(a_abh_locations, s_respawn_point, a_abh_locations.size);
	}

    // Map has a custom check to delete some Respawn Locations from ABH pool
	if(isdefined(level.zm_bgb_anywhere_but_here_respawn_override)) a_abh_locations = [[level.zm_bgb_anywhere_but_here_respawn_override]](a_abh_locations);

    if( !isdefined( a_s_respawn_point ) ){
        level thread debug_message("^1Rarete, no a_s_respawn_point...");
        return;
    }


	foreach( s_respawn_point in a_s_respawn_point )
	{

        //if( level.prp_clones.size > 30 ) break;

        if( IsInArray( a_abh_locations, s_respawn_point ) ){
            p_clone = make_default_clone( s_respawn_point, "c_zom_zod_beast_mpc_fb" );

        }else{
            p_clone = make_default_clone( s_respawn_point );
        }

        ArrayInsert(level.prp_clones, p_clone, level.prp_clones.size);


        a_respawn_points = struct::get_array(s_respawn_point.target, "targetname");
		foreach(spawn_point in a_respawn_points)
		{
            p_clone = make_player_clone( spawn_point.script_int );
            w_current = array::random( getarraykeys( level.zombie_weapons ) );

            // Weapon failsafe
            if( !isdefined( w_current ) || !IsWeapon( w_current ) || ( w_current == level.weaponnone ) ) w_current = self GetCurrentWeapon();

            if( isdefined( w_current ) && IsWeapon( w_current ) && ( w_current != level.weaponnone ) )
            {
                w_clone = [[ @zm_utility<scripts\zm\_zm_utility.gsc>::spawn_buildkit_weapon_model ]] (self, w_current, undefined, p_clone gettagorigin("tag_weapon_right"), p_clone gettagangles("tag_weapon_right"));
                w_clone linkto(p_clone, "tag_weapon_right");
                p_clone.w_clone = w_clone;
            }

            //v_return_pos = spawn_point.origin + vectorscale((0, 0, 1), 60);
            v_return_pos = spawn_point.origin;
            p_clone MoveTo(v_return_pos, 0.05);
            p_clone.angles = spawn_point.angles;
            ArrayInsert(level.prp_clones, p_clone, level.prp_clones.size);

		}
	}


    switch( MAP_NAME ){

        case "zm_zod":
        {
            n_ee_quest_state = level clientfield::get("ee_quest_state");
            var_18bac0f0 = array((2544, -3432, -368), (2708, -3432, -368), (2544, -3624, -368), (2708, -3624, -368));

            if( IsPlayer( self ) ) v_angles = self GetPlayerAngles();
            else v_angles = (0,0,0);

            foreach( num_index, s_spawnlocation in var_18bac0f0 ){
                s_spawnpoint = spawnstruct();
                s_spawnpoint.origin = s_spawnlocation;
                s_spawnpoint.angles = v_angles;

                if( n_ee_quest_state == 1 ){

                    p_clone = make_player_clone( num_index );
                    w_current = array::random( getarraykeys( level.zombie_weapons ) );

                    // Weapon failsafe
                    if( !isdefined( w_current ) || !IsWeapon( w_current ) || ( w_current == level.weaponnone ) ) w_current = self GetCurrentWeapon();

                    if( isdefined( w_current ) && IsWeapon( w_current ) && ( w_current != level.weaponnone ) )
                    {
                        w_clone = [[ @zm_utility<scripts\zm\_zm_utility.gsc>::spawn_buildkit_weapon_model ]] (self, w_current, undefined, p_clone gettagorigin("tag_weapon_right"), p_clone gettagangles("tag_weapon_right"));
                        w_clone linkto(p_clone, "tag_weapon_right");
                        p_clone.w_clone = w_clone;
                    }

                    v_return_pos = s_spawnpoint.origin;
                    p_clone MoveTo(v_return_pos, 0.05);
                    p_clone.angles = s_spawnpoint.angles;
                    ArrayInsert(level.prp_clones, p_clone, level.prp_clones.size);

                }else{
                    p_clone = make_default_clone( s_spawnpoint );
                    ArrayInsert(level.prp_clones, p_clone, level.prp_clones.size);
                }

            }

            break;
        }

        case "zm_stalingrad":
        {

            break;
        }

    }

    self IPrintLnBold("^2Created ^5Player Respawn Point ^2clones");
}

// Delete Player Respawn Points, Deletes already spawned models of the players on the starting spawn locations
function gsc_delete_player_respawn_points( args = undefined ){

    // Check there are clones to remove
    if( !isdefined( level.prp_clones ) ){
        self IPrintLnBold("^1No clones to remove from Player Respawn Points...");
        return;
    }

    // Delete previous clones
    foreach( clone in level.prp_clones ){
        // Delete clone's weapon
        if( isdefined( clone.w_clone ) ) clone.w_clone delete();
        clone delete();
    }
    level.prp_clones = undefined;

    self IPrintLnBold("^1Removed ^5Player Respawn Point ^1clones");
}
#endregion





// Complete EE Step
function gsc_ee( args ){

    if( !isdefined( level.ee_steps ) ){ // EE steps not collected
        self iPrintLnBold( "^1Error^7, no EE steps detected" );
        return;
    }

    if( !isdefined( args ) ){ // EE steps not collected
        self iPrintLnBold( "^1Error^7, UNDEFINED args on gsc_ee" );
        return;
    }

    if( args.size < 1 ){ // EE steps not collected
        self iPrintLnBold( "^1Error^7, MISSING arg on gsc_ee" );
        return;
    }

    ee_step_name = args[ 0 ];

    if( !isdefined( ee_step_name ) ){ // No ee step name
        self iPrintLnBold( "^1Error^7, missing argument on GSC_EE" );
        return;        
    }

    if( !isdefined( level.ee_steps[ ee_step_name ] ) ){ // EE step name is not registered
        self iPrintLnBold( "^1Error^7, can't find ^5"+ee_step_name+" ^7step" );
        return;        
    }

    if( level.ee_being_completed > 0 ){ // There is an EE being autocompleted
        self iPrintLnBold(  text_error()+"there is already an EE step being completed..." );
        #ifdef dev
            self iPrintLnBold( "^5Current EE steps: ^1"+level.ee_being_completed );
        #endif
        return; 
    }

    #ifdef dev
        self iPrintLnBold( "^5Current EE steps: ^2"+level.ee_being_completed );
    #endif

    // Give God to players that don't have it
    if( !IS_STATE_BEING_LOADED ){

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

    }

    // Autocomplete EE step
    self [[ level.ee_steps[ ee_step_name ] ]]();

    // Take God from players that didn't have it
    if( !IS_STATE_BEING_LOADED ){

        foreach(player in GetPlayers()){

            // Player had God beforehand, no need to take it from him
            if(IsInArray(a_god_players, PLAYER_XUID) ) continue;

            // Take God
            player thread deactivate_god_in_3_seconds();
        }

    }
}



/* TODO:
    -fix non open table craftables
*/
// OPEN ALL OBSTACLES AND ACTIVATE EVERYTHING
function gsc_open_all( args )
{

    // Everything is already open
    if( isdefined(level.open_all_lui) ){
        self iPrintLnBold("^5All doors already opened!");
        return;
    }

    level.open_all_lui = true;
    self iPrintLnBold("^5Opening all doors!");

    self open_sesame(); // Debris, doors, airlocks and power

    // Todo: This doesn't work properly, let's comment them for now
    //self get_craftables_pieces(); // Buildables
    //self build_all_craftables();

    self iPrintLnBold("Doors opening finished!");
}

// Since you are messing with shino numa triggers, do you have experience with buildable triggers? I want to autocraft buildables but
function open_sesame(){ // Open all doors and activate power

	if( is_true( level.lui_open_sesame ) ){
		level.host iPrintLnBold("^2All Doors and power already opened!");
		return;
	}

	level.lui_open_sesame = true;

    // Power
    level flag::set( "power_on" );
    level clientfield::set( "zombie_power_on", 1 );

    foreach( power_trig in getentarray( "use_elec_switch", "targetname" ) ) {
        if ( isdefined( power_trig.script_int ) ){
            level flag::set( "power_on" + power_trig.script_int );
            level clientfield::set( "zombie_power_on", power_trig.script_int );
        }
    }

    level specific_power();

    // Blockers
    setdvar( DVAR_ZOMBIE_UNLOCK_ALL, 1 );

    foreach( targetname in array( "zombie_door", "zombie_debris", "zombie_airlock_buy" ) ){

        foreach( blocker in getentarray( targetname, "targetname" ) ){

            if( !isdefined( blocker.target ) ){
                #ifdef dev
                    level thread debug_message("Undefined blocker.target.target");
                    if( isdefined( level.host ) ) level.host setOrigin( blocker.origin );
                    wait 3;
                #endif
            }else{
                junk = getentarray( blocker.target, "targetname" );
                if( !isdefined( junk ) ){

                    #ifdef dev
                        level thread debug_message( sprintf( "Undefined getentarray( blocker.target, targetname ) {0}", blocker.target ) );
                        if( isdefined( level.host ) ) level.host setOrigin( blocker.origin );
                        wait 3;
                    #endif

                }         
            }

            if( isdefined( blocker.zombie_cost ) ) blocker.zombie_cost = 0;
            blocker notify( "trigger", level.host );
        }

    }

    foreach( flag_blocker in GetEntArray( "flag_blocker", "targetname" ) ){

        level flag::set( flag_blocker.script_flag_wait );
        #ifdef dev
            level thread debug_message_instant( "Flag Blocker ^5"+flag_blocker.script_flag_wait );
        #endif
    }

    level specific_blockers();

    level notify( "open_sesame" );
    wait 1;
    setdvar( DVAR_ZOMBIE_UNLOCK_ALL, 0);
}


function build_all_craftables(){

    //level thread debug_message( "build_all_craftables" );

    foreach( uts in level.a_uts_craftables ){
        //wait 0.05;

        //level thread debug_message( "uts.craftablestub.name: "+uts.craftablestub.name );

        // str_craftable = uts.craftablestub.name;


        // You can't craft craftable tables
        if( uts.craftablestub.name == "open_table"){
            #ifdef def
                level thread debug_message( "Skipping craftable ^5"+uts.craftablestub.name );
            #endif
            continue;
        }

        // Already built
        if( is_true( level.craftables_crafted[ uts.craftablespawn.craftable_name ] ) ){
            #ifdef dev
                level thread debug_message( "Already crafted ^5"+uts.craftablestub.name );
            #endif
            continue;
        }


        //Craft the item depending if open_table
        if( is_true( uts.craftablestub.is_open_table ) ){

            #ifdef dev
                level thread debug_message( "Building open table craft: ^5"+uts.craftablestub.name );
            #endif

            self craft_open_table_object( uts.craftablestub.name, undefined );  // str_craftable, str_zoneToCraft
        }else{

            #ifdef dev
                level thread debug_message( "Building predefined table craft: ^5"+uts.craftablestub.name );
            #endif

            self get_full_craftable_object( uts.craftablestub.name );
            self complete_craftable( uts.craftablestub.name );

        }

        
    }

}

function specific_power(){

    switch( MAP_NAME ){
        case "zm_zod":
        {
        }
        case "zm_factory":
        {
            getent("use_power_switch", "targetname") notify( "trigger", level.host );
        }
        case "zm_castle":
        {
            getent("use_power_switch", "targetname") notify( "trigger", level.host );
            level thread de_pap_activate_lui(); // Custom pap activate
        }
        case "zm_island":
        {
        }
        case "zm_stalingrad":
        {
        }
        case "zm_genesis":
        {
        }
        case "zm_asylum":
        {
            getent("use_master_switch", "targetname") notify( "trigger", level.host );
        }
        case "zm_sumpf":
        {
        }
        case "zm_prototype":
        {
        }
        case "zm_theater":
        {
        }
        case "zm_cosmodrome":
        {
        }
        case "zm_temple":
        {
        }
        case "zm_moon":
        {
        }
        case "zm_tomb":
        {
            level thread activate_origins_generators();
        }
        default:
        {
            power_trigger = getent("use_power_switch", "targetname");
            if( isdefined( power_trigger )) getent("use_power_switch", "targetname") notify( "trigger", level.host );

            power_trigger = getent("use_master_switch", "targetname");
            if( isdefined( power_trigger )) getent("use_master_switch", "targetname") notify( "trigger", level.host );
        }
    }

}

function specific_blockers(){
    
    switch( MAP_NAME ){
        case "zm_zod":
        {
            level thread open_all_smashables();
            break;
        }
        case "zm_factory":
        {
            break;
        }
        case "zm_castle":
        {
            level flag::set("castle_teleporter_used"); // Enable Rocket test area
            self thread activate_flinger_pads(); // Flinger pads
            break;
        }
        case "zm_island":
        {
            break;
        }
        case "zm_stalingrad":
        {
            break;
        }
        case "zm_genesis":
        {
            break;
        }
        case "zm_asylum":
        {
            break;
        }
        case "zm_sumpf":
        {
            break;
        }
        case "zm_prototype":
        {
            break;
        }
        case "zm_theater":
        {
            break;
        }
        case "zm_cosmodrome":
        {
            break;
        }
        case "zm_temple":
        {
            break;
        }
        case "zm_moon":
        {
            break;
        }
        case "zm_tomb":
        {
            level.host thread open_gramophone_doors();
            level notify( "open_all_gramophone_doors" );
            level thread enable_agartha_zone();
            break;
        }
        default:
        {
        }


    }

}

function gsc_enable_especial_triggers( args ){

    // Already active
    if( isdefined( level.surtr_special_triggers ) ){
        self IPrintLnBold("^5Special Triggers ^1already active...");
        return;
    }

    // Avoid calling this again
    level.surtr_special_triggers = true;

    // Show everyone
    level thread displayfeedmessage( "^5Special Triggers ^2Enabled!" );

    // Enable special triggers
    set_trainer_triggers();
}

function set_trainer_triggers(){

    switch( MAP_NAME ){
        case "zm_zod":
        {
            
            level thread infinite_beastmode();
            level thread electric_rails();
            level thread smashable_triggers();
            return;
        }
        case "zm_factory":
        {
            level thread watch_ee_control_panel();
            level thread watch_ee_hide_and_seek();
            level thread watch_ee_extra_events();
            level thread autocomplete_hidden_perk_quest();
            level thread watch_flytrap_prize();
            return;
        }
        case "zm_castle":
        {
            // General
            level thread watch_ee_wisps(); // Time travel wisps
            self thread get_ragnarok_parts(); // Get gravityspikes parts
            //level thread activate_pressure_pads();
            //level flag::set( "grav_off_for_ee" ); // Inf low gravity

            // Storm bow
            level thread watch_beacons(); // Beacons
            level thread watch_for_weather_vane(); // Weather vane
            return;
        }
        case "zm_island":
        {
            level thread watch_anti_aircraft();// Anti aircraft trigger
            return;
        }
        case "zm_stalingrad":
        {
            return;
        }
        case "zm_genesis":
        {
            return;
        }
        case "zm_asylum":
        {
            return;
        }
        case "zm_sumpf":
        {
            return;
        }
        case "zm_prototype":
        {
            return;
        }
        case "zm_theater":
        {
            return;
        }
        case "zm_cosmodrome":
        {
            return;
        }
        case "zm_temple":
        {
            return;
        }
        case "zm_moon":
        {
            return;
        }
        case "zm_tomb":
        {
            level thread watch_air_staff_step_2();
            level thread watch_ice_staff_step_2();
            level thread watch_fire_staff_step_2();            
            level thread watch_elec_staff_step_2();

            level thread general_watch_ee_mechz_hole();
            level thread stwb_spawns();
            return;
        }
        default:
        {
            level thread debug_message("^5Custom maps ^1don't support ^6trainer triggers^1.");
            return;
        }

    }

}