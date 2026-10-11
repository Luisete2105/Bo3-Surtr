#include scripts\codescripts\struct;
#include scripts\shared\callbacks_shared;
#include scripts\shared\clientfield_shared;
#include scripts\shared\math_shared;
#include scripts\shared\system_shared;
#include scripts\shared\util_shared;
#include scripts\shared\hud_util_shared;
#include scripts\shared\hud_message_shared;
#include scripts\shared\hud_shared;
#include scripts\shared\array_shared;
#include scripts\shared\flag_shared;
#include scripts\shared\flagsys_shared;
#include scripts\shared\fx_shared;
#include scripts\shared\ai\zombie_utility;
#include scripts\shared\scene_shared;
#include scripts\shared\exploder_shared;
#include scripts\shared\laststand_shared;
#include scripts\shared\lui_shared; // To play movies


#namespace surtr;


function autoexec __init__sytem__()
{
    setdvar( DVAR_TIMESCALE, 1.0 ); // Maybe timescale was changed during EE step autocomplete or user manually changed it

    #ifdef dev
        IPrintLn("[IPrintLn] Hello World from Surtr");
        logprint( "[logprint] Hello World from Surtr\n" ); // Prints to gameserver.log
        iprintlnbold( "[iprintlnbold] Hello World from Surtr" );
    #endif


    // Check if it's the first time using Surtr to Load Dvars and World vars
	if( !IS_SURTR_CFG_LOADED ) load_full_cfg();
    // Check if we are on a new Session mode to load World vars
    else if( SESSION_MODE_CHANGED ) load_new_session_mode_cfg();
    // Check if we are on a Map Load
    else init_is_map_load();


    // Maybe there are no Surtr cfgs, so we should load default getkey for host
    level thread watch_surtr_players();

    // Set initial game start time for modes that don't have it and saves paused time before gameplay start
    level thread set_n_gameplay_start_time();

    // Zombie mode functions
	if( IS_ZOMBIES ){

        // Load custom states
		level thread load_practice_general();

        // Load practice mode if enabled, currently only Zombies have custom States
	    level thread check_cfg_state();

        // Flags for current Weapon attachments data
        FLAG_ACTIVE_WEAPON_SETTINGS = FLAG_SAVED_WEAPON_SETTINGS;

        // Flag to show/hide EE splits
        FLAG_ACTIVE_SHOW_EE_SPLITS = FLAG_SAVED_SHOW_EE_SPLITS;
	}

    // Show Surtr watermark
    if( SHOULD_SHOW_SURTR_MSG ) level thread display_surtr_msg();

    // Register Surtr System
	system::register("surtr", ::__init__, undefined, undefined);
}

function __init__()
{

    // Shared
    callback::on_start_gametype(::shared_init);
    callback::on_connecting(::shared_on_player_connecting);
    callback::on_connect(::shared_on_player_connect);
    callback::on_disconnect(::shared_on_player_disconnect); // Only needed on Share
    

    // Zombies
    if( IS_ZOMBIES ){
        callback::on_start_gametype(::zm_init);
        callback::on_connect(::zm_on_player_connect);
    }
    // Multiplayer
    else if( IS_MULTIPLAYER ){

    }
    // Campaign
    else if( IS_CAMPAIGN ){

    }
    // Maybe free run or zombies campaign?
    else{
        level thread debug_message("^1Unknown ^5Session Mode");
    }
}