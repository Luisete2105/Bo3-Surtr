// if(isdefined(level.round_end_custom_logic)) [[level.round_end_custom_logic]]();


function hook_round_end_custom_logic(){

    // Save old function if it exists
    if( isdefined( level.round_end_custom_logic ) ) level.old_round_end_custom_logic = level.round_end_custom_logic;
    level.round_end_custom_logic = ::change_round_number_end;
}

function change_round_number_end(){

    // Call real function if exists
    if(isdefined(level.old_round_end_custom_logic)) [[level.old_round_end_custom_logic]]();

    // No number to change
    if( !isdefined( level.lui_round ) ) return;

    setroundsplayed( level.lui_round );

	// One frame still glitches sometimes for non host players
	wait 0.1;
	level.lui_round = undefined;
}