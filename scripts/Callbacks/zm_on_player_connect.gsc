function zm_on_player_connect(){
    self endon("disconnect");

    // No bots
    if( self IsTestClient() ) return;

    // Update the Gum Category of the game to show at the end
    if( !isdefined( level.gum_category ) || ( level.gum_category != CATEGORY_ANY_GUM ) ) self thread track_gum_category();

    // Avoid game taking BGB tokens from players
    if( !USING_MODS ) self thread avoid_bgb_use();

    // Set hook to apply weapon settings
    if( is_any_weapon_setting_enabled() ){
        // Wallbuys ammo buy
        self.check_override_wallbuy_purchase = ::surtr_check_override_wallbuy_purchase;
    }

}