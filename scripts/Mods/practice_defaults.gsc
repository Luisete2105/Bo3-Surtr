
function load_practice_general(){

    level.practice_modes = [];

    // Custom Save states
    level.practice_modes[ "custom" ] = ::gsc_load;

    switch( MAP_NAME ){

        case "zm_zod":
        {
            level add_zod_practice();
            break;
        }
        case "zm_factory":
        {
            level add_factory_practice();
            break;
        }
        case "zm_castle":
        {
            level add_castle_practice();
            break;
        }
        case "zm_island":
        {

            break;
        }
        case "zm_stalingrad":
        {
            level add_stalingrad_practice();
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
            level add_tomb_practice();
            break;
        }
    }

    level.lui_practice_loaded = true;
}

function is_bgb_specific( str_bgb_patch ){

    if( !isdefined( str_bgb_patch ) ){
        level thread debug_message("^1Forgot to add ^5"+str_bgb_patch);
        return false;
    }

    return MY_XUID == world.bgb_specific[ MAP_NAME ][ str_bgb_patch ];
}

#region zm_zod

function add_zod_practice(){

    if( is_mod_active( MOD_BOSS_RUSH ) ){
        level thread debug_message("Old Bossrush detected!");
        level.practice_modes["abh"]       = ::practice_zod_abh_patch;
    }

    level.practice_modes["patch"]       = ::practice_zod_patch;

}

function practice_zod_abh_patch(){

    // Patch ABH locations for EE
    level thread override_abh_func( ::bossrush_zod_abh );

    // Patch gums
    level thread zod_bossrush_bgb();

    // Patch zombie spawn locations
    //level thread override_zm_spwn_loc_func( ::factory_zm_custom_spawn_location_selection );
    //level thread factory_revert_zm_spwn_loc_func();


    wait_for_game_start();
    level thread DisplayFeedMessage( "^5Zod Bossrush ABH ^2loaded!" );

}


function practice_zod_patch(){

    // Patch ABH locations for EE
    //level thread override_abh_func( ::best_factory_abh );
    //level thread factory_revert_abh_func();

    // Patch gums
    level thread zod_bgb();

    // Patch zombie spawn locations
    //level thread override_zm_spwn_loc_func( ::factory_zm_custom_spawn_location_selection );
    //level thread factory_revert_zm_spwn_loc_func();

    // Set the special rounds
    level thread zod_special_rounds();

    wait_for_game_start();
    level thread DisplayFeedMessage( "^5Zod patch ^2loaded!" );

    level thread zod_set_characters();

}

function zod_set_characters(){

    foreach(player in GetPlayers()){
        player thread execute_command("pbt 8");
    }

}

function zod_special_rounds(){

    level wait_till("all_players_spawned");
    level thread debug_message( "^5Special Rounds ^2patched!" );

    switch( getplayers().size ){
        case 1:
        {
            level thread override_next_wasp_round( array( 6 ) ); // Wasps
            level thread override_n_next_raps_round( array( 10 ) ); // Raps
        }
        case 2:
        {
            level thread override_next_wasp_round( array( 5 ) ); // Wasps
            level thread override_n_next_raps_round( array( 10 ) ); // Raps
        }
        case 3:
        {
            level thread override_next_wasp_round( array( 5 ) ); // Wasps
            level thread override_n_next_raps_round( array( 9 ) ); // Raps
        }
        case 4:
        {
            level thread override_next_wasp_round( array( 5 ) ); // Wasps
            level thread override_n_next_raps_round( array( 9 ) ); // Raps
        }          
    }


}

function zod_bgb(){

    level wait_till("all_players_spawned");
    level thread debug_message( "^5BGB ^2patched!" );

    switch( getplayers().size ){
        case 1:
        {
            player = getplayers()[ 0] ;
            // BGB pack
            player.bgb_pack = [];
                // Needs to be changed to the order with the highest chances cause of array::randomize
                ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
                ArrayInsert(player.bgb_pack, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack.size);
                ArrayInsert(player.bgb_pack, "zm_bgb_anywhere_but_here", player.bgb_pack.size);
                ArrayInsert(player.bgb_pack, "zm_bgb_perkaholic", player.bgb_pack.size);
                ArrayInsert(player.bgb_pack, "zm_bgb_wall_power", player.bgb_pack.size);

            // Random BGB pack order
            player.bgb_pack_randomized = [];

            player.bgb_pack_randomized = array::randomize(player.bgb_pack);
            // Reign first, ABH NOT second
            while( player.bgb_pack_randomized[0] != "zm_bgb_reign_drops" || player.bgb_pack_randomized[1] == "zm_bgb_anywhere_but_here" ){
                player.bgb_pack_randomized = array::randomize(player.bgb_pack);
            }
        }
        case 2:
        case 3:
        case 4:
        {
            foreach( player in getplayers() ){

                player.bgb_pack = [];
                player.bgb_pack_randomized = [];

                // Needs to be changed to the order with the highest chances cause of array::randomize
                ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
                ArrayInsert(player.bgb_pack, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack.size);
                ArrayInsert(player.bgb_pack, "zm_bgb_anywhere_but_here", player.bgb_pack.size);
                ArrayInsert(player.bgb_pack, "zm_bgb_perkaholic", player.bgb_pack.size);
                ArrayInsert(player.bgb_pack, "zm_bgb_wall_power", player.bgb_pack.size);

                // Make it shuffle to simulate a possible WR run
                ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", player.bgb_pack_randomized.size);
                ArrayInsert(player.bgb_pack_randomized, "zm_bgb_wall_power", player.bgb_pack_randomized.size);
                ArrayInsert(player.bgb_pack_randomized, "zm_bgb_perkaholic", player.bgb_pack_randomized.size );

                // Make these ones last as they are only useful for edge cases on 3- and 4-player games
                ArrayInsert(player.bgb_pack_randomized, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack_randomized.size);
                ArrayInsert(player.bgb_pack_randomized, "zm_bgb_anywhere_but_here", player.bgb_pack_randomized.size);

            }
        }          
    }

    wait_for_game_start();

    // Make ZWR mods work easier
    level thread print_new_bgb();
}

