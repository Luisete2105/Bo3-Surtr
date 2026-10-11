function stalingrad_fly1_completed(){

    level waittill("dragon_departure_1");
}

function stalingrad_fly2_completed(){

    level waittill("dragon_departure_2");
}

function stalingrad_fly3_completed(){

    level waittill("dragon_departure_3");
}

function stalingrad_challenges_started(){

    level waittill("scenario_active");
}

function stalingrad_download_started(){

    while( !isdefined( level.n_download_time ) ) wait 0.05; // level.n_download_time is the time that the Download lockdown is going to take
}

function stalingrad_nikolai_defeated(){

    level waittill( "cin_sta_outro_3rd_sh020_playing" );

    SetDvar( DVAR_LIVESPLIT_PAUSED, "1"); // Last split, user may be playing a Super EE
}