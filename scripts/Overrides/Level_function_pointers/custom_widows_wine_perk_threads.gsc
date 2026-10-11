// level thread [[level.custom_widows_wine_perk_threads]]();

function hook_custom_widows_wine_perk_threads(){
    wait_for_game_start();
    level widows_wine_enable_disable_hooks();
}

function widows_wine_enable_disable_hooks(){

    // There are no perks on the level or there is no Widows Wine
    if( !isdefined( level._custom_perks ) || !isdefined( level._custom_perks["specialty_widowswine"] ) ) return;

    level.old_widows_player_thread_give = level._custom_perks["specialty_widowswine"].player_thread_give;
    level._custom_perks["specialty_widowswine"].player_thread_give = ::surtr_widows_player_thread_give;
    level.old_widows_player_thread_take = level._custom_perks["specialty_widowswine"].player_thread_take;
    level._custom_perks["specialty_widowswine"].player_thread_take = ::surtr_widows_player_thread_take;

    //level thread debug_message("widows_wine_enable_disable_hooks");
}

function surtr_widows_player_thread_give(){
    self endon("disconnect");

    self [[ level.old_widows_player_thread_give ]]();

    // Widows give function sets a function pointer
    self.old_check_override_wallbuy_purchase = self.check_override_wallbuy_purchase;
    self.check_override_wallbuy_purchase = ::surtr_check_override_wallbuy_purchase;
}

function surtr_widows_player_thread_take(){
    self endon("disconnect");
    
    self [[ level.old_widows_player_thread_take ]]();

    // Widows take function removes function pointer
    self.old_check_override_wallbuy_purchase = undefined;
    self.check_override_wallbuy_purchase = ::surtr_check_override_wallbuy_purchase;
}