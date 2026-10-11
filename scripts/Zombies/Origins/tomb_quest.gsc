
/*  Easter Egg

    Step 0 - Build the staffs (extra created to have an earlier game save state)
    Opens the map, activates generators, activates portals and builds the staffs.
    if( !all_staffs_crafted() )   self tomb_staffs(); // Build the staffs

    Step 1 - Secure the keys
    Build staffs.
    if( !all_staffs_upgraded() )  self tomb_stk(); // Secure the keys / Upgrade staffs

    Step 2 - Ascend from darkness
    Upgrade the staffs and place them on the robots.
    if( !all_staffs_placed() )       self tomb_afd(); // Ascend from darkness / Place upg staffs on robot's head

    Step 3 - Rain fire
    Press robot's button, throw beacon to open mechz hole.
    if( !ee_panzer_hole_open() )        self tomb_rf();     // Rain fire / Press robot's button and throw beacon to excavation

    Step 4 - Unleash the horde
    Send Maxis' drone and kill the panzers.
    if( !ee_panzers_killed() )       self tomb_uth();    // Unleash the Horde / All ee panzers have been killed

    Step 5 - Skewer the winged beast
    Get zombie blood to shoot down zombie plane and retrieve Maxis' drone.
    if( !ee_maxis_drone_retrieved() )      self tomb_stwb();   // Skewer the winged beast / Kill zombie plane and retrieve maxis

    Step 6 - Wield a fist of iron
    Kill templars with iron fist until they drop the upgrade stone.
    if( !ee_all_players_upgraded_punch() )     self tomb_wafoi();  // Wield a Fist of Iron / Get upgraded fists + kill 20 templars on pap

    Step 7 - Raise hell
    Kill 100 zombies on Crazy Place, then use Maxis Drone and activate the laser beam.
    if( !ee_souls_absorbed() )        self tomb_rh();     // Raise Hell / Kill 100 zombies on Agartha

    Step 8 - Freedom
    Send maxis drone to Agartha (let the player choose if he wants to trigger the end cutscene)
    if( !ee_samantha_released() )   self tomb_freedom();// Freedom / Send maxis drone, we let players decide if they want to end the game

    ______________________________________________________________________________________________
*/


function tomb_gsc_ee_init(){

    // EE
    level add_autocomplete_step( "staffs", ::tomb_staffs );  // Build staffs
    level add_autocomplete_step( "stk", ::tomb_stk );  // Secure the keys
    level add_autocomplete_step( "afd", ::tomb_afd );  // Ascend from darkness 
    level add_autocomplete_step( "rf", ::tomb_rf );  // Rain fire
    level add_autocomplete_step( "uth", ::tomb_uth );  // Unleash the Horde
    level add_autocomplete_step( "stwb", ::tomb_stwb );  // Skewer the winged beast
    level add_autocomplete_step( "wafoi", ::tomb_wafoi );  // Wield a Fist of Iron
    level add_autocomplete_step( "rh", ::tomb_rh );  // Raise Hell
    level add_autocomplete_step( "freedom", ::tomb_freedom );  // Raise Hell

    // Maxis drone
    level add_autocomplete_step( "wfqcb", ::wait_for_quadrotor_custom_behavior );  // Wait quadrotor steps enabled
    level add_autocomplete_step( "tgq", ::tomb_give_quadrotor );  // Wait quadrotor steps enabled

    // Beacons
    level add_autocomplete_step( "abq", ::autocomplete_beacon_quest );  // Save Beacons progress

    // Raise Hell
    level add_autocomplete_step( "aesm", ::activate_ee_sam_portal );  // Inserts staffs on Agartha
    level add_autocomplete_step( "tfps", ::tomb_fill_portal_souls );  // Saves templar kills at agartha

    // Wield A Fist Of Iron
    level add_autocomplete_step( "tfsb", ::tomb_fill_soul_box );  // Fills soul boxes
    level add_autocomplete_step( "tgoiptp", ::tomb_give_one_inch_punch_to_player );  // Gives punches and kills for upgrade

    // Skewer the winged beast
    level add_autocomplete_step( "zplane", ::tomb_zombie_plane );  // Destroy zombie plane
    level add_autocomplete_step( "zpilot", ::tomb_zombie_pilot );  // Kill zombie pilot
    level add_autocomplete_step( "gud", ::tomb_get_upgraded_drone );  // Get Upgraded Drone

    // Unleash The Horde
    level add_autocomplete_step( "uth_drone", ::tomb_uth_drone );  // Send maxis drone
    level add_autocomplete_step( "panzers", ::tomb_uth_panzers );  // Kill all EE panzers

    // Rain Fire
    level add_autocomplete_step( "fl", ::tomb_fire_link ); // Activate fire link button
    level add_autocomplete_step( "ph", ::tomb_panzer_hole ); // Open panzer's hole

    // Ascend From Darkness
    level add_autocomplete_step( "pafd", ::tomb_place_afd ); // Place saved inserted staffs

    // Secure The Keys
    level add_autocomplete_step( "ip1", ::ice_puzzle_1 ); // Ice step 1
    level add_autocomplete_step( "ip2", ::ice_puzzle_2 ); // Ice step 2
    level add_autocomplete_step( "iu", ::ice_upgrade ); // Ice step 3

    level add_autocomplete_step( "ap1", ::air_puzzle_1 ); // Air step 1
    level add_autocomplete_step( "ap2", ::air_puzzle_2 ); // Air step 2
    level add_autocomplete_step( "au", ::air_upgrade ); // Air step 3

    level add_autocomplete_step( "ep1", ::electric_puzzle_1 ); // Electric step 1
    level add_autocomplete_step( "ep2", ::electric_puzzle_2 ); // Electric step 2
    level add_autocomplete_step( "eu", ::electric_upgrade ); // Electric step 3

    level add_autocomplete_step( "fp1", ::fire_puzzle_1 ); // Fire step 1
    level add_autocomplete_step( "fp2", ::fire_puzzle_2 ); // Fire step 2
    level add_autocomplete_step( "fu", ::fire_upgrade ); // Fire step 3
}


