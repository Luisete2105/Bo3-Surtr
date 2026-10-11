function miscellaneous_zombie_fixes(){

    // General fixes
    level thread zm_fixes();

    switch( MAP_NAME ){

        case "zm_zod":
        {
            // Make EE doable on any N of players
            level thread zod_fixes();
            break;
        }
        case "zm_factory":
        {
            break;
        }
        case "zm_castle":
        {
            // Make EE doable without upgrading all bows
            level thread castle_fixes();
            break;
        }
        case "zm_island":
        {
            break;
        }
        case "zm_stalingrad":
        {
            // Manages splitting on Fly+N EE splits
            level thread dragon_departures_monitor();
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
            // Make EE doable on any N of players
            level thread cosmodrome_fixes();
            break;
        }
        case "zm_temple":
        {
            // Make EE doable on any N of players
            level thread temple_fixes();
            break;
        }
        case "zm_moon":
        {
            break;
        }
        case "zm_tomb":
        {
            // Register fist weapons as melee to make "Weapon" command work properly
            level thread tomb_fixes();
            break;
        }

    }


}


#region bgb

function zm_fixes(){

    /* zm_bgb_flavor_hexed
        This allows us to get the correct number of flavor hexed uses.
        With this we can save and set the correct amount of uses for save states.
    */
    level thread zm_flavor_hexed_fix();

    // Dev 2 error may be produced when a debris doesn't have .target defined.
    //level thread fix_undefined_target_blockers();
}

function zm_flavor_hexed_fix(){
    
    while( !isdefined( level.bgb ) ) wait 0.05;
    while( !isdefined( level.bgb[ "zm_bgb_flavor_hexed" ] ) ) wait 0.05;

    level.bgb[ "zm_bgb_flavor_hexed" ].disable_func = ::lui_flavor_hexed_disable_func;
}

function is_using_flavor_hexed(){

    if( self.bgb == "none" ) return false; // No current gum
    if( isinarray(self.bgb_pack, self.bgb ) ) return false; // Gum is on player's pack
    if( !isdefined( self.a_str_flavor_hexed_bgb ) ) return false; // Undefined flavor hexed gum array

    return true;
}


function lui_flavor_hexed_disable_func(){
    self notify( "lui_flavor_hexed" );
    self endon( "lui_flavor_hexed" );

    self thread lui_flavor_hexed_endons();

    self waittill( "bgb_update", new_gum, old_gum); // Taking Flavor Hexed from player to be able to give a random gum
    self waittill( "bgb_update", new_gum, old_gum); // Giving first random gum due to Flavor Hexed
    self waittill( "bgb_update", new_gum, old_gum); // Taking first random gum to be able to give second random gum
    self waittill( "bgb_update", new_gum, old_gum); // Giving second random gum due to Flavor Hexed

    // Game doesn't re-empty the array, so by doing it ourselves when the 2nd random gum is given, we can detect it's the 2nd use!
    self.a_str_flavor_hexed_bgb = [];

    self waittill( "bgb_update", new_gum, old_gum); // Second random gum from Flavor Hexed is over!

    //self IPrintLnBold( "Flavor Hexed Over" );

    // Game doesn't undefine the array, this way we can detect that Flavor Hexed uses are done!
    self.a_str_flavor_hexed_bgb = undefined;
    self notify( "lui_flavor_hexed" );
}

function lui_flavor_hexed_endons(){
    self endon( "lui_flavor_hexed" );

    self util::waittill_any( "disconnect", "bled_out", "bgb_gumball_anim_give" );

    self.a_str_flavor_hexed_bgb = undefined;
    self notify( "lui_flavor_hexed" );
}

#endregion

#region zod

function zod_fixes(){

    // Allows EE to be doable on solo
    level thread zod_solo_rail_elictrified();
}

function zod_solo_rail_elictrified(){

    // Check Full Easter Egg is forced
    if( !isdefined( level.force_full_easter_egg ) ) return;

    // Print at the end of the game we used Full EE
    level.full_ee_forced = true;

    // Defeat Shadowman
    level waittill( "ee_boss_started" );



    level.b_ee_cheat_on = true;

    //wait 1;

    level waittill( "disable_nuke_delay_spawning" );

    if( level clientfield::get("ee_quest_state") != 3 ){
        foreach( player in getplayers() ) player IPrintLnBold("^1Not doing full EE...");
        return;
    }
    
    foreach( player in getplayers() ) player IPrintLnBold("^2Doing full EE!");

    // 1,2,3
	for(i = 1; i < 4; i++) level thread watch_district_rail_trigger(i);

}

