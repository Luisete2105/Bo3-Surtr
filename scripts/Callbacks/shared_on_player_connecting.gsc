function shared_on_player_connecting(){
    self endon("disconnect");

    // No bots
    if( self IsTestClient() ) return;

    #ifdef dev
        //self.characterindex = 3;
    #endif

    self thread init_livesplit();
}