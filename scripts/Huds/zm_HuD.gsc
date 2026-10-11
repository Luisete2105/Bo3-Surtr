function register_zm_huds(){

    // Match data
    #ifdef dev
        register_hud( "ZM_Private_Ranked_Match", array("ZMPrivateRankedMatch", "ZMRanked"), HUD_DEFAULT_VISIBILITY, ::zm_private_ranked_match, "ZM Private Ranked Match: ^1", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
    #endif

    // Player data
    #ifdef dev
        register_hud( "Gum_1", array( "Bgb_1", "Gum1", "Bgb1" ), HUD_DEFAULT_VISIBILITY, ::gum_1, "Gum 1: ^1", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
        register_hud( "Gum_2", array( "Bgb_2", "Gum2", "Bgb2" ), HUD_DEFAULT_VISIBILITY, ::gum_2, "Gum 2: ^1", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
        register_hud( "Gum_3", array( "Bgb_3", "Gum3", "Bgb3" ), HUD_DEFAULT_VISIBILITY, ::gum_3, "Gum 3: ^1", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
        register_hud( "Gum_4", array( "Bgb_4", "Gum4", "Bgb4" ), HUD_DEFAULT_VISIBILITY, ::gum_4, "Gum 4: ^1", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
        register_hud( "Gum_5", array( "Bgb_5", "Gum5", "Bgb5" ), HUD_DEFAULT_VISIBILITY, ::gum_5, "Gum 5: ^1", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
    #endif


    // Zombie Timers
    register_hud( "Seconds_Per_Horde", array("SPH"), HUD_DEFAULT_VISIBILITY, ::sph_update, "Seconds Per Horde: ^5", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
    register_hud( "Round_Time", array("RoundTime", "RT", "Round_Timer", "RoundTimer"), HUD_DEFAULT_VISIBILITY, ::round_timer_update, "Round Time: ^5", GLOBAL_HUD, ALL_MAPS, ALLOWED );
    // TODO: not accurate for ZNS
    register_hud( "Zombie_Cleanup", array("ZombieCleanup", "ZC", "Zombie_Despawn", "ZombieDespawn", "ZD"), HUD_DEFAULT_VISIBILITY, ::zcleanup_update, "Cleanup in: ^8", GLOBAL_HUD, ALL_MAPS, ALLOWED );


    // Zombie Counters
    register_hud( "Zombies_Alive", array("ZombiesAlive", "ZAlive"), HUD_DEFAULT_VISIBILITY, ::zalive_update, "Z Alive: ^1", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
    register_hud( "Zombies_Respawn", array("ZombiesRespawn", "ZRespawn"), HUD_DEFAULT_VISIBILITY, ::zrespawn_update, "Z Respawn: ^3", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );
    register_hud( "Zombies_Spawn", array("ZombiesSpawn", "ZSpawn"), HUD_DEFAULT_VISIBILITY, ::zspawn_update, "Z Spawn: ^3", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );

    // Spawn locations
    register_hud( "Zombies_Locations", array("ZombiesLocations", "ZLocations"), HUD_DEFAULT_VISIBILITY, ::zloc_update, "Z Locations: ^8", GLOBAL_HUD, ALL_MAPS, CHEAT_PROTECTED );

    // Player HuDs
    register_hud( "Out_Of_Bounds_Check", array("OutOfBoundsCheck", "OOBC", "Out_Of_Bounds", "OutOfBounds", "OOB"), HUD_DEFAULT_VISIBILITY, ::oobc_update, "Out Of Bounds Check: ^5", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );
    register_hud( "Player_Zone", array("PlayerZone", "Zone_Name", "ZoneName", "Zone"), HUD_DEFAULT_VISIBILITY, ::zone_update, "Zone: ^5", PLAYER_HUD, ALL_MAPS, CHEAT_PROTECTED );


    // PAP TODO: just add the map has pap check inside the update function and make an early return setting a text saying there is no pap
    if( current_map_has_pap() ){
        level thread check_for_pap_use();
        //register_split( "First_PAP", array("FirstPAP", "PAP"), "First PAP: ^5", MAP_NAME, GENERAL_SPLIT, ::wait_first_paped_weapon);
        register_split( "First_PAP", array("FirstPAP", "PAP"), "First PAP: ^5", ALL_MAPS, GENERAL_SPLIT, ::wait_first_paped_weapon);
    }

    // Shadows of Evil
        register_split( "Rift_TP", array("RiftTP", "Rift"),"Rift TP: ^2", SHADOWS_OF_EVIL, EE_SPLIT, ::zod_wait_for_rift_tp_enter);
        register_split( "Arch-Ovum", array("Arch_Ovum", "ArchOvum", "AO", "Egg_Upgrade", "EggUpgrade", "EU"),"Arch-Ovum: ^2", SHADOWS_OF_EVIL, EE_SPLIT, ::zod_wait_for_archovum_start);   
        register_split( "Flag_Start", array("FlagStart", "FS", "Flag"),"Flag Start: ^2", SHADOWS_OF_EVIL, EE_SPLIT, ::zod_wait_for_flag_start);
        register_split( "Shadowman_Trapped", array("ShadowmanTrapped", "SD"),"Shadowman Trapped: ^2", SHADOWS_OF_EVIL, EE_SPLIT, ::zod_wait_for_shadowman_defeated);  
        register_split( "Apocalypse_Averted", array("ApocalypseAverted", "AA", "Apothicon_Defeated", "ApothiconDefeated", "AD"),"Apocalypse Averted: ^2", SHADOWS_OF_EVIL, EE_SPLIT, ::zod_wait_for_apothicon_defeated);

        // Debugging for ScottyDogs
        register_hud( "Ritual", array("Defend_Area", "DefendArea"), HUD_DEFAULT_VISIBILITY, ::ritual_update, "Ritual: ^5", PLAYER_HUD, SHADOWS_OF_EVIL, CHEAT_PROTECTED );

    // The Giant
        register_split( "Fly_Trap", array("FlyTrap", "FT"), "Fly Trap: ^2", THE_GIANT, EE_SPLIT, ::factory_wait_fly_trap);
        register_split( "Paradoxical_Prologue", array( "ParadoxicalPrologue", "PP", "Hide_And_Seek", "HideAndSeek", "HAS", "HnS", "Hide_Seek", "HideSeek", "HS"), "Paradoxical Prologue: ^2", THE_GIANT, EE_SPLIT, ::factory_wait_paradoxical_prologue);

    // Der Eisendrache
        register_split( "Dragons_Fed", array("DragonsFed", "Dragons"), "Dragons Fed: ^2", DER_EISENDRACHE, EE_SPLIT, ::castle_wait_for_dragons_fed);
        register_split( "Time_Travel", array("TimeTravel", "TT"), "Time Travel: ^2", DER_EISENDRACHE, EE_SPLIT, ::castle_wait_for_time_travel);
        register_split( "Keeper_Summoned", array("KeeperSummoned", "KS"), "Keeper Summoned: ^2", DER_EISENDRACHE, EE_SPLIT, ::castle_wait_for_keeper_intro);
        register_split( "Keeper_Boss", array("KeeperBoss", "KB"), "Keeper Boss: ^2", DER_EISENDRACHE, EE_SPLIT, ::castle_wait_bossfight_begin);
        register_split( "My_Brothers_Keeper", array("MyBrothersKeeper", "MBK"), "My Brother's Keeper: ^2", DER_EISENDRACHE, EE_SPLIT, ::castle_wait_my_brothers_keeper);

        // Practice
        register_hud( "Keeper_Souls", array("KeeperSouls"), HUD_DEFAULT_VISIBILITY, ::Keeper_Souls, "Keeper Souls: ^5", GLOBAL_HUD, DER_EISENDRACHE, CHEAT_PROTECTED );

        // Debugging
        register_hud( "Box_Code", array("BoxCode"), HUD_DEFAULT_VISIBILITY, ::castle_box_code, "Box Code: ^5", GLOBAL_HUD, DER_EISENDRACHE, CHEAT_PROTECTED );


        #ifdef dev
            register_hud( "All_Bows_Required", array("AllBowsRequired"), HUD_DEFAULT_VISIBILITY, ::all_bows_required, "All Bows Required: ^5", GLOBAL_HUD, DER_EISENDRACHE, CHEAT_PROTECTED );
        #endif

    // Zetsubou No Shima
        register_split( "Bunker_Opened", array("BunkerOpened", "Bunker", "BO"),"Bunker Open: ^2", ZETSUBOU_NO_SHIMA, EE_SPLIT, ::island_wait_for_bunker_open);
        register_split( "Skull_Ritual", array("SkullRitual", "Skull"),"Skull Ritual: ^2", ZETSUBOU_NO_SHIMA, EE_SPLIT, ::island_wait_for_skull_ritual_completed);
        register_split( "Rainbow_Plant", array("RainbowPlant", "Plant", "RP"),"Rainbow Plant: ^2", ZETSUBOU_NO_SHIMA, EE_SPLIT, ::island_wait_for_rainbow_plant);
        register_split( "Elevator_Repaired", array("ElevatorRepaired", "Elevator", "ER"),"Elevator Repaired: ^2", ZETSUBOU_NO_SHIMA, EE_SPLIT, ::island_wait_for_elevator_repairs);
        register_split( "Seeds_Of_Doubt", array( "SeedsOfDoubt", "SOD", "TakeoDefeated", "Takeo", "TD"),"Seeds of Doubt: ^2", ZETSUBOU_NO_SHIMA, EE_SPLIT, ::island_wait_for_takeo_fight_ended);

    // Gorod Krovi
        register_split( "Fly_1", array("Fly1"),"Fly 1: ^2", GOROD_KROVI, EE_SPLIT, ::stalingrad_fly1_completed);
        register_split( "Fly_2", array("Fly2"),"Fly 2: ^2", GOROD_KROVI, EE_SPLIT, ::stalingrad_fly2_completed);   
        register_split( "Fly_3", array("Fly3"),"Fly 3: ^2", GOROD_KROVI, EE_SPLIT, ::stalingrad_fly3_completed);
        register_split( "Challenges", array("Challs", "Chall"),"Challenges: ^2", GOROD_KROVI, EE_SPLIT, ::stalingrad_challenges_started);  
        register_split( "Download", array("Dl"),"Download: ^2", GOROD_KROVI, EE_SPLIT, ::stalingrad_download_started);
        register_split( "Love_And_War", array("LoveAndWar", "LAW", "Nikolay_Defeated", "NikolayDefeated", "Niko"),"Love And War: ^2", GOROD_KROVI, EE_SPLIT, ::stalingrad_nikolai_defeated);

        // Practice
        register_hud( "Terminal_Armory", array("TerminalArmory", "Armory"), HUD_DEFAULT_VISIBILITY, ::stalingrad_terminal_armory, "Armory: ^5", GLOBAL_HUD, GOROD_KROVI, CHEAT_PROTECTED );
        register_hud( "Terminal_Barracks", array("TerminalBarracks", "Barracks"), HUD_DEFAULT_VISIBILITY, ::stalingrad_terminal_barracks, "Barracks: ^5", GLOBAL_HUD, GOROD_KROVI, CHEAT_PROTECTED );
        register_hud( "Terminal_Command", array("TerminalCommand", "Command"), HUD_DEFAULT_VISIBILITY, ::stalingrad_terminal_command, "Command: ^5", GLOBAL_HUD, GOROD_KROVI, CHEAT_PROTECTED );
        register_hud( "Terminal_Factory", array("TerminalFactory", "Factory"), HUD_DEFAULT_VISIBILITY, ::stalingrad_terminal_factory, "Factory: ^5", GLOBAL_HUD, GOROD_KROVI, CHEAT_PROTECTED );
        register_hud( "Terminal_Library", array("TerminalLibrary", "Library"), HUD_DEFAULT_VISIBILITY, ::stalingrad_terminal_library, "Library: ^5", GLOBAL_HUD, GOROD_KROVI, CHEAT_PROTECTED );
        register_hud( "Terminal_Store", array("TerminalStore", "Store"), HUD_DEFAULT_VISIBILITY, ::stalingrad_terminal_store, "Store: ^5", GLOBAL_HUD, GOROD_KROVI, CHEAT_PROTECTED ); 

    // Revelations
        register_split( "Keeper_Reel_Start", array("KeeperReelStart", "KRS"),"Keeper Reel Start: ^2", REVELATIONS, EE_SPLIT, ::genesis_wait_for_keeper_reel_start);
        register_split( "Reel_2_Placed", array( "Reel2Placed", "R2P"),"Reel 2 Placed: ^2", REVELATIONS, EE_SPLIT, ::genesis_wait_reel_2_placed);   
        register_split( "House_Teleport", array( "HouseTeleport", "House_Tp", "HouseTp", "HT", "HTP"),"House Teleport: ^2", REVELATIONS, EE_SPLIT, ::genesis_wait_house_tp);
        register_split( "Rift_Entrance", array( "RiftEntrance", "RE"),"Rift Entrance: ^2", REVELATIONS, EE_SPLIT, ::genesis_wait_rift_entrance);
        register_split( "Grand_Tour", array( "GrandTour", "GT"),"Grand Tour: ^2", REVELATIONS, EE_SPLIT, ::genesis_wait_grand_tour);
        register_split( "For_The_Good_Of_All", array( "ForTheGoodOfAll", "FTGOA"),"For The Good Of All: ^2", REVELATIONS, EE_SPLIT, ::genesis_wait_for_the_good_of_all);

        #ifdef dev
            register_hud( "Shadowman_souls", array("Shadowmansouls", "SS"), HUD_DEFAULT_VISIBILITY, ::Shadowman_Souls, "Shadowman Souls: ^5", GLOBAL_HUD, REVELATIONS, CHEAT_PROTECTED );
        #endif

    // Ascension
        register_split( "Launch_Complete", array( "LaunchComplete", "LC"),"Launch Complete: ^2", ASCENSION, EE_SPLIT, ::cosmodrome_wait_launch_complete);
        register_split( "Ascension_EE", array( "AscensionEE", "AEE"),"Ascension EE: ^2", ASCENSION, EE_SPLIT, ::cosmodrome_wait_ascension_ee);


    // Shangri-La
        register_split( "The_Once_A_Future_Crystal", array( "TheOnceAFutureCrystal", "TOAFC", "Once_A_Future_Crystal", "OnceAFutureCrystal", "OAFC" ),"The Once A Future Crystal: ^2", SHANGRI_LA, EE_SPLIT, ::temple_wait_toafc);
        register_split( "Dont_Go_Chasing_Waterfalls", array( "DontGoChasingWaterfalls", "DGCWF" ),"Don't Go Chasing Waterfalls: ^2", SHANGRI_LA, EE_SPLIT, ::temple_wait_dgcwf);
        register_split( "Lets_Get_Small", array( "LetsGetSmall", "LGS" ),"Let's Get Small: ^2", SHANGRI_LA, EE_SPLIT, ::temple_wait_lgs);
        register_split( "Pass_The_Torch", array( "PassTheTorch", "PTT" ),"Pass The Torch: ^2", SHANGRI_LA, EE_SPLIT, ::temple_wait_ptt);
        register_split( "Spike_The_Dikes", array( "SpikeTheDikes", "STD" ),"Spike The Dikes: ^2", SHANGRI_LA, EE_SPLIT, ::temple_wait_std);
        register_split( "Back_To_The_Past", array( "BackToThePast", "BTTP" ),"Back To The Past: ^2", SHANGRI_LA, EE_SPLIT, ::temple_wait_bttp);
        register_split( "Backer_To_The_Pasterer", array( "BackerToThePasterer", "BTTP2" ),"Backer To The Pasterer: ^2", SHANGRI_LA, EE_SPLIT, ::temple_wait_bttp2);
        register_split( "Bang_A_Gong", array( "BangAGong", "BAG" ),"Bang A Gong: ^2", SHANGRI_LA, EE_SPLIT, ::temple_wait_bag);
        register_split( "Time_Travel_Will_Tell", array( "TimeTravelWillTell", "TTWT" ),"Time Travel Will Tell: ^2", SHANGRI_LA, EE_SPLIT, ::temple_wait_ttwt);

    // Moon
        register_split( "Sam_Says_1", array( "SamSays1", "SS1" ),"Sam Says 1: ^2", MOON, EE_SPLIT, ::moon_wait_ss1);
        register_split( "Sam_Says_2", array( "SamSays2", "SS2" ),"Sam Says 2: ^2", MOON, EE_SPLIT, ::moon_wait_ss2);
        register_split( "Open_Sams_Chamber", array( "OpenSamsChamber", "OSC" ),"Open Sam's Chamber: ^2", MOON, EE_SPLIT, ::moon_wait_osc);
        register_split( "Cryogenic_Slumber_Party", array( "CryogenicSlumberParty", "CSP", "Sam_Chamber_Reveal", "SamChamberReveal", "SCR" ),"Cryogenic Slumber Party: ^2", MOON, EE_SPLIT, ::moon_wait_reveal_achieved);
        register_split( "Sam_Chamber", array( "SamChamber2", "SamChamber", "SC2", "SC"),"Sam Chamber: ^2", MOON, EE_SPLIT, ::moon_wait_sc2);
        register_split( "Charge_The_Tank_1", array( "ChargeTheTank1", "CTT1" ),"Charge The Tank 1: ^2", MOON, EE_SPLIT, ::moon_wait_ctt1);
        register_split( "Charge_The_Tank_2", array( "ChargeTheTank2", "CTT2" ),"Charge The Tank 2: ^2", MOON, EE_SPLIT, ::moon_wait_ctt2);
        register_split( "Build_The_Vrill_Generator", array( "BuildTheVrillGenerator", "BTVG" ),"Build The Vrill Generator: ^2", MOON, EE_SPLIT, ::moon_wait_btvg);
        register_split( "Charge_The_Vrill_Generator", array( "ChargeTheVrillGenerator", "CTVG" ),"Charge The Vrill Generator: ^2", MOON, EE_SPLIT, ::moon_wait_ctvg);
        register_split( "Black_Egg_1", array( "BlackEgg1", "BE1" ),"Black Egg 1: ^2", MOON, EE_SPLIT, ::moon_wait_be1);
        register_split( "Black_Egg_2", array( "BlackEgg2", "BE2" ),"Black Egg 2: ^2", MOON, EE_SPLIT, ::moon_wait_be2);
        register_split( "Big_Bang_Theory", array( "BigBangTheory", "BBT" ),"Big Bang Theory: ^2", MOON, EE_SPLIT, ::moon_wait_big_bang_achieved);

    // Origins

        // EE Splits
            register_split( "Secure_The_Keys", array("SecureTheKeys", "STK"),"Secure The Keys: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_all_secure_the_keys);
            register_split( "Ascend_From_Darkness", array("AscendFromDarkness", "AFD"),"Ascend From Darkness: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_ascend_from_drakness);
            register_split( "Rain_Fire", array("RainFire", "RF"),"Rain Fire: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_rain_fire);
            register_split( "Unleash_The_Horde", array("UnleashTheHorde", "UTH"),"Unleash The Horde: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_unleash_the_horde);
            register_split( "Skewer_The_Winged_Beast", array("SkewerTheWingedBeast", "STWB"),"Skewer The Winged Beast: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_skewer_the_winged_beast);
            register_split( "Wield_A_Fist_Of_Iron", array("WieldAFistOfIron", "WAFOI"),"Wield A Fist Of Iron: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_wield_a_fist_of_iron);
            register_split( "Raise_Hell", array("RaiseHell", "RH"),"Raise Hell: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_raise_hell);
            register_split( "Little_Lost_Girl", array( "LittleLostGirl", "LLG", "Freedom"),"Little Lost Girl: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_freedom);

        // Made-up splits

            // Staffs Crafting
                register_split( "Wind_Craft", array("WindCraft", "WC"),"Wind Craft: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_air_craft);
                register_split( "Fire_Craft", array("FireCraft", "FC"),"Fire Craft: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_fire_craft);
                register_split( "Electric_Craft", array("ElectricCraft", "EC"),"Electric Craft: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_electric_craft);
                register_split( "Ice_Craft", array("IceCraft", "IC"),"Ice Craft: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_ice_craft);

            // Portal enter
                register_split( "Wind_Enter", array("WindEnter", "WEnter"),"Wind Enter: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_air_enter);
                register_split( "Fire_Enter", array("FireEnter", "FEnter"),"Fire Enter: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_fire_enter);
                register_split( "Electric_Enter", array("ElectricEnter", "EEnter"),"Electric Enter: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_electric_enter);
                register_split( "Ice_Enter", array("IceEnter", "IEnter"),"Ice Enter: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_ice_enter);

            // Portal Exit
                register_split( "Wind_Exit", array("WindExit", "WExit"),"Wind Exit: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_air_exit);
                register_split( "Fire_Exit", array("FireExit", "FExit"),"Fire Exit: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_fire_exit);
                register_split( "Electric_Exit", array("ElectricExit", "EExit"),"Electric Exit: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_electric_exit);
                register_split( "Ice_Exit", array("IceExit", "IExit"),"Ice Exit: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_ice_exit);

            // So made-up that it goes beyond any reasonable name
                register_split( "Secure_The_Keys_Leave", array("SecureTheKeysLeave", "STKL"),"Secure The Keys Leave: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_secure_the_keys_leave);
                register_split( "Wield_A_Fist_Of_Iron_Enter", array("WieldAFistOfIronEnter", "WAFOIE"),"Wield A Fist Of Iron Enter: ^2", ORIGINS, EE_SPLIT, ::tomb_wait_wield_a_fist_of_iron_enter);

        // Dev
            #ifdef dev
                register_hud( "Ice_Part_1", array("IcePart1", "IP1"), HUD_DEFAULT_VISIBILITY, ::IcePart1, "Misses Ice Part 1: ", GLOBAL_HUD, ORIGINS, CHEAT_PROTECTED );
                register_hud( "Ice_Part_2", array("IcePart2", "IP2"), HUD_DEFAULT_VISIBILITY, ::IcePart2, "Misses Ice Part 2: ^5", GLOBAL_HUD, ORIGINS, CHEAT_PROTECTED );
                register_hud( "Ice_Part_3", array("IcePart3", "IP3"), HUD_DEFAULT_VISIBILITY, ::IcePart3, "Misses Ice Part 3: ^6", GLOBAL_HUD, ORIGINS, CHEAT_PROTECTED );
            #endif

}

#ifdef dev
function zm_private_ranked_match(){
    self endon( "death" );

    for(;;){
        wait 0.05;
        
        if( self.is_moving  ) continue;
        
        self SetValue( GetDvarInt(DVAR_ZM_PRIVATE_RANKEDMATCH) );
    }
}

function gum_1(){
    self endon( "death" );

    n_gum = 0;

    if( self.is_moving  ) wait 0.05;

    // Just default
    self SetValue( 0 );

    for(;;){
        wait 0.05;
        
        if( self.is_moving  ) continue;

        if( !isdefined( self.owner.bgb_pack ) || !isdefined( self.owner.bgb_pack[ n_gum ] ) ){
            val = 0;
        }else if( !is_bgb_consumable( self.owner.bgb_pack[ n_gum ] ) ){
            val = 777; // Infinite
        }else if( !isdefined( self.owner.bgb_stats ) || !isdefined( self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ] ) ){
            val = 666; // Diablo, esto no debería ocurrir    
        }else{
            val = self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ].bgb_available_at_start - self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ].bgb_used_this_game;
        }

        self SetValue( val );
    }
}

function gum_2(){
    self endon( "death" );

    n_gum = 1;

    if( self.is_moving  ) wait 0.05;

    // Just default
    self SetValue( 0 );

    for(;;){
        wait 0.05;
        
        if( self.is_moving  ) continue;

        if( !isdefined( self.owner.bgb_pack ) || !isdefined( self.owner.bgb_pack[ n_gum ] ) ){
            val = 0;
        }else if( !is_bgb_consumable( self.owner.bgb_pack[ n_gum ] ) ){
            val = 777; // Infinite
        }else if( !isdefined( self.owner.bgb_stats ) || !isdefined( self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ] ) ){
            val = 666; // Diablo, esto no debería ocurrir    
        }else{
            val = self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ].bgb_available_at_start - self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ].bgb_used_this_game;
        }

        self SetValue( val );
    }
}

function gum_3(){
    self endon( "death" );

    n_gum = 2;

    if( self.is_moving  ) wait 0.05;

    // Just default
    self SetValue( 0 );

    for(;;){
        wait 0.05;
        
        if( self.is_moving  ) continue;

        if( !isdefined( self.owner.bgb_pack ) || !isdefined( self.owner.bgb_pack[ n_gum ] ) ){
            val = 0;
        }else if( !is_bgb_consumable( self.owner.bgb_pack[ n_gum ] ) ){
            val = 777; // Infinite
        }else if( !isdefined( self.owner.bgb_stats ) || !isdefined( self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ] ) ){
            val = 666; // Diablo, esto no debería ocurrir    
        }else{
            val = self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ].bgb_available_at_start - self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ].bgb_used_this_game;
        }

        self SetValue( val );
    }
}

function gum_4(){
    self endon( "death" );

    n_gum = 3;

    if( self.is_moving  ) wait 0.05;

    // Just default
    self SetValue( 0 );

    for(;;){
        wait 0.05;
        
        if( self.is_moving  ) continue;

        if( !isdefined( self.owner.bgb_pack ) || !isdefined( self.owner.bgb_pack[ n_gum ] ) ){
            val = 0;
        }else if( !is_bgb_consumable( self.owner.bgb_pack[ n_gum ] ) ){
            val = 777; // Infinite
        }else if( !isdefined( self.owner.bgb_stats ) || !isdefined( self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ] ) ){
            val = 666; // Diablo, esto no debería ocurrir    
        }else{
            val = self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ].bgb_available_at_start - self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ].bgb_used_this_game;
        }

        self SetValue( val );
    }
}

function gum_5(){
    self endon( "death" );

    n_gum = 4;

    if( self.is_moving  ) wait 0.05;

    // Just default
    self SetValue( 0 );

    for(;;){
        wait 0.05;
        
        if( self.is_moving  ) continue;

        if( !isdefined( self.owner.bgb_pack ) || !isdefined( self.owner.bgb_pack[ n_gum ] ) ){
            val = 0;
        }else if( !is_bgb_consumable( self.owner.bgb_pack[ n_gum ] ) ){
            val = 777; // Infinite
        }else if( !isdefined( self.owner.bgb_stats ) || !isdefined( self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ] ) ){
            val = 666; // Diablo, esto no debería ocurrir    
        }else{
            val = self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ].bgb_available_at_start - self.owner.bgb_stats[ self.owner.bgb_pack[ n_gum ] ].bgb_used_this_game;
        }

        self SetValue( val );
    }
}
#endif

#region zombie timers

function sph_update(){
    self endon( "death" );

    while( self.is_moving  ) wait 0.05;
    self SetValue( 0 );
    old_kills = 0;
    sph = 0;

    while( !isdefined( level.round_start ) ) wait 0.05;

    for(;;){
        wait 0.05;

        if( level.is_round_waiting ){ // Keep same value between round transitions

            if( isdefined( sph ) && sph > 0 ){
                while( level.is_round_waiting ){
                    wait 0.05;
                    while( self.is_moving  ) wait 0.05;
                    self SetTenthsTimer( sph );
                }
            }else{
                while( self.is_moving  ) wait 0.05;
                self SetValue( 0 );
                while( level.is_round_waiting )
                    wait 0.05;
            }

            // Stay at 0 until the first kill is made
            while( self.is_moving  ) wait 0.05;
            self SetValue( 0 );
            kills = 0;

            // Wait for the first kill
            while( kills <= 0 ){
                kills = level.old_ztotal - ( getaiteamarray( "axis" ).size + level.zombie_total + level.zombie_respawns );
                wait 0.05;
            }

            // Avoid indetermination
            old_kills = kills;
        }

        // Update kills
        kills = level.old_ztotal - safe_get_all_zombies_left_to_kill();

        // When adding zombies to respawn, there is a time window where some zombies are killed but not added to respawners
        // No new kills have been made
        if( kills <= old_kills ){
            sph = ( ( gettime() - level.round_start ) / 1000 ) / ( old_kills / 24 );
            while( self.is_moving  ) wait 0.05;
            self SetTenthsTimer( sph );
            continue;
        }

        // only update if kills have been increased
        old_kills = kills;

        // sph = ( ( current time - time at round start ) / 1000ms per second ) / ( kills this round / 24 zombies per horde )
        sph = ( ( gettime() - level.round_start ) / 1000 ) / ( kills / 24 );
        while( self.is_moving  ) wait 0.05;
        self SetTenthsTimer( sph );
    }    
}

// Doing all checks to avoid Developer 2 errors
function safe_get_all_zombies_left_to_kill(){

    ztotal = 0;

    zombies = getaiteamarray( "axis" );
    current_zombies = isdefined( zombies ) ? zombies.size : 0;
    ztotal += current_zombies;

    respawn_zombies = isdefined( level.zombie_respawns ) ? level.zombie_respawns : 0;
    ztotal += respawn_zombies;

    total_zombies = isdefined( level.zombie_total ) ? level.zombie_total : 0;
    ztotal += total_zombies;

    return ztotal;
}

// TODO: refresh HUD depending if RTA is enabled or not
function round_timer_update(){
    self endon( "death" );

    self SetValue( 0 );
    while( self.is_moving  ) wait 0.05;

    if( has_game_started() ){
        self SetTimerUp( 0 - ( ( GetTime() - level.round_start ) / 1000 ) );
    }else{
        wait_for_game_start();
        wait 0.05;
        self SetTenthsTimerUp( 0.05 );
    }

    for(;;){

        // Automatic Round Times
        if( isdefined( level.autosplits ) ){
            level waittill( "end_of_round" );

            // Skip moon's earth TP
            if( level flag::exists("teleporter_used") && level flag::get("teleporter_used") ) continue;
        
        // Manual Round Times
        }else{
            level waittill( "manual_round_split" );
        }

        // Send Livesplit signal only if we are splitting rounds
        if( isdefined( level.split_rounds ) ) level livesplit( LIVESPLIT_SPLIT );

        wait 0.05;
        self SetTenthsTimerUp( 0.05 );
    }
}

function zcleanup_update(){
    self endon( "death" );

    while( self.is_moving  ) wait 0.05;
    self SetValue( 0 );

    // Wait for despawn function to start
    if ( !level flag::exists( "system_init_complete" ) ) level waittill( "system_init_complete" );

    n_next_eval = 0;

    for(;;){
        while( self.is_moving  ) wait 0.05;

        util::wait_network_frame();
        n_time = gettime();
        
        // Too soon
        if ( n_time < n_next_eval ){
            time = abs( n_time-n_next_eval );
            self setTenthsTimer( time/1000 );
            continue;
        }

        
        // There is a set checking time
        if ( isdefined( level.n_cleanup_manager_restart_time ) )
        {
            n_current_time = gettime() / 1000;
            n_delta_time = n_current_time - level.n_cleanup_manager_restart_time;
            
            // Too soon
            if ( n_delta_time < 0 ){

                self setTenthsTimer( abs( n_delta_time ) );
                continue;
            }
            
            #ifdef dev
                //level thread debug_message("Forced Cleanup time reached!");
            #endif
        }
        
        n_round_time = ( n_time - level.round_start_time ) / 1000;
        
        // Too soon for Round 5 or lower start
        if ( level.round_number <= 5 && n_round_time < 30 ){
            self setTenthsTimer( abs( n_round_time - 30 ) );
            continue;
        }
        // Too soon for round 6 or higher start
        else if ( level.round_number > 5 && n_round_time < 20 ){
            self setTenthsTimer( abs( n_round_time - 20 ) );
            continue;
        }
        
        n_next_eval += 3000;
    }    
}

#endregion

#region zombie counters

function zalive_update(){
    self endon( "death" );

    zombies = getaiteamarray( "axis" );
    old_val = isdefined( zombies ) ? zombies.size : 0;

    while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

    self SetValue( old_val );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

        zombies = getaiteamarray( "axis" );
        new_val = isdefined( zombies ) ? zombies.size : 0;

        if( new_val == old_val ) continue;

        old_val = new_val;
        self SetValue( old_val );
    }
}

function zrespawn_update(){
    self endon( "death" );

    old_val = isdefined( level.zombie_respawns ) ? level.zombie_respawns : 0;

    while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

    self SetValue( old_val );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

        new_val = isdefined( level.zombie_respawns ) ? level.zombie_respawns : 0;

        if( new_val == old_val ) continue;
        old_val = new_val;

        self SetValue( old_val );
    }
}

function zspawn_update(){
    self endon( "death" );

    old_val = isdefined( level.zombie_total ) ? level.zombie_total : 0;

    while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

    self SetValue( old_val );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

        new_val = isdefined( level.zombie_total ) ? level.zombie_total : 0;

        if( new_val == old_val ) continue;
        old_val = new_val;

        self SetValue( old_val );
    }
}

function zloc_update(){
    self endon( "death" );

    old_val = get_n_zombie_locations();

    while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

    self SetValue( old_val );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05; // wait until the HUD is not being moved to avoid visual glitch

        new_val = get_n_zombie_locations();

        if( new_val == old_val ) continue;
        old_val = new_val;

        self SetValue( old_val );
    }
}

function get_n_zombie_locations(){

    if( !isdefined( level.zm_loc_types ) ) return 0;
    if( !isdefined( level.zm_loc_types[ "zombie_location" ] ) ) return 0;

    return level.zm_loc_types[ "zombie_location" ].size;
}

#endregion

#region player huds

// Out of Bounds check
function oobc_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );
    // self.owner IPrintLnBold("OOB START");

    for(;;){
        self.owner waittill( "oob_check", dead );
        //self.owner IPrintLnBold("OOB NOTIFY");
        if( self.is_moving  ) continue; // Can't reset the 3s countdown

        self SetTenthsTimerUp( 0.05 );
        old_color = self.color; // Save old color (white)
        color = is_true( dead ) ? (0xFF, 0x0, 0x0) : (0x0, 0xFF, 0x00);
        self.color = color; // Set saved color (white)
        self FadeOverTime( 1 );
        self.color = old_color;

        time = GetTime() - level.n_gameplay_start_time;
        self.owner IPrintLnBold( sprintf( "OoB Check time:^5 {0}", CalcTime( time ) ) );
    }

}

function zone_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) wait 0.05;

        if( isdefined( self.owner.zone_name ) ) self SetText( basic_parser( self.owner.zone_name ) );
        else self SetText( "Out of bounds!" );
    }

}

#endregion


#region PAP

function current_map_has_pap(){

    zbarriers = getentarray("zm_pack_a_punch", "targetname");
    #ifdef dev
        //level thread debug_message("N Paps: ^5"+zbarriers.size);
    #endif
    return isdefined( zbarriers )  && zbarriers.size > 0;
}

function check_for_pap_use(){

    while(!isdefined( level.pack_a_punch ) ) wait 0.05;
    while(!isdefined( level.pack_a_punch.triggers ) ) wait 0.05;

    foreach( t_pap in level.pack_a_punch.triggers ) t_pap thread check_pap_upgrade();  
}

function wait_first_paped_weapon(){

    level waittill("weapon_paped", weapon, player);
    
    #ifdef dev
        //level thread debug_message(sprintf("Weapon ^5{0}^7 upgraded by ^6{1}", basic_parser(weapon.rootweapon.name), player.name ) );
    #endif
}

function check_pap_upgrade(){

    // level.pap_split = false; // This should be initialised before calling this func
    // self util::waittill_any("pap_timeout", "pap_taken", "pap_player_disconnected");

    for(;;){

        // Wait for the pap to get a valid user
        //while( !isdefined( self.pack_player ) ) wait 0.05;
        level waittill( "pack_machine_in_use" );
        player = self.pack_player;

        #ifdef dev
            //level thread debug_message("^5pack_player ^2"+player.name);
        #endif

        str_notify = self util::waittill_any_return("pap_timeout", "pap_taken", "pap_player_disconnected");

        #ifdef dev
            //level thread debug_message( "^5"+str_notify );
        #endif

        // Didn't pickup the PaP weapon
        if( str_notify  != "pap_taken" ){
            #ifdef dev
                //level thread debug_message( "^1PaP weapon missed... " );
            #endif
            continue;
        }

        level notify("weapon_paped", self.upgrade_weapon, player);

        //level thread debug_message( "^5"+player.name);
        //level thread debug_message( "^1"+self.current_weapon.rootweapon.name); // current_weapon == none?
        #ifdef dev
            //level thread debug_message( "^2"+MakeLocalizedString(self.upgrade_weapon.rootweapon.displayname));
        #endif
    }

}


#endregion

#region Zod

function ritual_update(){
    self endon( "death" );
    self.owner endon( "disconnect" );

    self SetText("Waiting for Rituals to set up");
    while( !isdefined( level.a_o_defend_areas ) ) wait 0.05;

    // level.a_o_defend_areas[ str_name ]
    a_str_names = array( "boxer", "detective", "femme", "magician" );
    self SetText( "^1Not in a Ritual..." );

    for(;;){
        wait 0.05;


    foreach( str_name in a_str_names){

        if( isdefined( level.a_o_defend_areas[ str_name ] ) ){

                if( isdefined( level.a_o_defend_areas[ str_name ].m_e_defend_volume ) ){
                    if( self.owner IsTouching( level.a_o_defend_areas[ str_name ].m_e_defend_volume ) ){
                        self SetText( sprintf("{0} ^2Touching VOLUME", str_name) );

                        while( self.owner IsTouching( level.a_o_defend_areas[ str_name ].m_e_defend_volume ) ) wait 0.05;
                    }
                }else if( isdefined( level.a_o_defend_areas[ str_name ].m_s_centerpoint ) ){
                    if( distance2dsquared( self.owner.origin, level.a_o_defend_areas[ str_name ].m_s_centerpoint.origin ) < level.a_o_defend_areas[ str_name ].m_n_defend_radius_sq && self.owner.origin[ 2 ] > level.a_o_defend_areas[ str_name ].m_s_centerpoint.origin[ 2 ] + -20 ){
                        self SetText( sprintf("{0} ^2Close enough to Centerpoint", str_name) );

                        while( distance2dsquared( self.owner.origin, level.a_o_defend_areas[ str_name ].m_s_centerpoint.origin ) < level.a_o_defend_areas[ str_name ].m_n_defend_radius_sq && self.owner.origin[ 2 ] > level.a_o_defend_areas[ str_name ].m_s_centerpoint.origin[ 2 ] + -20 ) wait 0.05;
                    }
                
                }else{
                    level thread debug_message( "^1Can't check "+str_name+" ???" );
                }

            }

        }

        self SetText( "^1Not in a Ritual..." );
    }

}

#endregion

#region Castle

function castle_box_code(){
    self endon( "death" );

    for(;;){
        wait 0.05;
        if( self.is_moving  ) continue; // Can't reset the 3s countdown
        
        if( !is_safe_box_code_known() ){
            self SetText("^1Unknown");
            continue;
        }

        level.var_ab58bca7 = array(1,3,3); // Patch Code to DLL :yonovoyadecirlo:
        self SetText("D L L");
    }

}

function Keeper_Souls(){
    self endon( "death" );

    for(;;){
        wait 0.05;
        
        if( self.is_moving  ) continue;
        
        self SetValue( isdefined( level.n_channeling_stone_kills ) ? level.n_channeling_stone_kills : 0 );
    }

}

#ifdef dev
function all_bows_required(){
    self endon( "death" );

    for(;;){
        wait 0.05;
        
        if( self.is_moving  ) continue;
        
        self SetValue( ( isdefined( level.b_can_hot_join ) && level.b_can_hot_join ) );
    }
}
#endif
#endregion

#region Stalingrad

function stalingrad_terminal_armory(){
    self endon( "death" );

    str_name = "armory";
    mdl_terminal = undefined;

    while( !isdefined( mdl_terminal ) ){
        wait 0.05;

        foreach( index, ee_terminal in level.a_mdl_ee_terminals ){
            if( ee_terminal.script_label != str_name) continue;

            mdl_terminal = ee_terminal;
            break;
        }
    }

    for(;;){
        wait 0.05;
        if( self.is_moving  ) continue; // Can't reset the 3s countdown

        if( !isdefined( mdl_terminal.var_1f3c0ca7 ) ){
            self SetText("^1Unknown...");
        }else{
            self SetValue( ( mdl_terminal.var_1f3c0ca7 + 1 ) );
            if( index == 0){
                self.color = (0x00,0xFF,0x00); // Green
            }else if( index == 5 ){
                self.color = (0xFF,0x00,0xFF); // Pink
            }else if( is_ee_puzzle_complete() ){
                self.color = (0x00,0x00,0xFF); // Blue
            }else{
                self.color = (0xFF,0x00,0x00); // Red
            }
        }
    }

}

function stalingrad_terminal_barracks(){
    self endon( "death" );

    str_name = "barracks";
    mdl_terminal = undefined;

    while( !isdefined( mdl_terminal ) ){
        wait 0.05;

        foreach( index, ee_terminal in level.a_mdl_ee_terminals ){
            if( ee_terminal.script_label != str_name) continue;

            mdl_terminal = ee_terminal;
            break;
        }
    }

    for(;;){
        wait 0.05;
        if( self.is_moving  ) continue; // Can't reset the 3s countdown

        if( !isdefined( mdl_terminal.var_1f3c0ca7 ) ){
            self SetText("^1Unknown...");
        }else{
            self SetValue( ( mdl_terminal.var_1f3c0ca7 + 1 ) );
            if( index == 0){
                self.color = (0x00,0xFF,0x00); // Green
            }else if( index == 5 ){
                self.color = (0xFF,0x00,0xFF); // Pink
            }else if( is_ee_puzzle_complete() ){
                self.color = (0x00,0x00,0xFF); // Blue
            }else{
                self.color = (0xFF,0x00,0x00); // Red
            }
        }
    }

}

function stalingrad_terminal_command(){
    self endon( "death" );

    str_name = "command";
    mdl_terminal = undefined;

    while( !isdefined( mdl_terminal ) ){
        wait 0.05;

        foreach( index, ee_terminal in level.a_mdl_ee_terminals ){
            if( ee_terminal.script_label != str_name) continue;

            mdl_terminal = ee_terminal;
            break;
        }
    }

    for(;;){
        wait 0.05;
        if( self.is_moving  ) continue; // Can't reset the 3s countdown

        if( !isdefined( mdl_terminal.var_1f3c0ca7 ) ){
            self SetText("^1Unknown...");
        }else{
            self SetValue( ( mdl_terminal.var_1f3c0ca7 + 1 ) );
            if( index == 0){
                self.color = (0x00,0xFF,0x00); // Green
            }else if( index == 5 ){
                self.color = (0xFF,0x00,0xFF); // Pink
            }else if( is_ee_puzzle_complete() ){
                self.color = (0x00,0x00,0xFF); // Blue
            }else{
                self.color = (0xFF,0x00,0x00); // Red
            }
        }
    }

}

function stalingrad_terminal_factory(){
    self endon( "death" );

    str_name = "factory";
    mdl_terminal = undefined;

    while( !isdefined( mdl_terminal ) ){
        wait 0.05;

        foreach( index, ee_terminal in level.a_mdl_ee_terminals ){
            if( ee_terminal.script_label != str_name) continue;

            mdl_terminal = ee_terminal;
            break;
        }
    }

    for(;;){
        wait 0.05;
        if( self.is_moving  ) continue; // Can't reset the 3s countdown

        if( !isdefined( mdl_terminal.var_1f3c0ca7 ) ){
            self SetText("^1Unknown...");
        }else{
            self SetValue( ( mdl_terminal.var_1f3c0ca7 + 1 ) );
            if( index == 0){
                self.color = (0x00,0xFF,0x00); // Green
            }else if( index == 5 ){
                self.color = (0xFF,0x00,0xFF); // Pink
            }else if( is_ee_puzzle_complete() ){
                self.color = (0x00,0x00,0xFF); // Blue
            }else{
                self.color = (0xFF,0x00,0x00); // Red
            }
        }
    }

}

function stalingrad_terminal_library(){
    self endon( "death" );

    str_name = "library";
    mdl_terminal = undefined;

    while( !isdefined( mdl_terminal ) ){
        wait 0.05;

        foreach( index, ee_terminal in level.a_mdl_ee_terminals ){
            if( ee_terminal.script_label != str_name) continue;

            mdl_terminal = ee_terminal;
            break;
        }
    }

    for(;;){
        wait 0.05;
        if( self.is_moving  ) continue; // Can't reset the 3s countdown

        if( !isdefined( mdl_terminal.var_1f3c0ca7 ) ){
            self SetText("^1Unknown...");
        }else{
            self SetValue( ( mdl_terminal.var_1f3c0ca7 + 1 ) );
            if( index == 0){
                self.color = (0x00,0xFF,0x00); // Green
            }else if( index == 5 ){
                self.color = (0xFF,0x00,0xFF); // Pink
            }else if( is_ee_puzzle_complete() ){
                self.color = (0x00,0x00,0xFF); // Blue
            }else{
                self.color = (0xFF,0x00,0x00); // Red
            }
        }
    }

}

function stalingrad_terminal_store(){
    self endon( "death" );

    str_name = "store";
    mdl_terminal = undefined;

    while( !isdefined( mdl_terminal ) ){
        wait 0.05;

        foreach( index, ee_terminal in level.a_mdl_ee_terminals ){
            if( ee_terminal.script_label != str_name) continue;

            mdl_terminal = ee_terminal;
            break;
        }
    }

    for(;;){
        wait 0.05;
        if( self.is_moving  ) continue; // Can't reset the 3s countdown

        if( !isdefined( mdl_terminal.var_1f3c0ca7 ) ){
            self SetText("^1Unknown...");
        }else{
            self SetValue( ( mdl_terminal.var_1f3c0ca7 + 1 ) );
            if( index == 0){
                self.color = (0x00,0xFF,0x00); // Green
            }else if( index == 5 ){
                self.color = (0xFF,0x00,0xFF); // Pink
            }else if( is_ee_puzzle_complete() ){
                self.color = (0x00,0x00,0xFF); // Blue
            }else{
                self.color = (0xFF,0x00,0x00); // Red
            }
        }
    }

}



function is_ee_puzzle_complete()
{
	first_terminal = level.a_mdl_ee_terminals[0];
	a_terminal_path = [];
	for(i = 0; i < 6; i++)
	{
		array::add(a_terminal_path, first_terminal, 0);
		first_terminal = get_terminal_by_location( first_terminal.var_cd705a9[ first_terminal.var_1f3c0ca7 ] );
	}

    // Impossible to happen? we always add 6 paths
	if(a_terminal_path.size != 6) return false;

    // The last routed terminal is different than the current last terminal of the randomized list
	if(a_terminal_path[5] != level.a_mdl_ee_terminals[5]) return false;

	return true;
}

function get_terminal_by_location( str_location )
{
	foreach(mdl_terminal in level.a_mdl_ee_terminals)
	{
		if(mdl_terminal.script_label == str_location)
		{
			return mdl_terminal;
		}
	}
}

#endregion

#region Genesis

#ifdef dev
function Shadowman_Souls(){
    self endon( "death" );

    for(;;){
        wait 0.05;
        
        if( self.is_moving  ) continue;
        
        self SetValue( isdefined( level.n_final_boss_basin_soul_counter ) ? level.n_final_boss_basin_soul_counter : 0 );
    }

}
#endif
#endregion

#region Tomb

#ifdef dev
function IcePart1(){
    self endon( "death" );

    while( !isdefined( level.ice_staff_pieces ) || level.ice_staff_pieces.size < 1 || !isdefined( level.ice_staff_pieces[0].num_misses ) ) wait 0.05;
    while( self.is_moving  ) wait 0.05;
    self SetValue( 0 );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) continue;
        self SetValue( level.ice_staff_pieces[0].num_misses );
    }
}

function IcePart2(){
    self endon( "death" );

    while( !isdefined( level.ice_staff_pieces ) || level.ice_staff_pieces.size < 2 || !isdefined( level.ice_staff_pieces[1].num_misses ) ) wait 0.05;
    while( self.is_moving  ) wait 0.05;
    self SetValue( 0 );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) continue;
        self SetValue( level.ice_staff_pieces[1].num_misses );
    }
}

function IcePart3(){
    self endon( "death" );

    while( !isdefined( level.ice_staff_pieces ) || level.ice_staff_pieces.size < 3 || !isdefined( level.ice_staff_pieces[2].num_misses ) ) wait 0.05;
    while( self.is_moving  ) wait 0.05;
    self SetValue( 0 );

    for(;;){
        wait 0.05;
        while( self.is_moving  ) continue;
        self SetValue( level.ice_staff_pieces[2].num_misses );
    }
}
#endif
#endregion