function zod_bossrush_bgb(){

    level wait_till("all_players_spawned");
    level thread debug_message( "^5BGB ^2patched!" );

    switch( getplayers().size ){
        case 1:
        {
            /*player = getplayers()[ 0] ;
            // BGB pack
            player.bgb_pack = [];
            // Needs to be changed to the order with the highest chances cause of array::randomize
            ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_ephemeral_enhancement", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_wall_power", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_anywhere_but_here", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_shopping_free", player.bgb_pack.size);

            // Random BGB pack order
            player.bgb_pack_randomized = [];
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_ephemeral_enhancement", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_anywhere_but_here", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_shopping_free", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_wall_power", player.bgb_pack_randomized.size);*/
        }
        case 2:
        case 3:
        case 4:
        {
            foreach( player in getplayers() ){

                if( IsInArray(player.bgb_pack, "zm_bgb_anywhere_but_here") ){
                    player.bgb_pack_randomized = [];
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_anywhere_but_here", player.bgb_pack_randomized.size);
                }

                if( IsInArray(player.bgb_pack, "zm_bgb_wall_power") ){
                    player.bgb_pack_randomized = [];
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_wall_power", player.bgb_pack_randomized.size);
                }

            }
        }          
    }

    wait_for_game_start();

    // Make ZWR mods work easier
    level thread print_new_bgb();
}

#endregion

#region zm_factory

function add_factory_practice(){

    // EE patch
    level.practice_modes["patch"]       = ::practice_factory_patch;

    // Rounds SR forbidden ABH strat
    level.practice_modes["forbidden"]   = ::practice_factory_forbidden_abh_strat;
}

function practice_factory_forbidden_abh_strat(){

    // Patch ABH locations for EE

    //wnuen_zone
    level thread override_abh_func( ::best_factory_rounds_sr_abh );

    // Patch gums
    level thread factory_rounds_sr_bgb();

    wait_for_game_start();
    level thread DisplayFeedMessage( "^5Factory Forbidden ABH patch ^2loaded!" );

    level thread notify_new_abh_loc();
}


function practice_factory_patch(){

    // Patch ABH locations for EE
    level thread override_abh_func( ::best_factory_abh );
    level thread factory_revert_abh_func();

    // Patch gums
    level thread factory_bgb();

    // Patch zombie spawn locations
    level thread override_zm_spwn_loc_func( ::factory_zm_custom_spawn_location_selection );
    level thread factory_revert_zm_spwn_loc_func();


    wait_for_game_start();
    level thread DisplayFeedMessage( "^5Factory patch ^2loaded!" );
}

function factory_revert_abh_func(){
    while( !is_factory_ee_complete() ) wait 0.05;
    #ifdef dev
        level thread debug_message_instant( "^5ABH loc UNpatched!" );
    #endif
    level revert_abh_func();
}

function factory_bgb(){

    level wait_till("all_players_spawned");
    level thread debug_message( "^5BGB ^2patched!" );

    switch( getplayers().size ){
        case 1:
        {
            player = getplayers()[ 0 ];
            // BGB pack
            player.bgb_pack = [];
            // Needs to be changed to the order with the highest chances cause of array::randomize
            ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_ephemeral_enhancement", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_wall_power", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_anywhere_but_here", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_shopping_free", player.bgb_pack.size);

            // Random BGB pack order
            player.bgb_pack_randomized = [];
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_ephemeral_enhancement", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_anywhere_but_here", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_shopping_free", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_wall_power", player.bgb_pack_randomized.size);
        }
        case 2:
        case 3:
        case 4:
        {
            foreach( player in getplayers() ){

                //player.bgb_pack = [];
                //player.bgb_pack_randomized = [];

                // Ephemeral player selected
                if( IsInArray(player.bgb_pack, "zm_bgb_ephemeral_enhancement")){

                    player.bgb_pack = [];
                    player.bgb_pack_randomized = [];

                    // Needs to be changed to the order with the highest chances cause of array::randomize
                    ArrayInsert(player.bgb_pack, "zm_bgb_ephemeral_enhancement", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_always_done_swiftly", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_danger_closest", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_armamental_accomplishment", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_firing_on_all_cylinders", player.bgb_pack.size);

                    while( player.bgb_pack_randomized[0] != "zm_bgb_ephemeral_enhancement" ) player.bgb_pack_randomized = array::randomize(player.bgb_pack);
                }else{

                    // Needs to be changed to the order with the highest chances cause of array::randomize
                    ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_extra_credit", player.bgb_pack.size);
                    //ArrayInsert(player.bgb_pack, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_round_robbin", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_profit_sharing", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_shopping_free", player.bgb_pack.size);

                    // Make it shuffle to simulate a possible WR run
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_shopping_free", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", RandomInt( player.bgb_pack_randomized.size ));
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_extra_credit", RandomInt( player.bgb_pack_randomized.size ));
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_profit_sharing", RandomInt( player.bgb_pack_randomized.size ));
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_round_robbin", RandomInt( player.bgb_pack_randomized.size ));

                }

            }
        }          
    }

    wait_for_game_start();

    // Make ZWR mods work easier
    level thread print_new_bgb();
}

