function hook_ephemeral_enhancement_activation(){

    while( !isdefined( level.bgb ) ) wait 0.05;
    while( !isdefined( level.bgb[ "zm_bgb_ephemeral_enhancement" ] ) ) wait 0.05;
    while( !isdefined( level.bgb[ "zm_bgb_ephemeral_enhancement" ].activation_func ) ) wait 0.05;

    #ifdef dev
        //level thread debug_message( "hook_ephemeral_enhancement_activation ^2completed" );
    #endif
    
    level.bgb[ "zm_bgb_ephemeral_enhancement" ].old_activation_func = level.bgb[ "zm_bgb_ephemeral_enhancement" ].activation_func;
    level.bgb[ "zm_bgb_ephemeral_enhancement" ].activation_func = ::surtr_ephemeral_enhancement_activation;
}

function surtr_ephemeral_enhancement_activation(){
    self endon("disconnect");
    self endon("death");
    self endon("bled_out");
    self endon("replaced_upgraded_weapon");

    //self IPrintLnBold("Ephemeral ^2Start!");
    self thread ephemeral_enhancement_weapon_settings();
    self [[ level.bgb[ "zm_bgb_ephemeral_enhancement" ].old_activation_func ]]();
    self notify( "ephemeral_enhancement_ended" );
    //self IPrintLnBold("Ephemeral ^1End...");
}

function ephemeral_enhancement_weapon_settings(){
    self endon("disconnect");
    self endon("death");
    self endon("bled_out");
    self endon("replaced_upgraded_weapon");

    // Wait for no PAPed weapon
    while( !isdefined( self.var_fb11234e ) ) wait 0.05;
    w_orig_weapon = self.var_fb11234e;

    // Maybe player is using an Alt weapon
    w_orig_nonalt = get_nonalternate_weapon( w_orig_weapon );

    // Wait for new PAPed weapon
    while( !self HasWeapon(level.zombie_weapons[ w_orig_nonalt.rootweapon ].upgrade, true) ) wait 0.05;
    w_paped = level.zombie_weapons[ w_orig_nonalt.rootweapon ].upgrade;

    // Find Weapon PAPed by Ephemeral Enhancement
    foreach(weapon in self GetWeaponsListPrimaries()){
        if( weapon.rootweapon != w_paped ) continue;
        //self IPrintLnBold("PAPed weapon: "+weapon.name);
        break;
    }

    weapon = get_nonalternate_weapon( weapon );

    // Swap the upgraded weapon with the one with our settings
    self thread apply_weapon_settings( weapon );

    self waittill( "ephemeral_enhancement_ended" );

    w_current = get_nonalternate_weapon ( self GetCurrentWeapon() );

    // Applying weapon settings forces a weapon switch, if we end Ephemeral without the original weapon, we must switch back to the current one
    //b_switch = ( w_current.rootweapon != w_orig_weapon.rootweapon );
    b_switch = ( w_current.rootweapon != w_paped.rootweapon );

    #ifdef dev
        self IPrintLnBold("Should Switch? "+b_switch);
        self IPrintLnBold("w_current "+w_current.rootweapon.name);
        //self IPrintLnBold("w_orig_weapon "+w_orig_weapon.rootweapon.name);
        self IPrintLnBold("w_orig_nonalt "+w_orig_nonalt.rootweapon.name);
    #endif

    foreach(weapon in self GetWeaponsListPrimaries()){
        if( weapon.rootweapon != w_orig_nonalt.rootweapon ) continue;
        #ifdef dev
            self IPrintLnBold("Returned weapon: "+weapon.name);
        #endif
        break;
    }

    ammo_stock = self GetWeaponAmmoStock( weapon );
    ammo_clip = self GetWeaponAmmoClip( weapon );

    // We need to wait a little bit, otherwise it will glitchout. We don't wait a full frame because that would change to the Game's buildkit data weapon instead of our version
    waittillframeend;

    //self thread apply_weapon_settings( weapon.rootweapon );
    self thread apply_weapon_settings( weapon, ammo_stock, ammo_clip );

    #ifdef dev
        level thread debug_message("ephemeral_enhancement_weapon_settings, Stock ammo: "+ammo_stock+", Clip ammo: "+ammo_clip);
    #endif

    //self apply_weapon_settings( weapon, ammo_stock, ammo_clip );
    if( b_switch ) self SwitchToWeaponImmediate( w_current );
}