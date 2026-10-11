function gsc_save( args ){

    if( !isdefined( world.save_state ) ) world.save_state = [];
    if( !isdefined( world.save_state[ MAP_NAME ] ) ) world.save_state[ MAP_NAME ] = [];

    if( IS_ZOMBIES ){

        // Power
        world.save_state[ MAP_NAME ][ "power" ] = level flag::exists( "power_on" ) ? get_power_flags() : undefined;

        // Blockers
        world.save_state[ MAP_NAME ][ "blockers" ] = get_opened_blockers();

        // Barriers
        world.save_state[ MAP_NAME ][ "barriers" ] = get_opened_barriers();
        
        // Easter Egg
        world.save_state[ MAP_NAME ][ "ee_specific" ] = [];
        world.save_state[ MAP_NAME ][ "ee" ] = [];
        wait 0.05;
        world.save_state[ MAP_NAME ][ "ee" ] =  [[ level.get_ee_steps ]]();

        // Rounds
        world.save_state[ MAP_NAME ][ "round" ] = isdefined( level.round_number ) ? level.round_number : 1;
    }

    // Players
    save_player_basic_info();
    #ifdef dev
        level thread debug_message_instant( "^5Save state ^2completed!" );
    #endif

    level thread DisplayFeedMessage( "^5Custom State ^2Saved!" );
    setDvar( DVAR_PRACTICE_STATE, "custom" );
}

function gsc_load(){

    // There is no save state created
    if( !isdefined( world.save_state ) ){
        level thread debug_message( "^1Error^7, ^5save state^7 doesn't exist..." );
        return;
    }

    // There is no save state created for current map
    if( !isdefined( world.save_state[ MAP_NAME ] ) ){
        level thread debug_message( "^1Error^7, ^5save state^7 for map '^5"+MAP_NAME+"^7' is not created..." );
        return;
    }

    setdvar( DVAR_TIMESCALE, 10 );

    // Wait for commands to be fully registered
    while( !isdefined( level.commands_register_completed ) ) wait 0.05;

    if( IS_ZOMBIES ){

        wait_for_game_start();

        // Power
        if( isdefined( world.save_state[ MAP_NAME ][ "power" ] ) ) level.host enable_saved_power();

        // Blockers
        if( isdefined( world.save_state[ MAP_NAME ][ "blockers" ] ) ) level enable_saved_blockers();

        // Barriers
        if( isdefined( world.save_state[ MAP_NAME ][ "barriers" ] ) ) level set_saved_barriers();

        #ifdef dev
            //level.host IPrintLnBold("Starting saved EE steps!");
        #endif

        // Easter Egg
        if( isdefined( world.save_state[ MAP_NAME ][ "ee" ] ) ) level complete_saved_ee_steps();

        #ifdef dev
            //level.host IPrintLnBold("Saved EE steps done!");
        #endif
        
        // Rounds
        if( isdefined( world.save_state[ MAP_NAME ][ "round" ] ) ) level.host execute_command("round " + world.save_state[ MAP_NAME ][ "round" ]  );
    }

    foreach( player in getplayers() ){
        // There is no saved data of any player
        if( !isdefined( world.save_state[ MAP_NAME ][ "players" ] ) ) break;

        // This player doesn't have saved data
        if( !isdefined( world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ] ) ) continue;

        // Points
        if( isdefined( world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Score ) ) player.score = world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Score;

        // Weapons
        player give_saved_weapons();

        // Perks
        player give_saved_perks();
    }

    setdvar( DVAR_TIMESCALE, 1 );

    foreach( player in getplayers() ){

        // There is no saved data of any player
        if( !isdefined( world.save_state[ MAP_NAME ][ "players" ] ) ) break;

        // This player doesn't have saved data
        if( !isdefined( world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ] ) ) continue;

        if( isdefined( world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Origin ) ) player SetOrigin( world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Origin );
        if( isdefined( world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Angles ) ) player setPlayerAngles( world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Angles );
        player SetStance( world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Stance );
        player setVelocity( world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Speed );

        // Gums
        player give_saved_gum();

        // Randomized BGB
        if( isdefined( world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].bgb_pack_randomized ) ){

            player.bgb_pack_randomized = [];
            foreach( index, str_gum in world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].bgb_pack_randomized ){
                level thread debug_message( "^5"+player.name+" ^7"+(index+1)+" "+parse_bgb_name( str_gum ) );
                ArrayInsert(player.bgb_pack_randomized, str_gum, player.bgb_pack_randomized.size);
            }

        }
        #ifdef dev
            else{
                //level thread debug_message( "^5"+player.name+" ^1no Randomized BGB..." );
            }
        #endif
    }
}