// For save state func
function tomb_get_ee_steps(){

    ee_functions = [];
    //level thread debug_message( "^5SAVING EE STEPS" );

    tomb_save_quadrotor();
    ArrayInsert( ee_functions, "tgq", ee_functions.size );

    save_beacon_progress();
    ArrayInsert( ee_functions, "abq", ee_functions.size );    


    // Everything is completed
    if( ee_samantha_released() ){
        level thread debug_message( "^2 ALL EE STEPS DONE!" );
        ArrayInsert( ee_functions, "freedom", ee_functions.size );
        return ee_functions;
    }

    // 100 kills on agartha done
    if( ee_souls_absorbed() ){

        level thread debug_message( "^1 SOULS ABSORBED" );
        ArrayInsert( ee_functions, "rh", ee_functions.size ); // Complete previous steps
        if( is_quadrotor_custom_behavior_active() ) ArrayInsert( ee_functions, "wfqcb", ee_functions.size ); // Check if maxis drone behaviour was active
        return ee_functions;        
    }

    // Get upgraded fists + kill 20 templars on pap
    if( ee_all_players_upgraded_punch() ){

        level thread debug_message( "^1ALL FISTS UPGRADED" );
        ArrayInsert( ee_functions, "wafoi", ee_functions.size ); // Complete previous EE steps

        save_inserted_staffs();
        ArrayInsert( ee_functions, "aesm", ee_functions.size ); // Set inserted staffs

        tomb_save_portal_souls();
        ArrayInsert( ee_functions, "tfps", ee_functions.size ); // Set killed zombies on agartha
        return ee_functions;
    }

    // At this point you could have done these steps at any point
    save_tomb_filled_soul_boxes();
    ArrayInsert( ee_functions, "tfsb", ee_functions.size ); // Complete soul boxes for punch

    tomb_save_one_inch_punch_players();
    ArrayInsert( ee_functions, "tgoiptp", ee_functions.size ); // Give punch

    // Killed zombie pilot and grab maxis drone
    if( ee_maxis_drone_retrieved() ){ // Maxis drone already upgraded

        level thread debug_message( "^1 SKEWER THE WINGED BEAST ^2 COMPLETED!" );
        ArrayInsert( ee_functions, "stwb", ee_functions.size ); // Complete previous EE steps
        return ee_functions;
    }

    // Killed all the panzers from uth
    if( ee_panzers_killed() ){

        level thread debug_message( "^1UNLEASH THE HORDE ^2COMPLETED!" );
        ArrayInsert( ee_functions, "uth", ee_functions.size ); // Complete previous EE steps

        if( isdefined( get_upgraded_drone_trigger() ) ){
            ArrayInsert( ee_functions, "zplane", ee_functions.size ); // Plane destroyed
            ArrayInsert( ee_functions, "zpilot", ee_functions.size ); // Pilot killed
        }else if( isdefined( get_zpilot() ) ){
            ArrayInsert( ee_functions, "zplane", ee_functions.size ); // Plane destroyed
        }

        return ee_functions;
    }

    // Broke the panzers hole
    if( ee_panzer_hole_open() ){

        level thread debug_message( "^1RAIN FIRE ^2COMPLETED!" );
        ArrayInsert( ee_functions, "rf", ee_functions.size );

        if( is_quadrotor_disabled() ) ArrayInsert( ee_functions, "uth_drone", ee_functions.size ); // Maxis drone sent
        return ee_functions;
    }

    // Inserted all upgraded staffs
    if( all_staffs_placed() ){

        level thread debug_message( "^1ASCEND FROM DARKNESS ^2COMPLETED!" );
        ArrayInsert( ee_functions, "afd", ee_functions.size );

        if( level flag::get( "fire_link_enabled" ) ) ArrayInsert( ee_functions, "fl", ee_functions.size ); // Fire Link button activated
        return ee_functions;
    }

    // Upgraded all staffs
    if( all_staffs_upgraded() ){

        level thread debug_message( "^1Secure The Keys ^2COMPLETED!" );
        ArrayInsert( ee_functions, "stk", ee_functions.size );

        tomb_save_afd();
        ArrayInsert( ee_functions, "pafd", ee_functions.size );

        return ee_functions;
    }


    // Ice staff
    if( is_staff_fully_unlocked( "water" ) ) ArrayInsert( ee_functions, "iu", ee_functions.size );
    else if( level flag::get( "ice_puzzle_2_complete" ) ) ArrayInsert( ee_functions, "ip2", ee_functions.size );
    else if( level flag::get( "ice_puzzle_1_complete" ) ) ArrayInsert( ee_functions, "ip1", ee_functions.size );

    // Air staff
    if( is_staff_fully_unlocked( "air" ) ) ArrayInsert( ee_functions, "au", ee_functions.size );
    else if( level flag::get( "air_puzzle_2_complete" ) ) ArrayInsert( ee_functions, "ap2", ee_functions.size );
    else if( level flag::get( "air_puzzle_1_complete" ) ) ArrayInsert( ee_functions, "ap1", ee_functions.size );

    // Electric staff
    if( is_staff_fully_unlocked( "lightning" ) ) ArrayInsert( ee_functions, "eu", ee_functions.size );
    else if( level flag::get( "electric_puzzle_2_complete" ) ) ArrayInsert( ee_functions, "ep2", ee_functions.size );
    else if( level flag::get( "electric_puzzle_1_complete" ) ) ArrayInsert( ee_functions, "ep1", ee_functions.size );

    // Fire staff
    if( is_staff_fully_unlocked( "fire" ) ) ArrayInsert( ee_functions, "fu", ee_functions.size );
    else if( level flag::get( "fire_puzzle_2_complete" ) ) ArrayInsert( ee_functions, "fp2", ee_functions.size );
    else if( level flag::get( "fire_puzzle_1_complete" ) ) ArrayInsert( ee_functions, "fp1", ee_functions.size );

    // Easter Egg has not been started
    return ee_functions;
}


