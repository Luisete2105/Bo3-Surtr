/*  Expected values

    n_zone:
        #define BEASTCODE_CANALS = 0; // Canals
        #define BEASTCODE_FOOTLIGHT = 1; // Footlight
        #define BEASTCODE_WATERFRONT = 2; // Waterfront
    
    n_code:
        any number from 0 to 9
*/

function zod_code_change( n_zone = 0, n_code = 0 ){

    n_code--;
    if( n_code < 0 ) n_code = 0;
    else if( n_code > 8 ) n_code = 8;

    if( n_zone < 0 ) n_zone = 0;
    else if( n_zone > 2 ) n_zone = 2;

    while( !isdefined( level.o_canal_beastcode ) ) wait 0.05;
    while( !isdefined( level.o_canal_beastcode.m_a_mdl_clues ) ) wait 0.05;
    while( !isdefined( level.o_canal_beastcode.m_a_mdl_clues[0] ) ) wait 0.05;
    while( !isdefined( level.o_canal_beastcode.m_a_mdl_clues[0].size < 3 ) ) wait 0.05;

    level.o_canal_beastcode.m_a_codes[0][n_zone] = n_code;

    #ifdef dev
        for( i = 0; i< level.o_canal_beastcode.m_a_codes[0].size; i++){
            level.host IPrintLnBold( "Code ^5"+(i+1)+" ^7: ^2"+(level.o_canal_beastcode.m_a_codes[0][i]+1) );
        }
    #endif

    for( i=0; i<level.o_canal_beastcode.m_a_mdl_clues[0].size; i++){
        mdl_clue_number = level.o_canal_beastcode.m_a_mdl_clues[0][i];
        for(j = 0; j < 10; j++)
        {
            mdl_clue_number hidepart("J_" + j);
            mdl_clue_number hidepart("p7_zm_zod_keepers_code_0" + j);
        }
        mdl_clue_number showpart("p7_zm_zod_keepers_code_0" + level.o_canal_beastcode.m_a_codes[0][i]);
    }
}