/*
    This file is used to create constants with names that are self-explanatory.
    There is a comment indicating the relation of the constant on the top of each list.
*/

/* Examples from Serious bo3 BloodRush
#define STR_XUID = "TODO playerxuid";
#define __XUID__ = self [[ level.__PROTECTED__getdstat ]](STR_XUID);
*/

// Watermark
#ifndef dev
    #define SURTR_VERSION = "0.1.2";
#else
    #define SURTR_VERSION = "-0.1.2"; // Invalid version, gameplay should not be valid for runs
#endif

// Game version strings: [BuildInfoString] BuildConfig ?Platform? BuildMachine (Changelist LocalChanges?empty?) BuildTime
    #define BO3_MS_ENHANCED = "[local] ship win64 BEYQBBUILD132 (20659811) Thu Nov 14 13:00:32 2024 10d27bef";
    #define BO3_STEAM_2023 = "[local] ship win64 CODBUILD8-764 (13892626) Fri Feb 24 15:18:05 2023 10d27bef";
    #define BO3_STEAM_2026 = "[local] ship win64 BEYQBBUILD132 (13892626) Wed Dec 10 17:10:46 2025 10d27bef";

// Game version
    #define VERSION_UNKNOWN = 0x0;
    #define VERSION_MS_ENHANCED = 0x1;
    #define VERSION_STEAM_2023 = 0x2;
    #define VERSION_STEAM_2026 = 0x3;

// Str Game Version
    #define STR_BO3_ENHANCED = "Bo3 Enhanced";
    #define STR_STEAM_2023 = "Steam 2023";
    #define STR_STEAM_2026 = "Steam 2026";

// Core Surtr related macros
    #define GAME_VERSION = get_game_version();
    #define STR_CURRENT_GAME_VERSION = str_game_version( GAME_VERSION );
    #define IS_MS_VERSION = ( GAME_VERSION == VERSION_MS_ENHANCED );
    #define IS_STEAM_VERSION = ( get_game_version() == VERSION_STEAM_2023 || get_game_version() == VERSION_STEAM_2026 );
    #define GAME_IS_LAST_VERSION = ( IS_MS_VERSION || get_game_version() == VERSION_STEAM_2026 );
    #define IS_T7_PATCH_ACTIVE = ( GetDvarInt( DVAR_UI_ERROR_CALLSTACK_SHIP ) == true );
    #define IS_SURTR_CFG_LOADED = ( GetDvarInt( DVAR_SURTR_CFG_LOADED ) == true );
    #define SESSION_MODE_CHANGED = ( !isdefined( world.surtr_cfg_loaded ) );
    #define IS_RTA = ( GetDvarInt(DVAR_RTA) == true ); // Get current timing method
    #define SHOULD_SHOW_SURTR_MSG = ( GetDvarInt(DVAR_SHOW_SURTR ) == true ); // Show Surtr watermark
    #define IS_CUSTOM_CLIENT = ( GetDvarInt( DVAR_LOBBYTIMERSTARTINTERVAL_ARENA ) != 20000 ); // Detect custom client like Boiii or T7x


// Macros
    #define MAP_NAME = tolower( getdvarstring( "mapname" ) );
    #define MY_XUID = self getxuid(0);
    #define PLAYER_XUID = player getxuid(0);
    #define IS_ZOMBIES = sessionmodeiszombiesgame();
    #define IS_MULTIPLAYER = sessionmodeismultiplayergame();
    #define IS_CAMPAIGN = SessionModeIsCampaignGame();
    #define IS_ONLINE = SessionModeIsOnlineGame();
    #define IS_OFFLINE = !SessionModeIsOnlineGame();
    #define SERVER_FRAME = 0.05;
    #define WAIT_SERVER_FRAME = wait( SERVER_FRAME );
    #define IS_STATE_BEING_LOADED = ( isdefined( level.loading_custom_state ) && level.loading_custom_state );
    #define USING_MODS = isusingmods();
    #define IS_MAP_LOAD = ( GetDvarInt(DVAR_MAP_LOAD) == true );

// Dvars Game
    #define DVAR_UI_ERROR_CALLSTACK_SHIP = "ui_error_callstack_ship";
    #define DVAR_LOG_FILENAME = "log_filename";
    #define DVAR_UI_HUD_OBITUARIES = "ui_hud_obituaries";
    #define DVAR_LOBBYTIMERSTARTINTERVAL = "lobbyTimerStartInterval";
    #define DVAR_LOBBYTIMERSTARTINTERVAL_ARENA = "lobbyTimerStatusVotingInterval_Arena";  
    #define DVAR_COM_PAUSESUPPORTED = "com_pauseSupported";
    #define DVAR_SCR_FIRSTGUMFREE = "scr_firstGumFree";
    #define DVAR_TIMESCALE = "timescale";
    #define DVAR_ZM_PRIVATE_RANKEDMATCH = "zm_private_rankedmatch";
    #define DVAR_NODW = "nodw";
    #define DVAR_LIVE_USEUNO = "live_useuno";
    #define DVAR_LIVE_USEUMBRELLA = "live_useumbrella";
    #define DVAR_SV_CHEATS = "sv_cheats";
    #define DVAR_CG_ISGAMEPLAYACTIVE = "cg_isGameplayActive";
    #define DVAR_ZOMBIE_UNLOCK_ALL = "zombie_unlock_all";


#define GAME_DVARS = array(DVAR_UI_ERROR_CALLSTACK_SHIP, DVAR_LOG_FILENAME, DVAR_UI_HUD_OBITUARIES, DVAR_LOBBYTIMERSTARTINTERVAL, DVAR_LOBBYTIMERSTARTINTERVAL_ARENA, DVAR_COM_PAUSESUPPORTED, DVAR_SCR_FIRSTGUMFREE, DVAR_TIMESCALE, DVAR_ZM_PRIVATE_RANKEDMATCH, DVAR_NODW, DVAR_LIVE_USEUNO, DVAR_LIVE_USEUMBRELLA, DVAR_SV_CHEATS, DVAR_CG_ISGAMEPLAYACTIVE, DVAR_ZOMBIE_UNLOCK_ALL);

// Dvars Surtr
    #define DVAR_SURTR = "surtr";
    #define DVAR_SURTR_CFG_LOADED = "surtr_cfg_loaded";
    #define DVAR_DEBUG_MSG_SPEED = "debug_msg_speed";
    #define DVAR_SHOW_SURTR = "show_surtr";
    #define DVAR_WARNING_VERSION = "warning_version";
    #define DVAR_WARNING_T7PATCH = "warning_t7patch";
    #define DVAR_PROCESS_START = "process_start";
    #define DVAR_PRACTICE_STATE = "practice_state";
    #define DVAR_PRACTICE = "practice";
    #define DVAR_RTA = "rta";
    #define DVAR_LIVESPLIT_PAUSED = "livesplit_paused";
    #define DVAR_NEXTMAP = "nextmap";
    #define DVAR_MAP_LOAD = "map_load";
    #define DVAR_CURRENT_MAP_LOAD_TIMESTAMP = "current_map_load_timestamp";
    #define DVAR_AUTOSPLITS = "autosplits";
    #define DVAR_SPLIT_ROUNDS = "split_rounds";
    #define DVAR_FORCE_FULL_EASTER_EGG = "force_full_easter_egg";
    #define DVAR_DE_EE_RANKED = "de_ee_ranked";
    

