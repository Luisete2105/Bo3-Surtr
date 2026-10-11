function hook_poopao(){
    level endon( "game_ended" );

    // Wait for Player Out Of Playable Area Override
    wait_poopao_function_created();
    if( isdefined( level.player_out_of_playable_area_override ) ) level.old_player_out_of_playable_area_override = level.player_out_of_playable_area_override;
    level.player_out_of_playable_area_override = ::lui_check_death_barrier_override;
}

function wait_poopao_function_created(){

    switch( MAP_NAME ){

        case "zm_zod":
        {
            while( !isdefined( level.player_out_of_playable_area_override ) ) wait 0.05;
        }
    }

}


function lui_check_death_barrier_override(){

    // level.player_out_of_playable_area_override | Only used on ZOD
    dead = isdefined( level.old_player_out_of_playable_area_override ) ? self [[ level.old_player_out_of_playable_area_override ]]() : false;

    // Flash the timer color depending if the player should have died
    if( level.practice )
        self notify( "oob_check", dead );
    
    return ( is_true( self.god_lui ) || is_true( self.noclip_lui ) ) ? false : is_true( dead );
    //return false; // Force to never die
}
