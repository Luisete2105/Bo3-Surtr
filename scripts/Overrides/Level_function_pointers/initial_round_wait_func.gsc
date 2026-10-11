// if(isdefined(level.initial_round_wait_func)) [[level.initial_round_wait_func]]();


function hook_initial_round_wait_func(){

    // Save old function if it exists
    if( isdefined( level.initial_round_wait_func ) ) level.old_initial_round_wait_func = level.initial_round_wait_func;
    level.initial_round_wait_func = ::change_round_number_initial;
}

function change_round_number_initial(){

    // Call real function if exists
    if(isdefined(level.old_initial_round_wait_func)) [[level.old_initial_round_wait_func]]();

    // No number to change
    if( !isdefined( level.lui_round ) ) return;

    setroundsplayed( level.lui_round );

	// One frame still glitches sometimes for non host players
	wait 0.1;
	level.lui_round = undefined;
}