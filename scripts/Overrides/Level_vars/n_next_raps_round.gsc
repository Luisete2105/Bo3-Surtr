function override_n_next_raps_round( a_raps_rounds = undefined ){

    // Undefined
    if( !isdefined( a_raps_rounds ) ){
        level thread debug_message("^1Error, undefined raps rounds in ^5override_n_next_raps_round");
        return;
    }

    // Not an array
    if( !isdefined( a_raps_rounds ) ){
        level thread debug_message("^1Error, raps rounds are not an array in ^5override_n_next_raps_round");
        return;
    }

    // Invalid number
    last_n = 0;
    foreach( raps_round in a_raps_rounds ){
        if( !StrIsNumber(raps_round) ){
            level thread debug_message("^1Error, INVALID value in ^5override_n_next_raps_round");
            return;
        }

        raps_round = int( raps_round );
        if( raps_round <= last_n ){
            level thread debug_message("^1Error, LOWER value in ^5override_n_next_raps_round");
            return;
        }
        last_n = raps_round;
    }



    while( !isdefined( level.n_next_raps_round ) ) wait 0.05;
    level.n_next_raps_round = a_raps_rounds[ level.raps_round_count-1 ];

    level thread debug_message( "^2Next raps round set to ^5"+level.n_next_raps_round );
    
    for(;;)
    {
        level waittill( "between_round_over" );
        if ( level.round_number == level.n_next_raps_round ){

            level waittill( "raps_round_ending" );
            wait 0.5;
            level thread debug_message( "^2Raps round over!" );

            if( a_raps_rounds.size < level.raps_round_count ){
                level thread debug_message( "^2No more raps rounds need to be set!" );
                return;
            }

            wait 1;
            level thread debug_message( "^2Old next ^5"+level.n_next_raps_round );
            wait 1;
            level.n_next_raps_round = a_raps_rounds[ level.raps_round_count-1 ];
            level thread debug_message( "^2New next ^5"+level.n_next_raps_round );
        }
    }
}