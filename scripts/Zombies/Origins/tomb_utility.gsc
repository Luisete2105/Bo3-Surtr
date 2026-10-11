function all_staffs_crafted(){

    return level flag::get( "ee_all_staffs_crafted" );
}

function all_staffs_upgraded(){

    return level flag::get( "ee_all_staffs_upgraded" );
}

function all_staffs_placed(){

    return level flag::get( "ee_all_staffs_placed" );
}

function ee_panzer_hole_open(){
    
    return level flag::get( "ee_mech_zombie_hole_opened" );
}

function ee_panzers_killed(){

    return level flag::get( "ee_mech_zombie_fight_completed" );
}

function ee_maxis_drone_retrieved(){

    return level flag::get( "ee_maxis_drone_retrieved" );
}

function ee_all_players_upgraded_punch(){

    return level flag::get( "ee_all_players_upgraded_punch" );
}

function ee_souls_absorbed(){
    
    return level flag::get( "ee_souls_absorbed" );
}

function ee_samantha_released(){

    return isdefined( level.ee_ending_beam_fx ) || level flag::get( "ee_samantha_released" ); // laser beam is before final trigger is activated
}

function is_quadrotor_disabled(){

    return level flag::get( "ee_quadrotor_disabled" );
}

function wait_for_quadrotor_custom_behavior(){

    while( !isdefined( level.quadrotor_custom_behavior ) ) wait 0.05;
}

function is_quadrotor_custom_behavior_active(){

    return isdefined( level.quadrotor_custom_behavior );
}



function set_discs_pos( gem_name ){

	disc = getent("crypt_puzzle_disc_main", "targetname");
	gem_position = (disc.position + level.gem_start_pos[gem_name]) % 4;

    puzzle_discs = getentarray("crypt_puzzle_disc", "script_noteworthy");
    foreach(puzzle_disc in puzzle_discs)
	{
		if(puzzle_disc.targetname === "crypt_puzzle_disc_main") continue; // Skip the bottom disc without symbols

		while(puzzle_disc.position != gem_position)
		{
            getEnt(puzzle_disc.target, "targetname").trigger_stub notify("trigger", self);
            level waittill("crypt_disc_rotation");
		}

	}
}

function move_air_quest_rings(){

    while( !isdefined( self.position ) ) wait 0.1;

    //dist_1 = 120 * 120; // 14400
	//dist_2 = 180 * 180; // 32400
	//dist_3 = 240 * 240; // 57600
	//dist_4 = 300 * 300; // 90000

    if      ( issubstr( self.targetname, "01" ) )   dist = 120;
    else if ( issubstr( self.targetname, "02" ) )   dist = 180;
    else if ( issubstr( self.targetname, "03" ) )   dist = 240;
    else if ( issubstr( self.targetname, "04" ) )   dist = 300;
    else{
        level.host iPrintLnBold("^1Error, unknown wind ring...");
        return;
    }

    //point = ( self.origin[0], ( self.origin[1]+dist ), self.origin[2] );

    while( self.script_int != self.position ){

        self notify( "damage", 7, level.host, (self.origin - level.host.origin), ( self.origin[0], ( self.origin[1]+dist ), self.origin[2] ), undefined, undefined, undefined, undefined, level.a_elemental_staffs["staff_air"].w_weapon);
        self waittill("rotatedone");
        wait 0.2;
    }

}

function move_air_quest_smoke(){

    level endon("air_puzzle_2_complete");
    while( !isdefined(self.e_fx ) ) wait 0.1; // Wait for the smoke to spawn

    //self.e_fx movez(-1000, 1, 0.1, 0.1); // Move to custom location not instantly?
    v_to_dest = vectornormalize( struct::get("puzzle_smoke_dest", "targetname").origin - self.origin);

    self.detector_brush notify( "damage", 7, level.host, v_to_dest, self.origin, undefined, undefined, undefined, undefined, level.a_elemental_staffs["staff_air"].w_weapon);
    //self.e_fx waittill( "rotatedone" );

}

function autocomplete_electric_relays(){
    level endon( "electric_puzzle_2_complete" );

    while( !isdefined( self.trigger_stub ) ) wait 0.1; // Wait for the trigger to exist just in case

    while( !isdefined( self.connections[ self.position ] ) ){

        self.trigger_stub notify( "trigger", level.host);
        self.e_switch waittill( "rotatedone" );
    }
    #ifdef dev
        //level.host iPrintLnBold("Switch ^5"+self.connections[ self.position ]+"^2 completed^7!");
    #endif
}

function save_beacon_progress(){

    world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ] = [];

    foreach( player in getplayers() ){
        // Player didn't even pick up the tablet from tank station
        if( !player.sq_one_inch_punch_stage  ) continue;

        world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ] = SpawnStruct();
        world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ].sq_one_inch_punch_stage = player.sq_one_inch_punch_stage;
        world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ].sq_one_inch_punch_kills = player.sq_one_inch_punch_kills;
        #ifdef dev
            //player IPrintLnBold( "punch stage: ^5"+player.sq_one_inch_punch_stage);
            //player IPrintLnBold( "punch kills: ^5"+player.sq_one_inch_punch_kills);
        #endif
    }

}