#define SURTR_DVARS = array(DVAR_SURTR, DVAR_SURTR_CFG_LOADED, DVAR_DEBUG_MSG_SPEED, DVAR_SHOW_SURTR, DVAR_WARNING_VERSION, DVAR_WARNING_T7PATCH, DVAR_PROCESS_START, DVAR_PRACTICE_STATE, DVAR_PRACTICE, DVAR_RTA, DVAR_LIVESPLIT_PAUSED, DVAR_NEXTMAP, DVAR_MAP_LOAD, DVAR_CURRENT_MAP_LOAD_TIMESTAMP, DVAR_AUTOSPLITS, DVAR_SPLIT_ROUNDS, DVAR_FORCE_FULL_EASTER_EGG, DVAR_DE_EE_RANKED);

// Dvars clients
    #define DVAR_CG_OBJECTIVETEXT = "cg_objectivetext";
    #define DVAR_COMPASS = "compass";
    #define DVAR_CG_DRAWTALK = "cg_drawtalk";
    #define DVAR_CG_FOCALLENGTH = "cg_focallength";
    #define DVAR_UI_HUD_HARDCORE = "ui_hud_hardcore";
    #define DVAR_MINISCOREBOARDHIDE = "miniscoreboardhide";
    #define DVAR_SCR_NUMLIVES = "scr_numlives";
    #define DVAR_PLAYERPUSHAMOUNT = "playerpushamount";
    #define DVAR_PLAYER_SPRINTTIME = "player_sprinttime";
    #define DVAR_G_SCRIPTMAINMENU = "g_scriptmainmenu";
    #define DVAR_CG_THIRDPERSON = "cg_thirdperson";
    #define DVAR_CG_THIRDPERSONANGLE = "cg_thirdpersonangle";

#define CLIENT_DVARS = array(DVAR_CG_OBJECTIVETEXT, DVAR_COMPASS, DVAR_CG_DRAWTALK, DVAR_CG_FOCALLENGTH, DVAR_UI_HUD_HARDCORE, DVAR_MINISCOREBOARDHIDE, DVAR_SCR_NUMLIVES, DVAR_PLAYERPUSHAMOUNT, DVAR_PLAYER_SPRINTTIME, DVAR_G_SCRIPTMAINMENU, DVAR_CG_THIRDPERSON, DVAR_CG_THIRDPERSONANGLE);

// Video Settings Dvars
    #define DVAR_R_FULLSCREEN                           = "r_fullscreen"; // Fullscreen
    #define DVAR_R_MONITOR                              = "r_monitor"; // Monitor
    #define DVAR_R_MODE                                 = "r_mode"; // Screen Resolution
    #define DVAR_R_REFRESHRATE                          = "r_refreshrate"; // Refresh Rate
    #define DVAR_R_SCENERESOLUTIONMULTIPLIER            = "r_sceneresolutionmultiplier"; // Render Resolution
    #define DVAR_R_VIDEOMODE                            = "r_videomode"; // Display Gamma
    #define DVAR_CG_FOV_DEFAULT                         = "cg_fov_default"; // FoV
    #define DVAR_COM_MAXFPS                             = "com_maxfps"; // Max FPS
    #define DVAR_R_VSYNC                                = "r_vsync"; // Vertical Sync
    #define DVAR_COM_DRAWFPS_PC                         = "com_drawfps_pc"; // Show FPS

// Advanced Settings Dvars
    #define DVAR_R_PICMIP                               = "r_picmip"; // Texture Quality
    #define DVAR_R_MODELLODLIMIT                        = "r_modellodlimit"; // Mesh Quality
    #define DVAR_R_LIGHTINGSUNSHADOWDISABLEDYNAMICDRAW  = "r_lightingsunshadowdisabledynamicdraw"; // Dynamic Shadows
    #define DVAR_R_DEFERREDFORCESHADOWNEVERUPDATE       = "r_deferredforceshadowneverupdate"; // Unknown
    #define DVAR_R_SSSBLURENABLE                        = "r_sssblurenable"; // Subsurface Scattering
    #define DVAR_R_OIT_MAXENTRIES                       = "r_oit_maxentries"; // Order Independent Transparency
    #define DVAR_R_AATECHNIQUE                          = "r_aatechnique"; // Anti-Aliasing
    #define DVAR_R_SSAOTECHNIQUE                        = "r_ssaotechnique"; // Ambient Occlusion
    #define DVAR_R_MOTIONBLURMODE                       = "r_motionblurmode"; // Motion Blur

// All Settings Dvars
#define GAME_SETTINGS_DVARS = array(
    // Video
    DVAR_R_FULLSCREEN,
    DVAR_R_MONITOR,
    DVAR_R_MODE,
    DVAR_R_REFRESHRATE,
    DVAR_R_SCENERESOLUTIONMULTIPLIER,
    DVAR_R_VIDEOMODE,
    DVAR_CG_FOV_DEFAULT,
    DVAR_COM_MAXFPS,
    DVAR_R_VSYNC,
    DVAR_COM_DRAWFPS_PC,

    // Advanced
    DVAR_R_PICMIP,
    DVAR_R_MODELLODLIMIT,
    DVAR_R_LIGHTINGSUNSHADOWDISABLEDYNAMICDRAW,
    DVAR_R_DEFERREDFORCESHADOWNEVERUPDATE,
    DVAR_R_SSSBLURENABLE,
    DVAR_R_OIT_MAXENTRIES,
    DVAR_R_AATECHNIQUE,
    DVAR_R_SSAOTECHNIQUE,
    DVAR_R_MOTIONBLURMODE
);


