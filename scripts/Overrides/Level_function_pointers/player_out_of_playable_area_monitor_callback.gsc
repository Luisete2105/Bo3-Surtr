function hook_poopamc(){
    level endon( "game_ended" );

    // Wait for Player Out Of Playable Area Monitor Callback
    wait_poopamc_function_created();

    if( isdefined( level.player_out_of_playable_area_monitor_callback ) ) level.old_player_out_of_playable_area_monitor_callback = level.player_out_of_playable_area_monitor_callback;
    level.player_out_of_playable_area_monitor_callback = ::lui_check_death_barrier;
}

function wait_poopamc_function_created(){

    switch( MAP_NAME ){

        case "zm_zod":
        case "zm_castle":
        case "zm_stalingrad":
        case "zm_genesis":
        case "zm_theater":
        case "zm_cosmodrome":
        case "zm_temple":
        case "zm_moon":
        case "zm_tomb":
        {
            while( !isdefined( level.player_out_of_playable_area_monitor_callback ) ) wait 0.05;
        }
    }

}

function lui_check_death_barrier(){

    dead = isdefined( level.old_player_out_of_playable_area_monitor_callback ) ? self [[ level.old_player_out_of_playable_area_monitor_callback ]]() : true;
    
    // Flash the timer color depending if the player should have died
    if( level.practice )
        self notify( "oob_check", dead );
    
    return ( is_true( self.god_lui ) || is_true( self.noclip_lui ) ) ? false : is_true( dead );
    //return false; // Force to never die
}