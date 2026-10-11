function livesplit( state = LIVESPLIT_NONE ){


    if( IsPlayer( self ) ){
        while( isdefined( self.splitting ) ) wait 0.05;

        self.splitting = true;
        self SetClientThirdPersonAngle( state );
        #ifdef dev
            //level thread debug_message_instant( "SPLIT ^5"+self.name+" ^2"+state );
        #endif

        wait 0.2;
        self SetClientThirdPersonAngle( LIVESPLIT_NONE );
        self.splitting = undefined;
    }
    else{
        foreach( player in GetPlayers() ){
            while( isdefined( player.splitting ) ) wait 0.05;

            player.splitting = true;
            player SetClientThirdPersonAngle( state );
        }
        #ifdef dev
            //level thread debug_message_instant( "SPLIT ^5ALL PLAYERS ^2"+state );
        #endif

        wait 0.2;

        foreach( player in GetPlayers() ){

            player SetClientThirdPersonAngle( LIVESPLIT_NONE );
            player.splitting = undefined;
        }
    }

}

function init_livesplit(){
    level endon( "game_ended" );
    self endon("disconnect");

    // Gameplay already started
    if( has_game_started() ){ // Maybe we are playing Any% and we are using a disconnect strat?
        self livesplit( LIVESPLIT_START ); // Start just in case player has bad connection and joined late into the game
        return;
    }

    // Match hasn't started yet
    /*self livesplit( LIVESPLIT_RESET );

    wait_for_game_start();
    self livesplit( LIVESPLIT_START );*/

    // I don't know yet how to make sure the game has reset client Dvars

    if( !GetDvarInt( DVAR_LIVESPLIT_PAUSED ) ){

        // Game resets the livesplit at some point, I don't know how to properly detect it so just force it until game start
        while( !has_game_started() ){
            wait 0.05;
            self livesplit( LIVESPLIT_RESET );
        }
    }

    // Gameplay just started
    self livesplit( LIVESPLIT_START );
}