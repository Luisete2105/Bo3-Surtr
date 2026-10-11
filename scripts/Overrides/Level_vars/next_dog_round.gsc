function override_next_dog_round( a_dog_rounds = undefined ){

    // Undefined
    if( !isdefined( a_dog_rounds ) ){
        level thread debug_message("^1Error, undefined dog rounds in ^5override_next_dog_round");
        return;
    }

    // Not an array
    if( !isdefined( a_dog_rounds ) ){
        level thread debug_message("^1Error, dog rounds are not an array in ^5override_next_dog_round");
        return;
    }

    // Invalid number
    last_n = 0;
    foreach( dog_round in a_dog_rounds ){
        if( !StrIsNumber(dog_round) ){
            level thread debug_message("^1Error, INVALID value in ^5override_next_dog_round");
            return;
        }

        dog_round = int( dog_round );
        if( dog_round <= last_n ){
            level thread debug_message("^1Error, LOWER value in ^5override_next_dog_round");
            return;
        }
        last_n = dog_round;
    }



    while( !isdefined( level.next_dog_round ) ) wait 0.05;
    level.next_dog_round = a_dog_rounds[ level.dog_round_count-1 ];

    level thread debug_message( "^2Next dog round set to ^5"+level.next_dog_round );
    
    for(;;)
    {
        level waittill( "between_round_over" );
        if ( level.round_number == level.next_dog_round ){

            level waittill( "dog_round_ending" );
            wait 0.5;
            level thread debug_message( "^2Dog round over!" );

            if( a_dog_rounds.size < level.dog_round_count ){
                level thread debug_message( "^2No more dog rounds need to be set!" );
                return;
            }

            wait 1;
            level thread debug_message( "^2Old next ^5"+level.next_dog_round );
            wait 1;
            level.next_dog_round = a_dog_rounds[ level.dog_round_count-1 ];
            level thread debug_message( "^2New next ^5"+level.next_dog_round );
        }
    }
}