// Build the staffs
function tomb_staffs(){

    step_name = "^5Staffs";

    if( all_staffs_crafted() ){ // If you already have the staffs crafted then it's already done
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }
    
    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    level thread remove_plane_fire_fx();

    get_specific_craftable_piece( "gramophone", "vinyl_player" ); // Grab gramophone
    get_specific_craftable_piece( "gramophone", "vinyl_master" ); // Grab white disk

    open_sesame(); // Open map doors
    level thread activate_origins_generators(); // Activate all power
    level thread enable_agartha_zone(); // Activate agartha

    // Grab staffs parts
    get_full_craftable_object( "elemental_staff_water" );
    complete_craftable( "elemental_staff_water" );

    get_full_craftable_object( "elemental_staff_air" );
    complete_craftable( "elemental_staff_air" );

    get_full_craftable_object( "elemental_staff_lightning" );
    complete_craftable( "elemental_staff_lightning" );

    get_full_craftable_object( "elemental_staff_fire" );
    complete_craftable( "elemental_staff_fire" );

    level thread remove_plane_fire_fx();


    ee_autocomplete_end( step_name+text_completed() );
}

// Secure the keys
function tomb_stk(){

    step_name = "^5Secure the keys";

    if( all_staffs_upgraded() ){ // If you already have the staffs upgraded then it's already done
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    if( !all_staffs_crafted() ) self tomb_staffs(); // Build the staffs

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    level thread activate_origins_generators();

    //self iPrintLnBold( "^5Before ICE: ^2"+level.ee_being_completed );

    // Ice Staff
    ice_upgrade();

    //self iPrintLnBold( "^5Before AIR: ^2"+level.ee_being_completed );

    // Wind Staff
    air_upgrade();

    //self iPrintLnBold( "^5Before ELECTRIC: ^2"+level.ee_being_completed );

    // Electric Staff
    electric_upgrade();

    //self iPrintLnBold( "^5Before FIRE: ^2"+level.ee_being_completed );

    // Fire Staff
    fire_upgrade();

    // Enable hatch on all robots since we are practicing
    level flag::set("all_robot_hatch");

    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );

    wait 0.1;
    setdvar( DVAR_TIMESCALE, "1" );
}

