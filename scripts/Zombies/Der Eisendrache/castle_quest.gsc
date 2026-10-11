/* EE FLAGS        
	level flag::init("ee_start_done");                          // Upgrade a bow and shoot TP
	level flag::init("choose_time_travel_target");              // Hit a correct wisp
	level flag::init("reset_time_travel_target");               // Failed a wisp or passed a round
	level flag::init("time_travel_teleporter_ready");           // Did wisps correctly
	level flag::init("stop_time_travel");                       // All objects from time travel retrieved
	level flag::init("switch_to_death_ray");                    // Changed the death ray mode
	level flag::init("death_ray_trap_used");                    // Death ray has been used
	level flag::init("dimension_set");                          // Safe box code introduced successfully
	level flag::init("tesla_connector_launch_platform");        // Part of Death Ray trap placed
	level flag::init("tesla_connector_lower_tower");            // Part of Death Ray trap placed
	level flag::init("mpd_canister_replacement");
	level flag::init("end_simon");
	level flag::init("simon_press_check");
	level flag::init("simon_terminal_activated");
	level flag::init("simon_timed_out");
	level flag::init("channeling_stone_replacement");
	level flag::init("start_channeling_stone_step");            // Dempsey called
	level flag::init("next_channeling_stone");
	level flag::init("see_keeper");                             // Someone was on pyramid zone when keeper arrived after filling all souls
	level flag::init("sent_rockets_to_the_moon");
	level flag::init("rockets_to_moon_vo_complete");
	level flag::init("ee_fuse_held_by_team");                   // Pickup fuse from time travel
	level flag::init("ee_fuse_placed");                         // Place fuse on Death ray
	level flag::init("ee_safe_open");                           // Safe box opened
	level flag::init("ee_golden_key");                          // Death Ray trap parts placed
	level flag::init("ee_outro");

    level flag::init("boss_fight_ready");                       // Keeper has been seen and made animation
	level flag::init("boss_fight_begin");
	level flag::init("boss_elemental_storm_cast_in_progress");  
	level flag::init("boss_stunned");
	level flag::init("boss_completed_early");
	level flag::init("boss_fight_completed");

    if( level.var_8ef26cd9 == 1 ) // Keeper is on his way to undercroft OR hasn't been seen by a player
    if( level.var_8ef26cd9 == undefined ) // Keeper's souls haven't been collected OR he has been already seen

    level.var_f1b0baba // Number of Keeper current area, if not defined then Keeper step hasn't been started ( apparently it's never undefined after use )
    level.n_channeling_stone_kills // Current keeper stone souls
    level.var_f91118d9 // Keeper step between rounds
    level.var_1f18338d // Current keeper element
    level.var_cc2ea6e8 // Can dogs spawn mid round for ee reasons

    level.var_b366f2dc // N of gravityspikes placed to do bossfight
    player.var_d725b0f2// zone placed gravityspikes for ee bossfight

    EE Safe Box Code translation
    0 = O
    1 = D
    2 = C
    3 = L

*/

/*  Easter Egg

    Step 1 - Dragons
    Unlock base bow.

    Step 2 - Start
    Upgrade necessary bows and start wisp.

    Step 3 - Teleport
    For first wisp, get to see the code (DLL), pick fuse and pick canister.

    Step 4 - Simon
    Place fuse, open safe box, pickup and place death ray parts, do simon says, do second wisps, call Dempsey, pickup and place golden rod.

    Step 5 - Keeper
    Place golden rod, fill keeper's souls, see him at the end and place canister.

    Step 6 - Bossfight
    Place ragnaroks to go bossfight and defeat giant keeper.

    Step 7 - My Brother's Keeper
    Place summoning key on the pyramid, take it back and let player decide to end EE.

    ______________________________________________________________________________________________

    if( !is_true( level.ee_steps["dragons"].completed ) )   self [[ level.ee_steps["dragons"].func ]]();    // Unlock base bow.
    if( !is_true( level.ee_steps["start"].completed ) )     self [[ level.ee_steps["start"].func ]]();      // Upgrade necessary bows and start wisp.
    if( !is_true( level.ee_steps["tp"].completed ) )        self [[ level.ee_steps["tp"].func ]]();         // For first wisp, get to see the code (DLL), pick fuse and pick canister.
    if( !is_true( level.ee_steps["simon"].completed ) )     self [[ level.ee_steps["simon"].func ]]();      // Place fuse, open safe box, pickup and place death ray parts, do simon says, do second wisps, call Dempsey, pickup and place golden rod.
    if( !is_true( level.ee_steps["keeper"].completed ) )    self [[ level.ee_steps["keeper"].func ]]();     // Place golden rod, fill keeper's souls, see him at the end and place canister.
    if( !is_true( level.ee_steps["bossfight"].completed ) ) self [[ level.ee_steps["bossfight"].func ]]();  // Place ragnaroks to go bossfight and defeat giant keeper.
    if( !is_true( level.ee_steps["mbk"].completed ) )       self [[ level.ee_steps["mbk"].func ]]();        // Place summoning key on the pyramid, take it back and let player decide to end EE.
*/

