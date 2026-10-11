function shared_on_player_disconnect(){

    // We need to save the XUID as soon as we can and store it, otherwise we are not able to get it when the player is fully disconnected
    _xuid = MY_XUID;

    // Make the currently toggled commands empty, if the player reconnects, they will be toggled again
    ArrayRemoveIndex(level.toggles, _xuid);

    // Destroy this player's specific client hud elems that were created for him
    level thread remove_active_player_huds( _xuid );
}