// Basic player info
function save_player_basic_info(){

    if( !isdefined( world.save_state[ MAP_NAME ][ "players" ] ) ) world.save_state[ MAP_NAME ][ "players" ] = [];

    foreach( player in getplayers() ){
        if( !isdefined( world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ] ) ) world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ] = spawnstruct();

        world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ] = SpawnStruct();
        world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Weapons = [];

        player get_player_gum();

        world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Score = is_true( player.score ) ? player.score : 0;

        if( IsAlive( player ) ){
            // Basic info
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Origin       = player getOrigin();
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Angles       = player getPlayerAngles();
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Stance       = player getStance();
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Speed        = player getVelocity();

            // Weapons
            player save_weapons_alive();

            // Perks
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Perks  = [];
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Perks  = player get_player_perks();
        }else{
            // Basic info
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Origin       = undefined;
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Angles       = undefined;
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Stance       = "stand";
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Speed        = ( 0, 0, 0 );

            // Weapons
            player save_weapons_dead();

            // Perks
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Perks  = [];

            // Current Gum
            world.save_state[ MAP_NAME ][ "players" ][ player getxuid(0) ].Gum  = undefined;

        }
    }


}

// Gum
function give_saved_gum(){

    if( !isdefined( world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Gum ) ){
        #ifdef dev
            //self IPrintLnBold("^1No gum saved???");
        #endif
        return;
    }

    str_bgb = world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Gum.Name;
    saved_remaining = world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Gum.Remaining;
    original_remaining = level.bgb[ str_bgb ].limit;
    type = level.bgb[ str_bgb ].limit_type;

    #ifdef dev
        self IPrintLnBold("^2Gum^7 is ^5"+str_bgb+"^7 with ^5"+saved_remaining+"^7 uses");
    #endif

    if( type != "event" ){

        level.bgb[ str_bgb ].limit = saved_remaining;
        wait 0.05;

        self execute_command( "bgb "+str_bgb );
        level.bgb[ str_bgb ].limit = original_remaining;
        wait 0.05;
    }else{

        self execute_command( "bgb "+str_bgb );
    }

    switch( type )
	{
		case "activated": // Purple
        {
            while( self clientfield::get_player_uimodel("bgb_timer") != 1 ) wait 0.05;
            wait 0.05;
            self clientfield::set_player_uimodel("bgb_activations_remaining", saved_remaining);
            self clientfield::set_player_uimodel("bgb_timer", saved_remaining / original_remaining );
            return;
        }
		case "time": // Green
        {
            while( self clientfield::get_player_uimodel("bgb_timer") != 1 ) wait 0.05;
            wait 0.05;
            self thread run_custom_bgb_timer( saved_remaining, str_bgb );
            return;
        }
        case "rounds": // Blue
        {
            while( self clientfield::get_player_uimodel("bgb_timer") != 1 ) wait 0.05;
            wait 0.05;
            self thread run_custom_bgb_rounds( saved_remaining, str_bgb );
            return;
        }
        case "event": // Orange
        {
            while( self clientfield::get_player_uimodel("bgb_timer") != 1 ) wait 0.05;
            self thread set_saved_orange_gum_uses( str_bgb, saved_remaining );
        }

	}

}