// Ascend from darkness
function tomb_afd(){

    step_name = "^5Ascend from darkness";

    if( all_staffs_placed() ){ // All staffs have already been placed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    if( !all_staffs_upgraded() ) self tomb_stk(); // Secure the keys / Upgrade staffs

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    tomb_place_afd( true );


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

// Rain fire
function tomb_rf(){

    step_name = "^5Rain fire";

    if( ee_panzer_hole_open() ){ // Panzer hole opened
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    if( !all_staffs_placed() ) self tomb_afd(); // Ascend from darkness / Place upg staffs on robot's head

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();

    level autocomplete_beacon_quest( true );

    tomb_fire_link();

    tomb_panzer_hole();


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

// Unleash the Horde
function tomb_uth(){

    step_name = "^5Unleash the Horde";

    if( ee_panzers_killed() ){ // All ee panzers have been killed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    // Check step 3
    if( !ee_panzer_hole_open() ) self tomb_rf(); // Rain fire / Press robot's button and throw beacon to excavation

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    // Sends maxis drone to panzer hole
    tomb_uth_drone();

    // Kills the panzers from UTH step
    tomb_uth_panzers();


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

// Skewer the winged beast
function tomb_stwb(){

    step_name = "^5Skewer The Winged Beast";

    if( ee_maxis_drone_retrieved() ){ // Maxis drone already upgraded
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    // Check step 4
    if( !ee_panzers_killed() ) self tomb_uth(); // Unleash the Horde / All ee panzers have been killed

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();
    

    tomb_zombie_plane(); // Destroy zombie plane

    tomb_zombie_pilot(); // Kill zombie pilot

    tomb_get_upgraded_drone(); // Pick up drone


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

// Wield a Fist of Iron
function tomb_wafoi(){

    step_name = "^5Wield a Fist of Iron";

    if( ee_all_players_upgraded_punch() ){ // All players upgraded punch melee
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    // Check step 5
    if( !ee_maxis_drone_retrieved() ) self tomb_stwb(); // Skewer the winged beast / Kill zombie plane and retrieve maxis

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();
    
    // Fill soul boxes
    tomb_fill_soul_box( true );

    // Give punch weapon to players and upgrade them
    tomb_give_one_inch_punch_to_player( true );


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

// Raise Hell
function tomb_rh(){

    step_name = "^5Raise Hell";

    if( ee_souls_absorbed() ){ // All players upgraded punch melee
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    // Check step 6
    if( !ee_all_players_upgraded_punch() ) self tomb_wafoi(); // Wield a Fist of Iron / Get upgraded fists + kill 20 templars on pap

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();
    

    // Waits for portal kills to be ready
    if( !tomb_is_portal_souls_active() ) activate_ee_sam_portal( true );

    // Fills agartha portal souls
    tomb_fill_portal_souls( true );


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

// Freedom
function tomb_freedom(){

    step_name = "^5Freedom";

    if( ee_samantha_released() ){ // All players upgraded punch melee
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    // Check step 7
    if( !ee_souls_absorbed() ) self tomb_rh(); // Raise Hell / Kill 100 zombies on Agartha

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();
    

    // wait for step to be ready
    wait_for_quadrotor_custom_behavior();

    // Send maxis drone to objective
    tomb_freedom_quadrotor();

    // Send players to laser beam
    tomb_tp_all_players_portal_final();


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}