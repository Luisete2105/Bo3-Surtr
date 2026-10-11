function zm_init()
{

    // TODO: Make a command to Force Full Easter Egg
    if( GetDvarInt( DVAR_FORCE_FULL_EASTER_EGG ) ) level.force_full_easter_egg = true;

    // Set the autosplit state for this game
    if( GetDvarInt( DVAR_SPLIT_ROUNDS) ) level.split_rounds = true;

    // Autoexecs should have already ran
    level thread miscellaneous_zombie_fixes();

    // Weapon settings
    if( is_any_weapon_setting_enabled() ){
        // Wallbuys weapon buy
        level thread hook_zombiemode_offhand_weapon_give_override();
        // Pap
        level thread pap_apply_weapon_settings();
        // Ephemeral Enhancement
        level thread hook_ephemeral_enhancement_activation();
        // Bullet Boost
        level thread hook_bullet_boost_activation();
        // Wallbuys ammo buy
        level thread hook_custom_widows_wine_perk_threads();
    }

     #ifdef dev
        //level thread gsc_open_all();
        //SetDvar(DVAR_ZM_PRIVATE_RANKEDMATCH, true);

        // Print Z spawn times
        //level thread print_zombie_spawns_times();
        level thread avoid_initial_blackscreen();
    #endif

    // Show used HUDs
    level.custom_end_screen = ::print_mods_huds_usage;

    // Between rounds check
    level thread monitor_between_rounds();

    switch( MAP_NAME ){
        case "zm_zod":
        {
            #ifdef dev
            
                /* ZOD TRAIN DEFINES

                    Zones
                        TRAIN_CANALS
                        TRAIN_FOOTLIGHT
                        TRAIN_WATERFRONT

                    TURN DIRECTION
                        TRAIN_LEFT
                        TRAIN_RIGHT
                */

                // Patch Train to go from Waterfront to Canals
                level thread patch_train( TRAIN_WATERFRONT, TRAIN_LEFT );

                /*  ZOD

                    Zones
                        BEASTCODE_CANALS
                        BEASTCODE_FOOTLIGHT
                        BEASTCODE_WATERFRONT
                    
                    Code
                        any number from 0 to 9
                */

                // Patch the code to 777 on Practice mode
                level thread zod_code_change( BEASTCODE_CANALS, 7 );
                level thread zod_code_change( BEASTCODE_FOOTLIGHT, 7 );
                level thread zod_code_change( BEASTCODE_WATERFRONT, 7 );

            #endif
            break;      
        }
        case "zm_castle":
        {
            // Force DE Ranked bow behaviour
            if( GetDvarInt(DVAR_DE_EE_RANKED) && !getdvarint( "zm_private_rankedmatch" ) ) level.de_ee_ranked = true;

            #ifdef dev
                level thread print_notifications( array( "start_channeling_stone_step" ) );
            #endif

            break;
        }
        case "zm_stalingrad":
        {
            #ifdef dev
                level thread print_notifications( array( "dragon_boss_start", "dragon_boss_vignette", "dragon_boss_vignette_ready", "dragon_boss_intro_init", "dragon_boss_init", "nikolai_start" ) );
            #endif
            break;
        }
        case "zm_genesis":
        {
            break;
        }
        case "zm_temple":
        {
            #ifdef dev

                level thread print_notifications( array( "stage_starting", // EE logic functions
                "sq_oafc_completed", "sq_dgcwf_completed", // Steps completed
                "raise_crystal_1", "raise_crystal_2", "raise_crystal_3", "raise_crystal_4", "raise_crystal_5", "raise_crystal_6", // Raise crystals
                "raised_crystal_1", "raised_crystal_2", "raised_crystal_3", "raised_crystal_4", "raised_crystal_5", "raised_crystal_6", // Raised crystals
                "sq_dgcwf_start", "dgcwf_start",  // Steps started
                "temple_sidequest_achieved" ) ); // Full EE completed

            #endif
        }
    }

    // Load a set of commands for the first time
    if( isdefined( world.initial_zm_commands ) ) level thread execute_initial_zm_commands();
}