// Menus
    // Menus defined by the game on mod tools files
        #define MENU_TEAM						= "ChangeTeam";
        #define MENU_START_MENU					= "StartMenu_Main";
        #define MENU_CLASS						= "class";
        #define MENU_CHANGE_CLASS				= "ChooseClass_InGame";
        #define MENU_EDIT_CHOOSE_CLASS			= "chooseClass";
        #define MENU_CONTROLS					= "ingame_controls";
        #define MENU_OPTIONS					= "ingame_options";
        #define MENU_LEAVEGAME					= "popup_leavegame";
        #define MENU_SPECTATE					= "spectate";
        #define MENU_RESTART_GAME				= "restartgamepopup";
        #define MENU_SCOREBOARD 				= "scoreboard";
        #define MENU_INIT_TEAM_ALLIES			= "initteam_marines";
        #define MENU_INIT_TEAM_AXIS				= "initteam_opfor";
        #define MENU_WAGER_SIDE_BET				= "sidebet";
        #define MENU_WAGER_SIDE_BET_PLAYER		= "sidebet_player";
        #define MENU_CHANGE_CLASS_WAGER			= "changeclass_wager";
        #define MENU_CHANGE_CLASS_CUSTOM		= "changeclass_custom";
        #define MENU_CHANGE_CLASS_BAREBONES		= "changeclass_barebones";
        #define MENU_FREERUN_RESTART			= "freerun_endgame_popup";

    // Start Menus
        #define MENU_OPTIONS_VOICE_PC                    = "StartMenu_Options_Voice_PC"; // PC voice menu
        #define MENU_OPTIONS_VOICE                       = "StartMenu_Options_Voice"; // Console voice menu
        #define MENU_OPTIONS_SOUND_PC                    = "StartMenu_Options_Sound_PC"; // PC sound menu
        #define MENU_OPTIONS_SOUND                       = "StartMenu_Options_Sound"; // Console sound menu
        #define MENU_OPTIONS_SOUND_ADVANCED              = "StartMenu_Options_Sound_Advanced"; // Normal sound options from default menu
        #define MENU_OPTIONS_SOCIAL                      = "StartMenu_Options_Social"; // Socials linking menu
        #define MENU_OPTIONS_PRIVACY_SETTINGS            = "StartMenu_Options_PrivacySettings"; // Privacy menu
        #define MENU_OPTIONS_NETWORK                     = "StartMenu_Options_Network"; // Network menu
        #define MENU_OPTIONS_MUSIC_TRACKS                = "StartMenu_Options_MusicTracks"; // Music menu
        #define MENU_OPTIONS_GRAPHICS_SAFE_AREA          = "StartMenu_Options_Graphics_SafeArea"; // Console safe area menu
        #define MENU_OPTIONS_GRAPHICS_PC                 = "StartMenu_Options_Graphics_PC"; // PC graphics menu
        #define MENU_OPTIONS_GRAPHICS                    = "StartMenu_Options_Graphics"; // Console graphics menu
        #define MENU_OPTIONS_GRAPHIC_CONTENT             = "StartMenu_Options_GraphicContent"; // Graphics content menu
        #define MENU_OPTIONS_CONTROLS_STICK_LAYOUT       = "StartMenu_Options_Controls_StickLayout"; // Console sticks menu
        #define MENU_OPTIONS_CONTROLS_PC                 = "StartMenu_Options_Controls_PC"; // PC controls menu
        #define MENU_OPTIONS_CONTROLS_BUTTON_LAYOUT      = "StartMenu_Options_Controls_ButtonLayout"; // Console buttons menu
        #define MENU_OPTIONS_CONTROLS                    = "StartMenu_Options_Controls"; // Console controls menu

    // Combat Records
        #define MENU_COMBAT_RECORD_ZM_MAPS               = "CombatRecordZMMaps"; // ZM maps data
        #define MENU_COMBAT_RECORD_ZM                    = "CombatRecordZM"; // ZM full menu data
        #define MENU_COMBAT_RECORD_WEAPONS_ZM            = "CombatRecordWeaponsZM"; // ZM weapon data
        #define MENU_COMBAT_RECORD_BUBBLEGUM_BUFFS       = "CombatRecordBubblegumBuffs"; // ZM BGB data
        #define MENU_COMBAT_RECORD_SPECIALISTS           = "CombatRecordSpecialists"; // MP specialists data
        #define MENU_COMBAT_RECORD_SCORESTREAKS          = "CombatRecordScorestreaks"; // MP ks data
        #define MENU_COMBAT_RECORD_GAME_MODES            = "CombatRecordGameModes"; // MP modes data
        #define MENU_COMBAT_RECORD_EQUIPMENT             = "CombatRecordEquipment"; // MP equipments data
        #define MENU_COMBAT_RECORD_CYBERCORE             = "CombatRecordCybercore"; // Gives lui error message
        #define MENU_COMBAT_RECORD_CP_MAPS               = "CombatRecordCPMaps"; // Campaign missions score data
        #define MENU_COMBAT_RECORD_FRIEND_SIDEBAR        = "CombatRecordFriendSidebar"; // Friend comparison sidebar

    // Other menus
        #define MENU_SOCIAL_MAIN                         = "Social_Main"; // Social from default menu
        #define MENU_SOCIAL_PLAYER_DETAILS_POPUP         = "Social_PlayerDetailsPopup"; // Player details menu
        #define MENU_TIMELINE_EDITOR                     = "TimelineEditor"; // Demo timeline menu
        #define MENU_TIMELINE_EDITOR_FILM_OPTIONS        = "TimelineEditorFilmOptions"; // Right side bar demo options
        #define MENU_SWITCH_CAMERA_WHEEL                 = "SwitchCameraWheel"; // Campaign tower defense HUD mission
        #define MENU_FEATURE_OVERLAY                     = "FeatureOverlay"; // Dark alpha overlay, CAN'T CLOSE
        #define MENU_FIRST_TIME_LANGUAGE_SELECTION       = "FirstTimeLanguageSelectionSetting"; // Language menu blank
        #define MENU_FIRST_TIME_BRIGHTNESS_SETTING       = "FirstTimeBrightnessSetting"; // First time Bright settings
        #define MENU_GROUPS_MEMBER_DETAILS_POPUP         = "GroupsMemberDetailsPopup"; // Player game mode levels info
        #define MENU_CREATE_GROUP                        = "CreateGroup"; // Group creation menu, can type on it
        #define MENU_SMALL_POPUP                         = "SmallPopup"; // PS4 mini popup
        #define MENU_MODAL_DIALOG                        = "ModalDialog"; // PS4 popup
        #define MENU_CRM_POPUP                           = "CRMPopup"; // Black and white table

    // Input Overlays
        #define MENU_KEYBOARD_INPUT_OVERLAY              = "KeyboardInputOverlay"; // BO3 text input box
        #define MENU_KEYBOARD_TEXT_FIELD                 = "KeyboardTextField"; // BO2 text input box

    // Menus that can't be closed
        #define MENU_SYSTEM_OVERLAY_NO_BG                = "SystemOverlay_NoBG"; // UI overlay no bg message stackable, CAN'T CLOSE
        #define MENU_SYSTEM_OVERLAY_MESSAGE_DIALOG       = "SystemOverlay_MessageDialog"; // UI overlay message stackable, CAN'T CLOSE
        #define MENU_SYSTEM_OVERLAY_FULL                 = "SystemOverlay_Full"; // UI Overlay message big, CAN'T CLOSE
        #define MENU_SYSTEM_OVERLAY_COMPACT              = "SystemOverlay_Compact"; // UI Overlay message, CAN'T CLOSE
        #define MENU_SYSTEM_OVERLAY_MESSAGE_DIALOG_FULL  = "SystemOverlay_MessageDialogFull"; // Error UI without message, CAN'T CLOSE
        #define MENU_SYSTEM_OVERLAY_FULL_ARENA           = "SystemOverlay_Full_Arena"; // Error UI without message, CAN'T CLOSE

        #define MENU_LOADING_SCREEN_TEAM_GAMES           = "LoadingScreenOverlayForTeamGames"; // Cool animated TG loading image with team versus connecting, CAN'T CLOSE
        #define MENU_LOADING_SCREEN_NON_TEAM_GAMES       = "LoadingScreenOverlayForNonTeamGames"; // Cool animated TG loading image with player connecting, CAN'T CLOSE
        #define MENU_LOADING_SCREEN_FREERUN              = "LoadingScreenOverlayForFreeRun"; // Cool animated TG loading image, CAN'T CLOSE

        #define MENU_INITIAL_BLACK                       = "InitialBlack"; // Fullscreen black with 3arc loading logo, CAN'T CLOSE
        #define MENU_FULLSCREEN_WHITE                    = "FullScreenWhite"; // Full screen white with transition, CAN'T CLOSE
        #define MENU_FULLSCREEN_BLACK                    = "FullScreenBlack"; // Full screen black, CAN'T CLOSE
        #define MENU_WAIT_DIALOG                         = "WaitDialog"; // Black screen with wait text at bottom right, CAN'T CLOSE
        #define MENU_CREDIT_FULLSCREEN                   = "Credit_Fullscreen"; // Game credits, CAN'T CLOSE
        #define MENU_CHOOSE_MODE_SIDEBAR                 = "ChooseModeSidebar"; // Side demo options, CAN'T CLOSE

