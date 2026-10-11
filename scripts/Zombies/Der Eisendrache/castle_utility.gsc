
function abh_boss_start(){

    if( isDefined( self.boss_start_arena ) ) return self.boss_start_arena;

    self iPrintLnBold("^1 ERROR, CAN'T FIND BOSS START ARENA POSITION");
    return self;
    
    return isDefined( self.boss_start_arena ) ? self.boss_start_arena : self.origin;
}

function are_all_dragons_fed(){

    return level flag::get("soul_catchers_charged");
}

function wait_all_dragons_fed(){
    level wait_till("soul_catchers_charged");
}

function castle_is_dragon_fed( n_dragon = undefined ){

    while( !isdefined( level.soul_catchers ) ) wait 0.05;

    // All dragons already fed
    if( level flag::get("soul_catchers_charged") ){
        level thread debug_message( "^5Specific dragon already fed!" );
        return true;
    }

    // Feed all dragons
    if( !isdefined( n_dragon ) ){

        level thread debug_message("^1Error unspecified dragon to check if fed...");
        return false;
    }

    if( StrIsNumber( n_dragon )  ) n_dragon = int( n_dragon );

    // Not a number
    if( !IsInt( n_dragon ) ){
        level thread debug_message("^1Invalid n_dragon to check if fed");
        return false;
    }

    // Invalid number
    if( n_dragon < 0 || n_dragon >= level.soul_catchers.size ){
        level thread debug_message("^1Invalid n_dragon to check if fed ^5"+n_dragon);
        return false;
    }

    return level.soul_catchers[ n_dragon ].var_98730ffa >= 8;
}


function castle_feed_dragons( n_dragon = undefined ){

    while( !isdefined( level.soul_catchers ) ) wait 0.05;

    // All dragons already fed
    if( level flag::get("soul_catchers_charged") ){
        level thread debug_message( "^5Dragons ^7 are already fed!" );
        return;
    }

    // Feed all dragons
    if( !isdefined( n_dragon ) ){

        level thread debug_message("^2Feeding all dragons!");

        foreach( dragon in level.soul_catchers ){
            if( dragon.var_98730ffa >= 8 ) continue; // Already fed

            if( !dragon.var_98730ffa ) dragon notify( "first_zombie_killed_in_zone", getplayers()[0] );
            dragon.var_98730ffa = 8;
        }

        level wait_till("soul_catchers_charged");
        level thread debug_message("^2All dragons fed!");
        return;
    }



    if( StrIsNumber( n_dragon )  ) n_dragon = int( n_dragon );

    // Not a number
    if( !IsInt( n_dragon ) ){
        level thread debug_message("^1Invalid n_dragon to feed");
        return;
    }

    // Invalid number
    if( n_dragon < 0 || n_dragon >= level.soul_catchers.size ){
        level thread debug_message("^1Invalid n_dragon to feed ^5"+n_dragon);
        return;
    }

    // Specific dragon already fed
    if( level.soul_catchers[ n_dragon ].var_98730ffa >= 8){
        level thread debug_message("^1Dragon ^5"+n_dragon+"^1 already fed...");
        return;
    }

    level.soul_catchers[ n_dragon ] notify( "first_zombie_killed_in_zone", getplayers()[0] );
    level.soul_catchers[ n_dragon ].var_98730ffa = 8;

    level thread debug_message("^2Dragon fed!");
}







