
function map_has_weighted_zm_spwn_loc_func(){

    switch( MAP_NAME ){

        case "zm_zod":
        case "zm_factory":
        case "zm_castle":
        case "zm_stalingrad":
        case "zm_genesis":
        //level thread debug_message("^2Map has zm spwn loc!");
            return true;
    }

    //level thread debug_message("^1NoNo map zm spwn loc...");
    return false;
}

function wait_for_zm_spwn_loc_func(){

    while( !isdefined( level.zm_custom_spawn_location_selection ) ) wait 0.05;
}

function override_zm_spwn_loc_func( new_zm_spwn_loc_func ){

    if( map_has_weighted_zm_spwn_loc_func() ) wait_for_zm_spwn_loc_func();

    level thread debug_message( "^5ZM SPWN LOC func ^2overridden!" );

    level.old_zm_custom_spawn_location_selection = level.zm_custom_spawn_location_selection;
    level.zm_custom_spawn_location_selection = new_zm_spwn_loc_func;
}

function revert_zm_spwn_loc_func(){

    level.zm_custom_spawn_location_selection = level.old_zm_custom_spawn_location_selection;
    level.old_zm_custom_spawn_location_selection = undefined;
}

function find_specific_spot( spots, script_string, target, origin ){

    // Error, no spots
    if( !isdefined( spots ) ){
        level thread debug_message_instant( "^1Error, Undefined spots to search..." );
        return undefined;
    }

    // Error, no parameters to search
    if( !isdefined( script_string ) && !isdefined( target ) && !isdefined( origin )  ){
        level thread debug_message_instant( "^1Error, no parameters to search a spot..." );
        return undefined;
    }

    
    if( isdefined( script_string ) ){
        foreach( index, spot in spots ){
            if( spot.script_string == script_string ){
                //ArrayInsert(a_spots, spot, a_spots.size);
                #ifdef dev
                    level thread debug_message_instant( "Found spot script_string: ^5"+script_string );
                #endif
                return index;
            }
        }
    }

    if( isdefined( target ) ){
        foreach(index, spot in spots ){
            if( spot.target == target ){
                #ifdef dev
                    level thread debug_message_instant( "Found spot target: ^5"+target );
                #endif
                return index;
            }
        }
    }

    if( isdefined( origin ) ){
        foreach(index, spot in spots ){

            distance = distancesquared(spot.origin, origin);

            // In theory making it square should not result in a negative number but maybe the distance comparison is performed after squaring them?
            //if( distance < 0 ) distance = abs( distance );
            //else distance = distance;


            // Let's have some distance as a safe check
            if( distance < 10 ){
                #ifdef dev
                    level thread debug_message_instant( "Found spot Origin: ^5"+origin );
                #endif
                return index;
            }
        }
    }

    //level thread debug_message_instant( "^1Error, couldn't find spot..." );
    /*if( isdefined( target ) ) level thread debug_message_instant( "target ^1"+target );
    if( isdefined( script_string ) ) level thread debug_message_instant( "script_string ^1"+script_string );
    if( isdefined( origin ) ) level thread debug_message_instant( "origin ^1"+origin );*/
    return undefined;
}




#region factory

function factory_zm_custom_spawn_location_selection( spots ){

    if ( level.zombie_respawns > 0 ){
        //level thread debug_message_instant( "Respawner..." );

        if( isdefined( level.old_zm_custom_spawn_location_selection ) ){
            //level thread debug_message_instant( "Spawning with old func" );
            return [[ level.old_zm_custom_spawn_location_selection ]]( spots );
        }
    }

    spawn_index = find_specific_spot( spots, "receiver_set_entry_b", "pf2062_auto408"  );
    if( isdefined( spawn_index ) ){
        level thread debug_message_instant( "Found ^2close ee window!" );
        return spots[spawn_index];
    }
    
    spawn_index = find_specific_spot( spots, "receiver_set_entry_b", "pf2062_auto407"  );
    if( isdefined( spawn_index ) ){
        level thread debug_message_instant( "Found ^2far ee window!" );
        return spots[spawn_index];
    }

    // Avoid errors by checking it exists
    if( isdefined( level.old_zm_custom_spawn_location_selection ) ){
        //level thread debug_message_instant( "Spawning with old func" );
        return [[ level.old_zm_custom_spawn_location_selection ]]( spots );
    }


    level thread debug_message_instant( "^1Error, shouldn't be reached in factory_zm_custom_spawn_location_selection" );
    return spots[0];
}