#define GAME_MENUS = array(
    // Menus defined by the game on mod tools files
        MENU_TEAM,
        MENU_START_MENU,
        MENU_CLASS,
        MENU_CHANGE_CLASS,
        MENU_EDIT_CHOOSE_CLASS,
        MENU_CONTROLS,
        MENU_OPTIONS,
        MENU_LEAVEGAME,
        MENU_SPECTATE,
        MENU_RESTART_GAME,
        MENU_SCOREBOARD,
        MENU_INIT_TEAM_ALLIES,
        MENU_INIT_TEAM_AXIS,
        MENU_WAGER_SIDE_BET,
        MENU_WAGER_SIDE_BET_PLAYER,
        MENU_CHANGE_CLASS_WAGER,
        MENU_CHANGE_CLASS_CUSTOM,
        MENU_CHANGE_CLASS_BAREBONES,
        MENU_FREERUN_RESTART,

    // Start Menus
        MENU_OPTIONS_VOICE_PC,
        MENU_OPTIONS_VOICE,
        MENU_OPTIONS_SOUND_PC,
        MENU_OPTIONS_SOUND,
        MENU_OPTIONS_SOUND_ADVANCED,
        MENU_OPTIONS_SOCIAL,
        MENU_OPTIONS_PRIVACY_SETTINGS,
        MENU_OPTIONS_NETWORK,
        MENU_OPTIONS_MUSIC_TRACKS,
        MENU_OPTIONS_GRAPHICS_SAFE_AREA,
        MENU_OPTIONS_GRAPHICS_PC,
        MENU_OPTIONS_GRAPHICS,
        MENU_OPTIONS_GRAPHIC_CONTENT,
        MENU_OPTIONS_CONTROLS_STICK_LAYOUT,
        MENU_OPTIONS_CONTROLS_PC,
        MENU_OPTIONS_CONTROLS_BUTTON_LAYOUT,
        MENU_OPTIONS_CONTROLS,

    // Combat Records
        MENU_COMBAT_RECORD_ZM_MAPS,
        MENU_COMBAT_RECORD_ZM,
        MENU_COMBAT_RECORD_WEAPONS_ZM,
        MENU_COMBAT_RECORD_BUBBLEGUM_BUFFS,
        MENU_COMBAT_RECORD_SPECIALISTS,
        MENU_COMBAT_RECORD_SCORESTREAKS,
        MENU_COMBAT_RECORD_GAME_MODES,
        MENU_COMBAT_RECORD_EQUIPMENT,
        MENU_COMBAT_RECORD_CYBERCORE,
        MENU_COMBAT_RECORD_CP_MAPS,
        MENU_COMBAT_RECORD_FRIEND_SIDEBAR,

    // Other menus
        MENU_SOCIAL_MAIN,
        MENU_SOCIAL_PLAYER_DETAILS_POPUP,
        MENU_TIMELINE_EDITOR,
        MENU_TIMELINE_EDITOR_FILM_OPTIONS,
        MENU_SWITCH_CAMERA_WHEEL,
        MENU_FEATURE_OVERLAY,
        MENU_FIRST_TIME_LANGUAGE_SELECTION,
        MENU_FIRST_TIME_BRIGHTNESS_SETTING,
        MENU_GROUPS_MEMBER_DETAILS_POPUP,
        MENU_CREATE_GROUP,
        MENU_SMALL_POPUP,
        MENU_MODAL_DIALOG,
        MENU_CRM_POPUP,

    // Input Overlays
        MENU_KEYBOARD_INPUT_OVERLAY,
        MENU_KEYBOARD_TEXT_FIELD,

    // Menus that can't be closed
        MENU_SYSTEM_OVERLAY_NO_BG,
        MENU_SYSTEM_OVERLAY_MESSAGE_DIALOG,
        MENU_SYSTEM_OVERLAY_FULL,
        MENU_SYSTEM_OVERLAY_COMPACT,
        MENU_SYSTEM_OVERLAY_MESSAGE_DIALOG_FULL,
        MENU_SYSTEM_OVERLAY_FULL_ARENA,

        MENU_LOADING_SCREEN_TEAM_GAMES,
        MENU_LOADING_SCREEN_NON_TEAM_GAMES,
        MENU_LOADING_SCREEN_FREERUN,

        MENU_INITIAL_BLACK,
        MENU_FULLSCREEN_WHITE,
        MENU_FULLSCREEN_BLACK,
        MENU_WAIT_DIALOG,
        MENU_CREDIT_FULLSCREEN,
        MENU_CHOOSE_MODE_SIDEBAR
);

// Constants
    #define AXIS_X = 0;
    #define AXIS_Y = 1;
    #define AXIS_Z = 2;

// Time
    #define SECONDS_IN_A_DAY = 86400;


// SESSION MODE ENUM
    #define SESSION_MODE = CurrentSessionMode();
    #define SESSIONMODE_ZOMBIES = 0;
    #define SESSIONMODE_MULTIPLAYER = 1;
    #define SESSIONMODE_CAMPAIGN = 2;
    #define SESSIONMODE_INVALID = 3;

// CHEAT PROTECTION
    #define CHEAT_PROTECTED = true;
    #define ALLOWED = false;

// Commands
    #define ARGS_0 = 0;
    #define ARGS_1 = 1;
    #define ARGS_2 = 2;
    #define PLAYER_TOGGLE = true;

// MODS ID
    #define MOD_BOSS_RUSH = "2372198694";

// BGB
    #define BGB_NO_GUM = "none";
    #define BGB_FLAVOR_HEXED = "zm_bgb_flavor_hexed";
    #define BGB_POWER_VACUUM = "zm_bgb_power_vacuum";
    #define BGB_ROUND_ROBBIN = "zm_bgb_round_robbin";
    #define BGB_ANY = array(BGB_FLAVOR_HEXED, BGB_POWER_VACUUM, BGB_ROUND_ROBBIN);

// Gum Category
    #define CATEGORY_NO_GUM = "No Gum";
    #define CATEGORY_CLASSIC_GUM = "Classic Gum";
    #define CATEGORY_MEGA_GUM = "Mega Gum";
    #define CATEGORY_ANY_GUM = "Any Gum";