function factory_rounds_sr_bgb(){

    level wait_till("all_players_spawned");
    level thread debug_message( "^5BGB forbidden ^2patched!" );

    switch( getplayers().size ){
        case 1:
        {
            player = getplayers()[ 0 ];
            // BGB pack
            player.bgb_pack = [];
            player.bgb_pack_randomized = [];

            // For solo I just want to see if ABH works
            // Needs to be changed to the order with the highest chances cause of array::randomize
            ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_anywhere_but_here", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_fatal_contraption", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_kill_joy", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_shopping_free", player.bgb_pack.size);

            // Fix first cycle
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_anywhere_but_here", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", player.bgb_pack_randomized.size );
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_fatal_contraption",  player.bgb_pack_randomized.size );
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_kill_joy", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_shopping_free", player.bgb_pack_randomized.size);
        }
        case 2:
        case 3:
        case 4:
        {
            foreach( player in getplayers() ){

                player.bgb_pack = [];
                player.bgb_pack_randomized = [];

                if( player IsHost() ){

                    // Needs to be changed to the order with the highest chances cause of array::randomize
                    ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_anywhere_but_here", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_fatal_contraption", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_kill_joy", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_shopping_free", player.bgb_pack.size);

                    // Fix first cycle
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_anywhere_but_here", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", player.bgb_pack_randomized.size );
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_fatal_contraption",  player.bgb_pack_randomized.size );
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_kill_joy", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_shopping_free", player.bgb_pack_randomized.size);
            
                }else{

                    // Needs to be changed to the order with the highest chances cause of array::randomize
                    ArrayInsert(player.bgb_pack, "zm_bgb_temporal_gift", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_fatal_contraption", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_kill_joy", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_shopping_free", player.bgb_pack.size);

                    // Fix first cycle
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_temporal_gift", player.bgb_pack_randomized.size );
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_fatal_contraption",  player.bgb_pack_randomized.size );
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_kill_joy", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_shopping_free", player.bgb_pack_randomized.size);
                }

            }
        }          
    }

    wait_for_game_start();

    // Make ZWR mods work easier
    level thread print_new_bgb();    

}


function factory_revert_zm_spwn_loc_func(){

    factory_wait_east_door_opened();
    #ifdef dev
        level thread debug_message_instant( "^5zm spwn loc UNpatched!" );
    #endif
    level revert_zm_spwn_loc_func();
}

#endregion

#region zm_castle

function add_castle_practice(){

    // 6 Dogs
    level.practice_modes["firebow"]     = ::firebow_castle_patch;

    // 5 Dogs
    level.practice_modes["abh"]         = ::abh_castle_patch;
}

function abh_castle_patch(){
    // Dummy

    // Patch gums
    level thread castle_bgb();

    // Patch dog round
    level thread override_next_dog_round( array( 5 ) );

    // Patch ABH locations for EE
    level thread override_abh_func( ::firebow_castle_abh );
    level thread abh_castle_revert_abh_func();


    wait_for_game_start();
    /* DRAGON VALUES

        DRAGON_COURTYARD // 2nd dragon on EE speedrun
        DRAGON_GREATHALL // 1st dragon on EE speedrun
        DRAGON_UNDERCROFT // 3rd dragon on EE speedrun
    */
    // Feed the dragon
    level thread castle_feed_dragons( DRAGON_GREATHALL );
    level thread castle_feed_dragons( DRAGON_COURTYARD );

    wait 2.5;
    level thread DisplayFeedMessage( "^5Castle Abh ^2loaded!" );
}

function abh_castle_revert_abh_func(){
    while( !is_true(level.tdot_abh) ) wait 0.05;
    #ifdef dev
        level thread debug_message_instant( "^5ABH loc UNpatched!" );
    #endif
    level revert_abh_func();
}

function firebow_castle_patch(){

    // Patch gums
    level thread castle_bgb();

    // Patch dog round
    level thread override_next_dog_round( array( 6 ) );

    // Patch zombie spawns
    level thread override_zm_spwn_loc_func( ::firebow_castle_zm_custom_spawn_location_selection );
    level thread firebow_castle_revert_zm_spwn_loc_func();


    wait_for_game_start();

    /* DRAGON VALUES

        DRAGON_COURTYARD // 2nd dragon on EE speedrun
        DRAGON_GREATHALL // 1st dragon on EE speedrun
        DRAGON_UNDERCROFT // 3rd dragon on EE speedrun
    */
    // Feed the dragon
    level thread castle_feed_dragons( DRAGON_GREATHALL );
    level thread castle_feed_dragons( DRAGON_COURTYARD );

    wait 2.5;
    level thread DisplayFeedMessage( "^5Castle FireBow ^2loaded!" );
}

function firebow_castle_revert_zm_spwn_loc_func(){
    
    wait_all_dragons_fed();
    #ifdef dev
        level thread debug_message_instant( "^5zm spwn loc UNpatched!" );
    #endif
    level revert_zm_spwn_loc_func();
}

function castle_bgb(){
    level wait_till("all_players_spawned");
    level thread debug_message( "^5BGB ^2patched!" );

    switch( getplayers().size ){
        case 1:
        {
            player = getplayers()[ 0] ;
            // BGB pack
            player.bgb_pack = [];
            // Needs to be changed to the order with the highest chances cause of array::randomize
            ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_perkaholic", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_anywhere_but_here", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_extra_credit", player.bgb_pack.size);

            // Random BGB pack order
            player.bgb_pack_randomized = [];

            // Random order
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_perkaholic", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_dead_of_nuclear_winter", RandomInt( player.bgb_pack_randomized.size ));
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_extra_credit", RandomInt( player.bgb_pack_randomized.size ));

            // Fixed order
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", 0); // Always first
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_anywhere_but_here", RandomIntRange(2, player.bgb_pack_randomized.size)); // Anything but first or second
        }
        case 2:
        case 3:
        case 4:
        {
            foreach( player in getplayers() ){

                player.bgb_pack = [];
                player.bgb_pack_randomized = [];

                // Assume host player is NOT the void bow player
                if( player IsHost() ){

                    // Needs to be changed to the order with the highest chances cause of array::randomize
                    ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_perkaholic", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_shopping_free", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_extra_credit", player.bgb_pack.size);

                    // Random BGB order
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_shopping_free", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_dead_of_nuclear_winter", RandomInt( player.bgb_pack_randomized.size ));
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_extra_credit", RandomInt( player.bgb_pack_randomized.size ));
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_perkaholic", RandomInt( player.bgb_pack_randomized.size ));

                    // Fixed BGB order
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", 0);
            
                }else{

                    // Needs to be changed to the order with the highest chances cause of array::randomize
                    ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_crawl_space", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_shopping_free", player.bgb_pack.size);
                    ArrayInsert(player.bgb_pack, "zm_bgb_extra_credit", player.bgb_pack.size);

                    // Random BGB order
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_shopping_free", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_dead_of_nuclear_winter", RandomInt( player.bgb_pack_randomized.size ));
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_extra_credit", RandomInt( player.bgb_pack_randomized.size ));
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_crawl_space", RandomInt( player.bgb_pack_randomized.size ));

                    // Fixed BGB order
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", 0);
                }

            }
        }          
    }

    wait_for_game_start();
    wait 3;

    // Make ZWR mods work easier
    level thread print_new_bgb();  
}