function set_saved_orange_gum_uses( bgb, uses_remaining ){

    // Orange gums with more than one use
    switch( bgb ){
        
        case "zm_bgb_burned_out":
        {
            if( uses_remaining == 2 ) return; // We already have all the uses

            spawner = getentarray("zombie_spawner", "script_noteworthy")[0];
            ai = [[@zombie_utility<scripts\shared\ai\zombie_utility.gsc>::spawn_zombie]]( spawner, spawner.targetname );
            self notify( "damage", undefined, ai, undefined, undefined, "MOD_MELEE");
            wait 0.05;
            ai kill();
            return;
        }
        case "zm_bgb_pop_shocks": 
        {
            self.bgb_remaining_hits = uses_remaining;
            self [[@bgb<scripts\zm\_zm_bgb.gsc>::set_timer]](self.bgb_remaining_hits, 5);
            return;
        } 
        case "zm_bgb_slaughter_slide":
        {
            self.bgb_slaughter_slides_remaining = uses_remaining;
            self [[@bgb<scripts\zm\_zm_bgb.gsc>::set_timer]](self.bgb_slaughter_slides_remaining, 6);
            return;
        }
        case "zm_bgb_soda_fountain":
        {
            self.n_bgb_soda_fountain_uses_remaining = uses_remaining;
            self [[@bgb<scripts\zm\_zm_bgb.gsc>::set_timer]](self.n_bgb_soda_fountain_uses_remaining, 5);
            return;
        }
        case "zm_bgb_self_medication":
        {
            self.n_bgb_self_medication_uses_remaining = uses_remaining;
            self [[@bgb<scripts\zm\_zm_bgb.gsc>::set_timer]](self.n_bgb_self_medication_uses_remaining, 3);
            return;
        }
        case "zm_bgb_flavor_hexed":
        {
            if( uses_remaining == 2 ) return; // We already have all the uses

            self waittill("bgb_update", new_gum, old_gum); // Taking random gum of Flavor Hexed from player to give the second random gum
            self [[@bgb<scripts\zm\_zm_bgb.gsc>::take]]();
            return;
        }
        case "zm_bgb_tone_death":{

            self.n_bgb_tone_death_count = uses_remaining;
            self [[@bgb<scripts\zm\_zm_bgb.gsc>::set_timer]](self.n_bgb_tone_death_count, 25);
            return;
        }

    }

    // If we reach here then orange gum is single use
    return;

}

function run_custom_bgb_rounds( rounds, str_bgb ){
    self endon( "disconnect" );
    self endon( "bled_out" );
    self endon( "bgb_gumball_anim_give" );

	self notify("bgb_limit_monitor" ); // End game's original bgb timer animation
	self endon( "bgb_limit_monitor" );

    count = level.bgb[ str_bgb ].limit + 1;

    level waittill( "end_of_round");

    for(i = count - ( rounds + 1 ); i < count; i++)
    {
        self [[@bgb<scripts\zm\_zm_bgb.gsc>::set_timer]]( count - i, count );
        level waittill( "end_of_round");
        self playsoundtoplayer("zmb_bgb_power_decrement", self);
    }
    self playsoundtoplayer("zmb_bgb_power_done_delayed", self);

    self thread [[@bgb<scripts\zm\_zm_bgb.gsc>::take]]();
}

function run_custom_bgb_timer( time_left, str_bgb ){
    self endon( "disconnect" );
    self endon( "bled_out" );
    self endon( "bgb_gumball_anim_give" );

    self notify( "bgb_run_timer" ); // End game's original bgb timer animation
    self endon( "bgb_run_timer" );
    
    max = level.bgb[ str_bgb ].limit;

    while(time_left > 0)
	{
        self clientfield::set_player_uimodel("bgb_timer", time_left / max);
		wait 0.05;
		time_left -= 0.05;
	}
    self clientfield::set_player_uimodel("bgb_timer", 0);
    self notify( "bgb_run_timer" );
}