// Give solo players 2 extra auto activations, so you have 1min and 30s.
function watch_district_rail_trigger(n_index)
{
	level endon("ee_final_boss_defeated");
	level endon("ee_final_boss_staggered");
	str_flag_ent = "ee_district_rail_electrified_" + n_index;
	t_electric = getent(str_flag_ent, "targetname");
	for(;;)
	{
		t_electric waittill("trigger", player);
        player IPrintLnBold("^2Activated rail N^5"+n_index);

        //  Why checking if player is defined? This script could be running on a dedicated server, only 1 player connects, another one connects and then the original one disconnects

        // No need to fix anything
        if( getplayers().size > 1 || !isdefined( player ) ) continue;

        level wait_till(str_flag_ent);
        level flag::wait_till_clear(str_flag_ent);

        // A player connected or triggerer disconnected
        if( getplayers().size > 1 || !isdefined( player ) ) continue;

        t_electric notify("trigger", player);
        level wait_till(str_flag_ent);
        level flag::wait_till_clear(str_flag_ent);

        // A player connected or triggerer disconnected
        if( getplayers().size > 1 || !isdefined( player ) ) continue;

        t_electric notify("trigger", player);
        level wait_till(str_flag_ent);
        level flag::wait_till_clear(str_flag_ent);
	}
}

#endregion

#region castle

function castle_fixes(){

    // Check Full Easter Egg is forced
    if( isdefined( level.de_ee_ranked ) ) level thread castle_force_ee_ranked_behaviour();
}

function castle_force_ee_ranked_behaviour(){

    wait_for_game_start();
    level.b_can_hot_join = undefined; // Not all bows upgraded needed
}

#endregion

#region stalingrad

// Needed for EE fly splits
function dragon_departures_monitor(){

    a_str_departures = array( DRAGON_DEPART_FACTORY, DRAGON_DEPART_LIBRARY, DRAGON_DEPART_JUDICIAL );

    for(i=0;i<a_str_departures.size;i++){
        departure = level util::waittill_any_array_return( a_str_departures );
        level notify("dragon_departure_"+(i+1));
        ArrayRemoveValue(a_str_departures, departure, false);
    }

}
#endregion

#region cosmodrome

function cosmodrome_fixes(){

    // Check Full Easter Egg is forced
    if( !isdefined( level.force_full_easter_egg ) ) return;

    // Print at the end of the game we used Full EE
    level.full_ee_forced = true;


    // Wait for previous step to be completed
    level waittill( "rerouted_power" );
    level thread check_for_sync_switches();


    // Wait for previous step to be completed
    level waittill( "pressure_sustained" );
    level thread check_for_passkey(); 


    // Wait for previous step to be completed
    level waittill( "passkey_confirmed" );
    level thread check_gersh_grenades();
}



// Switches step code
function check_for_sync_switches(){

    while ( !level flag::get( "switches_synced" ) )
    {
        level flag::wait_till( "monkey_round" );

        // Let's help the EE step
        if( level.players.size < 4 ) level thread watch_sync_switch();

        level util::waittill_either( "between_round_over", "switches_synced" );
    }

}

function all_switches_pressed(){
    
    // Missing switches state array???
    if( !isdefined( level.switches_state ) ){
        level thread debug_message("^1Error, missing switches state...");
        return false;
    }

    // There is one unpressed button...
    foreach( state in level.switches_state ) if( !state ) return false;

    // All buttons are pressed!
    return true;
}

