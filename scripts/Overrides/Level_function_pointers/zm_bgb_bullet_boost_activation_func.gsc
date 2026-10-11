function hook_bullet_boost_activation(){

    while( !isdefined( level.bgb ) ) wait 0.05;
    while( !isdefined( level.bgb[ "zm_bgb_bullet_boost" ] ) ) wait 0.05;
    while( !isdefined( level.bgb[ "zm_bgb_bullet_boost" ].activation_func ) ) wait 0.05;

    #ifdef dev
        //level thread debug_message( "hook_bullet_boost_activation ^2completed" );
    #endif

    level.bgb[ "zm_bgb_bullet_boost" ].old_activation_func = level.bgb[ "zm_bgb_bullet_boost" ].activation_func;
    level.bgb[ "zm_bgb_bullet_boost" ].activation_func = ::surtr_bullet_boost_activation;
}

function surtr_bullet_boost_activation(){
    self endon("disconnect");
    self endon("death");

    // Run original function
    self [[ level.bgb[ "zm_bgb_bullet_boost" ].old_activation_func ]]();
    // Now update AAT

    // Current weapon is the one updated
    w_current = self GetCurrentWeapon();

    // Get the buildkit weapon to update
    base_weapon = get_buildkit_Weapon( w_current );

    // Get the new AAT
    str_aat_weapon = self get_aat_for_weapon( w_current );
    if( !isdefined( str_aat_weapon ) ){
        level thread debug_message("^1Error, couldn't find new bullet boost ^5AAT");
        return;
    }

    #ifdef dev
        self IPrintLnBold("Bullet Boost AAT:^5 "+str_aat_weapon);
    #endif

    // Update base weapon
    self acquire( base_weapon, str_aat_weapon );

    // Update AAT HUD if needed
    w_noalt = get_nonalternate_weapon( w_current );
    
    // Only need to update if we are using an alt version of the weapon
    if( w_noalt != w_current ) self clientfield::set_to_player( "aat_current", level.aat[ self.aat[ w_noalt ] ].clientfield_index );
}