function get_player_gum(){

    // Randomized BGB
    if( isdefined( self.bgb_pack_randomized ) && self.bgb_pack_randomized.size ){

        level thread debug_message( "^5Saving some gums!" );

        world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].bgb_pack_randomized = [];

        foreach( index, str_gum in self.bgb_pack_randomized){
            
            //level thread debug_message( "^5"+self.name );
            //level thread debug_message( "^5"+self.name+" ^7"+index);
            level thread debug_message( "^5"+self.name+" ^7"+(index+1)+" "+parse_bgb_name( str_gum ) );

            ArrayInsert(world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].bgb_pack_randomized, str_gum, world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].bgb_pack_randomized.size);
        }    

    }else{
        level thread debug_message( "^5"+self.name+" ^1no gums...");
        world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].bgb_pack_randomized = undefined;
    }

    // In case you don't have any gum
    if( self.bgb == "none" ){
        world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Gum = undefined;
        return;
    }

    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Gum  = SpawnStruct();

    str_bgb = self is_using_flavor_hexed() ? "zm_bgb_flavor_hexed" : self.bgb;

    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Gum.Name = str_bgb;

    #ifdef dev
        self IPrintLnBold("^2Saved gum^7: ^5"+str_bgb);
    #endif

    switch( level.bgb[ str_bgb ].limit_type )
	{
		case "activated": // Purple
        {
            world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Gum.Remaining = get_bgb_uses();
            return;
        }
		case "time": // Green
        case "rounds": // Blue
        {
            world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Gum.Remaining = get_bgb_time_or_rounds();
            return;
        }
		case "event": // Orange
        {
            world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Gum.Remaining = get_event_gums_uses_left( str_bgb );
            return;
        }

        default:
        {
            level thread debug_message( "^1Error, unknown ^5Limit Type" );
            world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Gum.Remaining = 0;
        }
	}

}

function get_bgb_uses(){

    return self clientfield::get_player_uimodel("bgb_activations_remaining");
}

function get_bgb_time_or_rounds(){

    return int( self clientfield::get_player_uimodel("bgb_timer") * level.bgb[ self.bgb ].limit );
}

function get_event_gums_uses_left( bgb ){

    switch( bgb ){ // Orange gums with more than one use
        case "zm_bgb_burned_out":       return self clientfield::get_player_uimodel("bgb_timer") == 1 ? 2 : 1;
        case "zm_bgb_pop_shocks":       return self.bgb_remaining_hits;
        case "zm_bgb_slaughter_slide":  return self.bgb_slaughter_slides_remaining;
        case "zm_bgb_soda_fountain":    return self.n_bgb_soda_fountain_uses_remaining;
        case "zm_bgb_self_medication":  return self.n_bgb_self_medication_uses_remaining;
        case "zm_bgb_flavor_hexed":     return self.a_str_flavor_hexed_bgb.size > 0 ? 2 : 1;
        case "zm_bgb_tone_death":       return isdefined( self.n_bgb_tone_death_count ) ? self.n_bgb_tone_death_count : 25;

        default:
        {
            level thread debug_message("^1UNKNOWN 'Event gum'");
            return 1;
        }
    }

    level thread debug_message("^1Event gum out of index...");
    return 0;
}


// Weapons
function save_weapons_alive(){

    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "current" ] = self GetCurrentWeapon().rootweapon.name;

    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ] = SpawnStruct();
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ].weapon = undefined;
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ].aat = "none";

    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ] = SpawnStruct();
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ].weapon = undefined;
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ].aat = "none";

    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ] = SpawnStruct();
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ].weapon = undefined;
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ].aat = "none";

    if( self GetWeaponsListPrimaries().size < 1 ) return; 

    weapon = self GetWeaponsListPrimaries()[0];
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ].weapon = weapon.rootweapon.name;
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ].aat = self get_weapon_aat( weapon );

    if( self GetWeaponsListPrimaries().size < 2 ) return; 

    weapon = self GetWeaponsListPrimaries()[1];
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ].weapon = weapon.rootweapon.name;
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ].aat = self get_weapon_aat( weapon );


    if( self GetWeaponsListPrimaries().size < 3 ) return;

    weapon = self GetWeaponsListPrimaries()[2];
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ].weapon = weapon.rootweapon.name;
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ].aat = self get_weapon_aat( weapon );
}