function watch_sync_switch(){
    level endon( "between_round_over" );

    pressed = 0;
    switches = struct::get_array( "sync_switch_start", "targetname" );

    // init button states
    level.switches_state = [];
    // Maybe there is an 8-people mod and added extra buttons
    foreach( s_switch in switches ) ArrayInsert(level.switches_state, false, level.switches_state.size);
    
    for(;;)
    {
        level waittill( "sync_button_pressed" );
        timeout = gettime() + 500;
        timeout += 100000; // 3arc used this when level.sp_egg_testing is true, let's assume this would have been how the step would have been
        
        while ( gettime() < timeout )
        {
            
            // Check which switches are being pressed
            foreach( index, s_switch in switches ){
                // Pressed switch!
                if( isdefined( s_switch.pressed ) && s_switch.pressed ) level.switches_state[ index ] = true;
            }

            // All switches pressed!
            if( all_switches_pressed() ){
                
                // Fake all switches pressed
                foreach( s_switch in switches ){
                    s_switch.pressed = true;
                    //s_switch playsound( "zmb_ee_syncbutton_button" );
                }
                //waittillframeend;
                //level notify( "sync_button_pressed" );
                return;
            }

            wait 0.05;
        }

        // No need to reset the real switches, original game's code is going to do it

        // init button states
        level.switches_state = [];
        // Maybe there is an 8-people mod and added extra buttons
        foreach( s_switch in switches ) ArrayInsert(level.switches_state, false, level.switches_state.size);

    }  

}


// Letters step code
function check_for_passkey(){

    lander = getent( "lander", "targetname" );
    
    while ( !level flag::get( "passkey_confirmed" ) )
    {
        level waittill( "lander_launched" );
        wait 0.05; // Wait a server frame to make sure that the trigger exists

        // No letter to spawn
        if ( !lander.called ) continue;

        // No need to fix the step
        if( GetPlayers().size == 0 || GetPlayers().size > 1 ) continue;

        // Player to grab the letter
        player = GetPlayers()[0];
    
        // Lander info
        start = lander.depart_station;
        dest = lander.station;
        letter = level.lander_key[ start ][ dest ];
        model = level.lander_letters[ letter ];

        // Get all triggers
        a_trigs = getEntArray( "trigger_radius", "classname" );
        // Get the closest trigger to the letter model
        t_letter = ArraySortClosest(a_trigs, model.origin, 1, 0, 10)[0];
        
        // Missing letter trigger
        if( !isdefined( t_letter ) ){
            level thread debug_message_instant("^1Error, couldn't find ^5t_letter");
            continue;
        }

        // Too far to be the real trigger
        if(  distance( t_letter.origin, model.origin ) > 10 ){
            level thread debug_message_instant("^1Error, wrong ^5t_letter");
            continue;
        }

        player thread solo_letter_grab( t_letter );

        // Wait for lander to finish moving
        level flag::wait_till( "lander_grounded" );
    }

}

function solo_letter_grab( t_letter ){
    level endon( "lander_grounded" );
    self endon( "disconnect" ); // Dedicated server and player left?
    t_letter endon( "death" ); // Letter grabbed and game deleted the trigger

    // Get the lander to check distances
    lander = getent( "lander", "targetname" );

    // Wait to get the lander's height
    lander.anchor waittill( "movedone" );

    // Wait for lander to be close enough
    while( distance(lander.anchor.origin, t_letter.origin) > COSMODROME_PLAYER_GRAB_DISTANCE ) wait 0.05;

    // Grab the letter
    t_letter.origin = self.origin;
}




// Weapon combo step code
function check_gersh_grenades(){
    level endon( "ascension_ee" );

    // Check grenade throws
    foreach ( player in getplayers() ) player thread gersh_grenade_watcher();
    callback::on_connect( ::gersh_grenade_watcher );

    level waittill( "ascension_ee" );

    // Stop checking grenade throws
    callback::remove_on_connect( ::gersh_grenade_watcher );
    level notify( "stop_gersh_watcher" );

    level thread debug_message_instant( "stop_gersh_watcher" );
}

function gersh_grenade_watcher(){
    self endon("disconnect");
    level endon( "stop_gersh_watcher" );

    // Wait for a grenade throw
    for(;;){
        self waittill( "grenade_fire", grenade, weapon );

        // Not a gersh
        if ( weapon != level.w_black_hole_bomb ) continue;

        // Check possible Gersh hit
        self thread cosmodrome_ee_gersh_follow( grenade );
    }

}