// Kill panzer
function castle_shield_body(){

    if( level flag::get( "gravityspike_part_body_found" ) ) return;

    level notify(#"hash_b650259c", self.origin);
}

// Rocket test
function castle_shield_guards(){

    if( level flag::get( "gravityspike_part_guards_found" ) ) return;

    wall_switch = getent("spike_quest_wall_switch", "targetname");
    console_switch = getent("spike_quest_console_switch", "targetname");

    while( !level flag::get( "gravityspike_part_guards_found" ) ){
        wait 0.2;

        level flag::set("rocket_firing");

        t_wall_switch = get_trigger_from_origin( wall_switch.origin );
        self build_and_activate_trigger_from_unitrigger_stub( t_wall_switch );

        t_console_switch = get_trigger_from_origin( console_switch.origin );
        self build_and_activate_trigger_from_unitrigger_stub( t_console_switch );

        self thread get_specific_craftable_piece( "gravityspike", "part_guards" ); // Rocket test part
    }

    level flag::clear("rocket_firing");
}

// Activate trap
function castle_shield_handle(){
    
    if( level flag::get( "gravityspike_part_handle_found" ) ) return;

    while( !level flag::get( "gravityspike_part_handle_found" ) ){
        wait 0.2;

        level flag::set("tesla_coil_on");
        wait 0.5;
        level flag::clear("tesla_coil_on");
        wait 0.1;
        self thread get_specific_craftable_piece( "gravityspike", "part_handle" ); // Death ray part
    }

}

function get_ragnarok_parts(){

    self thread castle_shield_body();
    self thread castle_shield_guards();
    self thread castle_shield_handle();
}

function place_pyramid_canister(){

    s_canister = struct::get( "canister_2" );
    if( !isDefined( s_canister ) ) return;

    t_canister = get_trigger_from_origin( s_canister.origin );
    if( !isDefined( t_canister ) ) return;
    
    self build_and_activate_trigger_from_unitrigger_stub( t_canister );
}

function castle_see_keeper(){

    if( level [[ level.bgb["zm_bgb_phoenix_up"].validation_func ]]() )  level [[ level.bgb["zm_bgb_phoenix_up"].activation_func ]]();

    level.anywhere_but_here_select_teleport_point_override = ::abh_see_keeper;

    foreach( player in level.players ){
        player FreezeControlsAllowLook( true );
        player [[ level.bgb["zm_bgb_anywhere_but_here"].activation_func ]]();
    } 

    level.anywhere_but_here_select_teleport_point_override = undefined;

    level wait_till( "see_keeper" );

    foreach( player in level.players ) player FreezeControlsAllowLook( false );
}

function abh_see_keeper(){

    player_zone_name = [[@zm_zonemgr<scripts\zm\_zm_zonemgr.gsc>::get_zone_from_position]](self.origin + vectorscale((0, 0, 1), 32), 0);
	if(!isdefined(player_zone_name)) player_zone_name = self.zone_name;
	if(isdefined(player_zone_name)) current_zone = level.zones[player_zone_name];

	a_s_respawn_points = struct::get_array("player_respawn_point", "targetname");

    desired_zone = struct::get("zone_undercroft", "script_noteworthy");
    foreach( respawn_struct in a_s_respawn_points ){
        if( respawn_struct == desired_zone ){

            respawn_points = struct::get_array(respawn_struct.target, "targetname");
            foreach(respawn_point in respawn_points)
            {
                n_script_int = self getentitynumber() + 1;
                if(respawn_point.script_int === n_script_int) return respawn_point;
            }


        }
    }



	a_s_valid_respawn_points = [];
	foreach(s_respawn_point in a_s_respawn_points)
	{
		if( [[@zm_utility<scripts\zm\_zm_utility.gsc>::is_point_inside_enabled_zone]](s_respawn_point.origin, current_zone))
		{
			if(!isdefined(a_s_valid_respawn_points)) a_s_valid_respawn_points = [];
			else if(!isarray(a_s_valid_respawn_points)) a_s_valid_respawn_points = array(a_s_valid_respawn_points);
			a_s_valid_respawn_points[a_s_valid_respawn_points.size] = s_respawn_point;
		}
	}
	if(isdefined(level.zm_bgb_anywhere_but_here_respawn_override)) a_s_valid_respawn_points = [[level.zm_bgb_anywhere_but_here_respawn_override]](a_s_valid_respawn_points);
	s_player_respawn = undefined;
	if(a_s_valid_respawn_points.size > 0)
	{
		rand_valid_respawn = array::random(a_s_valid_respawn_points);
		respawn_points = struct::get_array(rand_valid_respawn.target, "targetname");
		foreach(respawn_point in respawn_points)
		{
			n_script_int = self getentitynumber() + 1;
			if(respawn_point.script_int === n_script_int) s_player_respawn = respawn_point;
		}
	}
	return s_player_respawn;

}


function is_all_keeper_souls_filled(){

    //if( level.var_1f18338d != level.a_elements[ level.a_elements.size -1 ] ) return false; // Not the last bow element

    //mdl_glow = getent("cs_glow_" + level.var_f1b0baba, "targetname");
    //if( mdl_glow clientfield::get("channeling_stone_glow") != 2 ) return false; // Souls for the stone are not filled

    //if( isDefined( level.var_cc2ea6e8 ) ) return false; // Dogs can spawn mid round for EE reasons

    //return is_current_keeper_location_completed();

    //return !is_true( level.var_cc2ea6e8 );

    ai_keeper = getent("keeper_archon_ai", "targetname");

    if( !isDefined( ai_keeper ) ) return true;
    if( ai_keeper clientfield::get("ghost_actor") == 0 ) return true;

    return false;
}

function is_current_keeper_location_completed(){ // function_1f8ca830

	if( level.n_channeling_stone_kills >= get_min_keeper_kills() )
	{
		if( is_true( level.var_f91118d9 ) ) return true;
		else if( level.n_channeling_stone_kills >= get_max_keeper_kills() ) return true;
	}

    return false;
}

function get_max_keeper_kills() // function_f507c094
{

    //return get_min_keeper_kills() * ( 4 - (level.players.size - 1) );
	max_kills = get_min_keeper_kills();

    //return min_kills * ( 4 - (level.players.size - 1) );
	multiplier = 4 - (level.players.size - 1);

    //return min_kills * multiplier;
	max_kills = max_kills * multiplier;

	return max_kills;
}

function get_min_keeper_kills() // function_4400f882
{

	switch( level.str_channeling_stone_element )
	{
		case "demongate":   return 17;
		case "rune_prison": return 16;
		case "storm":       return 20;
		case "wolf_howl":   return 18;

		default:            return 16;
	}

    debug_message("^1Error, ^7Can't find current needed bow for EE keeper step" );
	return 16;
}

function place_stone_replacement(){

    mdl_stone = getent( "cs_stone_2", "targetname" );
    mdl_stone notify( "trigger_activated" );
    return;

    vril_gen_trigger = get_trigger_from_origin( struct::get("vril_generator_family").origin );
    if( isDefined( vril_gen_trigger ) ) build_and_activate_trigger_from_unitrigger_stub( vril_gen_trigger );

}

function castle_ee_get_exploder_id()
{
	str_exploder = undefined;
	switch(level.n_channeling_stone_zone)
	{
		case 1:
		{
			str_exploder = "fxexp_631";
			break;
		}
		case 2:
		{
			str_exploder = "fxexp_632";
			break;
		}
		case 3:
		{
			str_exploder = "fxexp_630";
			break;
		}
		case 4:
		{
			str_exploder = "fxexp_633";
			break;
		}
		default:
		{
			break;
		}
	}
	return str_exploder;
}


function activate_death_ray(){

    if(!isPlayer(self)) self = level.host;

    tesla_coil = getent("tesla_coil_activate", "targetname");

    tesla_trap = get_trigger_from_origin( tesla_coil.origin );
    if( self.score < 1000 ) self.score += 1000;
    self build_and_activate_trigger_from_unitrigger_stub( tesla_trap );

    while( !level flag::get("death_ray_trap_used") ){
        wait 1;
        self iPrintLnBold("^1Trying to activate ^5Death Ray ^1again...");
        tesla_trap = get_trigger_from_origin( tesla_coil.origin );
        if( self.score < 1000 ) self.score += 1000;
        level.host build_and_activate_trigger_from_unitrigger_stub( tesla_trap );
        wait 0.5;
    }

}

function pick_ee_fuse(){

    if(!isPlayer(self)) self = level.host;

    s_lab_fuse = struct::get("ee_lab_fuse");

    ee_fuse = get_trigger_from_origin( s_lab_fuse.origin );
    self build_and_activate_trigger_from_unitrigger_stub( ee_fuse );

    while( !level flag::get("ee_fuse_held_by_team") ){
        wait 1;
        self iPrintLnBold("^1Trying to activate ^5EE Fuse box ^1again...");
        fuse_box = get_trigger_from_origin( s_lab_fuse.origin );
        level.host build_and_activate_trigger_from_unitrigger_stub( ee_fuse );
        wait 0.5;
    }

    level.host iPrintLnBold("^5EE Fuse ^2Picked up!");

}

function pick_canister(){

    if(!isPlayer(self)) self = level.host;

    s_canister = struct::get("mpd_canister");

    canister = get_trigger_from_origin( s_canister.origin );
    self build_and_activate_trigger_from_unitrigger_stub( canister );

    while( !level flag::get("mpd_canister_replacement") ){
        wait 1;
        self iPrintLnBold("^1Trying to activate ^5EE Canister ^1again...");
        canister = get_trigger_from_origin( s_canister.origin );
        level.host build_and_activate_trigger_from_unitrigger_stub( canister );
        wait 0.5;
    }

    level.host iPrintLnBold("^5EE Canister ^2Picked up!");

}

function place_ee_fuse(){

    if(!isPlayer(self)) self = level.host;

    // Pick fuse
    if( !level flag::get( "ee_fuse_held_by_team" ) ) self pick_ee_fuse();

    mdl_fuse_box = getent("fuse_box", "targetname");
    fuse_box = get_trigger_from_origin( mdl_fuse_box.origin );
    self build_and_activate_trigger_from_unitrigger_stub( fuse_box );

    while( !level flag::get("ee_fuse_placed") ){
        wait 1;
        self iPrintLnBold("^1Trying to place ^5EE fuse ^1again...");
        fuse_box = get_trigger_from_origin( mdl_fuse_box.origin );
        level.host build_and_activate_trigger_from_unitrigger_stub( fuse_box );
        wait 0.5;
    }

    level.host iPrintLnBold("^5EE Fuse ^2Placed!");

}

function death_ray_protect(){

    if(!isPlayer(self)) self = level.host;

    mdl_lever = getent("ee_death_ray_switch", "targetname");
    lever = get_trigger_from_origin( mdl_lever.origin );
    self build_and_activate_trigger_from_unitrigger_stub( lever );

    while( level flag::get("switch_to_death_ray") ){
        wait 1;
        self iPrintLnBold("^1Trying to interact with ^5Death Ray Switch ^1again...");
        lever = get_trigger_from_origin( mdl_lever.origin );
        level.host build_and_activate_trigger_from_unitrigger_stub( lever );
        wait 0.5;
    }

    level.host iPrintLnBold("^5Death Ray Switch ^2Interacted!");
}

function death_ray_destroy(){

    if(!isPlayer(self)) self = level.host;

    mdl_lever = getent("ee_death_ray_switch", "targetname");
    lever = get_trigger_from_origin( mdl_lever.origin );
    self build_and_activate_trigger_from_unitrigger_stub( lever );

    while( !level flag::get("switch_to_death_ray") ){
        wait 1;
        self iPrintLnBold("^1Trying to interact with ^5Death Ray Switch ^1again...");
        lever = get_trigger_from_origin( mdl_lever.origin );
        level.host build_and_activate_trigger_from_unitrigger_stub( lever );
        wait 0.5;
    }

    level.host iPrintLnBold("^5Death Ray Switch ^2Interacted!");
}

function take_trap_parts(){

    if(!isPlayer(self)) self = level.host;

    s_golden_key = getEnt("golden_key", "targetname");
    while( !isDefined(s_golden_key)){
        s_golden_key = getEnt("golden_key", "targetname");
        wait 1;
        self iPrintLnBold("^1Trap part doesn't exist...");
    }

    s_golden_key notify("trigger_activated");
    wait 0.5;

    while( !level flag::get("ee_golden_key") ){
        wait 1;
        s_golden_key notify("trigger_activated");
        self iPrintLnBold("^1Trying to pick up ^5Trap parts ^1again...");
    }

    level.host iPrintLnBold("^5EE Trap parts ^2picked up^7!");
}

function place_trap_parts(){

    if(!isPlayer(self)) self = level.host;

    str_suffixes = array("launch_platform", "lower_tower");

    foreach(str_suffix in str_suffixes){

        if( level flag::get("tesla_connector_" + str_suffix) ) continue;

        s_tesla_connector = struct::get("tc_" + str_suffix);
        trigger = get_trigger_from_origin( s_tesla_connector.origin );
        self build_and_activate_trigger_from_unitrigger_stub( trigger );

        while( !level flag::get("tesla_connector_" + str_suffix) ){
            wait 1;
            trigger = get_trigger_from_origin( s_tesla_connector.origin );
            self build_and_activate_trigger_from_unitrigger_stub( trigger );
        }

        self iPrintLnBold("^5Tesla trap part ^2placed!");
    }

}

function take_channeling_stone(){

    if(!isPlayer(self)) self = level.host;

    s_key = struct::get("golden_key_slot_past");
    s_key notify("trigger_activated");
    wait 0.1;
    stone_past = getEnt("stone_past", "targetname");
    stone_past notify("trigger_activated");
    wait 0.1;

    while( !level flag::get("channeling_stone_replacement") ){

        #ifdef dev
            self iPrintLnBold( "^1Trying again to pick ^5Channeling stone^1..." );
        #endif
        wait 1;

        s_key = struct::get("golden_key_slot_past");
        s_key notify("trigger_activated");
        wait 0.1;
        stone_past = getEnt("stone_past", "targetname");
        stone_past notify("trigger_activated");
        wait 0.1;

    }

    #ifdef dev
        self iPrintLnBold( "^5Channeling stone ^2picked up!" );
    #endif

}

function place_vril_generator(){

    vril_gen = struct::get("vril_generator_family");
    vril_gen_trigger = get_trigger_from_origin( vril_gen.origin );

    while(!isdefined(vril_gen_trigger)){
        wait 1;
        vril_gen_trigger = get_trigger_from_origin( vril_gen.origin );
    }

    build_and_activate_trigger_from_unitrigger_stub(vril_gen_trigger);
}

function call_dempsey(){

    s_death_ray = struct::get("death_ray_button");
    while( !isdefined( s_death_ray.s_unitrigger ) ){
        wait 1;
        s_death_ray = struct::get("death_ray_button");
    }

    s_death_ray notify( "trigger_activated" );
}

function pickup_rod(){

    mdl_vril_generator = struct::get("vril_generator");
    vril_trigger = get_trigger_from_origin( mdl_vril_generator.origin );

    while(!isDefined(vril_trigger)){
        wait 1;
        vril_trigger = get_trigger_from_origin( mdl_vril_generator.origin );
    }
    build_and_activate_trigger_from_unitrigger_stub(vril_trigger);
}

function is_channeling_stone_step_ready(){

    return level flag::get( "start_channeling_stone_step" );
}

function is_de_bossfight_ready(){

    return level flag::get( "boss_fight_ready" );
}

function is_de_bossfight_completed(){

    return level flag::get( "boss_fight_completed" );
}

// This is set whenever you press the last terminal button
function is_de_ee_completed(){

    return level flag::get( "sent_rockets_to_the_moon" );
}




function activate_flinger_pads(){

    flinger_landing_pad = struct::get_array("115_flinger_landing_pad", "targetname"); // Activate flingers
    foreach(pad in flinger_landing_pad){
        if( !level flag::get(pad.script_noteworthy) ){
            pad notify("trigger", self);
            level flag::set(pad.script_noteworthy);
        }
    }

}

function de_pap_activate_lui(){

    foreach(pap in level.a_s_pap_tp_locations){
        s_pap_tp_locations = level.host get_trigger_from_origin( ( pap.origin + vectorscale((0, 0, 1), 30) ) );
        s_pap_tp_locations notify("trigger", level.host);
        wait 1;
    }

}




function is_time_travel_needed(){ // If we pass the round, will another wisp spawn?

    return !level flag::get( "stop_time_travel" ); // All time travel objects have been picked up (for code it's soul's canister and keeper's tablet)
}

function is_this_round_wisp_done(){ // Wisps have been completed

    return level flag::get( "time_travel_teleporter_ready" );
}

function get_n_wisps_done(){

    wisps_done = 0;
    foreach( wisp in getentarray( "activate_teleporter_object", "targetname" ) ){
        if( is_true( wisp.var_25a8b5d5 ) ) wisps_done++;
    }

    return wisps_done;
}

function is_safe_box_code_known(){

    return ( isdefined( level.var_ab58bca7 ) && ( level.var_ab58bca7.size >= 3 ) );
}

function autocomplete_wisp(){

    if( !is_time_travel_needed() ) return;

    while( !is_this_round_wisp_done() ){ // Time travel is ready
        wait 0.5;
        //level.host iPrintLnBold("Between rounds OVER");

        if( !isDefined( level.e_target_selected ) ){ // Maybe this round wisps has been failed, we need to check it to decide if we need to pass the round
            level.host iPrintLnBold("^1We need to skip round...");

            while( ![[ level.bgb["zm_bgb_round_robbin"].validation_func ]]() ) wait 0.1;
            level [[ level.bgb["zm_bgb_round_robbin"].activation_func ]]();
            level waittill("start_of_round");

            while( !isDefined( level.e_target_selected ) ) wait 0.1;
            continue;
        }

        //level.host iPrintLnBold("Waiting for wisp to be selected");

        while( !is_true( level.e_target_selected.b_target_current ) ) wait 0.05; // Waiting for a wisp to be selected

        //level.host iPrintLnBold("^2Wisp sleceted!");

        #ifdef dev
            //self setOrigin( level.e_target_selected.origin );
        #endif

        level.e_target_selected notify( "damage", 7, self, self.angles, level.e_target_selected.origin, undefined, undefined, undefined, undefined, getweapon( "elemental_bow_storm" ) );

        if( get_n_wisps_done()+1 >= 4 ) break; // The 4th wisp has been hit

        while( is_true( level.e_target_selected.var_25a8b5d5 ) ) wait 0.05; // Wait for the wisp to be marked
    }

    //level.host iPrintLnBold("Wisps fininshed");
}

function first_wisp_tp(){

    teleport_pad = getentarray("trigger_teleport_pad", "targetname")[0];
    other_teleport = struct::get_array(getentarray("trigger_teleport_pad", "targetname")[1].target, "targetname");
    foreach( i, player in level.players ){ // Get players to teleporter
        #ifdef dev
            player notify("stop_player_out_of_playable_area_monitor");
        #endif
        if( PositionWouldTelefrag( other_teleport.origin )) player setorigin(other_teleport[i].origin + (randomfloatrange(-16, 16), randomfloatrange(-16, 16), 0));
        else player setorigin(other_teleport[i].origin);

        player FreezeControlsAllowLook( true );
    }

    if( is_true( level.is_cooldown ) ) level.is_cooldown = false; // Teleport cooldown
    if( level flag::get( "rocket_firing" ) ) level flag::clear("rocket_firing"); // Rocket is currently active?
    if( self.score < 1000 ) self.score += 1000;
    teleport_pad notify( "trigger", self );
}

function second_wisp_tp(){

    teleport_pad = getentarray("trigger_teleport_pad", "targetname")[1];
    other_teleport = struct::get_array(getentarray("trigger_teleport_pad", "targetname")[0].target, "targetname");
    foreach( i, player in level.players ){ // Get players to teleporter
        #ifdef dev
            player notify("stop_player_out_of_playable_area_monitor");
        #endif
        if( PositionWouldTelefrag( other_teleport.origin )) player setorigin(other_teleport[i].origin + (randomfloatrange(-16, 16), randomfloatrange(-16, 16), 0));
        else player setorigin(other_teleport[i].origin);

        player FreezeControlsAllowLook( true );
    }

    if( is_true( level.is_cooldown ) ) level.is_cooldown = false; // Teleport cooldown
    if( level flag::get( "rocket_firing" ) ) level flag::clear("rocket_firing"); // Rocket is currently active?
    teleport_pad notify( "trigger", self );

    while( self.zone_name != "zone_past_laboratory" ) wait 0.1;
    foreach( player in level.players ) player FreezeControlsAllowLook( false );

    // Pick keeper's tablet
    if( !level flag::get( "channeling_stone_replacement" ) ) self take_channeling_stone();

    // Pick canister
    if( !level flag::get("mpd_canister_replacement") ) self pick_canister();

    while( self.zone_name == "zone_past_laboratory" ) wait 0.1;
}


function castle_wait_for_dragons_fed(){

    level waittill( "soul_catchers_charged" );
}

function castle_wait_for_time_travel(){

    level waittill( "cin_zm_castle_drgroph_easteregg_initialized" );
}

function castle_wait_for_keeper_intro(){

    level waittill( "cin_zm_dlc1_corrupted_keeper_charge_stone_intro_playing" );
}

function castle_wait_bossfight_begin(){

    level waittill( "boss_fight_begin" );
}   

function castle_wait_my_brothers_keeper(){

    level waittill( "cin_cas_01_outro_3rd_sh010_playing" );
    
    SetDvar( DVAR_LIVESPLIT_PAUSED, "1"); // Last split, user may be playing a Super EE
}


/* HmmNotes
    NEEDED TO START KEEPER
	level wait_till("start_channeling_stone_step"); // Pickup stone
	level waittill(#"hash_4619f71b");   // Placed rod at Phantom Keeper Spawn

    // Before keeper level.zombie_death_event_callbacks.size = 5
    // After keeper level.zombie_death_event_callbacks.size = 6
*/