function save_weapons_dead(){

    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ] = SpawnStruct();
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ] = SpawnStruct();
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ] = SpawnStruct();

    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ].weapon = level.start_weapon.rootweapon.name;
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ].aat = "none";

    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ].weapon = level.super_ee_weapon.rootweapon.name;
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ].aat = "none";

    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ].weapon = undefined;
    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ].aat = "none";

    world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "current" ] = level.super_ee_weapon.rootweapon.name;
}

function give_saved_weapons(){

    foreach( w_take in self GetWeaponsListPrimaries() ) self TakeWeapon( w_take );

    if( self is_first_weapon_saved() )  self execute_command( "weapon "+ world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ].weapon );
    if( self is_second_weapon_saved() ) self execute_command( "weapon "+ world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ].weapon );
    if( self is_third_weapon_saved() )  self execute_command( "weapon "+ world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ].weapon );

    wait 0.05;

    foreach( weapon in self GetWeaponsListPrimaries() ){
        self ShouldDoInitialWeaponRaise(weapon, false);

        if( self is_first_weapon_saved() && weapon.rootweapon.name == world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ].weapon )    self [[@aat<scripts\shared\aat_shared.gsc>::acquire]]( weapon, world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ].aat );
        if( self is_second_weapon_saved() && weapon.rootweapon.name == world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ].weapon )    self [[@aat<scripts\shared\aat_shared.gsc>::acquire]]( weapon, world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ].aat );
        if( self is_third_weapon_saved() && weapon.rootweapon.name == world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ].weapon )    self [[@aat<scripts\shared\aat_shared.gsc>::acquire]]( weapon, world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ].aat );
        if( weapon.rootweapon.name == world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "current" ] )          self SwitchToWeaponImmediate( weapon );
    }

}

function is_first_weapon_saved(){
    return isdefined( world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "first" ].weapon );
}

function is_second_weapon_saved(){
    return isdefined( world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "second" ].weapon );
}

function is_third_weapon_saved(){
    return isdefined( world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].weapons[ "third" ].weapon );
}

function get_weapon_aat( weapon ){
    weapon = get_nonalternate_weapon( weapon );
    return isdefined( self.aat[ weapon ] ) ? self.aat[ weapon ] : "none";

    /*  3arc code
        weapon = get_nonalternate_weapon( weapon );
        keys = getarraykeys( level.aat );
        self.aat[ weapon ] = keys[0];
    */
}


// POWER
function get_power_flags(){

    power_flags = [];

    // default power flag
    if( level flag::get( "power_on" ) ){
        power_flags[ "power_on" ] = true;
        //level thread debug_message_instant( "^8GENERAL POWER ACTIVE!" );
    }

    // custom power flags
    foreach( flag_name in GetArrayKeys( level.flag ) ){
        if( !is_valid_power_flag( flag_name ) ) continue;

        power_flags[ flag_name ] = int( strtok(flag_name, "power_on")[0] );
        //level thread debug_message_instant( "Flag: ^5"+flag_name+"^7 Value: ^5"+power_flags[ flag_name ] );
    }

    return power_flags;
}

function is_valid_power_flag( flag_name ){

    if( !issubstr( flag_name, "power_on") ) return false; // Not a power flag
    //if( IsInArray( strtok(flag_name, "_"), "scene") ) return false; // We don't want scene flags
    if( IsInArray( strtok(flag_name, "_"), "bundle") ) return false; // We don't want bundle flags
    if( flag_name.size <= 8 || !StrIsNumber( strtok(flag_name, "power_on")[0] ) ) return false; // Not a valid number
    if( !level flag::get( flag_name ) ) return false; // Ignore unset flags

    return true;
}

