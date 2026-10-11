function shared_init()
{
    #ifdef dev
        //level thread log_menu_responses();
        //level thread debug_flags();
    #endif

    // Allow Livesplit autosplits
	setdvar( DVAR_SV_CHEATS, "1" ); // Maybe the user loaded a mod and disabled it again

    // Set the autosplit state for this game
    if( GetDvarInt(DVAR_AUTOSPLITS) ) level.autosplits = true;

    // Init toggle commands data
    level.toggles = [];

    // Practice watermark
    level thread check_for_practice_mode();

    // Refresh HUDs after pause or RTA change
    level thread refresh_huds_on_game_pause();

    // Init Global HuD data
    level thread init_global_huds();

    // If we are using a mod, then mod console should be usable for Surtr console mod
    if( USING_MODS ) level thread Surtr_modvar();

    // Load a set of commands for the first time
    if( isdefined( world.initial_shared_commands ) ) level thread execute_initial_shared_commands();
}