function autocomplete_beacon_quest( give_all = false ){

    t_bunker = getent("trigger_oneinchpunch_bunker_table", "targetname");
    t_birdbath = getent("trigger_oneinchpunch_church_birdbath", "targetname");

    // if it's called from autocomplete ee then give beacon to all players
    if( give_all ){
        foreach(player in level.players){
            if( isDefined( player.sq_one_inch_punch_stage ) && player.sq_one_inch_punch_stage > 6 ) continue; // Beacon quest already completed 

            self.sq_one_inch_punch_stage = 0;
            self.sq_one_inch_punch_kills = 0;

            while( player.sq_one_inch_punch_stage == 0 ){
                wait 0.05;
                t_bunker notify("trigger", player);
            }

            #ifdef dev
                player iPrintLnBold("Taken from ^5Tank station");
            #endif

            while( player.sq_one_inch_punch_stage == 1 ){
                wait 0.05;
                t_birdbath notify("trigger", player);
            }

            #ifdef dev
                player iPrintLnBold("Placed on ^5Church goblet");
            #endif

            player.sq_one_inch_punch_kills = 20;
            player.sq_one_inch_punch_stage = 3;
            player.sq_one_inch_punch_kills = 0; // I know this is stupid, I am just simulating I did the kills "legit"

            while( player.sq_one_inch_punch_stage == 3 ){
                wait 0.05;
                t_birdbath notify("trigger", player);
            }

            #ifdef dev
                player iPrintLnBold("Taken from ^5Church goblet");
            #endif

            while( player.sq_one_inch_punch_stage == 4 ){
                wait 0.05;
                t_bunker notify("trigger", player);
            }

            #ifdef dev
                player iPrintLnBold("Placed on ^5Tank station");
            #endif

            player.sq_one_inch_punch_kills = 20;
            player clientfield::set_to_player("ee_beacon_reward", 1);
            player.beacon_ready = true;
            player.sq_one_inch_punch_stage++;

            while( player.sq_one_inch_punch_stage == 6 ){
                wait 0.05;
                t_bunker notify("trigger", player);
            }

            #ifdef dev
                player iPrintLnBold("^5Beacons ^2completed!");
            #endif
        }

        return;
    }

    foreach(player in getplayers() ){
        if( !isdefined( world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ] ) ) continue; // Player didn't even pick up the tablet from tank station
        if( isdefined( player.sq_one_inch_punch_stage ) && player.sq_one_inch_punch_stage > 6 ) continue; // Beacon quest already completed 

        // Pick up tablet from tank station
        while( player.sq_one_inch_punch_stage == 0 ){
            wait 0.05;
            t_bunker notify("trigger", player);
        }
        wait 0.05;

        #ifdef dev
            player iPrintLnBold("Taken from ^5Tank station");
        #endif

        // Player didn't place tablet on church
        if( world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ].sq_one_inch_punch_stage < 2 ) continue;

        // Place tablet on church
        while( player.sq_one_inch_punch_stage == 1 ){
            wait 0.05;
            t_birdbath notify("trigger", player);
        }
        wait 0.05;

        #ifdef dev
            player iPrintLnBold("Placed on ^5Church goblet");
        #endif

        // Player didn't get all kills for church tablet
        if( world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ].sq_one_inch_punch_stage < 3 ){
            player.sq_one_inch_punch_kills = world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ].sq_one_inch_punch_kills;
            continue;
        }

        player.sq_one_inch_punch_kills = 20;
        player.sq_one_inch_punch_stage = 3;
        player.sq_one_inch_punch_kills = 0; // I know this is stupid, I am just simulating I did the kills "legit"
 
        // Player is not carrying the cleaned tablet
        if( world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ].sq_one_inch_punch_stage < 4 ){
            continue;
        }

        // Pick up cleaned tablet from church
        while( player.sq_one_inch_punch_stage == 3 ){
            wait 0.05;
            t_birdbath notify("trigger", player);
        }
        wait 0.05;

        #ifdef dev
            player iPrintLnBold("Taken from ^5Church goblet");
        #endif

        // Player did not place cleaned tablet at tank station
        if( world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ].sq_one_inch_punch_stage < 5 ){
            continue;
        }

        // Placing cleaned tablet at tank station
        while( player.sq_one_inch_punch_stage == 4 ){
            wait 0.05;
            t_bunker notify("trigger", player);
        }
        wait 0.05;

        #ifdef dev
            player iPrintLnBold("Placed on ^5Tank station");
        #endif


        // Player did not kill all 20 zombies at tank station
        if( world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ].sq_one_inch_punch_stage < 6 ){
            player.sq_one_inch_punch_kills = world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ].sq_one_inch_punch_kills;
            continue;
        }

        player.sq_one_inch_punch_kills = 20;
        player clientfield::set_to_player("ee_beacon_reward", 1);
        player.beacon_ready = true;
        player.sq_one_inch_punch_stage = 6;

        // player did not pickup beacons
        if( world.save_state[ MAP_NAME ][ "ee_specific" ][ "beacon" ][ player getxuid(0) ].sq_one_inch_punch_stage < 7 ){
            player IPrintLnBold( "^1NO JESSIE, DON'T PICK UP THE BEACONS!" );
            continue;
        }


        while( player.sq_one_inch_punch_stage == 6 ){
            wait 0.05;
            t_bunker notify("trigger", player);
        }

        #ifdef dev
            player iPrintLnBold("^5Beacons ^2completed!");
        #endif
    }

}

function build_staff( element = "^1Error no element" ){

    get_full_craftable_object( "elemental_staff_"+element );
    complete_craftable( "elemental_staff_"+element );

}

