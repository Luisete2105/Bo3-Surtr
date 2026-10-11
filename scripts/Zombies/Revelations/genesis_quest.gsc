function genesis_wait_for_keeper_reel_start(){

    level waittill( "cin_zm_dlc4_keeper_prtctr_ee_idle_playing" );
}

function genesis_wait_reel_2_placed(){

    level waittill( "placed_audio2" );
}

function genesis_wait_house_tp(){

    level waittill( "sophia_at_teleporter" );
    level waittill( "teleporter_on" );
}

function genesis_wait_rift_entrance(){

    level waittill( "rift_entrance_open" );
}

function genesis_wait_grand_tour(){

    level waittill( "grand_tour" );
}

genesis_wait_for_the_good_of_all(){

    level waittill( "genesis_ee_sams_room_playing" );

    SetDvar( DVAR_LIVESPLIT_PAUSED, "1"); // Last split, user may be playing a Super EE
}