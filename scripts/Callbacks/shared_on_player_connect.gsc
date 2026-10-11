function shared_on_player_connect()
{
    self endon("disconnect");

    // No bots
    if( self IsTestClient() ) return;

    if( self IsHost() ) level.host = self;

    // Init player HuD data
    self thread init_player_huds();

    // Run saved toggle commands
    self thread init_player_toggles();

    // Fix for T7x and Boiii
    if( IS_CUSTOM_CLIENT ) self thread fix_game_client_connect();

    #ifdef dev
        if( isdefined( level.first_surtr_load ) ){

            // Wait for commands to be fully registered
            while( !isdefined( level.commands_register_completed ) ) wait 0.05;

            self thread execute_command( "god" );
            self thread execute_command( "no_clip" );
            self thread execute_command( "no_target" );
            //self thread execute_command( "hud xuid" );

            //self.laststandpistol = "manolo"; // I saw that it changed something but I don't know what it is anymore
            //self thread log_menu_responses();
            //self thread check_shoot(); // Silly weapon bullet
        }


        wait_for_game_start();
        self thread execute_command( "score 7777777" );
    #endif
}