// Weapons
    #define MP_ATTACHMENTS = array("fmj", "extclip", "suppressed", "tacknife", "dw", "fastads", "dualclip", "damage");
    #define PAP_ATTACHMENTS = array("fmj", "extclip");
    #define IGNORED_ATTACHMENTS = array("none", "gmod0", "gmod1", "gmod2", "gmod3", "gmod4", "gmod5", "gmod6", "gmod7");
    #define FLAG_ACTIVE_WEAPON_SETTINGS = level.weapon_settings_flags;
    #define FLAG_SAVED_WEAPON_SETTINGS = world.weapon_settings_flags;
    #define FLAG_NO_MP_ATTACHMENTS = 1<<0; // Removes things like FMJ or Suppressor
    #define FLAG_AUTOMATIC_ATTACHMENTS = 1<<1; // Gives attachments to guns without any
    #define FLAG_ADD_STATTRAK = 1<<2; // Adds StatTrak to valid weapons
    #define FLAG_GIVE_CAMO = 1<<3; // Give a random camo
    #define FLAG_INITIAL_PISTOL_ATTACHMENTS = 1<<4; // Removes attachments on Initial Pistol
    #define ATTACHMENT_STATTRAK = "gmod6";

// CSV
    #define CSV_ATTACHMENTSTABLE = "gamedata/weapons/common/attachmentTable.csv";
    #define CSV_ATTACHMENTSTABLE_ROW_SIZE = TableLookupRowCount(CSV_ATTACHMENTSTABLE);
    #define CSV_ATTACHMENTSTABLE_ATTACHMENT_INDEX = 0;
    #define CSV_ATTACHMENTSTABLE_ATTACHMENT_TYPE = 1;
    #define CSV_ATTACHMENTSTABLE_ATTACHMENT_TYPE_NAME = 2;
    #define CSV_ATTACHMENTSTABLE_ITEM_NAME = 4;
    #define CSV_ATTACHMENTSTABLE_COMPATIBLE_ATTACHMENTS = 12;



// Maps
    #define SHADOWS_OF_EVIL = "zm_zod";
    #define THE_GIANT = "zm_factory";
    #define DER_EISENDRACHE = "zm_castle";
    #define ZETSUBOU_NO_SHIMA = "zm_island";
    #define GOROD_KROVI = "zm_stalingrad";
    #define REVELATIONS = "zm_genesis";
    #define VERRUCKT = "zm_asylum";
    #define SHI_NO_NUMA = "zm_sumpf";
    #define NATCH_DER_UNTOTEN = "zm_prototype";
    #define KINO_DER_TOTEN = "zm_theater";
    #define ASCENSION = "zm_cosmodrome";
    #define SHANGRI_LA = "zm_temple";
    #define MOON = "zm_moon";
    #define ORIGINS = "zm_tomb";

    #define ALL_MAPS = "general";

    #define TREYARCH_MAPS = array(SHADOWS_OF_EVIL, THE_GIANT, DER_EISENDRACHE, ZETSUBOU_NO_SHIMA, GOROD_KROVI, REVELATIONS, VERRUCKT, SHI_NO_NUMA, NATCH_DER_UNTOTEN, KINO_DER_TOTEN, ASCENSION, SHANGRI_LA, MOON, ORIGINS);

// Livesplit
    #define LIVESPLIT_RESET = 1;
    #define LIVESPLIT_START = 2;
    #define LIVESPLIT_SPLIT = 3;
    #define LIVESPLIT_NONE = 4;

    #define FLAG_ACTIVE_SHOW_EE_SPLITS = level.show_ee_splits;
    #define FLAG_SAVED_SHOW_EE_SPLITS = world.show_ee_splits;

// HuD
#define PLAYER_HUD = true;
#define GLOBAL_HUD = false;

#define EE_SPLIT = true;
#define GENERAL_SPLIT = false;

#define HUD_DEFAULT_VISIBILITY = undefined;

#define FEED_MESSAGES_MAX = 6;

// Main Maps EE Splits
    #define SOE_COMMON_SPLITS = array( "Rift_TP", "Arch-Ovum", "Flag_Start", "Shadowman_Trapped", "Apocalypse_Averted" );
    #define TG_COMMON_SPLITS = array( "Fly_Trap", "Paradoxical_Prologue" );
    #define DE_COMMON_SPLITS = array( "Time_Travel", "Keeper_Summoned", "Keeper_Boss", "My_Brothers_Keeper" );
    #define ZNS_COMMON_SPLITS = array( "Bunker_Opened", "Skull_Ritual", "Rainbow_Plant", "Elevator_Repaired", "Seeds_Of_Doubt" );
    #define GK_COMMON_SPLITS = array( "Fly_1", "Fly_2", "Challenges", "Download", "Love_And_War" );
    #define REV_COMMON_SPLITS = array( "Keeper_Reel_Start", "Reel_2_Placed", "House_Teleport", "Rift_Entrance", "Grand_Tour", "For_The_Good_Of_All" );

// All Main Maps Splits
    #define MAIN_MAPS_COMMON_SPLITS = array( SOE_COMMON_SPLITS, TG_COMMON_SPLITS, DE_COMMON_SPLITS, ZNS_COMMON_SPLITS, GK_COMMON_SPLITS, REV_COMMON_SPLITS );

// Chronicles Maps EE Splits
    #define ASC_COMMON_SPLITS = array( "Launch_Complete", "Ascension_EE" );
    #define SHANG_COMMON_SPLITS = array( "The_Once_A_Future_Crystal", "Dont_Go_Chasing_Waterfalls", "Lets_Get_Small", "Pass_The_Torch", "Spike_The_Dikes", "Back_To_The_Past", "Backer_To_The_Pasterer", "Bang_A_Gong", "Time_Travel_Will_Tell" );
    #define MOON_COMMON_SPLITS = array( "Sam_Says_1", "Open_Sams_Chamber", "Cryogenic_Slumber_Party", "Sam_Chamber", "Big_Bang_Theory" );
    #define ORIGINS_COMMON_SPLITS = array( "Secure_The_Keys", "Ascend_From_Darkness", "Rain_Fire", "Unleash_The_Horde", "Skewer_The_Winged_Beast", "Wield_A_Fist_Of_Iron", "Raise_Hell", "Little_Lost_Girl" );

// All Chronicle Maps Splits
    #define CHRONICLE_MAPS_COMMON_SPLITS = array( ASC_COMMON_SPLITS, SHANG_COMMON_SPLITS, MOON_COMMON_SPLITS, ORIGINS_COMMON_SPLITS );



// Smite Chat
    // Smite binds
    #define SMITE_CLOSE_CHAT_BINDS = array( BIND_BACKSPACE, BIND_TAB, BIND_ENTER, BIND_CAPSLOCK );

    // Smite colors
        //                                       RED GREEN BLUE
        #define SMITE_COLOR_BORDERS    = ( color(0x7D5D35) ); //    = (125/255,      93/255,      53/255); // Yellow
        #define SMITE_COLOR_VOID       = ( color(0x12111A) ); //    = ( 18/255,      17/255,      26/255); // Grey
        #define SMITE_COLOR_BACKGROUND = ( color(0x1C2334) ); //    = ( 28/255,      35/255,      52/255); // Dark Blue 1
        #define SMITE_COLOR_SHADOW     = ( color(0x000000) ); //    = (  0/255,       0/255,       0/255); // Black
        #define SMITE_COLOR_TEXT       = ( color(0xB5B6BA) ); //    = (181/255,     182/255,     186/255); // White

    // Smite HUDS

        // General
        #define SMITE_ALIGNMENT = "LEFT_CENTER";

        #define SMITE_SORT_1 = 1;
        #define SMITE_SORT_2 = 2;
        #define SMITE_SORT_3 = 3;
        #define SMITE_SORT_4 = 4;

        // Top
            #define SMITE_HUD_TOP_X = 50;
            #define SMITE_HUD_TOP_BORDER_Y = -90;
            #define SMITE_HUD_TOP_SHADOW_Y = -85;


