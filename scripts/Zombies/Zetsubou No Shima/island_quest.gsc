function island_wait_for_bunker_open(){
    
    level waittill( "p7_fxanim_zm_island_bunker_door_main_bundle_playing" );
}

function island_wait_for_skull_ritual_completed(){

    level waittill( "skull_quest_complete" );
}

function island_wait_for_rainbow_plant(){

    level waittill( "wwup3_found" );
}

function island_wait_for_elevator_repairs(){

    // Avoid Dev 2 error for non initialized flag
    level waittill( "elevator_part_gear1_placed" );

    // Wait for the other 2, the flags now exist so no Dev 2 errors
    level flag::wait_till_all( array( "elevator_part_gear2_placed", "elevator_part_gear3_placed"  ) );
}

function island_wait_for_takeo_fight_ended(){
    
    level waittill( "cin_isl_outro_3rd_sh010_playing" );

    SetDvar( DVAR_LIVESPLIT_PAUSED, "1"); // Last split, user may be playing a Super EE
}