function override_next_wasp_round( a_wasp_rounds = undefined ){

    // Undefined
    if( !isdefined( a_wasp_rounds ) ){
        level thread debug_message("^1Error, undefined wasp rounds in ^5override_next_wasp_round");
        return;
    }

    // Not an array
    if( !isdefined( a_wasp_rounds ) ){
        level thread debug_message("^1Error, wasp rounds are not an array in ^5override_next_wasp_round");
        return;
    }

    // Invalid number
    last_n = 0;
    foreach( wasp_round in a_wasp_rounds ){
        if( !StrIsNumber(wasp_round) ){
            level thread debug_message("^1Error, INVALID value in ^5override_next_wasp_round");
            return;
        }

        wasp_round = int( wasp_round );
        if( wasp_round <= last_n ){
            level thread debug_message("^1Error, LOWER value in ^5override_next_wasp_round");
            return;
        }
        last_n = wasp_round;
    }



    while( !isdefined( level.next_wasp_round ) ) wait 0.05;
    level.next_wasp_round = a_wasp_rounds[ level.wasp_round_count-1 ];

    level thread debug_message( "^2Next wasp round set to ^5"+level.next_wasp_round );
    
    for(;;)
    {
        level waittill( "between_round_over" );
        if ( level.round_number == level.next_wasp_round ){

            level waittill( "wasp_round_ending" );
            wait 0.5;
            level thread debug_message( "^2Wasp round over!" );

            if( a_wasp_rounds.size < level.wasp_round_count ){
                level thread debug_message( "^2No more Wasp rounds need to be set!" );
                return;
            }

            wait 1;
            level thread debug_message( "^2Old next ^5"+level.next_wasp_round );
            wait 1;
            level.next_wasp_round = a_wasp_rounds[ level.wasp_round_count-1 ];
            level thread debug_message( "^2New next ^5"+level.next_wasp_round );
        }
    }
}