function castle_gsc_ee_init(){

    level add_autocomplete_step( "dragons", ::castle_dragons ); 
    level add_autocomplete_step( "start", ::castle_start ); 
    level add_autocomplete_step( "tp", ::castle_tp ); 
    level add_autocomplete_step( "simon", ::castle_simon ); 
    level add_autocomplete_step( "keeper", ::castle_keeper ); 
    level add_autocomplete_step( "bossfight", ::castle_bossfight ); 
    level add_autocomplete_step( "mbk", ::castle_mbk ); 
}

function castle_get_ee_steps(){
    ee_functions = [];

    // My Brother Keeper
    if( is_de_ee_completed() ){

        level thread debug_message( "^1My Brother Keeper" );
        ArrayInsert( ee_functions, "mbk", ee_functions.size ); // Complete previous steps
        return ee_functions;  
    }

    // Bossfight
    if( is_de_bossfight_completed() ){

        level thread debug_message( "^1Bossfight" );
        ArrayInsert( ee_functions, "bossfight", ee_functions.size ); // Complete previous steps
        return ee_functions;  
    }

    // Keeper
    if( is_de_bossfight_ready() ){

        level thread debug_message( "^1Keeper" );
        ArrayInsert( ee_functions, "keeper", ee_functions.size ); // Complete previous steps
        return ee_functions;  
    }

    // Simon says
    if( is_channeling_stone_step_ready() ){

        level thread debug_message( "^1Simon Says" );
        ArrayInsert( ee_functions, "simon", ee_functions.size ); // Complete previous steps
        return ee_functions;  
    }

    // Teleport
    if( level flag::get("ee_fuse_held_by_team") || level flag::get("ee_fuse_placed") ){

        level thread debug_message( "^1Teleport" );
        ArrayInsert( ee_functions, "tp", ee_functions.size ); // Complete previous steps
        return ee_functions;  
    }

    // Start EE
    if( level flag::get("ee_start_done") ){

        level thread debug_message( "^1Start EE" );
        ArrayInsert( ee_functions, "start", ee_functions.size ); // Complete previous steps
        return ee_functions;  
    }

    // Dragons
    if( are_all_dragons_fed() ){

        level thread debug_message( "^1Dragons" );
        ArrayInsert( ee_functions, "dragon", ee_functions.size ); // Complete previous steps
        return ee_functions;  
    }


    return ee_functions;
}

/* DRAGON VALUES

    DRAGON_COURTYARD // 2nd dragon on EE speedrun
    DRAGON_GREATHALL // 1st dragon on EE speedrun
    DRAGON_UNDERCROFT // 3rd dragon on EE speedrun
*/