// Colors
    #define COLOR_DARK_ORANGE = ( 0xFF/0xFF, 0x74/0xFF, 0x00/0xFF ); // Dark Orange
    #define COLOR_LIGHT_GREY = ( 0xAB/0xFF, 0xA8/0xFF, 0xA8/0xFF ); // Light Grey
    #define COLOR_DARK_GREY = ( 0x69/0xFF, 0x69/0xFF, 0x69/0xFF ); // Dark Grey
    #define COLOR_DARK_BLACK = ( 0x06/0xFF, 0x02/0xFF, 0x02/0xFF ); // Dark Black
    #define COLOR_BO3_WHITE = ( 0xF4/0xFF, 0xF4/0xFF, 0xF4/0xFF ); // Bo3 White


// LUI defines
    #define LUI_HUDELEM_TEXTSIZE_DEFAULT = 25;
    #define LUI_HUDELEM_TEXTSIZE_SMALL = 20;
    #define LUI_HUDELEM_TEXTSIZE_MEDIUM = 36;
    #define LUI_HUDELEM_TEXTSIZE_LARGE = 48;

    #define LUI_HUDELEM_ALIGNMENT_LEFT = 1;
    #define LUI_HUDELEM_ALIGNMENT_CENTER = 2;
    #define LUI_HUDELEM_ALIGNMENT_RIGHT = 3;

// ZOD_Train
    #define TRAIN_CANALS = "canal";
    #define TRAIN_FOOTLIGHT = "theater";
    #define TRAIN_WATERFRONT = "slums";

    #define TRAIN_LEFT = true;
    #define TRAIN_RIGHT = false;

// ZOD_Beastcode
    #define BEASTCODE_CANALS = 0;
    #define BEASTCODE_FOOTLIGHT = 1;
    #define BEASTCODE_WATERFRONT = 2;

// CASTLE_Dragons
    #define DRAGON_COURTYARD = 0;
    #define DRAGON_GREATHALL = 1;
    #define DRAGON_UNDERCROFT = 2;

// CASTLE_EE
    #define BOX_CODE_D = 1;
    #define BOX_CODE_L = 3;

// STALINGRAD DRAGON DEPARTURES
    #define DRAGON_DEPART_FACTORY = "cin_t7_ai_zm_dlc3_dragon_transport_roost1_idle_2_pavlovs_playing";
    #define DRAGON_DEPART_LIBRARY = "cin_t7_ai_zm_dlc3_dragon_transport_roost2_idle_2_pavlovs_playing";
    #define DRAGON_DEPART_JUDICIAL = "cin_t7_ai_zm_dlc3_dragon_transport_roost3_idle_2_pavlovs_playing";

// COSMODROME EE LANDER
    #define COSMODROME_PLAYER_GRAB_DISTANCE = 200;

// ACTION BITS
    #define BIT_INVALID = "BUTTON_BIT_INVALID";
    #define BIT_ATTACK =    "BUTTON_BIT_ATTACK";
    #define BIT_SPRINT =    "BUTTON_BIT_SPRINT";
    #define BIT_MELEE =    "BUTTON_BIT_MELEE";
    #define BIT_ACTIVATE =    "BUTTON_BIT_ACTIVATE";
    #define BIT_RELOAD =    "BUTTON_BIT_RELOAD";
    #define BIT_USE_RELOAD =    "BUTTON_BIT_USE_RELOAD";
    #define BIT_LEANLEFT =    "BUTTON_BIT_LEANLEFT";
    #define BIT_LEANRIGHT =    "BUTTON_BIT_LEANRIGHT";
    #define BIT_PRONE =    "BUTTON_BIT_PRONE";
    #define BIT_CROUCH = "BUTTON_BIT_CROUCH";
    #define BIT_JUMP = "BUTTON_BIT_JUMP";
    #define BIT_WALKING = "BUTTON_BIT_WALKING";
    #define BIT_TEMPSTANCE = "BUTTON_BIT_TEMPSTANCE";
    #define BIT_BREATH = "BUTTON_BIT_BREATH";
    #define BIT_FRAG = "BUTTON_BIT_FRAG";
    #define BIT_OFFHANDSECONDARY = "BUTTON_BIT_OFFHANDSECONDARY";
    #define BIT_CONFIRM_LOCATION = "BUTTON_BIT_CONFIRM_LOCATION";
    #define BIT_CANCEL_LOCATION = "BUTTON_BIT_CANCEL_LOCATION";
    #define BIT_GAS = "BUTTON_BIT_GAS";
    #define BIT_REVERSE = "BUTTON_BIT_REVERSE";
    #define BIT_HANDBRAKE = "BUTTON_BIT_HANDBRAKE";
    #define BIT_THROW = "BUTTON_BIT_THROW";
    #define BIT_CAMERALOCK = "BUTTON_BIT_CAMERALOCK";
    #define BIT_GESTURESHIFT = "BUTTON_BIT_GESTURESHIFT";
    #define BIT_LOOKSPRING = "BUTTON_BIT_LOOKSPRING";
    #define BIT_CHANGE_SEAT = "BUTTON_BIT_CHANGE_SEAT";
    #define BIT_TALK = "BUTTON_BIT_TALK";
    #define BIT_RED = "BUTTON_BIT_RED";
    #define BIT_GREEN = "BUTTON_BIT_GREEN";
    #define BIT_BLUE = "BUTTON_BIT_BLUE";
    #define BIT_YELLOW = "BUTTON_BIT_YELLOW";
    #define BIT_VEHICLE_ATTACK = "BUTTON_BIT_VEHICLE_ATTACK";
    #define BIT_VEHICLE_ATTACK2 = "BUTTON_BIT_VEHICLE_ATTACK2";
    #define BIT_VEHICLE_MOVEUP = "BUTTON_BIT_VEHICLE_MOVEUP";
    #define BIT_VEHICLE_MOVEDOWN = "BUTTON_BIT_VEHICLE_MOVEDOWN";
    #define BIT_JAM = "BUTTON_BIT_JAM";
    #define BIT_SLIDE = "BUTTON_BIT_SLIDE";
    #define BIT_DIVE_TO_PRONE = "BUTTON_BIT_DIVE_TO_PRONE";
    #define BIT_ACTIONSLOT_1 = "BUTTON_BIT_ACTIONSLOT_1";
    #define BIT_ACTIONSLOT_2 = "BUTTON_BIT_ACTIONSLOT_2";
    #define BIT_ACTIONSLOT_3 = "BUTTON_BIT_ACTIONSLOT_3";
    #define BIT_ACTIONSLOT_4 = "BUTTON_BIT_ACTIONSLOT_4";
    #define BIT_OFFHAND_CANCEL = "BUTTON_BIT_OFFHAND_CANCEL";
    #define BIT_USE_DOUBLE_TAP = "BUTTON_BIT_USE_DOUBLE_TAP";
    #define BIT_AIRBURST = "BUTTON_BIT_AIRBURST";
    #define BIT_LASING = "BUTTON_BIT_LASING";
    #define BIT_INVENTORY = "BUTTON_BIT_INVENTORY";
    #define BIT_NUNCHUKSCOPE = "BUTTON_BIT_NUNCHUKSCOPE";
    #define BIT_NUNCHUKTURRET = "BUTTON_BIT_NUNCHUKTURRET";
    #define BIT_ACTIONSLOT_CAROUSEL = "BUTTON_BIT_ACTIONSLOT_CAROUSEL";
    #define BIT_WEAPON_PICKUP = "BUTTON_BIT_WEAPON_PICKUP";
    #define BIT_ALT_WEAPON_PICKUP_ENABLED = "BUTTON_BIT_ALT_WEAPON_PICKUP_ENABLED";
    #define BIT_DOUBLETAPJUMP = "BUTTON_BIT_DOUBLETAPJUMP";
    #define BIT_CCP_SHIFTGRENADE = "BUTTON_BIT_CCP_SHIFTGRENADE";
    #define BIT_STANCE = "BUTTON_BIT_STANCE";
    #define BIT_VEHICLE_BOOST = "BUTTON_BIT_VEHICLE_BOOST";
    #define BIT_ACTION = "BUTTON_BIT_ACTION";
    #define BIT_DOUBLEJUMP = "BUTTON_BIT_DOUBLEJUMP";
    #define BIT_JUKE = "BUTTON_BIT_JUKE";
    #define BIT_SWIM_UP = "BUTTON_BIT_SWIM_UP";
    #define BIT_SWIM_DOWN = "BUTTON_BIT_SWIM_DOWN";
    #define BIT_PLANT_SHIELD = "BUTTON_BIT_PLANT_SHIELD";
    #define BIT_OFFHAND_SPECIAL = "BUTTON_BIT_OFFHAND_SPECIAL";
    #define BIT_WEAPON_SWITCH = "BUTTON_BIT_WEAPON_SWITCH";

