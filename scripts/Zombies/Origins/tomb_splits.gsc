function tomb_wait_all_secure_the_keys(){

    level waittill( "ee_all_staffs_upgraded" );
}

function tomb_wait_ascend_from_drakness(){

    level waittill( "ee_all_staffs_placed" );
}

function tomb_wait_rain_fire(){

    level waittill( "ee_mech_zombie_hole_opened" );
}

function tomb_wait_unleash_the_horde(){

    level waittill( "ee_mech_zombie_fight_completed" );
}

function tomb_wait_skewer_the_winged_beast(){

    level waittill( "ee_maxis_drone_retrieved" );
}

function tomb_wait_wield_a_fist_of_iron(){

    level waittill( "ee_all_players_upgraded_punch" );
}

function tomb_wait_raise_hell(){

    level waittill( "ee_souls_absorbed" );
}

function tomb_wait_freedom(){

    level waittill( "ee_samantha_released" );
    SetDvar( DVAR_LIVESPLIT_PAUSED, "1"); // Last split, user may be playing a Super EE
}


// Staffs Crafting
function notify_staff_crafted(){

    b_result = self [[ self.craftablestub.old_onfullycrafted ]]();

    // Failed to craft?
    if( !b_result ){
        return b_result;
    }

    level notify( sprintf("{0}_crafted", self.craftablestub.name) );
    return b_result;
}


function tomb_wait_air_craft(){

    while( !isdefined( level.zombie_craftablestubs ) ) wait 0.05;
    while( !isdefined( level.zombie_craftablestubs[ "elemental_staff_air" ] ) ) wait 0.05;

    level.zombie_craftablestubs[ "elemental_staff_air" ].old_onfullycrafted = level.zombie_craftablestubs[ "elemental_staff_air" ].onfullycrafted;
    level.zombie_craftablestubs[ "elemental_staff_air" ].onfullycrafted = ::notify_staff_crafted;


    level waittill( "elemental_staff_air_crafted" );
}

function tomb_wait_fire_craft(){

    while( !isdefined( level.zombie_craftablestubs ) ) wait 0.05;
    while( !isdefined( level.zombie_craftablestubs[ "elemental_staff_fire" ] ) ) wait 0.05;

    level.zombie_craftablestubs[ "elemental_staff_fire" ].old_onfullycrafted = level.zombie_craftablestubs[ "elemental_staff_fire" ].onfullycrafted;
    level.zombie_craftablestubs[ "elemental_staff_fire" ].onfullycrafted = ::notify_staff_crafted;


    level waittill( "elemental_staff_fire_crafted" );
}

function tomb_wait_electric_craft(){

    while( !isdefined( level.zombie_craftablestubs ) ) wait 0.05;
    while( !isdefined( level.zombie_craftablestubs[ "elemental_staff_lightning" ] ) ) wait 0.05;

    level.zombie_craftablestubs[ "elemental_staff_lightning" ].old_onfullycrafted = level.zombie_craftablestubs[ "elemental_staff_lightning" ].onfullycrafted;
    level.zombie_craftablestubs[ "elemental_staff_lightning" ].onfullycrafted = ::notify_staff_crafted;


    level waittill( "elemental_staff_lightning_crafted" );
}

function tomb_wait_ice_craft(){

    while( !isdefined( level.zombie_craftablestubs ) ) wait 0.05;
    while( !isdefined( level.zombie_craftablestubs[ "elemental_staff_water" ] ) ) wait 0.05;

    level.zombie_craftablestubs[ "elemental_staff_water" ].old_onfullycrafted = level.zombie_craftablestubs[ "elemental_staff_water" ].onfullycrafted;
    level.zombie_craftablestubs[ "elemental_staff_water" ].onfullycrafted = ::notify_staff_crafted;


    level waittill( "elemental_staff_water_crafted" );
}

// Portal enter
function tomb_wait_portal_enter(){

    a_s_teleporters = struct::get_array( "trigger_teleport_pad", "targetname" );
    array::thread_all( a_s_teleporters, ::run_chamber_entrance_teleporter );

}

function run_chamber_entrance_teleporter(){

    element = StrTok(self.target, "_")[0]; // fire,air,water,electric

    for(;;){
        level waittill( "player_teleported", player, script_int );
        
        // Not this portal
        if( script_int != self.script_int ) continue;

        level notify( sprintf("{0}_portal_enter", element) );

        player thread manage_enter_portal();
        return;
    }
}

function manage_enter_portal(){
    self endon( "disconnect" );

    waittillframeend;


    self.using_enter_portal = true;

    self waittill( "teleport_finished" );

    self.using_enter_portal = undefined;
}

function tomb_wait_air_enter(){

    level waittill( "air_portal_enter" );
}

function tomb_wait_fire_enter(){

    level waittill( "fire_portal_enter" );
}

function tomb_wait_electric_enter(){

    level waittill( "electric_portal_enter" );
}

function tomb_wait_ice_enter(){

    level waittill( "water_portal_enter" );
}

// Portal Exit
function tomb_wait_portal_exit(){

    for(i=0; i<4;i++){
        image_room = struct::get( "teleport_room_" + i, "targetname" );
        image_room thread run_chamber_exit( i );
    }

}

function run_chamber_exit( n_pos ){

    for(;;){
        self waittill( "stop_teleport_fx" );
        player = undefined;
        foreach( e_player in GetPlayers() ){
            if( e_player.characterindex != n_pos ) continue;

            player = e_player;
        }

        if( !isdefined( player ) ) level thread debug_message("couldn't find player Portal Exit...");

        // Threaded so it works with 8 player mods
        player thread wait_for_portal_exit();
    }
}

function wait_for_portal_exit(){
    self endon( "disconnect" );

    // This is an enter portal
    if( isdefined( self.using_enter_portal ) ) return;

    self waittill( "teleport_finished" );

    // Teleport FX zone is the robot head
    while( self.zone_name == "zone_robot_head") wait 0.05;

    str_tokens = StrTok(self.zone_name, "_");

    element = str_tokens[1];
    //level thread debug_message( sprintf("Sending notify {0} with element {1}", "player_portal_exit", element) );
    level notify( "player_portal_exit", element);
}

function tomb_wait_air_exit(){

    for(;;){
        level waittill( "player_portal_exit", element );
        if( element == "air" ) return;
    }
}

function tomb_wait_fire_exit(){

    for(;;){
        level waittill( "player_portal_exit", element );
        if( element == "fire" ) return;
    }
}

function tomb_wait_electric_exit(){

    for(;;){
        level waittill( "player_portal_exit", element );
        if( element == "bolt" ) return;
    }
}

function tomb_wait_ice_exit(){

    for(;;){
        level waittill( "player_portal_exit", element );
        if( element == "ice" ) return;
    }
}

// So made up that it goes beyond any reasonable name
function tomb_wait_secure_the_keys_leave(){

    // Secure The Keys
    level waittill( "ee_all_staffs_upgraded" );

    // Leave
    level waittill( "player_portal_exit" );
}

function tomb_wait_wield_a_fist_of_iron_enter(){

    // Wield A Fist Of Iron
    level waittill( "ee_all_players_upgraded_punch" );

    // Enter
    level waittill( "player_teleported" );
}