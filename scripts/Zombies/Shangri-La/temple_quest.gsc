
function temple_wait_toafc(){

    level waittill( "sq_oafc_completed" );
}

function temple_wait_dgcwf(){

    level waittill( "sq_dgcwf_completed" );
}

function temple_wait_lgs(){

    level waittill( "sq_lgs_completed" );
}

function temple_wait_ptt(){

    level waittill( "sq_ptt_completed" );
}

function temple_wait_std(){

    level waittill( "sq_std_completed" );
}

function temple_wait_bttp(){

    level waittill( "sq_bttp_completed" );
}

function temple_wait_bttp2(){

    level waittill( "sq_bttp2_completed" );
}

function temple_wait_bag(){

    level waittill( "sq_bag_completed" );
}

function temple_wait_ttwt(){

    level waittill( "temple_sidequest_achieved" );
    SetDvar( DVAR_LIVESPLIT_PAUSED, "1"); // Last split, user may be playing a Super EE
}