#endregion

#region castle

function firebow_castle_zm_custom_spawn_location_selection( spots ){

    //level thread debug_message_instant( "N spots ^5"+spots.size );

    // I do not care about respawners despite being DE
    if ( level.zombie_respawns > 0 ){
        //level thread debug_message_instant( "Respawner..." );

        if( isdefined( level.old_zm_custom_spawn_location_selection ) ){
            //level thread debug_message_instant( "Spawning with old func" );
            return [[ level.old_zm_custom_spawn_location_selection ]]( spots );
        }else{
            level thread debug_message_instant( "^1Error, ^5rarete ^1in firebow_castle_zm_custom_spawn_location_selection" );
        }
    }

    /* DRAGON VALUES

        DRAGON_COURTYARD // 2nd dragon on EE speedrun
        DRAGON_GREATHALL // 1st dragon on EE speedrun
        DRAGON_UNDERCROFT // 3rd dragon on EE speedrun
    */

    if( !castle_is_dragon_fed( DRAGON_GREATHALL )){
        spawn_index = find_specific_spot( spots, "greathall_set_a" );
        if( isdefined( spawn_index ) ){
            //level thread debug_message_instant( "Found ^5DRAGON_GREATHALL ^2window! ^5"+spawn_index );
            return spots[spawn_index];
        }
    }
    
    if( !castle_is_dragon_fed( DRAGON_UNDERCROFT )){
        spawn_index = find_specific_spot( spots, undefined, undefined, (-954,2920,237) );
        if( isdefined( spawn_index ) ){
            //level thread debug_message_instant( "Found ^5DRAGON_UNDERCROFT ^2window! ^5"+spawn_index );
            return spots[spawn_index];
        }
    }

    if( !castle_is_dragon_fed( DRAGON_COURTYARD )){
        spawn_index = find_specific_spot( spots, undefined, undefined, (1873,2521,400) );
        if( isdefined( spawn_index ) ){
            //level thread debug_message_instant( "Found ^5DRAGON_COURTYARD ^2window! ^5"+spawn_index );
            return spots[spawn_index];
        }
    }



    // Avoid errors by checking it exists
    if( isdefined( level.old_zm_custom_spawn_location_selection ) ){
        //level thread debug_message_instant( "Spawning with old func" );
        return [[ level.old_zm_custom_spawn_location_selection ]]( spots );
    }

    level thread debug_message_instant( "^1Error, shouldn't be reached in firebow_castle_zm_custom_spawn_location_selection" );
    return spots;
}

#endregion

#region debug_zombie_spawn_times

function print_zombie_spawns_times(){

    // Check if the current map has "level.zm_custom_spawn_location_selection"
    if( map_has_weighted_zm_spwn_loc_func() ){
        wait_for_zm_spwn_loc_func(); // Wait for "level.zm_custom_spawn_location_selection" to be defined
        level.zm_custom_spawn_location_selection_old = level.zm_custom_spawn_location_selection;
    }

    level.zm_custom_spawn_location_selection = ::print_round_time_zombie_spawn;
}

function print_round_time_zombie_spawn( spots ){


    foreach( player in getplayers() ) player IPrintLnBold( CalcTime( GetTime() - level.round_start ) );

    return isdefined( level.zm_custom_spawn_location_selection_old ) ? [[ level.zm_custom_spawn_location_selection_old ]]( spots ) : array::random(spots);
}

#endregion