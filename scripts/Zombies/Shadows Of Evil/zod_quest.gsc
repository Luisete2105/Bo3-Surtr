function zod_wait_for_rift_tp_enter(){

    for(;;){
        wait 0.05;

        // End when a player gets in a portal
        foreach(player in GetPlayers()) if( isdefined(player.teleporting ) ) return;
    }
}

function zod_wait_for_archovum_start(){

    level waittill( "ritual_pap_complete" );

    for(;;){
        wait 0.05;

        // Wait for Arch Ovum keeper state
        for(i=0;i<4;i++) if( level clientfield::get( "keeper_quest_state_"+i ) == 2 ) return;
    }
}

function zod_wait_for_flag_start(){

    level waittill( "ee_book" );

    for(;;){
        wait 0.05;

        // End when a player gets in a portal
        foreach(player in GetPlayers()) if( isdefined(player.mdl_ee_totem ) ) return;
    }
}

function zod_wait_for_shadowman_defeated(){

    level waittill( "ee_boss_defeated" );

    // EE is not fully completed
    if( GetPlayers().size == 4 || ( isdefined( level.b_ee_cheat_on ) && level.b_ee_cheat_onlevel.b_ee_cheat_on ) ) return;

    SetDvar( DVAR_LIVESPLIT_PAUSED, "1"); // Last split, user may be playing a Super EE
}

function zod_wait_for_apothicon_defeated(){

    level waittill( "cin_zod_vign_summoning_key_playing" );

    SetDvar( DVAR_LIVESPLIT_PAUSED, "1"); // Last split, user may be playing a Super EE
}