#endregion

#region zm_stalingrad

function add_stalingrad_practice(){

    level.practice_modes["patch"]       = ::practice_stalingrad_patch;

    level.practice_modes["gersh"]       = ::practice_stalingrad_gersh;
    level.practice_modes["download"]    = ::practice_stalingrad_download;
    level.practice_modes["sophia"]      = ::practice_stalingrad_sophia;
}

function stalingrad_any_challenge_active(){

    return stalingrad_is_gersh_active() || stalingrad_is_download_active() || stalingrad_is_sophia_active();
}

 function stalingrad_is_gersh_active(){

    return isdefined( level.a_s_pursue_positions );
}

function stalingrad_is_gersh_available(){

    a_s_positions = struct::get_array("ee_pursue_position", "targetname");
    return isdefined( a_s_positions ) && a_s_positions.size > 0;
}

function practice_stalingrad_gersh(){

    // There is a challenge already active
    if( stalingrad_any_challenge_active() ){
        self IPrintLnBold("^5There is already a challenge active.");
        return;
    }

    // Challenge unavailable
    if( !stalingrad_is_gersh_available() ){
        self IPrintLnBold("^5Gersh ^1already done, you need to ^2 fast_restart.");
        return;
    }


    //var_ad364454 = ::zm_stalingrad_ee_main::function_21284834;
    func_scenario = @zm_stalingrad_ee_main<scripts\zm\zm_stalingrad_ee_main.gsc>::function_21284834;

    if( !isdefined( func_scenario ) ){
        self IPrintLnBold("^1Error, undefined Gersh func.");
        return;
    }

    SetDvar(DVAR_TIMESCALE, "10");

    self gsc_open_all();

    foreach( player in GetPlayers() ){
        player execute_command( "weapon "+level.w_raygun_mark3_upgraded.name );
        player execute_command( "weapon launcher_dragon_strike" );
        player [[@stalingrad_dragon_strike<scripts\zm\zm_stalingrad_dragon_strike.gsc>::function_8258d71c]]();
        player execute_command( "bgb perkaholic");

        player.score = 7777777;

        player tp_player_to_closest_respawn_point( "judicial_A_zone" );
        wait 0.05;
        player SwitchToWeaponImmediate( level.w_raygun_mark3_upgraded );
    }

    SetDvar(DVAR_TIMESCALE, "1");

    // Devgui
    //level.var_c91c0e41 = 1; // Dev var to know if a challenge is being played
    //level function_2868b6f4(); // Flash
    funcPtr = @zm_stalingrad_ee_main<scripts\zm\zm_stalingrad_ee_main.gsc>::function_2868b6f4;
    //[[ funcPtr ]]();
    level thread [[ func_scenario ]]();

    while( !isdefined( level.mdl_gersh ) ) wait 0.05;

    self IPrintLnBold("Waypoint?");

    str_shader = "black";
	color = (0x255, 0x255, 0x255);
    b_constantSize = false;
    b_isDistanceShown = false;
    b_noOffScreen = false;

    // Functionality
    /*waypoint_gersh = NewHudElem();
    waypoint_gersh setwaypoint( b_constantSize, str_shader, b_isDistanceShown, b_noOffScreen );
    waypoint_gersh SetTargetEnt( level.mdl_gersh );
    waypoint_gersh.alpha = 1;*/


    waypoint_gersh = NewHudElem();
    waypoint_gersh settargetent( level.mdl_gersh );
    waypoint_gersh setshader( str_shader, 5, 5 );
    waypoint_gersh setwaypoint( b_constantSize, "black", b_isDistanceShown, b_noOffScreen );
    waypoint_gersh.color = color;
    waypoint_gersh.alpha = 1;
    waypoint_gersh.label = &"Dr Grrrrrsh";

    //waypoint_gersh.x = level.mdl_gersh.origin[0];
    //waypoint_gersh.y = level.mdl_gersh.origin[1];
    //waypoint_gersh.z = level.mdl_gersh.origin[2];


    //level function_2868b6f4(0); // Flash
    //[[ funcPtr ]](0);

    var_e25d11fd = level util::waittill_any_return("ee_pursue_complete", "ee_pursue_failed");
    waypoint_gersh Destroy();
    self IPrintLnBold("No more Grrrrsh");
}



// level.n_download_time = 180; // Default Time for the download
function stalingrad_is_download_active(){

    return GetPlayers()[0] flag::exists("ee_koth_terminal_used");
}

function stalingrad_is_download_available(){

    return !isdefined( level.n_download_time );
}

function practice_stalingrad_download(){

    // There is a challenge already active
    if( stalingrad_any_challenge_active() ){
        self IPrintLnBold("^5There is already a challenge active.");
        return;
    }

    // Challenge unavailable
    if( !stalingrad_is_download_available() ){
        self IPrintLnBold("^5Download ^1already done, you need to ^2 fast_restart.");
        return;
    }


    //var_ad364454 = ::zm_stalingrad_ee_main::function_21284834;
    func_scenario = @zm_stalingrad_ee_main<scripts\zm\zm_stalingrad_ee_main.gsc>::function_101e5b38;

    if( !isdefined( func_scenario ) ){
        self IPrintLnBold("^1Error, undefined Download func.");
        return;
    }

    SetDvar(DVAR_TIMESCALE, "10");

    self gsc_open_all();

    level flag::set("dragon_wings_items_aquired");
    level flag::set("dragon_platforms_all_used");

    level flag::set("dragonride_crafted"); // Activate PAP zone
    wait 0.5;

    foreach( player in GetPlayers() ){
        player execute_command( "Weapon "+ level.w_raygun_mark3_upgraded.name );
        player [[@stalingrad_dragon_strike<scripts\zm\zm_stalingrad_dragon_strike.gsc>::function_8258d71c]]();
        player execute_command( "bgb perkaholic" );
        wait 0.1;
        player execute_command( "bgb anywhere_but_here" );

        player.score = 7777777;

        player tp_player_to_closest_respawn_point( "judicial_A_zone" );
        wait 0.05;
        player SwitchToWeaponImmediate( level.w_raygun_mark3_upgraded );

        if( isdefined( player.s_wearable ) ) player.s_wearable = undefined;
        player.s_wearable = spawnstruct();
        player.s_wearable.model = "c_zom_dlc3_player_wings";
		player.s_wearable.tag = "j_spine4";
        player.str_wearable = "dragon_wings";
		player playsound("zmb_wearable_wing_wear");
        level clientfield::set(("player" + player.entity_num) + "wearableItem", 3);
        array::run_all(level.var_37e960a1, ::showtoplayer, player);
    }

    level thread [[ func_scenario ]]();

    SetDvar(DVAR_TIMESCALE, "1");

    // Change Download time
    while( !isdefined( level.n_download_time ) ) wait 0.05;
    level.n_download_time = 5;
}