function enable_saved_power(){

    // Power flags
    foreach( name, value in world.save_state[ MAP_NAME ][ "power" ] ){
        if( !is_true( value ) ) continue;

        #ifdef dev
            //level thread debug_message_instant( "Flag: ^5"+name+"^7 Value: ^5"+value );
            //continue;
        #endif

        if( name == "power_on" ){
            //level thread debug_message_instant( "^8Activating general power" );
            level specific_power();
            continue;
        }

        //continue;
        level flag::set( name );
        level clientfield::set( "zombie_power_on", value );
    }

}


// BLOCKERS
function get_opened_blockers(){

    blockers = [];

    // Doors
    blockers["zombie_door"] = [];
    foreach( door in getentarray( "zombie_door", "targetname" ) ){
        if( !is_true( door._door_open ) ) continue;
        if( door.script_noteworthy == "electric_door" ) continue; // The Giant power doors must be ignored

        #ifdef dev
            if( !isdefined( door.script_flag ) ){
                level thread debug_message_instant( "Door doesn't have a flag!: ^5"+door.script_noteworthy);
                level.host SetOrigin( door.origin );
            }else{
                //level thread debug_message_instant( "Saved door: ^5"+door.script_flag);
            }

        #endif
        ArrayInsert( blockers["zombie_door"], door.script_flag, blockers["zombie_door"].size );
    }

    level thread debug_message_instant( "Saving Debris Start");

    // Debris
    blockers["zombie_debris"] = [];

    /* How do debris work?

        Debris are deleted after being opened, so if we detect a debris it's 100% closed.
        You have to save the closed debris and open the ones that are NOT saved
        self [[level.custom_debris_function]](); // Only debris have this custom function check, it's unused on all maps
    */
    foreach( debris in getentarray( "zombie_debris", "targetname" ) ){

        #ifdef dev
            /*if( !isdefined( debris.script_flag ) || debris.script_flag == "" || debris.script_flag == " " ){
                level thread debug_message_instant( "Saved debris ^1WITHOUT FLAG" );
                getplayers()[0] SetOrigin( debris.origin );
            }else{
                level thread debug_message_instant( "Saved debris: ^5"+debris.script_flag);
            }*/
        #endif

        ArrayInsert( blockers["zombie_debris"], debris.script_flag, blockers["zombie_debris"].size );
    }

    // Airlocks
    blockers["zombie_airlock_buy"] = [];
    foreach( airlock in getentarray( "zombie_airlock_buy", "targetname" ) ){
        if( !airlock is_debris_opened() ) continue;

        #ifdef dev
            //level thread debug_message_instant( "Saved airlock: ^5"+airlock.script_flag);
        #endif
        ArrayInsert( blockers["zombie_airlock_buy"], airlock.script_flag, blockers["zombie_airlock_buy"].size );
    }
    // AIRLOCKS MAY BE ABLE TO USE "._door_open"

    return blockers;
}



function is_debris_opened(){

    foreach( token in strtok( self.script_flag, "," ) ){
        level thread debug_message_instant( "^2DEBRIS FLAG: ^6");
        wait 0.5;
        if( !level flag::get( token ) ) return false;
    }

    return true;
}

function enable_saved_blockers(){

    setdvar( DVAR_ZOMBIE_UNLOCK_ALL, 1 );

    // Doors
    foreach( door in getentarray( "zombie_door", "targetname" ) ){
        wait 0.05;
        if( is_true( door._door_open ) ) continue;
        if( !IsInArray( world.save_state[ MAP_NAME ][ "blockers" ][ "zombie_door" ], door.script_flag) ) continue;

        //level thread debug_message_instant( "Opening Door: ^5"+door.script_flag );
        door notify( "trigger", level.host );
    }

    // Debris
    foreach( debris in getentarray( "zombie_debris", "targetname" ) ){
        wait 0.05;

        if( !isdefined( debris.script_flag ) || debris.script_flag == "" || debris.script_flag == " " ) continue;
        if( IsInArray( world.save_state[ MAP_NAME ][ "blockers" ][ "zombie_debris" ], debris.script_flag) ) continue;

        //level thread debug_message_instant( "Opening debris: ^5"+debris.script_flag);
        debris thread force_open_debris();
    }

    // Airlocks
    foreach( airlock in getentarray( "zombie_airlock_buy", "targetname" ) ){
        wait 0.05;
        if( airlock is_debris_opened() ) continue;
        if( !IsInArray( world.save_state[ MAP_NAME ][ "blockers" ][ "zombie_airlock_buy" ], airlock.script_flag) ) continue;

        airlock notify( "trigger", level.host );
    }

    setdvar( DVAR_ZOMBIE_UNLOCK_ALL, 0 );
}

