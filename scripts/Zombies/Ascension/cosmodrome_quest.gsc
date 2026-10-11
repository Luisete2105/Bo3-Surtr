
function cosmodrome_wait_launch_complete(){

    level waittill( "launch_complete" );
}

function cosmodrome_wait_ascension_ee(){

    level waittill( "ascension_ee" );
    SetDvar( DVAR_LIVESPLIT_PAUSED, "1"); // Last split, user may be playing a Super EE
}