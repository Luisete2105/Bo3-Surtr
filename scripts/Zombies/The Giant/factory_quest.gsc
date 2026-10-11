
/*  Easter Egg

    Step 1 - Button
    Shoot the button out of the map with an upgraded weapon.
    if( !is_oob_button_hit() ) )        self factory_button(); // Hit oob button.

    Step 2 - Hide And Seek
    Hit the 3 targets around the map (let player choose if he wants to pickup annihilator).
    if( !factory_all_targets_hit() )    self factory_hns();    // Hit 3 EE targets (let player grab annihilator)

    ______________________________________________________________________________________________
*/


function factory_gsc_ee_init(){

    // EE
    level add_autocomplete_step( "button", ::factory_button );  // Oob button
    level add_autocomplete_step( "hns", ::factory_hns );        // Hit all targets

    // Hide And Seek
    level add_autocomplete_step( "em", ::hit_exp_monkey );      // Hit Exp Monkey
    level add_autocomplete_step( "bb", ::hit_bowie_bear );      // Hit Bowie Bear
    level add_autocomplete_step( "pb", ::hit_perk_bear );       // Hit Perk Bear

    // Wait for targets to be ready
    level add_autocomplete_step( "whns", ::wait_for_hide_and_seek );      // Wait for Hide And Seek
}


// Shoot the button out of the map with an upgraded weapon
function factory_button(){

    step_name = "^5Button";

    if( is_oob_button_hit() ){ // Step already completed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }
    
    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();

    
    // Hit oob button
    hit_oob_button();


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}

// Hit the 3 targets around the map
function factory_hns(){

    step_name = "^5Hide and Seek";

    if( factory_all_targets_hit() ){ // Step already completed
        self iPrintLnBold( step_name+text_already_completed() );
        return;
    }

    // Check step 1
    if( !is_oob_button_hit() )  self factory_button();

    // Avoids having 2 autocomplete functions
    ee_autocomplete_start();


    // Wait for targets to be ready
    wait_for_hide_and_seek();

    hit_exp_monkey();   // Monkey on furnace
    hit_bowie_bear();   // Bear on water tank
    hit_perk_bear();    // Bear on catwalk

    // Don't grab annihilator, let the player do it
    //getent( "flytrap_prize", "targetname" ) notify( "trigger", self );


    // Avoids having 2 autocomplete functions
    ee_autocomplete_end( step_name+text_completed() );
}


// For save state func
function factory_get_ee_steps(){

    ee_functions = [];

    // Everything is completed
    if( factory_all_targets_hit() ){

        ArrayInsert( ee_functions, "hns", ee_functions.size );
        return ee_functions;
    }

    // Button is shot
    if( is_oob_button_hit() ){

        ArrayInsert( ee_functions, "button", ee_functions.size ); // Shoot oob button

        // If any target is hit then we have already waited for Hide And Seek to be ready
        if( factory_any_target_hit() ){

            ArrayInsert( ee_functions, "whns", ee_functions.size ); // Wait for targets to be ready

            if( is_exp_monkey_hit() ) ArrayInsert( ee_functions, "em", ee_functions.size ); // Monkey on furnace
            if( is_bowie_bear_hit() ) ArrayInsert( ee_functions, "bb", ee_functions.size ); // Bear on water tank
            if( is_perk_bear_hit() )  ArrayInsert( ee_functions, "pb", ee_functions.size ); // Bear on catwalk

        }else if( is_hide_and_seek_ready() ){

            ArrayInsert( ee_functions, "whns", ee_functions.size ); // Wait for targets to be ready
        }

        return ee_functions;
    }

    // Easter Egg has not been started
    return ee_functions;
}