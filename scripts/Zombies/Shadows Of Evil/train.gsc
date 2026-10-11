
/*  Expected values

    destination:
        #define TRAIN_CANALS = "canal";
        #define TRAIN_FOOTLIGHT = "theater";
        #define TRAIN_WATERFRONT = "slums";
    
    left_path:
        true;
        false;
*/

function patch_train( destination = "canal", left_path = true ){

    while( !isdefined( level.o_zod_train ) ) wait 0.05;
    while( !isdefined( level.o_zod_train.m_str_destination ) ) wait 0.05;
    wait 0.05; // Just in case to avoid race condition

    level.o_zod_train.m_str_station = destination;
    level.o_zod_train.m_str_closest_station = destination;
    level.o_zod_train.m_a_s_stations[ destination ].b_left_path_active = left_path;


    // Currently Classes are not supported in Serious T7 Compiler
    level.o_zod_train.m_str_destination = get_current_destination();
    
    // If your compiler supports classes, you can use the original class function:
    //[[ level.o_zod_train ]]->get_current_destination();

    level.o_zod_train.m_vh_train attachpath( level.o_zod_train.m_a_s_stations[ destination ].start_node );
}