function stalingrad_is_sophia_active(){

    return level flag::get("weapon_cores_delivered");
}

function stalingrad_is_sophia_available(){

    return !level flag::get("weapon_cores_delivered");
}

function practice_stalingrad_sophia(){

    // There is a challenge already active
    if( stalingrad_any_challenge_active() ){
        self IPrintLnBold("^5There is already a challenge active.");
        return;
    }

    // Challenge unavailable
    if( !stalingrad_is_sophia_available() ){
        self IPrintLnBold("^5Sophia ^1already done, you need to ^2 fast_restart.");
        return;
    }


    //var_ad364454 = ::zm_stalingrad_ee_main::function_21284834;
    func_scenario = @zm_stalingrad_ee_main<scripts\zm\zm_stalingrad_ee_main.gsc>::function_e0c4c3a8;

    if( !isdefined( func_scenario ) ){
        self IPrintLnBold("^1Error, undefined Sophia func.");
        return;
    }

    SetDvar(DVAR_TIMESCALE, "10");

    self gsc_open_all();

    level flag::set("dragon_wings_items_aquired");
    level flag::set("dragon_platforms_all_used");

    level flag::set("dragonride_crafted"); // Activate PAP zone
    wait 0.5;

    foreach( player in GetPlayers() ){
        player execute_command( "weapon "+level.w_raygun_mark3_upgraded.name );
        player [[@stalingrad_dragon_strike<scripts\zm\zm_stalingrad_dragon_strike.gsc>::function_8258d71c]]();
        player execute_command( "bgb perkaholic" );

        player.score = 7777777;

        player tp_player_to_closest_respawn_point( "bunker_zone" );
        wait 0.05;
        player SwitchToWeaponImmediate( level.w_raygun_mark3_upgraded );

        if( isdefined( player.s_wearable ) ) player.s_wearable = undefined;
        player.s_wearable = spawnstruct();
        player.s_wearable.model = "c_zom_dlc3_player_wings";
		player.s_wearable.tag = "j_spine4";
        player.str_wearable = "dragon_wings";
		player playsound("zmb_wearable_wing_wear");
        level clientfield::set(("player" + player.entity_num) + "wearableItem", 3);
        array::run_all(level.var_37e960a1, ::showtoplayer, player);
        player execute_command( "bgb idle_eyes" );

        player FreezeControlsAllowLook( true );
    }

    level thread [[ func_scenario ]]();
    level flag::set("weapon_cores_delivered");

    wait 60;

    foreach( player in getplayers() ) player FreezeControlsAllowLook( false );

    SetDvar(DVAR_TIMESCALE, "1");
}






function practice_stalingrad_patch(){

    // Patch gums
    level thread stalingrad_bgb();

    level thread stalingrad_perfect_dragon();

    level thread stalingrad_perfect_cylinder();

    wait_for_game_start();
    level thread DisplayFeedMessage( "^5Stalingrad patch ^2loaded!" );

}

// level.s_drop_pods.var_365bcb3c // N of map pieces to activate PaP dragon travels
function stalingrad_perfect_cylinder(){

    level wait_till("power_on");
    wait 0.1;

    while( level.s_drop_pods.var_365bcb3c < 3){
        wait 0.05;
        if( can_cylinder_drop_spawn() ) level.s_drop_pods.n_code_cylinder_drop_rate = 100; // Guaranteed cylinder drop
        else level.s_drop_pods.n_code_cylinder_drop_rate = 0; // Never drops cylinder
    }

}


// level.s_drop_pods.var_a622ee25 // There is a cylinder dropped already
function can_cylinder_drop_spawn(){

    // level.s_drop_pods.str_cylinder_acquired // The cylinder we currently have
    if( isdefined(level.s_drop_pods.str_cylinder_acquired) || level flag::get("drop_pod_spawned") || level flag::get("drop_pod_active") || level.s_drop_pods.var_a622ee25 ) return false;

    return true;
}

// level.var_de98a8ad Var that checks the chances for the dragon to spit fire, randomfloat(1) has to be lower than the dragon var.
// level.var_a8b674f9 = 0; This var is set to true when the top part of department store is opened, allowing the dragon to spit on that zone
function stalingrad_perfect_dragon(){
    level endon( "dragon_boss_intro_init" ); // This is when you fight the dragon on the bossfight
    if( level flag::get("dragon_boss_intro_init") ) return;

    wait_dragon_available();
    wait 1;

    foreach( player in getplayers() ) player IPrintLnBold("^1Dragon ^7waiting for the ^2Egg to be placed");

    // No dragon until we place the Egg
    while( !level flag::get( "egg_placed_in_hazard" ) ){
        wait 0.05;
        level.n_attack_rate = 0;
    }

    foreach( player in getplayers() ) player IPrintLnBold("^1Dragon ^7waiting for ^2Fire Challenge and Egg Roasted");

    // We want dragon until we complete fire zombies challenge
    while( !level flag::get("gauntlet_step_2_complete" ) || !level flag::get("egg_bathed_in_flame" ) ){
        wait 0.05;
        level.n_attack_rate = 100;
    }

    foreach( player in getplayers() ) player IPrintLnBold("^1Dragon is over!");

    for(;;){
        wait 0.05;
        level.n_attack_rate = 0;
    }
}