// KEY BINDS

    // KEY NUMBERS
        #define BIND_0 = "0";
        #define BIND_1 = "1";
        #define BIND_2 = "2";
        #define BIND_3 = "3";
        #define BIND_4 = "4";
        #define BIND_5 = "5";
        #define BIND_6 = "6";
        #define BIND_7 = "7";
        #define BIND_8 = "8";
        #define BIND_9 = "9";

    // KEY LETTERS
        #define BIND_A = "A";
        #define BIND_B = "B";
        #define BIND_C = "C";
        #define BIND_D = "D";
        #define BIND_E = "E";
        #define BIND_F = "F";
        #define BIND_G = "G";
        #define BIND_H = "H";
        #define BIND_I = "I";
        #define BIND_J = "J";
        #define BIND_K = "K";
        #define BIND_L = "L";
        #define BIND_M = "M";
        #define BIND_N = "N";
        #define BIND_O = "O";
        #define BIND_P = "P";
        #define BIND_Q = "Q";
        #define BIND_R = "R";
        #define BIND_S = "S";
        #define BIND_T = "T";
        #define BIND_U = "U";
        #define BIND_V = "V";
        #define BIND_W = "W";
        #define BIND_X = "X";
        #define BIND_Y = "Y";
        #define BIND_Z = "Z";

    // KEY MOUSE
        #define BIND_M1 = "MOUSE1"; // Left click
        #define BIND_M2 = "MOUSE2"; // Right click
        #define BIND_M3 = "MOUSE3"; // Wheel click
        #define BIND_M4 = "MOUSE4"; // Side back button
        #define BIND_M5 = "MOUSE5"; // Side front button

        #define BIND_MWHEELDOWN = "MWHEELDOWN"; // Side back button
        #define BIND_MWHEELUP = "MWHEELUP"; // Side front button

    // KEY SPECIALS
        #define BIND_ESCAPE = "ESCAPE";

        #define BIND_APOSTROPHE = "APOSTROPHE"; // '
        #define BIND_INS = "INS"; // ¡
        #define BIND_BACKSPACE = "BACKSPACE";

        #define BIND_TAB = "TAB";
        #define BIND_PLUS = "PLUS";
        #define BIND_ENTER = "ENTER";

        #define BIND_CAPSLOCK = "CAPSLOCK";
        #define BIND_ACCENT = "ACCENT"; // ´ 0xb4
        #define BIND_CEDILLA = "CEDILLA"; // ç 0x88

        #define BIND_SHIFT = "SHIFT";
        #define BIND_LESSTHAN = "LESSTHAN"; // <
        #define BIND_COMMA = "COMMA"; // ,
        #define BIND_DOT = "DOT"; // .
        #define BIND_MINUS = "MINUS";

        #define BIND_CONTROL = "CTRL";
        #define BIND_ALT = "ALT";
        #define BIND_SPACE = "SPACE";

        #define BIND_PAUSE = "PAUSE";

        #define BIND_HOME = "HOME";
        #define BIND_PGUP = "PGUP";

        #define BIND_DEL = "DEL";
        #define BIND_END = "END";
        #define BIND_PGDN = "PGDN";

    // KEY ARROWS
        #define BIND_UPARROW = "UPARROW";
        #define BIND_DOWNARROW = "DOWNARROW";
        #define BIND_LEFTARROW = "LEFTARROW";
        #define BIND_RIGHTARROW = "RIGHTARROW";

    // KEY F+NUMBER
        #define BIND_F1 = "F1";
        #define BIND_F2 = "F2";
        #define BIND_F3 = "F3";
        #define BIND_F4 = "F4";
        #define BIND_F5 = "F5";
        #define BIND_F6 = "F6";
        #define BIND_F7 = "F7";
        #define BIND_F8 = "F8";
        #define BIND_F9 = "F9";
        #define BIND_F10 = "F10";
        #define BIND_F11 = "F11";
        #define BIND_F12 = "F12";

    // KEY BUTTONS CONTROLLER
        #define BIND_BUTTON_A = "BUTTON_A";
        #define BIND_BUTTON_B = "BUTTON_B";
        #define BIND_BUTTON_X = "BUTTON_X";
        #define BIND_BUTTON_Y = "BUTTON_Y";

    // KEY TRIGGERS CONTROLLER
        #define BIND_LSHLDR = "BUTTON_LSHLDR";
        #define BIND_RSHLDR = "BUTTON_RSHLDR";
        #define BIND_LTRIG = "BUTTON_LTRIG";
        #define BIND_RTRIG = "BUTTON_RTRIG";

        #define BIND_START = "BUTTON_START";
        #define BIND_BACK = "BUTTON_BACK";

    // KEY JOYSTICKS CONTROLLER
        #define BIND_LSTICK = "BUTTON_LSTICK";
        #define BIND_RSTICK = "BUTTON_RSTICK";

    // KEY PAD CONTROLLERS
        #define BIND_DPAD_UP = "DPAD_UP";
        #define BIND_DPAD_DOWN = "DPAD_DOWN";
        #define BIND_DPAD_LEFT = "DPAD_LEFT";
        #define BIND_DPAD_RIGHT = "DPAD_RIGHT";