// Secure The Keys
function ice_puzzle_1(){

    step_name = "^5Ice Puzzle 1";

    if( level flag::get( "ice_puzzle_1_complete" ) ){ // Already completed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    if( !is_fully_crafted( "elemental_staff_water" ) ) build_staff( "water" );

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    ice_gem = getent("ice_chamber_gem", "targetname");
    while( !level flag::get( "ice_puzzle_1_complete" ) ){
        wait 0.05;
        
        foreach(tile in level.unsolved_tiles){
            if( !is_true( tile.showing_tile_side ) ) continue;

            if( tile.value == ice_gem.value ){
                tile notify( "damage", 7, self, VectortoAngles( tile.oring - self.origin ), tile.origin, undefined, undefined, undefined, undefined, level.a_elemental_staffs["staff_water"].w_weapon );
                break;
            }

        }

        level wait_till("ice_tile_flipping");
    }


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

function ice_puzzle_2(){

    step_name = "^5Ice Puzzle 2";

    if( level flag::get( "ice_puzzle_2_complete" ) ){ // Already completed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    if( !level flag::get( "ice_puzzle_1_complete" ) ) ice_puzzle_1();

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    while( !isdefined(level.ice_stones_remaining) ) wait 0.1;
    wait 4;

    a_stone_positions = struct::get_array("puzzle_stone_water", "targetname");
    foreach( ice_stone in a_stone_positions ){
        if(!isdefined(ice_stone.e_model)) continue; // This one is already completed

        if( !is_true( ice_stone.e_model clientfield::get( "stone_frozen" ) ) ){
            ice_stone.e_model notify( "damage", 7, self, VectortoAngles( ice_stone.oring - self.origin ), ice_stone.origin, undefined, undefined, undefined, undefined, level.a_elemental_staffs["staff_water"].w_weapon );
            
            while( !is_true( ice_stone.e_model clientfield::get( "stone_frozen" ) ) ) wait 0.5;
        }

        ice_stone.e_model notify( "damage", 7, self, VectortoAngles( ice_stone.oring - self.origin ), ice_stone.origin, "MOD_PISTOL_BULLET", undefined, undefined, undefined, getweapon( "pistol_c96" ) );
    }


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

function ice_upgrade(){

    if( !level flag::get( "ice_puzzle_2_complete" ) ) ice_puzzle_2();

    complete_staff_upgrade( "water" );
}


function air_puzzle_1(){

    step_name = "^5Air Puzzle 1";

    if( level flag::get( "air_puzzle_1_complete" ) ){ // Already completed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    if( !is_fully_crafted( "elemental_staff_air" ) ) build_staff( "air" );

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    array::thread_all( getentarray("ceiling_ring", "script_noteworthy"), ::move_air_quest_rings);
    level wait_till( "air_puzzle_1_complete" );

    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

function air_puzzle_2(){

    step_name = "^5Air Puzzle 2";

    if( level flag::get( "air_puzzle_2_complete" ) ){ // Already completed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    if( !level flag::get( "air_puzzle_1_complete" ) ) air_puzzle_1();

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();

    // Second step
    array::thread_all( struct::get_array("puzzle_smoke_origin", "targetname"), ::move_air_quest_smoke);
    level wait_till( "air_puzzle_2_complete" );

    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

function air_upgrade(){

    if( !level flag::get( "air_puzzle_2_complete" ) ) air_puzzle_2();

    complete_staff_upgrade( "air" );
}



function electric_puzzle_1(){

    step_name = "^5Electric Puzzle 1";

    if( level flag::get( "electric_puzzle_1_complete" ) ){ // Already completed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    if( !is_fully_crafted( "elemental_staff_lightning" ) ) build_staff( "lightning" );

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    if( is_true( level.a_piano_keys_playing.size ) ){ // Reset the step in case it's already started
        level notify("piano_keys_stop");
        level.a_piano_keys_playing = [];
    }

    a_piano_keys = struct::get_array("piano_key", "script_noteworthy");
    s_chord = struct::get("piano_chord_" + chord_name, "script_noteworthy" );
    a_chord_order = array("a_minor", "e_minor", "d_minor");
    foreach( chord_name in a_chord_order ){

        s_chord = struct::get("piano_chord_" + chord_name, "script_noteworthy" );
        notes_played = 0;
        foreach( note in s_chord.notes){

            foreach( piano_key in a_piano_keys ){

                if( piano_key.script_string == note ){
                    piano_key notify( "piano_key_shot" );
                    break;
                }
            }

        }

        level waittill( "piano_keys_stop" );
    }


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

function electric_puzzle_2(){

    step_name = "^5Electric Puzzle 2";

    if( level flag::get( "electric_puzzle_2_complete" ) ){ // Already completed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    if( !level flag::get( "electric_puzzle_1_complete" ) ) electric_puzzle_1();

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    array::thread_all(level.electric_relays, ::autocomplete_electric_relays);
    level wait_till( "electric_puzzle_2_complete" );


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

function electric_upgrade(){

    if( !level flag::get( "electric_puzzle_2_complete" ) ) electric_puzzle_2();

    complete_staff_upgrade( "lightning" );
}


function fire_puzzle_1(){

    step_name = "^5Fire Puzzle 1";

    if( level flag::get( "fire_puzzle_1_complete" ) ){ // Already completed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    if( !is_fully_crafted( "elemental_staff_fire" ) ) build_staff( "fire" );

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    /*if(!isdefined(level.s_chamber_center))
        {
            self iPrintLnBold("^5Creating chamber center");
            level.s_chamber_center = struct::get("chamber_center", "targetname");
            level.s_chamber_center.radius_sq = level.s_chamber_center.script_float * level.s_chamber_center.script_float;
            wait 1;
        }

        old_origin      = level.s_chamber_center.origin;
        old_radius_sq   = level.s_chamber_center.radius_sq;

        level.s_chamber_center.radius_sq    = 7777777;

        foreach( volume in level.sacrifice_volumes ){
            if( is_true( volume.b_gods_pleased ) ) continue; // Already filled

            volume.num_sacrifices_received = 32;
            if( !isdefined( volume.pct_sacrifices_received ) ) self iPrintLnBold("^1Error, missing ignition point...");

            volume.pct_sacrifices_received = volume.e_ignition_point.script_float +1;

            e_projectile = level.host MagicMissile(level.a_elemental_staffs["staff_fire"].w_weapon, volume.origin, (7,77,177), undefined);
            level notify( "fire_staff_explosion", volume.origin , e_projectile );
            wait 1;
        }

        level.s_chamber_center              = old_origin;
        level.s_chamber_center.radius_sq    = old_radius_sq;
    */

    level.sacrifice_volumes[0].b_gods_pleased = true;
    wait 0.1;
    level notify("fire_sacrifice_completed");
    level wait_till( "fire_puzzle_1_complete" );


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

function fire_puzzle_2(){

    step_name = "^5Fire Puzzle 2";

    if( level flag::get( "fire_puzzle_2_complete" ) ){ // Already completed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    if( !level flag::get( "fire_puzzle_1_complete" ) ) fire_puzzle_1();

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    while( !level flag::get( "fire_puzzle_2_complete" ) ){
        wait 0.5;

        a_torches = struct::get_array("church_torch_target", "script_noteworthy");
        foreach( torch in a_torches ){
            if( !is_true( torch.b_correct_torch ) ) continue;

            level notify("fire_staff_explosion", torch.origin);
            wait 2;
        }

    }

    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

function fire_upgrade(){

    if( !level flag::get( "fire_puzzle_2_complete" ) ) fire_puzzle_2();

    complete_staff_upgrade( "fire" );
}



function complete_staff_upgrade( element = undefined ){

    self = isplayer( self ) ? self : level.host;

    if( is_staff_fully_unlocked( element ) ){
        self IPrintLnBold( "^5"+element+" ^2Already upgraded!" );
        return;
    }
    
    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    while( !level flag::get( "staff_"+element+"_upgrade_unlocked" ) ){
        wait 0.05;

        orb = get_ent_by_model( get_orb_by_element( element ) );
        if( !isdefined( orb ) ) continue;

        if( is_true( orb clientfield::get("element_glow_fx") ) ) break;
        orb notify( "damage", 7, self, (orb.origin - self.origin), orb.origin, undefined, undefined, undefined, undefined, level.a_elemental_staffs["staff_"+element].w_weapon);
    }

    set_discs_pos( get_crypt_gem_by_element( element ) );

    // This flag is set when the orb arrives
    level wait_till( "staff_"+element+"_upgrade_unlocked" );
    level.a_elemental_staffs["staff_"+element].charger.charges_received = 20;


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( "^5Upgrade for "+element+text_completed() );
    wait 0.05;
}


function is_staff_fully_unlocked( element ){

    return level flag::get( "staff_"+element+"_upgrade_unlocked" ) && ( level.a_elemental_staffs["staff_"+element].charger.charges_received >= 20 );
}

function get_orb_by_element( element ){

    switch( element ){
        case "water"    : return "p7_zm_ori_orb_ice";
        case "air"      : return "p7_zm_ori_orb_wind";
        case "fire"     : return "p7_zm_ori_orb_fire";
        case "lightning": return "p7_zm_ori_orb_lightning";
    }

    self IPrintLnBold( "^1Error, unknown orb for element ^5" +element );
    return undefined;
}

function get_crypt_gem_by_element( element ){

    switch( element ){
        case "water"    : return "crypt_gem_ice";
        case "air"      : return "crypt_gem_air";
        case "fire"     : return "crypt_gem_fire";
        case "lightning": return "crypt_gem_elec";
    }

    self IPrintLnBold( "^1Error, unknown crypt gem for element ^5" +element );
    return undefined;
}


// Ascend From Darkness
function tomb_place_afd( b_place_all = false ){

    wait 0.05;

    a_structs = struct::get_array( "robot_head_staff", "targetname" );

    while( !isdefined( a_structs[a_structs.size-1].m_plinth ) ) wait 0.05;

    if( b_place_all ){

        foreach( unitrigger_stub in a_structs )
        {
            s_upgraded_staff = level.a_elemental_staffs["staff_" + unitrigger_stub.script_noteworthy].upgrade;

            while( !is_true( s_upgraded_staff.ee_in_use ) ) {

                t_robot = get_trigger_from_origin( unitrigger_stub.origin );
                while( !isdefined( t_robot ) ){
                    wait 0.5;
                    t_robot = get_trigger_from_origin( unitrigger_stub.origin );
                }

                staff = s_upgraded_staff.w_weapon;
                b_staff_found = false;
                foreach( player in level.players ){ // Check if there is a player who already has the desired staff and make him be the one placing the staff
                    if( player hasWeapon( staff ) ){

                        #ifdef dev
                            player iPrintLnBold("^2Inserting staff ^5"+unitrigger_stub.script_noteworthy);
                        #endif

                        player build_and_activate_trigger_from_unitrigger_stub( t_robot );
                        b_staff_found = true;

                        while( player hasWeapon( staff ) ) wait 0.05;
                        break;
                    }
                }

                if( b_staff_found ) continue; // Someone already has the staff we just go to the next one

                // Get weapon limit
                if(isdefined(self.get_player_weapon_limit))                 weapon_limit = [[ self.get_player_weapon_limit ]]  (self);
                else if(isdefined(level.get_player_weapon_limit))           weapon_limit = [[ level.get_player_weapon_limit ]] (self);
                else if(self hasperk("specialty_additionalprimaryweapon"))  weapon_limit = level.additionalprimaryweapon_limit;
                else    weapon_limit = 2;

                weapons = self getWeaponsListPrimaries().size;

                if( weapons >= weapon_limit ){ // Take a weapon in case we are already on the limit
                    self takeWeapon( self getWeaponsListPrimaries()[0] );
                    wait 0.05;
                }

                self giveWeapon( staff );
                //wait 0.05;
                //self switchToWeapon( staff );

                #ifdef dev
                    self iPrintLnBold("^2Inserting staff ^5"+unitrigger_stub.script_noteworthy);
                #endif
                self build_and_activate_trigger_from_unitrigger_stub( t_robot );
                while( self hasWeapon( staff ) ) wait 0.05;


            } // Waiting for the staff to be placed

        } // Robot triggers

        return;
    }

    foreach( unitrigger_stub in a_structs )
    {
        if( !IsInArray( world.save_state[ MAP_NAME ][ "ee_specific" ][ "inserted_staffs" ], "staff_" + unitrigger_stub.script_noteworthy)) continue; // Not a saved staff

        s_upgraded_staff = level.a_elemental_staffs["staff_" + unitrigger_stub.script_noteworthy].upgrade;
        while( !is_true( s_upgraded_staff.ee_in_use ) ) {

            t_robot = get_trigger_from_origin( unitrigger_stub.origin );
            while( !isdefined( t_robot ) ){
                wait 0.5;
                t_robot = get_trigger_from_origin( unitrigger_stub.origin );
            }

            staff = s_upgraded_staff.w_weapon;
            b_staff_found = false;
            foreach( player in level.players ){ // Check if there is a player who already has the desired staff and make him be the one placing the staff
                if( player hasWeapon( staff ) ){

                    #ifdef dev
                        player iPrintLnBold("^2Inserting staff ^5"+unitrigger_stub.script_noteworthy);
                    #endif

                    player build_and_activate_trigger_from_unitrigger_stub( t_robot );
                    b_staff_found = true;

                    while( player hasWeapon( staff ) ) wait 0.05;
                    break;
                }
            }

            if( b_staff_found ) continue; // Someone already has the staff we just go to the next one

            // Get weapon limit
            if(isdefined(self.get_player_weapon_limit))                 weapon_limit = [[ self.get_player_weapon_limit ]]  (self);
            else if(isdefined(level.get_player_weapon_limit))           weapon_limit = [[ level.get_player_weapon_limit ]] (self);
            else if(self hasperk("specialty_additionalprimaryweapon"))  weapon_limit = level.additionalprimaryweapon_limit;
            else    weapon_limit = 2;

            weapons = self getWeaponsListPrimaries().size;

            if( weapons >= weapon_limit ){ // Take a weapon in case we are already on the limit
                self takeWeapon( self getWeaponsListPrimaries()[0] );
                wait 0.05;
            }

            self giveWeapon( staff );
            //wait 0.05;
            //self switchToWeapon( staff );

            #ifdef dev
                self iPrintLnBold("^2Inserting staff ^5"+unitrigger_stub.script_noteworthy);
            #endif
            self build_and_activate_trigger_from_unitrigger_stub( t_robot );
            while( self hasWeapon( staff ) ) wait 0.05;


        } // Waiting for the staff to be placed

    } // Robot triggers


    level.n_ee_robot_staffs_planted = world.save_state[ MAP_NAME ][ "ee_specific" ][ "n_ee_robot_staffs_planted" ];
}

function tomb_save_afd(){

    if( !isdefined( world.save_state[ MAP_NAME ][ "ee_specific" ][ "inserted_staffs" ] ) ) world.save_state[ MAP_NAME ][ "ee_specific" ][ "inserted_staffs" ] = [];

    world.save_state[ MAP_NAME ][ "ee_specific" ][ "n_ee_robot_staffs_planted" ] = is_true( level.n_ee_robot_staffs_planted ) ? level.n_ee_robot_staffs_planted : 0; // N of inserted staffs on robot's head.

    level thread debug_message( "^5Saving AFD progress" );

    if( isdefined( level.n_ee_robot_staffs_planted ) ){
        level thread debug_message( "^5Inserted staffs: ^2" + level.n_ee_robot_staffs_planted );
    }else{
        level thread debug_message( "^5Inserted staffs: ^1UNDEFINED" );
    }

    foreach( unitrigger_stub in struct::get_array("robot_head_staff", "targetname") ){

        //if( !isdefined( unitrigger_stub.m_plinth.e_staff.ee_in_use ) ) continue; // Staff is not inserted

        /*sc info
            fire
            water
            lightning
            air
        */

        #ifdef dev
            if( !isdefined( unitrigger_stub.m_plinth.m_staff ) ){
                level thread debug_message( "^5NOT INSERTED: ^1staff_" + unitrigger_stub.script_noteworthy );
            }else{
                level thread debug_message( "^5INSERTED: ^2staff_" + unitrigger_stub.script_noteworthy );
                ArrayInsert( world.save_state[ MAP_NAME ][ "ee_specific" ][ "inserted_staffs" ], "staff_" + unitrigger_stub.script_noteworthy, world.save_state[ MAP_NAME ][ "ee_specific" ][ "inserted_staffs" ].size );
            }
        #endif

        //ArrayInsert( world.save_state[ MAP_NAME ][ "ee_specific" ][ "inserted_staffs" ], "staff_" + unitrigger_stub.script_noteworthy, world.save_state[ MAP_NAME ][ "ee_specific" ][ "inserted_staffs" ].size );

    }
}


// Rain Fire
function tomb_fire_link(){

    while( !isdefined( getEntArray("fire_link_button", "targetname")[0] ) ) wait 0.05;
    wait 1;
    
    level thread deactivate_triple_robot_flag();

    while( !level flag::get("fire_link_enabled") ){
        wait 0.2;

        fire_link_button = getEntArray("fire_link_button", "targetname")[0]; // Robot EE button
        t_fire_link_button = get_trigger_from_origin( fire_link_button.origin );
        self build_and_activate_trigger_from_unitrigger_stub( t_fire_link_button );
        t_fire_link_button notify("trigger", self);
    }
}

function deactivate_triple_robot_flag(){
    level notify( "lui_fake_three_robot" );
    level endon( "lui_fake_three_robot" );

    level flag::set( "three_robot_round" );

    if( level.zombie_ai_limit == 22 ) return; // legit 3 robot walk already happening

    level waittill( "giant_robot_walk_cycle_complete" );
    level flag::clear( "three_robot_round" );

    #ifdef dev
        IPrintLnBoldAllPlayers( "^5Fake Three Robot Round ^1 is over..." );
    #endif
}

function tomb_panzer_hole(){

    if( !level flag::get("fire_link_enabled") ) tomb_fire_link(); // Fire Link button is not currently activated
    wait 0.05;
    if( !level flag::get( "three_robot_round" ) ) level thread deactivate_triple_robot_flag(); // 3 Robot walk is needed, let's fake it
    wait 0.05;

    t_hole = getent("fire_link_damage", "targetname"); // Panzer hole EE trigger

    //t_hole waittill(#"damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon);
    t_hole notify("damage", 7, self, undefined, t_hole.origin, undefined, undefined, undefined, undefined, level.w_beacon);

    while( !ee_panzer_hole_open() ) wait 0.05;
    wait 0.1;
}


/*  Unleash The Horde Info
    level.ee_mech_zombies_killed = 0;
    level.ee_mech_zombies_alive = 0;
    level.ee_mech_zombies_spawned = 0;
*/

// Unleash The Horde
function tomb_uth_drone(){

    if( !ee_panzer_hole_open() ){ // Rain Fire not completed
        self IPrintLnBold( "^5Rain Fire ^1must be completed..." );
        return;
    }

    if( ee_panzers_killed() || is_quadrotor_disabled() ){ // EE step is already completed 
        self IPrintLnBold( "^UTH Drone ^2already completed!" );
        return;
    }

    w_drone = getweapon("equip_dieseldrone");
    s_goal = struct::get("ee_mech_hole_goal_0", "targetname");
    wait_for_quadrotor_custom_behavior();
    if( quadrotor_cooling_down() ) remove_quadrotor_cooldown();

    while( !is_quadrotor_disabled() ){ // Send the Drone to its goal
        wait 0.1;

        quadrotors = getentarray("quadrotor_ai", "targetname");
        if( quadrotors.size >= 1 ){ // There is already a Maxis Drone
            quadrotor = quadrotors[0];
        }else{

            player_dron = undefined;
            foreach( player in level.players ){ // Check if someone has Maxis Drone
                if( player hasWeapon( w_drone ) ){
                    player_dron = player;
                    break;
                }
            }

            if( !isDefined( player_dron ) ){ // No one has the Maxis Drone
                
                player_dron = level.host;
                if( !is_object_crafted( "equip_dieseldrone" ) ) craft_open_table_object( "equip_dieseldrone", undefined );
                player_dron grab_crafted_item( "equip_dieseldrone" );
            }


            // Force player using a drone
            player_dron notify("quadrotor_control_thread");
            player_dron switchToWeapon( w_drone );
            player_dron util::waittill_any_timeout(1, "weapon_change_complete");
            player_dron playsound("veh_qrdrone_takeoff");
            player_dron [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::switch_back_primary_weapon]]();
            player_dron util::waittill_any_timeout(1, "weapon_change_complete");
            player_dron [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::switch_back_primary_weapon]]();
            player_dron [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::weapon_take]]( w_drone );
            player_dron setactionslot(4, "");

            str_vehicle = level flag::get( "ee_maxis_drone_retrieved" ) ? "heli_quadrotor_upgraded_zm" : "heli_quadrotor_zm"; 

            quadrotor = spawnvehicle(str_vehicle, player_dron.origin + vectorscale((0, 0, 1), 96), player_dron.angles, "quadrotor_ai");
            level thread [[@zm_tomb_craftables<scripts\zm\zm_tomb_craftables.gsc>::quadrotor_death_watcher]]( quadrotor );
            quadrotor thread [[@zm_tomb_craftables<scripts\zm\zm_tomb_craftables.gsc>::quadrotor_death_watcher]]( player_dron );
            quadrotor thread [[@zm_tomb_vo<scripts\zm\zm_tomb_vo.gsc>::function_a808bc8e]]();
            wait 1;
        }

        quadrotor.origin = s_goal.origin;
        quadrotor util::waittill_any("near_goal", "force_goal", "reached_end_node");
        quadrotor util::waittill_any("near_goal", "force_goal", "reached_end_node");
        wait 2.5;
        quadrotor util::waittill_any("near_goal", "force_goal", "reached_end_node");
        wait 0.5;
    }

}

function tomb_uth_panzers(){

    if( !ee_panzer_hole_open() ){ // Rain Fire not completed
        self IPrintLnBold( "^5Rain Fire ^1must be completed..." );
        return;
    }

    if( !is_quadrotor_disabled() ){ // EE step is already completed 
        self IPrintLnBold( "^UTH Drone ^2needs to be completed..." );
        return;
    }

    if( ee_panzers_killed() ){ // All staffs have already been placed
        self iPrintLnBold( "^5Rain fire"+text_already_completed() );
        return;
    }

    while( !ee_panzers_killed() ){ // Kill all panzers
        wait 0.1;
        mechzs = getaiarchetypearray("mechz", level.zombie_team);
        if( !mechzs.size ) continue;

        foreach( mechz in mechzs ) mechz dodamage( mechz.health+7, mechz getcentroid(), level.host, level.host, undefined, "MOD_PISTOL_BULLET", 0, getweapon( "pistol_c96" ) );
    }
}


// Skewer The Winged Beast
function tomb_zombie_plane(){

    if( !ee_panzers_killed() ){
        self IPrintLnBold( "^5Unleash The Horde ^1must be completed..." );
        return;
    }

    if( ee_maxis_drone_retrieved() || isdefined( get_zpilot() ) || isdefined( get_upgraded_drone_trigger() ) ){
        self IPrintLnBold( "^5Zombie Plane"+text_already_completed() );
        return;
    }

    wait 0.05;
    setdvar(DVAR_TIMESCALE, "10");

    while( !isdefined( get_zplane() ) ) wait 0.05;

    zb_plane = get_zplane();

    if( zb_plane flag::get( "biplane_down" ) ) return;

    zb_player = get_zb_player();
    if( !zb_player.zombie_vars["zombie_powerup_zombie_blood_on"] ) level thread [[ level._custom_powerups[ "zombie_blood" ].grab_powerup ]]( zb_player );
    wait 0.1;

    //zb_plane [[ level.callbackvehicledamage ]](e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, var_740c2c73, v_point, v_dir, str_hit_loc, v_origin, psoffsettime, b_damage_from_underneath, n_model_index, str_part_name, v_normal)
    zb_plane [[ level.callbackvehicledamage ]](undefined, zb_player, 7, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
    wait 0.05;

    setdvar(DVAR_TIMESCALE, "1");
}

function tomb_zombie_pilot(){

    if( !ee_panzers_killed() ){
        self IPrintLnBold( "^5Unleash The Horde ^1must be completed..." );
        return;
    }

    if( ee_maxis_drone_retrieved() || isdefined( get_upgraded_drone_trigger() ) ){
        self IPrintLnBold( "^5Zombie Pilot"+text_already_completed() );
        return;
    }

    if( isdefined( get_zplane() ) && !( get_zplane() flag::get( "biplane_down" ) ) ){
        self IPrintLnBold( "^5Zombie Plane ^1must be destroyed..." );
        return;
    }

    wait 0.05;
    setdvar(DVAR_TIMESCALE, "10");

    while( !isdefined( get_zpilot() ) ) wait 0.05;

    z_pilot = get_zpilot();

    while( !is_true( z_pilot.zombie_think_done ) ) wait 0.05;
    wait 0.1;

    zb_player = get_zb_player();

    if( !zb_player.zombie_vars["zombie_powerup_zombie_blood_on"] ) level thread [[ level._custom_powerups[ "zombie_blood" ].grab_powerup ]]( zb_player );
    wait 0.1;
    magicbullet( getweapon( "pistol_c96_upgraded" ), z_pilot.origin, z_pilot getcentroid(), zb_player);
    wait 0.05;

    setdvar(DVAR_TIMESCALE, "1");
}

function tomb_get_upgraded_drone(){

    if( !ee_panzers_killed() ){
        self IPrintLnBold( "^5Unleash The Horde ^1must be completed..." );
        return;
    }

    if( ee_maxis_drone_retrieved() ){
        self IPrintLnBold( "^5Get Upgraded Drone"+text_already_completed() );
        return;
    }

    if( isdefined( get_zplane() ) ){
        self IPrintLnBold( "^5Zombie Plane ^1must be destroyed..." );
        return;
    }

    if( isdefined( get_zpilot() ) ){
        self IPrintLnBold( "^5Zombie Pilot ^1must be killed..." );
        return;
    }

    wait 0.05;
    setdvar(DVAR_TIMESCALE, "10");

    while( !isdefined( get_upgraded_drone_trigger() ) ) wait 0.05;

    quadrotor = get_upgraded_drone_trigger();
    
    while( !isdefined( get_trigger_from_origin( ( quadrotor.origin + vectorscale((0, 0, 1), -30) ) ) ) ) wait 0.05;

    t_quadrotor = get_trigger_from_origin( ( quadrotor.origin + vectorscale((0, 0, 1), -30) ) ); 
    level.host build_and_activate_trigger_from_unitrigger_stub( t_quadrotor );

    setdvar(DVAR_TIMESCALE, "1");
}

function get_upgraded_drone_trigger(){
    return getent( "quadrotor_pickup", "targetname" );
}

function get_zb_player(){

    foreach( player in level.players ) if( player.zombie_vars["zombie_powerup_zombie_blood_on"] ) return player;
    return level.host;
}

function get_zplane(){

    return getent( "zombie_blood_biplane", "targetname" );
}

function get_zpilot(){

    foreach( zombie in getaispeciesarray(level.zombie_team, "all") ) if( is_true( zombie.b_zombie_blood_damage_only ) ) return zombie;
    return undefined;
}


// Wield A Fist Of Iron
function tomb_give_one_inch_punch_to_player( give_all = false ){

    // Give melee to all
    if( give_all ){
        foreach( player in getplayers() ){
            if( is_true( player.b_punch_upgraded ) ) continue; // Already has punches and upgraded them

            if( !is_true( player.one_inch_punch_flag_has_been_init ) ){ // Give punch
                player thread [[@_zm_weap_one_inch_punch<scripts\zm\_zm_weap_one_inch_punch.gsc>::one_inch_punch_melee_attack]]();
                player playsound("zmb_powerup_grabbed");
                player thread [[@zm_tomb_challenges<scripts\zm\zm_tomb_challenges.gsc>::one_inch_punch_watch_for_death]]();
            }

            // Give punch upgraded
            player.n_ee_punch_souls = 20;
            player thread hud::fade_to_black_for_x_sec(0, 0.3, 0.5, 0.5, "white");
            player.b_punch_upgraded = true;
            foreach(mdl_staff in level.a_elemental_staffs_upgraded) if(player hasweapon(mdl_staff.w_weapon)) player.str_punch_element = mdl_staff.w_weapon.element;
            if(!isdefined(player.str_punch_element)) player.str_punch_element = "upgraded";

            player thread [[@_zm_weap_one_inch_punch<scripts\zm\_zm_weap_one_inch_punch.gsc>::one_inch_punch_melee_attack]]();
            player thread [[@_zm_weap_one_inch_punch<scripts\zm\_zm_weap_one_inch_punch.gsc>::one_inch_punch_melee_attack]]();

        }

        level flag::set( "ee_all_players_upgraded_punch" );
        return;
    }

    // Give saved melees
    foreach( player in getplayers() ){
        if( !is_true( world.save_state[ MAP_NAME ][ "ee_specific" ][ "punch" ][ player getxuid(0) ] ) ) continue; // player doesn't have punch

        // Give punch
        player thread [[@_zm_weap_one_inch_punch<scripts\zm\_zm_weap_one_inch_punch.gsc>::one_inch_punch_melee_attack]]();
	    player playsound("zmb_powerup_grabbed");
        player thread [[@zm_tomb_challenges<scripts\zm\zm_tomb_challenges.gsc>::one_inch_punch_watch_for_death]]();

        player.n_ee_punch_souls = world.save_state[ MAP_NAME ][ "ee_specific" ][ "punch" ][ player getxuid(0) ] ; // Set the saved punch upgraded souls
        if( player.n_ee_punch_souls < 20 ) continue; // player didn't get enough kills for punch upgraded

        player thread hud::fade_to_black_for_x_sec(0, 0.3, 0.5, 0.5, "white");
        player.b_punch_upgraded = true;
        foreach(mdl_staff in level.a_elemental_staffs_upgraded) if(player hasweapon(mdl_staff.w_weapon)) player.str_punch_element = mdl_staff.w_weapon.element;
        if(!isdefined(player.str_punch_element)) player.str_punch_element = "upgraded";

        player thread [[@_zm_weap_one_inch_punch<scripts\zm\_zm_weap_one_inch_punch.gsc>::one_inch_punch_melee_attack]]();
        player thread [[@_zm_weap_one_inch_punch<scripts\zm\_zm_weap_one_inch_punch.gsc>::one_inch_punch_melee_attack]]();
    }

    if( tomb_all_players_have_upgraded_punch() ) level flag::set( "ee_all_players_upgraded_punch" );
}

function tomb_save_one_inch_punch_players(){

    if( !isdefined( world.save_state[ MAP_NAME ][ "ee_specific" ][ "punch" ] ) ) world.save_state[ MAP_NAME ][ "ee_specific" ][ "punch" ] = [];
    if( !isdefined( world.save_state[ MAP_NAME ][ "ee_specific" ][ "punch" ] ) ) world.save_state[ MAP_NAME ][ "ee_specific" ][ "punch_upgraded" ] = [];

    foreach( player in getplayers() ){

        world.save_state[ MAP_NAME ][ "ee_specific" ][ "punch_upgraded" ][ player getxuid(0) ] = is_true( player.n_ee_punch_souls ) ? player.n_ee_punch_souls : 0;
        world.save_state[ MAP_NAME ][ "ee_specific" ][ "punch" ][ player getxuid(0) ] = is_true( player.b_punch_upgraded );
    }
}

function tomb_all_players_have_upgraded_punch(){
    
    foreach( player in getplayers() ) if( !is_true( player.b_punch_upgraded ) ) return false;
    return true;
}

function tomb_fill_soul_box( fill_all = false ){

    if( tomb_all_box_fully_filled() ) return; // Already done

    if( fill_all ){

        foreach( box in getentarray("foot_box", "script_noteworthy") ){
            if( box.n_souls_absorbed >= 30 ) continue; // Already filled
            box.n_souls_absorbed = 30;
            box notify("soul_absorbed", level.host);
        }

        // Give punch chest reward
        foreach( player in getplayers() ) level._challenges.a_stats["zc_boxes_filled"].a_b_player_rewarded[player.characterindex] = true;
        return;
    }

    if( !isdefined( world.save_state[ MAP_NAME ][ "ee_specific" ][ "foot_box" ] ) ) return;

    // Fill all boxes
    foreach( box in getentarray("foot_box", "script_noteworthy") ){
        index = box tomb_get_box_index();
        if( !isdefined( index ) ) continue; // Completed

        saved_souls = world.save_state[ MAP_NAME ][ "ee_specific" ][ "foot_box" ][ index ];
        //level thread debug_message( "Box ^5"+index+" with souls: ^5"+saved_souls );

        if( !saved_souls ) continue; // Didn't absorb any soul

        if( saved_souls >= 30 ) box.n_souls_absorbed = saved_souls;

        box notify("soul_absorbed", level.host);
        wait 0.1;
        box.n_souls_absorbed = saved_souls -1;
    }

    wait 1;

    // Give punch chest reward
    if( tomb_all_box_fully_filled() ) foreach( player in getplayers() ) level._challenges.a_stats["zc_boxes_filled"].a_b_player_rewarded[player.characterindex] = true;
}

function save_tomb_filled_soul_boxes(){

    if( !isdefined( world.save_state[ MAP_NAME ][ "ee_specific" ][ "foot_box" ] ) ) world.save_state[ MAP_NAME ][ "ee_specific" ][ "foot_box" ] = [];

    a_boxes = [];

    for( i=0; i<4; i++ ) a_boxes[ i ] = 30;

    foreach( box in getentarray("foot_box", "script_noteworthy") ){
        index = box tomb_get_box_index();
        if( !isdefined( index ) ) continue; // Already completed

        //level thread debug_message( "Box ^5"+index+" ^2 Detected^7 with souls: ^5"+box.n_souls_absorbed );
        a_boxes[ index ] = box.n_souls_absorbed;
    }

    //for( i=0; i<4; i++ ) level thread debug_message_instant( "Box ^5"+i+" with souls: ^5"+a_boxes[ i ] );

    world.save_state[ MAP_NAME ][ "ee_specific" ][ "foot_box" ] = a_boxes;
}

function tomb_all_box_fully_filled(){

    return level.n_soul_boxes_completed >= 4;
}

function tomb_get_box_index(){

    if( !isdefined( self ) ) return undefined;

    switch( self [[ @zm_utility<scripts\zm\_zm_utility.gsc>::get_current_zone ]]() ){
        case "zone_nml_6": // Pap
            return 0;
        case "zone_nml_12": // Jugg
            return 1;
        case "zone_village_0": // Church
            return 2;
        case "zone_nml_5": // Gen 5
            return 3;

        default:
            return undefined;
    }

    return undefined;
}


// Raise Hell
function tomb_fill_portal_souls( b_all = false ){

    if( b_all ){
        if( level.n_ee_portal_souls < 100 ) level.n_ee_portal_souls = 100;
        level flag::set("ee_souls_absorbed");
        return;
    }

    if( !isdefined( world.save_state[ MAP_NAME ][ "ee_specific" ][ "portal_souls" ] ) ) return; // No save state available

    tomb_wait_for_samantha_portal();

    level.n_ee_portal_souls = world.save_state[ MAP_NAME ][ "ee_specific" ][ "portal_souls" ];

    #ifdef dev
        level thread debug_message( "Filled souls: ^5"+level.n_ee_portal_souls );
    #endif

    if( level.n_ee_portal_souls >= 100 ) level flag::set("ee_souls_absorbed");
}

function tomb_save_portal_souls(){

    if( !isdefined( world.save_state[ MAP_NAME ][ "ee_specific" ][ "portal_souls" ] ) ) world.save_state[ MAP_NAME ][ "ee_specific" ][ "punch" ] = [];

    world.save_state[ MAP_NAME ][ "ee_specific" ][ "portal_souls" ] = is_true( level.n_ee_portal_souls ) ? level.n_ee_portal_souls : 0;

    #ifdef dev
        level thread debug_message( "Filled souls: ^5"+world.save_state[ MAP_NAME ][ "ee_specific" ][ "portal_souls" ] );
    #endif
}

function tomb_is_portal_souls_active(){

    return level flag::get("ee_sam_portal_active");
}

function tomb_wait_for_samantha_portal(){
    
    while( !tomb_is_portal_souls_active() ) wait 0.05;
}

function activate_ee_sam_portal( insert_all = false ){

    if( insert_all ){
        foreach( staff in level.a_elemental_staffs )
        {
            if( is_true( staff.upgrade.charger.is_inserted ) ) continue; // Staff is already placed on agartha

            staff.upgrade.charger.is_inserted = true;
            #ifdef dev
                //level thread debug_message_instant( "^5Inserting staff^7: ^2"+ staff.upgrade.element);
            #endif
        }       
    }

	foreach( index, staff in level.a_elemental_staffs )
	{
		if( is_true( staff.upgrade.charger.is_inserted ) ) continue; // Staff is already placed on agartha

        staff.upgrade.charger.is_inserted =  world.save_state[ MAP_NAME ][ "ee_specific" ][ "staffs_inserted" ][ index ];
        #ifdef dev
            //level thread debug_message_instant( "^5SET Inserting staff^7: ^2"+ staff.upgrade.element+"^7 "+staff.upgrade.charger.is_inserted);
        #endif
	}

}

function save_inserted_staffs(){

    if( !isdefined( world.save_state[ MAP_NAME ][ "ee_specific" ][ "staffs_inserted" ] ) ) world.save_state[ MAP_NAME ][ "ee_specific" ][ "staffs_inserted" ] = [];

    foreach( index, staff in level.a_elemental_staffs)
	{
        world.save_state[ MAP_NAME ][ "ee_specific" ][ "staffs_inserted" ][ index ] = is_true( staff.upgrade.charger.is_inserted );

        #ifdef dev
            //level thread debug_message_instant( "^5Saved inserted staff^7: ^2"+ staff.upgrade.element+"^7 | ^5"+is_true( staff.upgrade.charger.is_inserted ) );
        #endif
	}

}


// Freedom
function tomb_save_quadrotor(){

    world.save_state[ MAP_NAME ][ "ee_specific" ][ "qudrotor_player" ] = undefined;
    world.save_state[ MAP_NAME ][ "ee_specific" ][ "qudrotor_cooldown" ] = quadrotor_cooling_down();
    w_drone = getweapon( "equip_dieseldrone" );

    foreach( player in GetPlayers() ){
        if( player HasWeapon( w_drone ) ){
            //player IPrintLnBold("^5Drone ^2detected!");
            world.save_state[ MAP_NAME ][ "ee_specific" ][ "qudrotor_player" ] = player getxuid(0);
            return;
        }
    }

    //level.host IPrintLnBold("^1There is no player with ^5drone");

}

function tomb_give_quadrotor(){

    if( !isdefined( world.save_state[ MAP_NAME ][ "ee_specific" ][ "qudrotor_player" ] ) ) return; // No save state available    
    
    foreach( player in getplayers() ) if( player getxuid(0) == world.save_state[ MAP_NAME ][ "ee_specific" ][ "qudrotor_player" ] ) break;
    w_drone = getweapon( "equip_dieseldrone" );

    player [[ @zm_weapons<scripts\zm\_zm_weapons.gsc>::weapon_give ]]( w_drone );
    player setweaponammoclip( w_drone, 1 );
    player playsoundtoplayer( "zmb_buildable_pickup_complete", player );
    player setactionslot( 4, "weapon", w_drone );
    player clientfield::set_player_uimodel( "hudItems.showDpadRight_Drone", 1 );
    player notify( "equip_dieseldrone_zm_given" );
    level thread [[ @zm_tomb_craftables<scripts\zm\zm_tomb_craftables.gsc>::quadrotor_watcher]]( player );


    qudrotor_cooldown = world.save_state[ MAP_NAME ][ "ee_specific" ][ "qudrotor_cooldown" ]; // No save state available    
    if( quadrotor_cooling_down() && !qudrotor_cooldown ) remove_quadrotor_cooldown();
}

function tomb_freedom_quadrotor(){

    w_drone = getweapon("equip_dieseldrone");
    s_goal = struct::get("maxis_portal_path", "targetname");
    if( quadrotor_cooling_down() ) remove_quadrotor_cooldown();

    while( !is_quadrotor_disabled() ){ // Send the Drone to its goal
        wait 0.1;

        quadrotors = getentarray("quadrotor_ai", "targetname");
        if( quadrotors.size >= 1 ){ // There is already a Maxis Drone
            quadrotor = quadrotors[0];
        }else{

            player_dron = undefined;
            foreach( player in level.players ){ // Check if someone has Maxis Drone
                if( player hasWeapon( w_drone ) ){
                    player_dron = player;
                    break;
                }
            }

            if( !isDefined( player_dron ) ){ // No one has the Maxis Drone
                
                player_dron = level.host;
                if( !is_object_crafted( "equip_dieseldrone" ) ) craft_open_table_object( "equip_dieseldrone", undefined );
                player_dron grab_crafted_item( "equip_dieseldrone" );
            }

            // Force player using a drone
            player_dron notify("quadrotor_control_thread");
            player_dron switchToWeapon( w_drone );
            player_dron util::waittill_any_timeout(1, "weapon_change_complete");
            player_dron playsound("veh_qrdrone_takeoff");
            player_dron [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::switch_back_primary_weapon]]();
            player_dron util::waittill_any_timeout(1, "weapon_change_complete");
            player_dron [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::switch_back_primary_weapon]]();
            player_dron [[@zm_weapons<scripts\zm\_zm_weapons.gsc>::weapon_take]]( w_drone );
            player_dron setactionslot(4, "");

            str_vehicle = level flag::get( "ee_maxis_drone_retrieved" ) ? "heli_quadrotor_upgraded_zm" : "heli_quadrotor_zm"; 

            quadrotor = spawnvehicle(str_vehicle, player_dron.origin + vectorscale((0, 0, 1), 96), player_dron.angles, "quadrotor_ai");
            level thread [[@zm_tomb_craftables<scripts\zm\zm_tomb_craftables.gsc>::quadrotor_death_watcher]]( quadrotor );
            quadrotor thread [[@zm_tomb_craftables<scripts\zm\zm_tomb_craftables.gsc>::quadrotor_death_watcher]]( player_dron );
            quadrotor thread [[@zm_tomb_vo<scripts\zm\zm_tomb_vo.gsc>::function_a808bc8e]]();
            wait 1;
        }

        quadrotor.origin = s_goal.origin;
        quadrotor util::waittill_any("near_goal", "force_goal", "reached_end_node");
        quadrotor util::waittill_any("near_goal", "force_goal", "reached_end_node");
        wait 2.5;
        quadrotor util::waittill_any("near_goal", "force_goal", "reached_end_node");
        wait 0.5;
    }
    
}



function open_gramophone_doors(){

    level.b_open_all_gramophone_doors = true;
    level notify( "gramophone_vinyl_player_picked_up" );
    level notify( "open_all_gramophone_doors" );

    // Activate main chamber

    a_door_main = getentarray("chamber_entrance", "targetname"); // Para bajar a los bastones
    trig_position = struct::get(a_door_main[1].targetname + "_position", "targetname");

    if( isdefined( trig_position.gramophone_model ) ){
        #ifdef dev
            level.host iPrintLnBold( "undefining gramophone model");
        #endif
        trig_position.gramophone_model delete();
        trig_position.gramophone_model = undefined;
    }

    while( !is_true( trig_position.has_vinyl ) ){
        level notify( "gramophone_vinyl_main_picked_up");
        wait 0.1;
    }

    trig_position.trigger notify( "trigger", level.host );


    a_s_teleporters = struct::get_array("trigger_teleport_pad", "targetname");

    foreach( s_teleporters in a_s_teleporters ){
        level flag::set( "enable_teleporter_" + s_teleporters.script_int );
    }

}

function activate_origins_generators(){

    a_generators = struct::get_array("s_generator", "targetname");
    foreach(s_generator in a_generators)
    {
        if( s_generator flag::get("player_controlled") ) continue; // Generator already active
        
        s_temp = level.zone_capture.zones[s_generator.script_noteworthy];
        s_temp [[@zm_tomb_capture_zones<scripts\zm\zm_tomb_capture_zones.gsc>::set_player_controlled_area]]();
        s_temp.n_current_progress = 100;
        s_temp [[@zm_tomb_capture_zones<scripts\zm\zm_tomb_capture_zones.gsc>::generator_state_power_up]]();
        level clientfield::set(s_temp.script_noteworthy, s_temp.n_current_progress / 100);
    }

}

function enable_agartha_zone(){

    if( level flag::get("activate_zone_chamber")) return; // Already activated

    level flag::set("activate_zone_chamber");
    level notify("player_teleported", level.host, 1);
    wait 0.05;
    level notify("player_teleported", level.host, 2);
    wait 0.05;
    level notify("player_teleported", level.host, 3);
    wait 0.05;
    level notify("player_teleported", level.host, 4);
}

function tomb_tp_all_players_portal_final(){

    end_pos = struct::get("player_portal_final", "targetname").origin;
    foreach( player in getplayers() ){
        player setOrigin( end_pos );
        wait 1;
    }
}

function quadrotor_cooling_down(){
    return level flag::get( "quadrotor_cooling_down" );
}

function remove_quadrotor_cooldown(){
    level flag::clear( "quadrotor_cooling_down" );
}