function wait_dragon_available(){
    level endon("department_store_upper_open");
    if( level flag::get( "department_store_upper_open" ) ) return;

    while(level.round_number <= 4)
	{
		level waittill("between_round_over");
	}

    //foreach(player in GetPlayers() ) player IPrintLnBold("^2Dragon available!");
}


function stalingrad_bgb(){

    level wait_till("all_players_spawned");
    level thread debug_message( "^5BGB ^2patched!" );

    // Create specific BGB players
    if( !isdefined( world.bgb_specific ) ){
        world.bgb_specific = [];
    }

    // Create specific BGB players for this map
    if( !isdefined( world.bgb_specific[ MAP_NAME ] ) ){
        world.bgb_specific[ MAP_NAME ] = [];
    }

    // Choose who is getting shopping free to go Power
    if( !isdefined( world.bgb_specific[ MAP_NAME ][ "power" ] ) ){
        world.bgb_specific[ MAP_NAME ][ "power" ] = GetPlayers()[ 0 ] GetXuid(0);
    }


    switch( getplayers().size ){
        case 1:
        {
            player = getplayers()[ 0] ;
            
            // BGB pack
            player.bgb_pack = [];
            player.bgb_pack_randomized = [];

            // Needs to be changed to the order with the highest chances cause of array::randomize
            ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_anywhere_but_here", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_perkaholic", player.bgb_pack.size);
            ArrayInsert(player.bgb_pack, "zm_bgb_shopping_free", player.bgb_pack.size);

            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_shopping_free", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_perkaholic", player.bgb_pack_randomized.size );
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_anywhere_but_here", player.bgb_pack_randomized.size);
            ArrayInsert(player.bgb_pack_randomized, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack_randomized.size);

        }
        case 2:
        case 3:
        case 4:
        {
            foreach( player in getplayers() ){

                player.bgb_pack = [];
                player.bgb_pack_randomized = [];

                // Needs to be changed to the order with the highest chances cause of array::randomize
                ArrayInsert(player.bgb_pack, "zm_bgb_reign_drops", player.bgb_pack.size);
                ArrayInsert(player.bgb_pack, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack.size);
                ArrayInsert(player.bgb_pack, "zm_bgb_anywhere_but_here", player.bgb_pack.size);
                ArrayInsert(player.bgb_pack, "zm_bgb_perkaholic", player.bgb_pack.size);

                if( player is_bgb_specific( "power" ) ){
                    ArrayInsert(player.bgb_pack, "zm_bgb_shopping_free", player.bgb_pack.size);

                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_shopping_free", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_perkaholic", player.bgb_pack_randomized.size );
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_anywhere_but_here", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack_randomized.size);
                }else{
                    ArrayInsert(player.bgb_pack, "zm_bgb_idle_eyes", player.bgb_pack.size);

                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_reign_drops", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_perkaholic", player.bgb_pack_randomized.size );
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_anywhere_but_here", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_dead_of_nuclear_winter", player.bgb_pack_randomized.size);
                    ArrayInsert(player.bgb_pack_randomized, "zm_bgb_idle_eyes", player.bgb_pack_randomized.size);
                }

            }
        }          
    }

    wait_for_game_start();

    // Make ZWR mods work easier
    level thread print_new_bgb();
}

#endregion


#region zm_tomb

function add_tomb_practice(){

    // Specific staffs practice
    level.practice_modes["ice"]         = ::practice_ice_staff;
    level.practice_modes["air"]         = ::practice_air_staff;
    level.practice_modes["lightning"]   = ::practice_lightning_staff;
    level.practice_modes["fire"]        = ::practice_fire_staff;

    // General Staff Practice
    level.practice_modes["patch"]       = ::practice_tomb_patch;

    level.practice_modes["petthedog"]   = ::practice_tomb_petthedog;
}

    /* Origins teleports script numbers
        4 = Ice
        3 = Electric
        2 = Wind
        1 = Fire
    */

function practice_fire_staff(){

    SetDvar( DVAR_TIMESCALE, 10 );
    wait_for_game_start();

    get_specific_craftable_piece( "gramophone", "vinyl_player" ); // Idk which one is the correct piece
    get_specific_craftable_piece( "gramophone", "vinyl_master" ); // Idk which one is the correct piece
    level.host gsc_open_all(); // Open doors

    level thread activate_origins_generators();
    level.host thread open_gramophone_doors();
    level notify( "open_all_gramophone_doors" );
    level enable_agartha_zone();


    a_s_teleporters = struct::get_array("chamber_exit_trigger", "script_noteworthy");
    foreach( teleporter in a_s_teleporters ){

        if( teleporter.script_int == 4 ){
            a_pos = struct::get_array(teleporter.target, "targetname");
            break;
        }

    }

    foreach( player in level.players){

        s_pos = get_free_teleport_pos(player, a_pos);
        player setorigin(s_pos.origin);
	    player setplayerangles(s_pos.angles);
        player playsoundtoplayer("zmb_teleporter_plr_end", player);
        player thread execute_command( "weapon staff_fire" );

        player iPrintLnBold("^2Fire staff ^5practice!");
    }

    if( !is_true( level.a_elemental_staffs["staff_fire"].charger.full ) ){

        // First step
        if( !level flag::get( "fire_puzzle_1_complete" ) ){

            level.sacrifice_volumes[0].b_gods_pleased = true;
            wait 0.1;
            level notify("fire_sacrifice_completed");
            level waittill( "fire_puzzle_1_complete" );

        }
    }

    wait 10;
    SetDvar( DVAR_TIMESCALE, 1 );
}

