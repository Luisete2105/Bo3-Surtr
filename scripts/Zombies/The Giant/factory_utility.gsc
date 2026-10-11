// Check flags
function is_exp_monkey_hit(){
    return level flag::get( "ee_exp_monkey" );
}

function is_bowie_bear_hit(){
    return level flag::get( "ee_bowie_bear" );
}

function is_perk_bear_hit(){
    return level flag::get( "ee_perk_bear" );
}

function factory_all_targets_hit(){
    return is_exp_monkey_hit() && is_bowie_bear_hit() && is_perk_bear_hit();
}

function factory_any_target_hit(){
    return is_exp_monkey_hit() || is_bowie_bear_hit() || is_perk_bear_hit();
}

function is_oob_button_hit(){
    return level flag::get( "flytrap" ) || level flag::get( "hide_and_seek" );
}

function factory_wait_fly_trap(){

    level waittill( "flytrap" );
}

function is_hide_and_seek_ready(){
    return level flag::get( "hide_and_seek" );
}

function factory_wait_paradoxical_prologue(){
    
    while( !isdefined( level.main_ee_quest_factory_awarded ) ) wait 0.05;

    SetDvar( DVAR_LIVESPLIT_PAUSED, "1"); // Last split, user may be playing a Super EE
}

function is_factory_ee_complete(){
    return isdefined( level.main_ee_quest_factory_awarded );
}

function factory_is_east_door_opened(){
    return level flag::get( "enter_outside_east" );
}

function factory_wait_east_door_opened(){
    while( !factory_is_east_door_opened() ) wait 0.05;
}

// Hit ee targets
function hit_exp_monkey(){

    if( !is_hide_and_seek_ready() ){
        self IPrintLnBold( "^5EE Targets ^1must be ready to hit..." );
        return;
    }

    if( is_exp_monkey_hit() ){
        self IPrintLnBold( "^5Exp Monkey ^2already hit!" );
        return;
    }

    setdvar(DVAR_TIMESCALE, "10");

    wait 0.05;
    GetEnt( "trig_ee_exp_monkey", "targetname" ) notify( "trigger" );
    
    setdvar(DVAR_TIMESCALE, "1");
}

function hit_bowie_bear(){

    if( !is_hide_and_seek_ready() ){
        self IPrintLnBold( "^5EE Targets ^1must be ready to hit..." );
        return;
    }

    if( is_bowie_bear_hit() ){
        self IPrintLnBold( "^5Bowie Bear ^2already hit!" );
        return;
    }

    setdvar(DVAR_TIMESCALE, "10");

    wait 0.05;
    GetEnt( "trig_ee_bowie_bear", "targetname" ) notify( "trigger" );

    setdvar(DVAR_TIMESCALE, "1");
}

function hit_perk_bear(){

    if( !is_hide_and_seek_ready() ){
        self IPrintLnBold( "^5EE Targets ^1must be ready to hit..." );
        return;
    }

    if( is_perk_bear_hit() ){
        self IPrintLnBold( "^5Perk Bear ^2already hit!" );
        return;
    }

    setdvar(DVAR_TIMESCALE, "10");

    wait 0.05;
    GetEnt( "trig_ee_perk_bear", "targetname" ) notify( "trigger" );

    setdvar(DVAR_TIMESCALE, "1");
}

function hit_oob_button(){
    getent( "trig_ee_flytrap", "targetname" ) notify( "damage", 7, self, self getPlayerAngles(), self getOrigin(), undefined, undefined, undefined, undefined, getweapon( "tesla_gun_upgraded" ) );
}


// Wait funcs
function wait_for_hide_and_seek(){

    wait 0.05;

    if( !is_oob_button_hit() ){
        self IPrintLnBold( "^5Oob Button ^1must be hit..." );
        return;
    }

    step_name = "^5Wait Hide and Seek";

    if( is_hide_and_seek_ready() ){
        self IPrintLnBold( step_name+text_already_completed() );
        return;
    }

    ee_autocomplete_start();
    
    level wait_till( "hide_and_seek" );
    wait 0.05;

    ee_autocomplete_end( step_name+text_completed() );
}