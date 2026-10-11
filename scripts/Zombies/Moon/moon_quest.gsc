function moon_wait_ss1(){

    level waittill( "sq_ss1_completed" );
}

function moon_wait_ss2(){

    level waittill( "sq_ss2_completed" );
}

function moon_wait_osc(){

    level waittill( "sq_osc_completed" );
}

function moon_wait_reveal_achieved(){

    level waittill( "moon_sidequest_reveal_achieved" );
}

function moon_wait_sc2(){

    level waittill( "sq_sc2_completed" );
}

function moon_wait_ctt1(){

    level waittill( "tanks_ctt1_completed" );
}

function moon_wait_ctt2(){

    level waittill( "tanks_ctt2_completed" );
}

function moon_wait_btvg(){

    level waittill( "ctvg_build_completed" );
}

function moon_wait_ctvg(){

    level waittill( "ctvg_charge_completed" );
}

function moon_wait_be1(){

    level waittill( "be_stage_one_completed" );
}

function moon_wait_be2(){

    level waittill( "be_stage_two_completed" );
}

function moon_wait_big_bang_achieved(){

    level waittill( "moon_sidequest_big_bang_achieved" );
    SetDvar( DVAR_LIVESPLIT_PAUSED, "1"); // Last split, user may be playing a Super EE
}