function practice_lightning_staff(){

    SetDvar( DVAR_TIMESCALE, 10 );
    wait_for_game_start();

    get_specific_craftable_piece( "gramophone", "vinyl_player" ); // Idk which one is the correct piece
    get_specific_craftable_piece( "gramophone", "vinyl_master" ); // Idk which one is the correct piece
    level.host gsc_open_all(); // Open doors

    level thread activate_origins_generators();
    level.host thread open_gramophone_doors();
    level notify( "open_all_gramophone_doors" );
    level enable_agartha_zone();
    
    a_s_teleporters = struct::get_array("trigger_teleport_pad", "targetname");
    foreach( teleporter in a_s_teleporters ){

        if( teleporter.script_int == 3 ){
            a_pos = struct::get_array(teleporter.target, "targetname");
            break;
        }

    }

    foreach( player in level.players){

        s_pos = get_free_teleport_pos(player, a_pos);
        player setorigin(s_pos.origin);
	    player setplayerangles(s_pos.angles);
        player playsoundtoplayer("zmb_teleporter_plr_end", player);
        player thread execute_command( "give staff_lightning" );

        player iPrintLnBold("^2Lightning staff ^5practice!");
    }

    wait 10;
    SetDvar( DVAR_TIMESCALE, 1 );
}

function practice_air_staff(){

    SetDvar( DVAR_TIMESCALE, 10 );
    wait_for_game_start();

    self thread get_specific_craftable_piece( "gramophone", "vinyl_player" ); // Idk which one is the correct piece
    self thread get_specific_craftable_piece( "gramophone", "vinyl_master" ); // Idk which one is the correct piece
    
    level.host gsc_open_all(); // Open doors

    level thread activate_origins_generators();
    level.host thread open_gramophone_doors();
    level notify( "open_all_gramophone_doors" );
    level enable_agartha_zone();

    a_s_teleporters = struct::get_array("trigger_teleport_pad", "targetname");
    foreach( teleporter in a_s_teleporters ){

        if( teleporter.script_int == 2 ){
            a_pos = struct::get_array(teleporter.target, "targetname");
            break;
        }

    }

    foreach( player in level.players){

        s_pos = get_free_teleport_pos(player, a_pos);
        player setorigin(s_pos.origin);
	    player setplayerangles(s_pos.angles);
        player playsoundtoplayer("zmb_teleporter_plr_end", player);
        player thread execute_command( "weapon staff_air");

        player iPrintLnBold("^2Air staff ^5practice!");
    }

    wait 10;
    SetDvar( DVAR_TIMESCALE, 1 );

}

function practice_ice_staff(){

    SetDvar( DVAR_TIMESCALE, 10 );
    wait_for_game_start();

    level thread debug_message("Running Ice practice");

    get_specific_craftable_piece( "gramophone", "vinyl_player" ); // Idk which one is the correct piece
    get_specific_craftable_piece( "gramophone", "vinyl_master" ); // Idk which one is the correct piece
    level.host gsc_open_all(); // Open doors

    level thread activate_origins_generators();
    level.host thread open_gramophone_doors();
    level notify( "open_all_gramophone_doors" );
    level enable_agartha_zone();
    
    a_s_teleporters = struct::get_array("trigger_teleport_pad", "targetname");
    foreach( teleporter in a_s_teleporters ){

        if( teleporter.script_int == 4 ){
            a_pos = struct::get_array(teleporter.target, "targetname");
            break;
        }

    }

    foreach( player in level.players){

        s_pos = get_free_teleport_pos(player, a_pos);
        player setorigin(s_pos.origin);
	    player setplayerangles(s_pos.angles);
        player playsoundtoplayer("zmb_teleporter_plr_end", player);
        player thread execute_command( "weapon staff_water" );

        player iPrintLnBold("^2Ice staff ^5practice!");
    }

    wait 10;
    SetDvar( DVAR_TIMESCALE, 1 );
}


function practice_tomb_patch(){

    // Patch ABH locations for EE
    //level thread override_abh_func( ::best_factory_abh );
    //level thread factory_revert_abh_func();

    // Patch gums
    //level thread zod_bgb();

    // Patch zombie spawn locations
    //level thread override_zm_spwn_loc_func( ::factory_zm_custom_spawn_location_selection );
    //level thread factory_revert_zm_spwn_loc_func();

    // Patch weather
    level thread tomb_force_weather();

    // Patch ice staff piece chance
    level thread tomb_force_ice_staff_parts();

    // Robots have both feet open always
    level flag::set("all_robot_hatch");

    level thread shopping_free_first();
    level thread reign_drops_first();

    wait_for_game_start();
    level thread DisplayFeedMessage( "^5Tomb patch ^2loaded!" );
}

function practice_tomb_petthedog(){

    SetDvar(DVAR_TIMESCALE, 10);

    v_origin = (2316, 750, -19);
    while( !isdefined( level.commands_register_completed ) ) wait 0.05;
    wait_for_game_start();

    level.host execute_command( "openall");

    level.host execute_command( "ee stk");
    level.host execute_command( "bgb per");
    level.host execute_command( "bgb sm");
    while( level.ee_being_completed ) wait 0.05;

    level flag::set( "staff_fire_zm_enabled" );
    
    a_weapons = level.host GetWeaponsListPrimaries();
    foreach( weapon in a_weapons ) level.host TakeWeapon( weapon );
    level.host GiveWeapon( getweapon("pistol_c96_upgraded") );
    level.host GiveWeapon( level.a_elemental_staffs_upgraded[ "staff_fire_upgraded" ].w_weapon );
    level.host GiveWeapon( getweapon("ar_stg44") );

    b_give_beacon_to_all = true;
    autocomplete_beacon_quest( b_give_beacon_to_all );

    // Fill all boxes
    foreach( box in getentarray("foot_box", "script_noteworthy") ){
        index = box tomb_get_box_index();
        if( !isdefined( index ) ) continue; // Completed
        if( index == 0 || index == 3 ) continue; // Don't fill PAP or Gen 5 soul boxes

        saved_souls = 30;
        if( saved_souls >= 30 ) box.n_souls_absorbed = saved_souls;

        box notify("soul_absorbed", level.host);
        wait 0.1;
        box.n_souls_absorbed = saved_souls -1;
    }

    str_build_zone = "zone_nml_9";

    while( !is_object_crafted( "equip_dieseldrone" ) ){
        wait 0.05;
        level.host craft_open_table_object( "equip_dieseldrone", str_build_zone );
    }

    w_drone = getweapon( "equip_dieseldrone" );
    while( !level.host HasWeapon( w_drone ) ){
        wait 0.05;
        level.host grab_crafted_item( "equip_dieseldrone" );
    }


    level.host execute_command( "round 15");
    level.host execute_command( "score 20000");

    level flag::set("all_robot_hatch");

    level.host SetOrigin( v_origin );

    // 1) TP player to jugg soul box
    // 2) Start at round 15 DONE
    // 3) Give all perks DONE
    // 4) Take all and give Boomhilda, Fire staff upgraded, Stg DONE
    // 5) Give self med DONE
    // 6) Jug and Church soul boxes must be filled DONE
    // 7) Maxis drone built at wind tunnel and picked up DONE
    // 8) Give beacons DONE
    // 9) New gum cycle DONE
    // 10) 20k points DONE
    // 11) level flag::set("all_robot_hatch"); DONE

    wait_for_game_start();
    level thread DisplayFeedMessage( "^5Tomb Pet The Dog ^2loaded!" );    
}