function castle_dragons(){

    step_name = "^5Dragons";

    if( are_all_dragons_fed() ){ // All 3 dragons are fed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();

    if( !level flag::get( "power_on" ) ){ // You can't reach one of the dragons without activating power
        trig = getent( "use_power_switch", "targetname" );
        trig notify( "trigger", self );
    }

    castle_feed_dragons();

    wait_all_dragons_fed();

    ee_autocomplete_end( step_name+text_completed() );

}

function castle_start(){

    if( level flag::get("ee_start_done") ){ // If you started wisps or there is an upgraded bow then it's already done
        self iPrintLnBold( "^5Bow step ^7already completed..." );
        return;
    }

    if( !level flag::get("ee_start_done") ) self castle_dragons();

    setdvar(DVAR_TIMESCALE, "10");

    // Claim quest
    if( !isdefined( level.var_f8d1dc16 ) ){ // Check if there is a player already with storm bow quest

        if( !isdefined( level.var_18c771ad )){ // Check if someone shot the thing for the arrow quest
            aq_es_weather_vane_trig = getent("aq_es_weather_vane_trig", "targetname");
            aq_es_weather_vane_trig notify("damage", 7, self, (self.origin[1],self.origin[0],0), undefined, "MOD_PROJECTILE_SPLASH", undefined,undefined, undefined, getweapon("elemental_bow") );

            level waittill( #"hash_4e123b5d" ); // Wait for animation to end before hitting the trigger
        }

        quest_start_elemental_storm = struct::get("quest_start_elemental_storm");
        quest_start_elemental_storm.t_unitrigger notify("trigger", self);

        wait 1;
    }

    // Beacons fire
    beacons = getentarray("aq_es_beacon_trig", "script_noteworthy");
    foreach( beacon in beacons ){ // Check if there is a beacon that we need to light up
        if( !is_true( beacon.b_lit ) ){

            level.var_f8d1dc16 notify( "projectile_impact", getweapon( "elemental_bow" ), undefined );
            array::wait_till( beacons, "beacon_activated" );
            while( isdefined( level.var_c5c6a918 ) ) wait 0.05;


            break;
        }else{
            if( struct::get(beacon.target).mdl_fx_anchor clientfield::get("beacon_fx") === 2 ){

                break; // Fx 2 means we need electric shots
            }
        }
    }

    // Activate Death ray
    if( !level flag::get( "death_ray_trap_used" ) ){
        self activate_death_ray();
    }

    // Wallrun
    if( !level flag::get( "elemental_storm_wallrun" ) ){

        wallrun_trigger = getentarray("aq_es_wallrun_trigger", "targetname");
        foreach(wallrun in wallrun_trigger) wallrun notify("trigger", self);
        level wait_till("elemental_storm_wallrun");
    }

    // Batteries
    if( !level flag::get("elemental_storm_batteries") ){ // Check if batteries are already fully charged
        aq_es_battery_volume = getentarray("aq_es_battery_volume", "script_noteworthy");
        foreach(battery in aq_es_battery_volume){
            if( isdefined( battery.n_battery_kills ) && battery.n_battery_kills == 5 ) continue; // It's already filled

            while( !isdefined(battery.n_battery_kills) ) wait 0.05; // Step is not loaded yet
            battery.n_battery_kills = 5;
            battery notify("killed");
        }

        level wait_till("elemental_storm_batteries");

    }

    if( !level flag::get("castle_teleporter_used") ) level flag::set("castle_teleporter_used"); // You are required to use TP

    // Electric beacons
    if( !level flag::get( "elemental_storm_beacons_charged" ) ){ // Check if beacons are already electrified

        e_projectile = magicbullet( getweapon( "elemental_bow" ), (7,7,7), (0,0,0) );
        e_projectile.var_e4594d27 = 1;

        foreach( beacon in beacons ){
            destination = beacon.origin;
            level.var_f8d1dc16 notify( "projectile_impact", getweapon( "elemental_bow" ), undefined, undefined, e_projectile, undefined);
        }
    }

    // Repair electric bow
    if( !level flag::get( "elemental_storm_repaired" ) ){

        quest_reforge_elemental_storm = struct::get("quest_reforge_elemental_storm");
        while(!level flag::get("elemental_storm_repaired")){
            wait 0.1;
            quest_reforge_elemental_storm.t_unitrigger notify("trigger", self);
        }
    }

    // Placing and upgrading bow
    if( !level flag::get( "elemental_storm_placed" ) ){
        upgraded_bow_struct_elemental_storm = struct::get("upgraded_bow_struct_elemental_storm", "targetname");
        upgraded_bow_struct_elemental_storm.t_unitrigger notify("trigger", level.var_f8d1dc16);

        while(!level flag::get("elemental_storm_placed")){
            wait 0.1;
            upgraded_bow_struct_elemental_storm.t_unitrigger notify("trigger", self);
        }
    }

    // Fill upgraded bow souls
    upgraded_bow_struct_elemental_storm.var_ce58f456 = 20;
    level flag::set("elemental_storm_upgraded");
    upgraded_bow_struct_elemental_storm.t_unitrigger notify("trigger", self);

    while( !level flag::get( "elemental_storm_spawned" ) ){
        wait 0.1;
        upgraded_bow_struct_elemental_storm.t_unitrigger notify("trigger", self);
    }

    // Usually you have activated the flingers by now
    self activate_flinger_pads();

    // Shooting the teleporter with ancient bow
    if( !level flag::get("ee_start_done") ){ // Wisps haven't been started

        foreach(target in getentarray("activate_targets_object", "targetname")){
            target notify("damage", 7, self, undefined, undefined, undefined, undefined, undefined, undefined, getweapon("elemental_bow"));
        }
    }

    setdvar(DVAR_TIMESCALE, "1");

    self iPrintLnBold( "^5Start ^7step ^2completed!" );
}

function check_bow_upgraded(){

    return flag::get_any( array( "elemental_storm_upgraded", "rune_prison_upgraded", "wolf_howl_upgraded", "demon_gate_upgraded" ) );
}

function castle_tp(){


    if( level flag::get("ee_fuse_held_by_team") || level flag::get("ee_fuse_placed") ){ // You have already traveled back in time
        self iPrintLnBold( "^5TP step ^7already completed..." );
        return;
    }

    if( !level flag::get("ee_start_done") ) self castle_start();

    setdvar(DVAR_TIMESCALE, "10");

    self open_sesame();

    if( !is_true(self.god_lui) ) self thread gsc_god();

    // Activate Death ray
    if( !level flag::get( "death_ray_trap_used" ) ) self activate_death_ray();

    if( !is_safe_box_code_known() ){ // Check if we already traveled back in time to see the safe box code

        // Do first wisps
        if( is_time_travel_needed() && !is_this_round_wisp_done() ){

            self autocomplete_wisp();

            while( !is_this_round_wisp_done() ) wait 0.1;
        }

        // Set realistic round
        if( level.round_number < 8 ){
            self execute_command("round 8" );
            wait 5;  
        }

        // Go TP
        self first_wisp_tp();

        while( !is_safe_box_code_known() ) wait 0.05;
        level.var_ab58bca7 = array(1,3,3); // Patch Code to DLL :yonovoyadecirlo:
        wait 2;
        foreach( player in level.players ) player FreezeControlsAllowLook( false );
        level waittill("ee_button_1");
        setdvar(DVAR_TIMESCALE, "10");
        //level waittill("ee_button_2");
        //level waittill("ee_button_3");

        // Pick fuse
        if( !level flag::get("ee_fuse_held_by_team") && !level flag::get("ee_fuse_placed") ) self pick_ee_fuse();

        // Pick canister
        if( !level flag::get("mpd_canister_replacement") ) self pick_canister();

        zone = self.zone_name;
        while( self.zone_name == zone ) wait 0.1; // Time travel finished?
    }

    #ifdef dev
        self.bgb_pack_randomized = [];
        ArrayInsert(self.bgb_pack_randomized, "zm_bgb_anywhere_but_here", 0);

        // TODO write full BGB names so it's easier to understand for people who want to help with Surtr! (don't worry, it's not needed!)
        self thread execute_command( "bgb per" );
        wait 0.5;
        self thread execute_command( "bgb ext");
        self.points = 200000;

        self tp_player_to_closest_respawn_point( "zone_v10_pad_door" );
    #endif

    //if( is_true(self.god_lui) ) self thread gsc_god();
    //if( is_true(self.no_target_lui) ) self thread gsc_no_target();

    // Only do time travel but don't insert the code so we can practice first tp like speedruns do

    setdvar(DVAR_TIMESCALE, "1");
    self iPrintLnBold( "^5Teleport ^7step ^2completed!" );
}

function castle_simon(){

    //level._zm_build_trigger_from_unitrigger_stub_override = ::_zm_build_trigger_from_unitrigger_stub_override;

    if( is_channeling_stone_step_ready() ){ // Dempsey already called
        self iPrintLnBold( "^5Simon ^7step already completed..." );
        return;
    }

    if( !is_channeling_stone_step_ready() ) self castle_tp();

    setdvar(DVAR_TIMESCALE, "10");

    self open_sesame();
    if( !is_true(self.god_lui) ) self thread gsc_god();

    //setdvar(DVAR_TIMESCALE, "1");

    if( !is_safe_box_code_known() ){ // Check if we need to travel back in time to see the safe box code

        // Do first wisps
        if( is_time_travel_needed() && !is_this_round_wisp_done() ){

            self autocomplete_wisp();

            while( !is_this_round_wisp_done() ) wait 0.1;
        }
        // Go TP
        self first_wisp_tp();

        while( !is_safe_box_code_known() ) wait 0.05;
        level.var_ab58bca7 = array(1,3,3); // Patch Code to DLL :yonovoyadecirlo:
        wait 2;
        foreach( player in level.players ) player FreezeControlsAllowLook( false );
        level waittill("ee_button_1");
        setdvar(DVAR_TIMESCALE, "10");
        //level waittill("ee_button_2");
        //level waittill("ee_button_3");


        // Pick canister
        if( !level flag::get("mpd_canister_replacement") ) self pick_canister();

        zone = self.zone_name;
        while( self.zone_name == zone ) wait 0.1; // Time travel finished?
    }

    setdvar(DVAR_TIMESCALE, "10");

    // Place Fuse on Death ray
    if( !level flag::get( "ee_fuse_placed" ) ) self place_ee_fuse();

    // Switch Death ray mode
    if( level flag::get("switch_to_death_ray") ) self death_ray_protect();

    // Open the safe box
    if( !level flag::get( "ee_safe_open" ) ){

        // This is only to create Simon Terminals... with their triggers
        simon_terminals = [];
        golden_key_slots = struct::get_array("golden_key_slot");

        foreach(s_slot in golden_key_slots) // Apparently it doesn't work if I only take 4 terminals from one location | Idk why but I won't fix it, it just works
        {

            for(i = 1; i <= 4; i++) // Get the 4 monitors
            {
                s_monitor = struct::get((("monitor_" + s_slot.script_noteworthy) + "_") + i);
                if( !isdefined( s_monitor ) ) continue; // I should probably add an ERROR print
                while( !isdefined( s_monitor.n_symbol_id ) ) wait 0.1; // Maybe this will wait until the triggers are active?
                simon_terminals[simon_terminals.size] = get_trigger_from_origin( s_monitor.origin );
            }

        }   

        for( i=0; i<level.var_ab58bca7.size; i++ ){ // One terminal press per code length

            foreach( terminal in simon_terminals ){

                if( !isdefined( terminal.related_parent.n_symbol_id ) ){
                    self iPrintLnBold("^1ERROR, Can't find terminal number");
                    wait 1;
                }

                if( terminal.related_parent.n_symbol_id -1 == level.var_ab58bca7[i] ){

                    // IDK exactly which notify or function is the correct one but I am just too lazy
                    terminal.related_parent notify( "trigger_activated" );
                    terminal.related_parent notify( "trigger", self );
                    terminal notify( "trigger_activated" );
                    terminal notify( "trigger", self );

                    self build_and_activate_trigger_from_unitrigger_stub( terminal );
                    
                    level flag::wait_till_clear( "simon_press_check" );
                    wait 0.2;
                    break;

                }else{
                    //level.host iPrintLnBold( "^1Bad Terminal Code "+terminal.related_parent.n_symbol_id );
                    continue;
                }

            }

        }

        level wait_till("ee_safe_open");
        wait 0.1;
    }

    // Pickup trap parts
    if( !level flag::get("ee_golden_key") ) self take_trap_parts();

    // Set death ray mode to destroy
    if( !level flag::get("switch_to_death_ray") ) self death_ray_destroy();
    
    // Place trap parts
    if( !level flag::get("tesla_connector_launch_platform") || !level flag::get("tesla_connector_lower_tower")) self place_trap_parts();

    // Simon Says
    a_terminals = struct::get_array("golden_key_slot");

    // Do Simon Says
    for(i=0; i<a_terminals.size; i++)
    {
        if( is_true( a_terminals[i].b_done ) ) continue;
        
        a_terminals[i] notify("trigger_activated");
        wait 0.1;
        while( level.s_terminal_activated != a_terminals[i] ){
            wait 1;
            a_terminals[i] notify("trigger_activated");
            //level.host iPrintLnBold("^1Terminal not assigned yet...");
        }

        //level.host iPrintLnBold("^2Terminal Asigned!");
        wait 1;

        n_simon = level.s_terminal_activated.script_noteworthy == "launch_platform" ? 2 : 1;
        simon_triggers = [];
        for(j = 0; j < 4; j++)
        {
            terminal = struct::get((("monitor_" + level.s_terminal_activated.script_noteworthy) + "_") + (j + 1)); // Ent to get the trigger
            simon_triggers[simon_triggers.size] = get_trigger_from_origin( terminal.origin );
        }

        level waittill( #"hash_706f7f9a" );
        wait 0.05;

        simons_done = 0;
        foreach( terminal in a_terminals) if( is_true( terminal.b_done ) ) simons_done++;
        n_hits = is_true( simons_done ) ? 8 : 7;

        while( level.var_521b0bd1 < n_hits )
        {
            wait 0.3;

            //self iPrintLnBold("Current: ^2"+level.var_521b0bd1+"^7/^5"+n_hits);

            if(level flag::get("simon_timed_out"))
            {
                self iPrintLnBold("^1Simon time out");
                break;
            }
            else
            {

                foreach(s_trigger in simon_triggers){
                    wait 0.05;

                    if( is_true(s_trigger.related_parent.b_selected) ){

                        self build_and_activate_trigger_from_unitrigger_stub( s_trigger );
                        level waittill(#"hash_b7f06cd9");
                        level flag::wait_till_clear("simon_press_check");
                        break;
                    }else{
                        if(!isDefined(s_trigger.related_parent)) self iPrintLnBold("^1ERROR, No parent");
                        //if(!isDefined(s_trigger.related_parent.var_73527aa3)) self iPrintLnBold("^1ERROR, No correct code");
                        //else self iPrintLnBold("^1Wrong simon trigger...");

                        wait 0.1;
                        continue;
                    }

                }

            }

            wait(0.25);
        }

        self iPrintLnBold("A ^5Simon Says ^7game has been ^2completed!");
    }
    
    // Do second wisps
    if( is_time_travel_needed() && !is_this_round_wisp_done() ){ // Check if we need to pickup something from time travel

        self autocomplete_wisp();

        while( !is_this_round_wisp_done() ) wait 0.1;
    }

    /// Call Dempsey
    if( !level flag::get( "start_channeling_stone_step" ) ) self call_dempsey();

    // Set realistic round
    if( level.round_number < 9 ){
        self execute_command("round 9" );
        wait 5;  
    }

    a_players = getplayers();
    n_total_kills = RandomIntRange(90, 160);
    n_total_kills = int( n_total_kills / a_players.size );
    foreach( player in a_players ){
        player.kills = n_total_kills + RandomIntRange(-20, 20);
    }

    // Go TP
    self second_wisp_tp();
 
    // Get the rod
    //pickup_rod();


    //if( is_true(self.god_lui) ) self thread gsc_god();
    //if( is_true(self.no_target_lui) ) self thread gsc_no_target();

    self thread get_ragnarok_parts();
    self thread de_pap_activate_lui();

    setdvar(DVAR_TIMESCALE, "1");
    self iPrintLnBold( "^5Simon ^7step ^2completed!" );
}

function castle_keeper(){

    if( is_de_bossfight_ready() ){ // Keeper step already completed
        self iPrintLnBold( "^5Keeper ^7step already completed..." );
        return;
    }

    if( !is_channeling_stone_step_ready() ) self castle_simon();

    setdvar(DVAR_TIMESCALE, "10");

    // Place Fuse on Death ray
    if( !level flag::get( "ee_fuse_placed" ) ){
        self place_ee_fuse();
    }

    // Has keeper spawned?
    while( !isDefined( level.n_channeling_stone_zone ) ){
        wait 0.1;

        // Pickup rod
        vril_gen_trigger = get_trigger_from_origin( struct::get("vril_generator_family").origin );
        if( isDefined( vril_gen_trigger ) ) build_and_activate_trigger_from_unitrigger_stub( vril_gen_trigger );

        // Place rod
        vril_trigger = get_trigger_from_origin( struct::get("vril_generator").origin );
        if( isDefined( vril_trigger ) ) build_and_activate_trigger_from_unitrigger_stub( vril_trigger );
    }

    level.host iPrintLnBold( "Keeper has been spawned" );

    if( !level flag::get("channeling_stone_replacement") ) self take_channeling_stone();
    if( getent("cs_stone_2", "targetname") flagsys::get( "channeling_stone_cracked" ) ) self place_stone_replacement();

    // Have all stones filled with their souls?
    while( !is_all_keeper_souls_filled() ){
        wait 0.5;

        mdl_stone = getent("cs_stone_" + level.n_channeling_stone_zone, "targetname");
        if(!isdefined(mdl_stone) || !mdl_stone flagsys::get("channeling_stone_cracked")){
            mdl_glow = getent("cs_glow_" + level.n_channeling_stone_zone, "targetname");

            s_stone = struct::get("cs_keeper_pos_" + level.n_channeling_stone_zone);
            ai_keeper = getent("keeper_archon_ai", "targetname");

            while( distance( ai_keeper.origin, s_stone.origin ) > 10 ) wait 0.2;
            level.host iPrintLnBold("Keeper arrived goal");
            wait 1;

            if(level.n_channeling_stone_kills == 0){
                level notify(#"hash_d8b279ab");
                mdl_glow clientfield::set("channeling_stone_glow", 1);
                ai_keeper = getent("keeper_archon_ai", "targetname");
                ai_keeper notify("start_moving");
                ai_keeper scene::play("cin_zm_dlc1_corrupted_keeper_charge_stone_intro", ai_keeper);
                ai_keeper thread scene::play("cin_zm_dlc1_corrupted_keeper_charge_stone_loop", ai_keeper);
                ai_keeper fx::play("keeper_charge", ai_keeper.origin, ai_keeper.angles, "keeper_charge", 1, "j_spineupper", 1);
                str_exploder = castle_ee_get_exploder_id();
                exploder::exploder(str_exploder);
            }


            level.n_channeling_stone_kills = get_max_keeper_kills();
            wait 5;
        }

    }

    level.host iPrintLnBold( "All keeper souls filled!" );

    if( !level flag::get( "see_keeper" ) ) castle_see_keeper();

    //level wait_till("boss_fight_ready");

    // Check if canister has been replaced
    while( !is_true( level.var_8ef26cd9 ) || !is_true( level.var_513683a6 )  ){
        wait 0.2;
        self place_pyramid_canister();
    }

    level wait_till("boss_fight_ready");

    setdvar(DVAR_TIMESCALE, "1");
    if( !is_object_crafted( "gravityspike" ) ) level.host craft_open_table_object( "gravityspike", (-1659, 2258, 260) ); // Doesn't work when the trigger is set to be deleted
    //foreach( player in level.players ) player thread [[@zm_castle_craftables<scripts\zm\zm_castle_craftables.gsc>::function_adbf2990]](undefined, player);

    //setdvar(DVAR_TIMESCALE, "1");
    self iPrintLnBold( "^5Keeper ^7step ^2completed!" );
}

function castle_bossfight(){

    if( is_de_bossfight_completed() ){ // Boss is already over
        self iPrintLnBold( "^5Bossfight ^7step already completed..." );
        return;
    }

    if( !is_de_bossfight_ready() ) self castle_keeper();

    setdvar(DVAR_TIMESCALE, "10");

    foreach( player in level.players ) player thread [[@zm_castle_craftables<scripts\zm\zm_castle_craftables.gsc>::function_adbf2990]](undefined, player);

    /*
        BOSSFIGHT FLAGS
        level flag::init("boss_fight_ready");
        level flag::init("boss_fight_begin");
        level flag::init("boss_elemental_storm_cast_in_progress");
        level flag::init("boss_stunned");
        level flag::init("boss_completed_early");
        level flag::init("boss_fight_completed");

        GRAVITYSPIKES TILES FUNCTION
        function_73c15b91 // CHECKS PLAYER HAS PLACED HIS RAGNAROK
        function_1c249965 // RUNS ON THE VOLUMES TO CHECK PEOPLE WHO MAY HAVE PLACED RAGNAROK
        
    */

    // Fakes gravity spikes planted to go bossfight
    if( !level flag::get( "boss_fight_begin" ) ){

        a_t_boss_start_arena = getentarray("boss_gravity_spike_start_area", "targetname");
        level.anywhere_but_here_select_teleport_point_override = ::abh_boss_start;

        foreach( index, player in level.players ){
            player FreezeControlsAllowLook( true );
            player.boss_start_arena = spawnStruct();
            player.boss_start_arena.origin = a_t_boss_start_arena[ index ].origin;
            player [[ level.bgb["zm_bgb_anywhere_but_here"].activation_func ]]();
        }

        while( !level flag::get( "boss_fight_begin" ) ){
            wait 0.1;
            foreach( player in level.players ) player notify("gravity_trap_planted");
        }

        foreach( player in level.players ){
            player.boss_start_arena = undefined;
            player FreezeControlsAllowLook( false );
        }

        level.anywhere_but_here_select_teleport_point_override = undefined;
    }

    t_spike_stun = getent("boss_gravity_spike_stun_area", "targetname");
    t_weak_point = getent("boss_weak_point", "targetname");
    while( !level flag::get( "boss_fight_completed" ) && !level flag::get( "boss_completed_early" ) ){
        wait 0.1;

        if( level flag::get( "boss_elemental_storm_cast_in_progress" ) ){
            wait 0.2;
            level.players[0] FreezeControlsAllowLook( true );
            level.players[0] setOrigin( t_spike_stun.origin );
            level.players[0] notify( "gravity_trap_planted" );
            while( level flag::get( "boss_elemental_storm_cast_in_progress" ) ) wait 0.05;
            level.players[0] FreezeControlsAllowLook( false );
        }

        while(level flag::get("boss_stunned"))
        {
            wait 0.2;
            t_weak_point notify( "damage", 1000000, level.players[0] ); // self.var_42433bc BOSS HEALTH
        }
    }

    setdvar(DVAR_TIMESCALE, "1");
    self iPrintLnBold( "^5Bossfight ^7step ^2completed!" );
}

function castle_mbk(){

    if( is_de_ee_completed() ){ // Boss is already over
        self iPrintLnBold( "^5My Brother's Keeper ^7step already completed..." );
        return;
    }

    if( !is_de_bossfight_completed() ) self castle_bossfight();

    setdvar(DVAR_TIMESCALE, "10");

    while( !isDefined( struct::get("terminal_summoning_key").s_unitrigger) ){
        wait 0.05;
        struct::get( "ee_mpd_summoning_key" ) notify( "trigger_activated" );
    }

    end_pos = struct::get("terminal_summoning_key").origin;
    foreach( player in level.players ){
        player setOrigin( end_pos );
        wait 1;
    }

    setdvar(DVAR_TIMESCALE, "1");
    self iPrintLnBold( "^5My Brother's Keeper ^7step ^2completed!" );
}