function force_open_debris(){
    self endon( "kill_debris_prompt_thread" ); 

    for(;;){
        wait 0.2;
        self notify( "trigger", getplayers()[0], true ); // This one works
    }
}


// BARRIERS
function get_opened_barriers(){

    a_barriers = [];

    foreach(barrier in level.exterior_goals){
        if( !isdefined( barrier.zbarrier ) ){
            #ifdef dev
                level thread debug_message("Barrier without ^1zbarrier...");
                level.host SetOrigin(barrier.origin);
            #endif
            continue;
        }

        a_barriers[ barrier.script_string ] = [];

        for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++)
        {
            zstate = barrier.zbarrier getzbarrierpiecestate(x);
            
            a_barriers[ barrier.script_string ][ x ] = (zstate == "opening" || zstate == "open") ? "opening" : "closing";
            //level thread debug_message("Saved state^5 "+barrier.script_string+" ^7N^5"+x+" ^7"+a_barriers[ barrier.script_string ][ x ]);
        }
    }

    return a_barriers;
}

function set_saved_barriers(){

    foreach(barrier in level.exterior_goals){
        if( !isdefined( barrier.zbarrier ) ) continue;

        // Not saved the info for the barrier?
        if( !isdefined( world.save_state[ MAP_NAME ][ "barriers" ][ barrier.script_string ] ) ){
            level thread debug_message("^1Missing zbarrier info? ^5"+barrier.script_string);
            continue;
        }

        for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++)
        {
            if( !isdefined( world.save_state[ MAP_NAME ][ "barriers" ][ barrier.script_string ][ x ] ) ){
                //level thread debug_message("^1Missing zbarrier PIECE info? ^5"+barrier.script_string);
                continue;
            }

            //level thread debug_message("^5"+barrier.script_string+" ^7N^2"+x+" ^5"+world.save_state[ MAP_NAME ][ "barriers" ][ barrier.script_string ][ x ]);

            barrier.zbarrier setzbarrierpiecestate(x, world.save_state[ MAP_NAME ][ "barriers" ][ barrier.script_string ][ x ]);
        }
    }

}

// PERKS
function get_player_perks(){

    a_perks = [];

    foreach( perk in GetArrayKeys( level._custom_perks ) ){

        if( self HasPerk( perk ) ) ArrayInsert( a_perks, perk, a_perks.size );
    }

    return a_perks;
}

function give_saved_perks(){

    if( !isdefined( world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Perks ) ) return;

    foreach( perk in world.save_state[ MAP_NAME ][ "players" ][ MY_XUID ].Perks ){
        self thread execute_command( "perk "+perk );
    }

}


// Easter Egg
function complete_saved_ee_steps(){

    foreach( step_name in world.save_state[ MAP_NAME ][ "ee" ] ){
        #ifdef dev
            //wait 0.05;
            //level thread debug_message( "^2Activating step ^5"+step_name );
        #endif

        level.host [[ get_step_function( step_name ) ]]();
    }

    #ifdef dev
        //level thread debug_message( "^2Steps saved: ^5"+world.save_state[ MAP_NAME ][ "ee" ].size );
        //level thread debug_message( "^2All saved ^5Easter Steps^2 completed!");
    #endif

}