// ACTION BINDS

    // COMBAT
        #define BIND_ATTACK = "+attack";
        #define BIND_WEAPHERO = "+weaphero";
        #define BIND_SPEED = "+speed";
        #define BIND_SPEED_THROW = "+speed_throw";
        #define BIND_TOGGLEADS = "toggleads";
        #define BIND_ACTIVATE = "+activate";
        #define BIND_FRAG = "+frag";
        #define BIND_SMOKE = "+smoke";
        #define BIND_MELEE = "+melee";
        #define BIND_MELEE_ZOOM = "+melee_zoom";
        #define BIND_RELOAD = "+reload";
        #define BIND_USERELOAD = "+usereload";
        #define BIND_WEAPNEXT_INVENTORY = "+weapnext_inventory";
        #define BIND_WEAPNEXT = "weapnext";
        #define BIND_WEAPPREV = "weapprev";

    // MOVEMENT
        #define BIND_STANCE = "+stance";
        #define BIND_GOSTAND = "+gostand";
        #define BIND_PRONE = "+prone";
        #define BIND_SPRINT = "+sprint";
        #define BIND_BREATH_SPRINT = "+breath_sprint";
        #define BIND_HOLDBREATH = "+holdbreath";
        #define BIND_SLIDE = "slide";
        #define BIND_GOPRONE = "goprone";
        #define BIND_TOGGLEPRONE = "toggleprone";
        #define BIND_RAISESTANCE = "raisestance";
        #define BIND_LOWERSTANCE = "lowerstance";
        #define BIND_MOVEUP = "+moveup";
        #define BIND_MOVEDOWN = "+movedown";
        #define BIND_FORWARD = "+forward";
        #define BIND_BACK = "+back";
        #define BIND_MOVELEFT = "+moveleft";
        #define BIND_MOVERIGHT = "+moveright";
        #define BIND_LEANLEFT = "+leanleft";
        #define BIND_LEANRIGHT = "+leanright";

    // ACTION SLOTS
        #define BIND_ACTIONSLOT1 = "+actionslot 1";
        #define BIND_ACTIONSLOT2 = "+actionslot 2";
        #define BIND_ACTIONSLOT3 = "+actionslot 3";
        #define BIND_ACTIONSLOT4 = "+actionslot 4";

    // VEHICLE
        #define BIND_VEHICLEBOOST = "+vehicleboost";
        #define BIND_GAS = "+gas";
        #define BIND_REVERSE = "+reverse";
        #define BIND_HANDBRAKE = "+handbrake";
        #define BIND_SWITCHSEAT = "+switchseat";
        #define BIND_VEHICLEATTACK = "+vehicleattack";
        #define BIND_VEHICLEATTACKSECOND = "+vehicleattacksecond";
        #define BIND_VEHICLEMOVEUP = "+vehiclemoveup";
        #define BIND_VEHICLEMOVEDOWN = "+vehiclemovedown";

// Binds GSC can detect
    #define DETECTABLE_BINDS = array( BIND_ATTACK, BIND_WEAPHERO, BIND_SPEED, BIND_SPEED_THROW, BIND_TOGGLEADS, BIND_ACTIVATE, BIND_FRAG, BIND_SMOKE,
        BIND_MELEE, BIND_MELEE_ZOOM, BIND_RELOAD, BIND_USERELOAD, BIND_WEAPNEXT_INVENTORY, BIND_STANCE, BIND_GOSTAND, BIND_PRONE, BIND_SPRINT,
        BIND_BREATH_SPRINT, BIND_HOLDBREATH, BIND_MOVEUP, BIND_MOVEDOWN, BIND_FORWARD, BIND_BACK, BIND_MOVELEFT, BIND_MOVERIGHT, BIND_LEANLEFT,
        BIND_LEANRIGHT, BIND_ACTIONSLOT1, BIND_ACTIONSLOT2, BIND_ACTIONSLOT3, BIND_ACTIONSLOT4, BIND_VEHICLEBOOST, BIND_GAS, BIND_REVERSE, BIND_HANDBRAKE,
        BIND_SWITCHSEAT, BIND_VEHICLEATTACK, BIND_VEHICLEATTACKSECOND, BIND_VEHICLEMOVEUP, BIND_VEHICLEMOVEDOWN );

// KEYCODES

    // NUMBERS
        #define KEY_1 = 0x31;
        #define KEY_2 = 0x32;
        #define KEY_3 = 0x33;
        #define KEY_4 = 0x34;
        #define KEY_5 = 0x35;
        #define KEY_6 = 0x36;
        #define KEY_7 = 0x37;
        #define KEY_8 = 0x38;
        #define KEY_9 = 0x39;
        #define KEY_0 = 0x30;

    // LETTERS
        #define KEY_A = 0x41;
        #define KEY_B = 0x42;
        #define KEY_C = 0x43;
        #define KEY_D = 0x44;
        #define KEY_E = 0x45;
        #define KEY_F = 0x46;
        #define KEY_G = 0x47;
        #define KEY_H = 0x48;
        #define KEY_I = 0x49;
        #define KEY_J = 0x4A;
        #define KEY_K = 0x4B;
        #define KEY_L = 0x4C;
        #define KEY_M = 0x4D;
        #define KEY_N = 0x4E;
        #define KEY_O = 0x4F;
        #define KEY_P = 0x50;
        #define KEY_Q = 0x51;
        #define KEY_R = 0x52;
        #define KEY_S = 0x53;
        #define KEY_T = 0x54;
        #define KEY_U = 0x55;
        #define KEY_V = 0x56;
        #define KEY_W = 0x57;
        #define KEY_X = 0x58;
        #define KEY_Y = 0x59;
        #define KEY_Z = 0x5A;

    // F + NUMBER
        #define KEY_F1 = 0x70;
        #define KEY_F2 = 0x71;
        #define KEY_F3 = 0x72;
        #define KEY_F4 = 0x73;
        #define KEY_F5 = 0x74;
        #define KEY_F6 = 0x75;
        #define KEY_F7 = 0x76;
        #define KEY_F8 = 0x77;
        #define KEY_F9 = 0x78;
        #define KEY_F10 = 0x79;
        #define KEY_F11 = 0x7A;
        #define KEY_F12 = 0x7B;

    // SPECIALS
        #define KEY_ESCAPE = 0x1B;

        #define KEY_APOSTROPHE = 0xDE; // '
        //#define KEY_INS = 0x31; // ¡ // Same as 1
        #define KEY_BACKSPACE = 0x08;

        #define KEY_TAB = 0x09;
        #define KEY_PLUS = 0xBB;
        #define KEY_ENTER = 0x0D;

        #define KEY_CAPSLOCK = 0x14;
        #define KEY_ACCENT = 0xC0; // ´ 0xb4
        #define KEY_CEDILLA = 0xE2; // ç 0x88

        #define KEY_SHIFT = 0xA0;
        //#define KEY_LESSTHAN = 0xBC; // < // Same as comma
        #define KEY_COMMA = 0xBC; // ,
        #define KEY_DOT = 0xBE; // .
        #define KEY_MINUS = 0xBD;

        #define KEY_CONTROL = 0xA2;
        #define KEY_ALT = 0x12;
        #define KEY_SPACE = 0x20;