function cosmodrome_ee_gersh_follow( grenade ){
    level endon( "stop_gersh_watcher" );

    // Cancel gersh
    if( ( isdefined( self.intermission ) && ( self.intermission ) ) || self laststand::player_is_in_laststand() ) return;

    // Wait for Gersh to stop
    velocitysq = 100000000;
    oldpos = grenade.origin;
    while( velocitysq != 0 ){

        wait 0.05;
        
        // Gersh no longer exists
        if ( !isdefined( grenade ) ) return;
        
        // Get new speed
        velocitysq = distancesquared( grenade.origin, oldpos );

        // Update pos
        oldpos = grenade.origin;
    }

    // Gersh no longer exists
    if( !isdefined( grenade ) ) return;

    // Missing or not close enough to EE trigger
    if( !isdefined( level.black_hold_bomb_target_trig ) || !grenade istouching( level.black_hold_bomb_target_trig ) ) return;

    // Make sure the grenade has created the possible EE trigger
    waittillframeend;

    // Check there are damage triggers
    a_triggers = GetEntArray("trigger_damage", "classname");
    if( !isdefined( a_triggers ) || !IsArray( a_triggers ) || a_triggers.size == 0 ){
        #ifdef dev
            level thread debug_message_instant("No trigger_damage???");
        #endif
        return;
    }

    // Check there is at least one valid close trigger
    a_closest = ArraySortClosest(a_triggers, grenade.origin, 1);
    if( !isdefined( a_closest ) || !IsArray( a_closest ) || a_closest.size == 0 ){
        #ifdef dev
            level thread debug_message_instant("No a_closest trigger_damage???");
        #endif
        return;
    }

    trig = a_closest[0];

    // Missing damage trigger?
    if( !isdefined( trig ) ){
        #ifdef dev
            level thread debug_message_instant("Couldn't find trigger_damage...");
        #endif
        return;
    }

    // Stop when the nade blasts
    grenade endon( "death" );

    // Get players to know if we should skip last step
    players = getplayers();
    // Wait for a raygun hit
    ray_gun_hit = false;
    // Make EE doable on solo by skipping nesting dolls damage
    if( players.size == 1 ) doll_hit = true;
    else doll_hit = false;
    
    // Wait for gersh to be damaged by EE weapons
    for(;;)
    {
        trig waittill( "damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weapon );

        if ( isdefined( inflictor ) )
        {
            if ( weapon.name == "ray_gun_upgraded" || type == "MOD_PROJECTILE" && weapon.name == "raygun_mark2_upgraded" )
            {
                ray_gun_hit = 1;
            }
            else if ( weapon.name == "nesting_dolls" || weapon.name == "nesting_dolls_single" )
            {
                doll_hit = 1;
            }
            
            // All EE weapon hits done!
            if ( ray_gun_hit && doll_hit && level flag::get( "thundergun_hit" ) )
            {
                // Fake a nesting doll hit
                if( players.size == 1 ){
                    amount = 95000;
                    weapon = getweapon( "nesting_dolls" );
                    type = "MOD_GRENADE_SPLASH";
                    trig notify( "damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weapon );
                }

                // Last step completed!
                grenade thread notify_ascension_ee_end();
                return;
            }
        }
    }

}

function notify_ascension_ee_end(){
    level endon( "ascension_ee" );

    // Wait for the game to give rewards
    self waittill("death"); // soul_release
    wait 12.5; // wait_for_gersh_vox
    
    level notify( "ascension_ee" );
}


#endregion

#region temple

function temple_fixes(){

    // Check Full Easter Egg is forced
    if( !isdefined( level.force_full_easter_egg ) ) return;

    // Print at the end of the game we used Full EE
    level.full_ee_forced = true;

    // 4 Buttons to go moon eclipse
    level thread fix_ee_sundial_button();

    // No need to run "The Once and Future Crystal" fix until all sun dials are pressed for the first time!
    level waittill( "stage_starting" );

    // Fix tiles for solo
    level thread fix_ee_oafc();

    // No need to run "Don't Go Chasing Waterfalls" fix until "The Once and Future Crystal" step is completed!
    level waittill( "sq_oafc_completed" );

    // Fix water plate count
    level thread fix_ee_plate();
}

// Don't Go Chasing Waterfalls
function fix_ee_plate(){
    level endon( "sq_dgcwf_completed" ); // EE step completed!
    level endon( "raise_crystal_2" ); // This is the crystal to raise when DgCWf step is completed
    level endon( "raised_crystal_2" ); // This is the crystal raised when DgCWf step is completed

    for(;;){
        level waittill( "stage_starting" ); // Wait for an eclipse to start

        // Solo is already solved by 3arc on the original script and 4p is the normal way to solve the step
        switch( getplayers().size ){
            case 2:
            case 3:
            {
                level._on_plate += 4 - getplayers().size;
                #ifdef dev
                    level thread debug_message_instant( "^5on_plate Modified: ^2"+level._on_plate);
                #endif
                break;
            }

            default:
            {
                #ifdef dev
                    level thread debug_message_instant( "Solo, 4p or more don't need ^5fix_ee_plate" );
                #endif
                break;
            }
        }

    }

    #ifdef dev
        level thread debug_message_instant( "^1OUT OF LOOP ^5fix_ee_plate" );
    #endif
}


// The Once and Future Crystal
function fix_ee_oafc(){
    level endon( "sq_oafc_completed" ); // EE step completed!
    level endon( "raise_crystal_1" ); // This is the crystal to raise when OaFC step is completed
    level endon( "raised_crystal_1" ); // This is the crystal raised when OaFC step is completed

    for(;;){
        level waittill( "oafc_switch_pressed" ); // Wait for EE button to be pressed

        if( getplayers().size > 1 ) continue; // This fix is only needed for solo

        wait_oafc_tiles_raised();

        // We start with no tiles fixed
        level.fixed_tile = false;

        level._oafc_trigger1 thread fix_ee_tiles_for_solo( 1 );
        level._oafc_trigger2 thread fix_ee_tiles_for_solo( 2 );
    }
}

function wait_oafc_tiles_raised(){

    e_tile = GetEntArray( "sq_oafc_tileset2", "targetname" )[ 0 ];
    while( e_tile.origin != e_tile.original_origin ) wait 0.05;
}

function get_true_matched_tiles( set ){

    a_matched = [];
    foreach( tile in getentarray( "sq_oafc_tileset"+set, "targetname" ) ) ArrayInsert(a_matched, tile.matched, a_matched.size);

    return a_matched;
}

function fix_ee_tiles_for_solo( set ){
    level endon( "sq_oafc_completed" ); // EE step completed!
    level endon( "raise_crystal_1" ); // This is the crystal to raise when OaFC step is completed
    level endon( "raised_crystal_1" ); // This is the crystal raised when OaFC step is completed
    level endon( "reset_tiles" ); // In case the script manually resets the tiles, for example when re doing the stage
	self endon( "death" ); // Called when the trigger is deleted when the step is over

    tile_set = getentarray( "sq_oafc_tileset"+set, "targetname" );

    for(;;){
        wait 0.05;

        if( set == 1 ){

            // Wait for the first tile to be detected
            while( !isdefined( level._picked_tile1 ) ) wait 0.05;

            // There is already a fixed tile, let the original game script run
            if( level.fixed_tile ){
                level.host IPrintLnBold( "Waiting for tiles to be unfixed" );
                level waittill( "unfixed_tile" );
                continue;
            }

            // Avoids the other script from selecting a fixed tile
            level.fixed_tile = true;

            // Spawn a fake tile to make it seem like the real one being always pulsed
            fake_tile = Spawn( "script_model", level._picked_tile1.origin);
            fake_tile.angles = level._picked_tile1.angles;
            fake_tile SetModel(level._picked_tile1.tile);

            // Hide the current tile so we only show the fake one
            level._picked_tile1 hide();

            // Original script needs the trigger to be touching a player
            v_origin = level._picked_tile1.origin;

            // Save true matched tiles
            e_tile1 = level._picked_tile1;
            a_true_matched = get_true_matched_tiles( set );

            // Avoids the rest of the tile set to show when walking over them
            foreach(tile in tile_set) if(tile != e_tile1) tile.matched = true;

            #ifdef dev
                a_debug_tiles = getentarray( "sq_oafc_tileset2", "targetname" );
                foreach( debug_tile in a_debug_tiles ){
                    if( debug_tile.tile != fake_tile.model ) continue;
                    
                    if( !isdefined( level.host ) ) level.host = getplayers()[ 0 ];
                    level.host IPrintLnBold( "Found debug tile" );
                    level.host SetOrigin( debug_tile.origin );
                    break;
                }
            #endif

            // Wait for the tile of the opposite set to be matched
            while( !isdefined( level._picked_tile2 ) || ( level._picked_tile2.tile != fake_tile.model ) ) wait 0.05;

            // Move the original tile to the one that matches with
            e_tile1.origin = level._picked_tile2.origin;
            e_tile1.angles = level._picked_tile2.angles;

            // Wait for the game to match them
            while( !e_tile1.matched ) wait 0.05;

            // Move the original tile to its original position and hide it
            e_tile1.origin = v_origin;
            e_tile1 moveto(e_tile1.origin - vectorscale((0, 0, 1), 24), 0.5);
            e_tile1 waittill( "movedone" );

            // Set the matched tiles back to the true values
            foreach(index, tile in tile_set) tile.matched = a_true_matched[ index ];
            e_tile1.matched = true;

            // Remove the fake tile
            fake_tile delete();

            // Now you can fix a tile of any set
            level.fixed_tile = false;
            level notify( "unfixed_tile" );

        }else{

            // Wait for the first tile to be detected
            while( !isdefined( level._picked_tile2 ) ) wait 0.05;

            // There is already a fixed tile, let the original game script run
            if( level.fixed_tile ){
                level.host IPrintLnBold( "Waiting for tiles to be unfixed" );
                level waittill( "unfixed_tile" );
                continue;
            }

            // Avoids the other script from selecting a fixed tile
            level.fixed_tile = true;

            // Spawn a fake tile to make it seem like the real one being always pulsed
            fake_tile = Spawn( "script_model", level._picked_tile2.origin);
            fake_tile.angles = level._picked_tile2.angles;
            fake_tile SetModel(level._picked_tile2.tile);

            // Hide the current tile so we only show the fake one
            level._picked_tile2 hide();

            // Original script needs the trigger to be touching a player
            v_origin = level._picked_tile2.origin;

            // Save true matched tiles
            e_tile1 = level._picked_tile2;
            a_true_matched = get_true_matched_tiles( set );

            // Avoids the rest of the tile set to show when walking over them
            foreach(tile in tile_set) if(tile != e_tile1) tile.matched = true;

            // Autocomplete
            #ifdef dev
                a_debug_tiles = getentarray( "sq_oafc_tileset1", "targetname" );
                foreach( debug_tile in a_debug_tiles ){
                    if( debug_tile.tile != fake_tile.model ) continue;
                    
                    level.host IPrintLnBold( "Found debug tile" );
                    level.host SetOrigin( debug_tile.origin );
                    break;
                }
            #endif

            // Wait for the tile of the opposite set to be matched
            while( !isdefined( level._picked_tile1 ) || ( level._picked_tile1.tile != fake_tile.model ) ) wait 0.05;

            // Move the original tile to the one that matches with
            e_tile1.origin = level._picked_tile1.origin;
            e_tile1.angles = level._picked_tile1.angles;

            // Wait for the game to match them
            while( !e_tile1.matched ) wait 0.05;

            // Move the original tile to its original position and hide it
            e_tile1.origin = v_origin;
            e_tile1 moveto(e_tile1.origin - vectorscale((0, 0, 1), 24), 0.5);
            e_tile1 waittill( "movedone" );

            // Set the matched tiles back to the true values
            foreach(index, tile in tile_set) tile.matched = a_true_matched[ index ];
            e_tile1.matched = true;

            // Remove the fake tile
            fake_tile delete();

            // Now you can fix a tile of any set
            level.fixed_tile = false;
            level notify( "unfixed_tile" );

        }

    }
}



// SUN DIALS
function fix_ee_sundial_button(){
    level endon( "temple_sidequest_achieved" ); // Full EE completed
    
    // 4 Buttons to start moon eclipse
    level.sq_sundial_button = getentarray( "sq_sundial_button", "targetname" );

    for(;;){

        // Wait for the script to start buttons logic
        level waittill( "kill_buttons" );
        wait_sundial_buttons_ready();

        // Kill original sun dials' trigger logic
        level notify( "kill_buttons" );

        // Set pressed dials to 0 for all players, this way we can ensure everyone presses a button as 3arc designed the EE
        foreach( player in getplayers() ) player.dials_pressed = 0;
        array::thread_all(level.sq_sundial_button, ::lui_sundial_button );
    }

}

// Modified version of "sundial_button"
function lui_sundial_button(){
    level endon( "stage_starting" ); // Whenever we enter eclipse mode
    level endon( "kill_buttons" ); // When the script resets the buttons script

    // Delete previous triggers | When you spawn a trigger you can not check if it's defined?
    self.trigger delete();
    self.trigger = undefined;
    
    // Don't start until power is activated like on the original script
    level wait_till( "power_on" );

    // Set trigger location
    offset = anglestoforward( self.angles ) * 5 - ( 0, 0, 16 );
    self.trigger = spawn( "trigger_radius_use", self.on_pos + offset, 0, 48, 32 );
    self.trigger triggerignoreteam();
    self.trigger.radius = 48;
    self.trigger setcursorhint( "HINT_NOICON" );

    //self.trigger sethintstring( "^5Button trigger" );
    
    for(;;)
    {
        self.trigger waittill( "trigger", player );
        
        //player IPrintLnBold( "^5 button ^2triggered!" );
        if ( !player can_sundial_be_pressed_by_player() )
        {
            //player IPrintLnBold( "^1Too many dials pressed..." );
            continue;
        }
        
        //player IPrintLnBold( "^5Dial ^2pressed!" );

        if ( !level._stage_active && level._buttons_can_reset )
        {
            player.dials_pressed++;
            level._sundial_buttons_pressed++;
            self playsound( "evt_sq_gen_button" );
            self moveto( self.off_pos, 0.25 );
            //delay = 1; // Original delay

            delay = (5 - GetPlayers().size) % 5;  // Starts at 1s 4p and adds an extra second for every missing player
            //level thread debug_message_instant( "Delay: ^5"+delay);
            wait delay;
            
            // Wait for current eclipse to be over
            while ( level._sundial_active ) wait 0.1;
            
            // Unpress the buttons pressed by the player
            player.dials_pressed--;
            self moveto( self.on_pos, 0.25 );
            
            // Unpress the button for the global counter
            if ( level._sundial_buttons_pressed > 0 ) level._sundial_buttons_pressed--;
        }
    }
}

function wait_sundial_buttons_ready(){

    // Wait for struct to initialise
    while( !isdefined( level.sq_sundial_button[ level.sq_sundial_button.size -1 ].on_pos ) ) wait 0.05;

    // Sun dial moved correctly
    while( level.sq_sundial_button[ level.sq_sundial_button.size -1 ].origin != level.sq_sundial_button[ level.sq_sundial_button.size -1 ].on_pos ) wait 0.05;
}

function can_sundial_be_pressed_by_player(){

    switch( getplayers().size ){
        case 1:
        {
            return true;
        }
        case 2:
        {
            return self.dials_pressed <= 1;
        }
        case 3:
        {
            if( self extra_dial_already_pressed() ) return self.dials_pressed < 1;
            else return self.dials_pressed <= 1;
        }
        case 4:
        {
            return !!self.dials_pressed;
        }
    }

    // 8 players mod is being used or no players are being detected, just allow it
    return true;
}

function extra_dial_already_pressed(){

    foreach( player in getplayers() ){
        if( player == self ) continue;
        if( player.dials_pressed > 1) return true;
    }

    return false;
}

#endregion

#region tomb

function tomb_fixes(){

    /* Flourish weapons
        They are detected as projectiles and bowie flourish is not
        registered by 3arc so I don't either
    */
    //level thread surtr_register_melee_weapon( "zombie_one_inch_punch_flourish" );
    //level thread surtr_register_melee_weapon( "zombie_one_inch_punch_upgrade_flourish" );

    // Register these weapons as melee category so they can be properly given by surtr gsc_weapon
    level thread surtr_register_melee_weapon( "one_inch_punch" );
    level thread surtr_register_melee_weapon( "one_inch_punch_upgraded" );
    level thread surtr_register_melee_weapon( "one_inch_punch_fire" );
    level thread surtr_register_melee_weapon( "one_inch_punch_air" );
    level thread surtr_register_melee_weapon( "one_inch_punch_lightning" );
    level thread surtr_register_melee_weapon( "one_inch_punch_ice" );

    // Allows EE splits for portal enter
    level thread tomb_wait_portal_enter();

    // Allows EE splits for portal exit
    level thread tomb_wait_portal_exit();

    #ifdef dev
        //thread debug_message( "^2Origins fixes applied!" );
    #endif
}

#endregion