function shopping_free_first(){
    level wait_till("all_players_spawned");

    foreach( player in GetPlayers() ){
        // Player doesn't have reign drops...
        if( !IsInArray(player.bgb_pack, "zm_bgb_shopping_free") ) continue;
        
        player.bgb_pack_randomized = array::randomize(player.bgb_pack);
        while( player.bgb_pack_randomized[0] != "zm_bgb_shopping_free" ) player.bgb_pack_randomized = array::randomize(player.bgb_pack);
    }
}

function reign_drops_first(){
    level wait_till("all_players_spawned");
    level thread debug_message( "^5BGB ^2patched!" );

    foreach( player in GetPlayers() ){
        // Player doesn't have reign drops...
        if( !IsInArray(player.bgb_pack, "zm_bgb_reign_drops") ) continue;

        // Already has a patched gum cycle
        if( isdefined( player.bgb_pack_randomized ) && player.bgb_pack_randomized.size > 0 ) continue;
        
        player.bgb_pack_randomized = array::randomize(player.bgb_pack);
        while( player.bgb_pack_randomized[0] != "zm_bgb_reign_drops" ) player.bgb_pack_randomized = array::randomize(player.bgb_pack);
    }

    wait_for_game_start();

    // Make ZWR mods work easier
    level thread print_new_bgb();
}

function tomb_force_weather(){

    while( !isdefined( level.force_weather ) || !isdefined( level.force_weather[10] ) ) wait 0.05;

    level.force_weather[2] = "rain";
    level.force_weather[3] = "snow";
    level.force_weather[4] = "snow";
    // TODO: display on feed which rounds are forced to snow
    //level thread debug_message("Weather changed!");
}

function tomb_force_ice_staff_parts()
{

    while( !isdefined( level.ice_staff_pieces ) ) wait 0.05;
    while( !IsArray( level.ice_staff_pieces ) ) wait 0.05;
    while( level.ice_staff_pieces.size < 3 ) wait 0.05;
    while( !isdefined( level.ice_staff_pieces[2].num_misses ) ) wait 0.05;

    level.ice_staff_pieces[0].num_misses = 4;
    level.ice_staff_pieces[1].num_misses = 4;
    level.ice_staff_pieces[2].num_misses = 4;

    // TODO: display on feed staff parts are first dig
    // level thread debug_message("Ice parts forced!");
}

/*
function init_weather_manager()
{
	level.weather_snow = 0;
	level.weather_rain = 0;
	level.weather_fog = 0;
	level.weather_vision = 0;
	//level thread weather_manager();
	//level thread rotate_skydome();
	//callback::on_connect(&set_weather_to_player);
	level.force_weather = [];
	level.force_weather[1] = "none";

	if(math::cointoss())
	{
		level.force_weather[3] = "snow";
	}
	else
	{
		level.force_weather[4] = "snow";
	}

	for(i = 5; i <= 9; i++)
	{
		if(math::cointoss())
		{
			level.force_weather[i] = "none";
			continue;
		}
		level.force_weather[i] = "rain";
	}
	level.force_weather[10] = "snow";
	level notify(#"hash_149fa2ac");
}


function randomize_weather()
{
	weather_name = level.force_weather[level.round_number];
	if(!isdefined(weather_name))
	{
		n_round_weather = randomint(100);
		rounds_since_snow = level.round_number - level.last_snow_round;
		rounds_since_rain = level.round_number - level.last_rain_round;
		if(n_round_weather < 40 || rounds_since_snow > 3)
		{
			weather_name = "snow";
		}
		else
		{
			if(n_round_weather < 80 || rounds_since_rain > 4)
			{
				weather_name = "rain";
			}
			else
			{
				weather_name = "none";
			}
		}
	}
	if(weather_name == "snow")
	{
		level.weather_snow = randomintrange(1, 5);
		level.weather_rain = 0;
		level.weather_vision = 2;
		level.last_snow_round = level.round_number;
	}
	else
	{
		if(weather_name == "rain")
		{
			level.weather_snow = 0;
			level.weather_rain = randomintrange(1, 5);
			level.weather_vision = 1;
			level.last_rain_round = level.round_number;
		}
		else
		{
			level.weather_snow = 0;
			level.weather_rain = 0;
			level.weather_vision = 3;
		}
	}
}


function weather_manager()
{
	level.last_snow_round = 0;
	level.last_rain_round = 0;
	level waittill(#"hash_149fa2ac");
	while(true)
	{
		randomize_weather();
		level clientfield::set("rain_level", level.weather_rain);
		level clientfield::set("snow_level", level.weather_snow);
		wait(2);
		foreach(player in getplayers())
		{
			if(zombie_utility::is_player_valid(player, 0, 1))
			{
				player set_weather_to_player();
			}
		}
		level waittill(#"end_of_round");
	}
}
*/
#endregion
