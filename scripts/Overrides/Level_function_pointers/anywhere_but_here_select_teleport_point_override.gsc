
function map_has_weighted_abh_func(){

    switch( MAP_NAME ){

        case "zm_zod":
        case "zm_island":
        case "zm_stalingrad":
        //level thread debug_message("^2Map has ABH!");
            return true;
    }

    //level thread debug_message("^1NoNo map ABH...");
    return false;

}

function wait_for_abh_func(){

    while( !isdefined( level.anywhere_but_here_select_teleport_point_override ) ) wait 0.05;
}

function override_abh_func( new_abh_func ){

    if( map_has_weighted_abh_func() ) wait_for_abh_func();

    level thread debug_message( "^5ABH func ^2overridden!" );

    level.old_abh_func = level.anywhere_but_here_select_teleport_point_override;
    level.anywhere_but_here_select_teleport_point_override = new_abh_func;
}

function revert_abh_func(){

    level.anywhere_but_here_select_teleport_point_override = level.old_abh_func;
    level.old_abh_func = undefined;
}

function is_ent_inside_zone( str_zone )
{
    // Self is the ent
    temp_ent = spawn("script_origin", self.origin );

    if( !isdefined( level.zones[ str_zone ] ) ){
        level thread debug_message_instant("^1Error, can't find zone ^5"+str_zone );
        return false;
    }

    foreach( e_volume in level.zones[ str_zone ].volumes )
    {
        if (temp_ent istouching(e_volume)){
            level thread debug_message_instant("^2ABH zone found! ^5"+str_zone );
            temp_ent delete();
            return true;
        }
    }

    temp_ent delete();
    return false;
}

function get_abh_inside_zone( a_s_respawn_points, str_zone ){

    foreach( s_respawn_point in a_s_respawn_points ){

        // We found the correct ABH
        if( s_respawn_point is_ent_inside_zone( str_zone ) ){
            return s_respawn_point;
        }
    }

    return undefined;
}

function is_abh_zone_in_array( a_s_respawn_points, str_zone ){

    foreach( s_respawn_point in a_s_respawn_points ){

        // We found the correct ABH
        if( s_respawn_point is_ent_inside_zone( str_zone ) ){
            return true;
        }
    }

    return false;
}

function get_n_abh_loc_available(){

    a_s_respawn_points = struct::get_array( "player_respawn_point", "targetname" );
    a_s_valid_respawn_points = [];
    
    // Ignores respawn points on zones that are not enabled yet or the current player zone
    foreach ( s_respawn_point in a_s_respawn_points )
    {
        if( is_point_inside_enabled_zone(s_respawn_point.origin, undefined))
        {
            // Safe array insert macro
            if ( !isdefined( a_s_valid_respawn_points ) ) a_s_valid_respawn_points = [];
            else if ( !isarray( a_s_valid_respawn_points ) ) a_s_valid_respawn_points = array( a_s_valid_respawn_points );
            
            a_s_valid_respawn_points[ a_s_valid_respawn_points.size ] = s_respawn_point;
        }
    }
    
    // Excludes respawn points
    if ( isdefined( level.zm_bgb_anywhere_but_here_respawn_override ) ) a_s_valid_respawn_points = [[ level.zm_bgb_anywhere_but_here_respawn_override ]]( a_s_valid_respawn_points );

    return a_s_valid_respawn_points.size;
}

function notify_new_abh_loc(){

    old_val = get_n_abh_loc_available();


    for(;;){
        wait 0.05;

        new_val = get_n_abh_loc_available();

        if( new_val == old_val ) continue;
        
        level iprintLnBoldAllPlayers("^2New ^5ABH ^2available!");
        old_val = new_val;
    }

}

#region zm_zod

function bossrush_zod_abh(){

    self IPrintLnBold("ABH BOSSRUSH logic started");

    player_zone_name = [[@zm_zonemgr<scripts\zm\_zm_zonemgr.gsc>::get_zone_from_position]](self.origin + vectorscale((0, 0, 1), 32), 0);
    
    if ( !isdefined( player_zone_name ) )
    {
        player_zone_name = self.zone_name;
    }
    
    if ( isdefined( player_zone_name ) )
    {
        current_player_zone = level.zones[ player_zone_name ];
    }
    
    a_s_respawn_points = struct::get_array( "player_respawn_point", "targetname" );
    a_s_valid_respawn_points = [];
    
    // Ignores respawn points on zones that are not enabled yet or the current player zone
    foreach ( s_respawn_point in a_s_respawn_points )
    {
        if( is_point_inside_enabled_zone(s_respawn_point.origin, current_player_zone))
        {
            // Safe array insert macro
            if ( !isdefined( a_s_valid_respawn_points ) )
            {
                a_s_valid_respawn_points = [];
            }
            else if ( !isarray( a_s_valid_respawn_points ) )
            {
                a_s_valid_respawn_points = array( a_s_valid_respawn_points );
            }
            
            a_s_valid_respawn_points[ a_s_valid_respawn_points.size ] = s_respawn_point;
        }
    }
    
    // Excludes respawn points
    if ( isdefined( level.zm_bgb_anywhere_but_here_respawn_override ) )
    {
        a_s_valid_respawn_points = [[ level.zm_bgb_anywhere_but_here_respawn_override ]]( a_s_valid_respawn_points );
    }
    
    s_player_respawn = undefined;

    // Todo: kits system to choose each ABH loc player

    // Host gets Footlight ABH
    if( ( self == GetPlayers()[0] ) && is_abh_zone_in_array( a_s_valid_respawn_points, "zone_theater_C" ) ){
        chosen_respawn_point = get_abh_inside_zone( a_s_valid_respawn_points, "zone_theater_C" );
        #ifdef dev
            level thread debug_message_instant( "^5Theater C zone ^2enabled!" );
        #endif

        e_respawn_point = struct::get_array( chosen_respawn_point.target, "targetname" );
        
        foreach ( a_spawn_point in e_respawn_point )
        {
            n_script_int = self getentitynumber() + 1;

            if ( a_spawn_point.script_int === n_script_int ) return a_spawn_point;
        }
    }

    // Second player gets Canals ABH
    if( (GetPlayers().size > 1 && self == GetPlayers()[1] ) && is_abh_zone_in_array( a_s_valid_respawn_points, "zone_canal_D" ) ){
        chosen_respawn_point = get_abh_inside_zone( a_s_valid_respawn_points, "zone_canal_D" );
        #ifdef dev
            level thread debug_message_instant( "^5Canals 0 zone ^2enabled!" );
        #endif

        e_respawn_point = struct::get_array( chosen_respawn_point.target, "targetname" );
        
        foreach ( a_spawn_point in e_respawn_point )
        {
            n_script_int = self getentitynumber() + 1;

            if ( a_spawn_point.script_int === n_script_int ) return a_spawn_point;
        }
    }



    // Original code
    if ( a_s_valid_respawn_points.size > 0 )
    {
        chosen_respawn_point = array::random( a_s_valid_respawn_points );
        e_respawn_point = struct::get_array( chosen_respawn_point.target, "targetname" );
        
        foreach ( a_spawn_point in e_respawn_point )
        {
            n_script_int = self getentitynumber() + 1;
            
            if ( a_spawn_point.script_int === n_script_int )
            {
                s_player_respawn = a_spawn_point;
            }
        }
    }
    
    return s_player_respawn;

}

#endregion

#region zm_factory

// For EE
function best_factory_abh(){

    // Print for Tdot
    self IPrintLnBold("ABH logic started");

    player_zone_name = [[@zm_zonemgr<scripts\zm\_zm_zonemgr.gsc>::get_zone_from_position]](self.origin + vectorscale((0, 0, 1), 32), 0);
    
    if ( !isdefined( player_zone_name ) )
    {
        player_zone_name = self.zone_name;
    }
    
    if ( isdefined( player_zone_name ) )
    {
        current_player_zone = level.zones[ player_zone_name ];
    }
    
    a_s_respawn_points = struct::get_array( "player_respawn_point", "targetname" );
    a_s_valid_respawn_points = [];
    
    // Ignores respawn points on zones that are not enabled yet or the current player zone
    foreach ( s_respawn_point in a_s_respawn_points )
    {
        if( is_point_inside_enabled_zone(s_respawn_point.origin, current_player_zone))
        {
            // Safe array insert macro
            if ( !isdefined( a_s_valid_respawn_points ) )
            {
                a_s_valid_respawn_points = [];
            }
            else if ( !isarray( a_s_valid_respawn_points ) )
            {
                a_s_valid_respawn_points = array( a_s_valid_respawn_points );
            }
            
            a_s_valid_respawn_points[ a_s_valid_respawn_points.size ] = s_respawn_point;
        }
    }
    
    // Excludes respawn points
    if ( isdefined( level.zm_bgb_anywhere_but_here_respawn_override ) )
    {
        a_s_valid_respawn_points = [[ level.zm_bgb_anywhere_but_here_respawn_override ]]( a_s_valid_respawn_points );
    }
    
    s_player_respawn = undefined;
    

    // Random ABH
    if ( is_factory_ee_complete() || !is_oob_button_hit() )
    {
        chosen_respawn_point = array::random( a_s_valid_respawn_points );
        e_respawn_point = struct::get_array( chosen_respawn_point.target, "targetname" );
        
        foreach ( a_spawn_point in e_respawn_point )
        {
            n_script_int = self getentitynumber() + 1;
            
            if ( a_spawn_point.script_int === n_script_int )
            {
                return a_spawn_point;
            }
        }
    }

    // We are on the ee monkey throwing nade zone
    if ( player_zone_name == "wnuen_zone" )
    {

        //level thread debug_message_instant( "^5Let's go to furnace!" );

        // Top furnace ABH is available
        if( is_abh_zone_in_array( a_s_valid_respawn_points, "warehouse_top_zone" ) ){
            chosen_respawn_point = get_abh_inside_zone( a_s_valid_respawn_points, "warehouse_top_zone" );
            #ifdef dev
                level thread debug_message_instant( "^5Top furnace zone ^2enabled!" );
            #endif
        // Bottom furnace ABH is available
        }else if( is_abh_zone_in_array( a_s_valid_respawn_points, "warehouse_bottom_zone" ) ){
            chosen_respawn_point = get_abh_inside_zone( a_s_valid_respawn_points, "warehouse_bottom_zone" );
            #ifdef dev
                level thread debug_message_instant( "^5Top furnace zone ^2enabled!" );
            #endif
        // No good ABHs available
        }else{
            chosen_respawn_point = array::random( a_s_valid_respawn_points );
            #ifdef dev
                level thread debug_message_instant( "^1No good locations available..." );
            #endif
        }

        e_respawn_point = struct::get_array( chosen_respawn_point.target, "targetname" );
        
        foreach ( a_spawn_point in e_respawn_point )
        {
            n_script_int = self getentitynumber() + 1;
            
            if ( a_spawn_point.script_int === n_script_int ) return a_spawn_point;
        }
    }

    // We want to reach ee monkey
    if ( player_zone_name != "wnuen_zone" && player_zone_name != "outside_east_zone" )
    {

        //level thread debug_message_instant( "^5Let's go to EE monkey!" );

        // Inside fabric ABH is available
        if( is_abh_zone_in_array( a_s_valid_respawn_points, "wnuen_zone" ) ){
            chosen_respawn_point = get_abh_inside_zone( a_s_valid_respawn_points, "wnuen_zone" );
            #ifdef dev
                level thread debug_message_instant( "^5Inside fabric zone ^2enabled!" );
            #endif
        // Bottom furnace ABH is available
        }else if( is_abh_zone_in_array( a_s_valid_respawn_points, "outside_east_zone" ) ){
            chosen_respawn_point = get_abh_inside_zone( a_s_valid_respawn_points, "outside_east_zone" );
            #ifdef dev
                level thread debug_message_instant( "^5Outside fabric zone ^2enabled!" );
            #endif
        // No good ABHs available
        }else{
            chosen_respawn_point = array::random( a_s_valid_respawn_points );
            #ifdef dev
                level thread debug_message_instant( "^1No good locations available..." );
            #endif
        }

        e_respawn_point = struct::get_array( chosen_respawn_point.target, "targetname" );
        
        foreach ( a_spawn_point in e_respawn_point )
        {
            n_script_int = self getentitynumber() + 1;
            
            if ( a_spawn_point.script_int === n_script_int ) return a_spawn_point;
        }
    }


    // Original code
    if ( a_s_valid_respawn_points.size > 0 )
    {
        chosen_respawn_point = array::random( a_s_valid_respawn_points );
        e_respawn_point = struct::get_array( chosen_respawn_point.target, "targetname" );
        
        foreach ( a_spawn_point in e_respawn_point )
        {
            n_script_int = self getentitynumber() + 1;
            
            if ( a_spawn_point.script_int === n_script_int )
            {
                s_player_respawn = a_spawn_point;
            }
        }
    }
    
    return s_player_respawn;
}

// For Rounds SR
function best_factory_rounds_sr_abh(){

    level revert_abh_func();

    player_zone_name = [[@zm_zonemgr<scripts\zm\_zm_zonemgr.gsc>::get_zone_from_position]](self.origin + vectorscale((0, 0, 1), 32), 0);
    
    if ( !isdefined( player_zone_name ) )
    {
        player_zone_name = self.zone_name;
    }
    
    if ( isdefined( player_zone_name ) )
    {
        current_player_zone = level.zones[ player_zone_name ];
    }
    
    a_s_respawn_points = struct::get_array( "player_respawn_point", "targetname" );
    a_s_valid_respawn_points = [];
    
    // Ignores respawn points on zones that are not enabled yet or the current player zone
    foreach ( s_respawn_point in a_s_respawn_points )
    {
        if( is_point_inside_enabled_zone(s_respawn_point.origin, current_player_zone))
        {
            // Safe array insert macro
            if ( !isdefined( a_s_valid_respawn_points ) )
            {
                a_s_valid_respawn_points = [];
            }
            else if ( !isarray( a_s_valid_respawn_points ) )
            {
                a_s_valid_respawn_points = array( a_s_valid_respawn_points );
            }
            
            a_s_valid_respawn_points[ a_s_valid_respawn_points.size ] = s_respawn_point;
        }
    }
    
    // Excludes respawn points
    if ( isdefined( level.zm_bgb_anywhere_but_here_respawn_override ) )
    {
        a_s_valid_respawn_points = [[ level.zm_bgb_anywhere_but_here_respawn_override ]]( a_s_valid_respawn_points );
    }
    
    s_player_respawn = undefined;


    //if( is_abh_zone_in_array( a_s_valid_respawn_points, "warehouse_top_zone" ) ){
    if( is_abh_zone_in_array( a_s_valid_respawn_points, "wnuen_zone" ) ){

        level thread debug_message_instant( "^5Let's go to Wnuen!" );

        //chosen_respawn_point = get_abh_inside_zone( a_s_valid_respawn_points, "warehouse_top_zone" );
        chosen_respawn_point = get_abh_inside_zone( a_s_valid_respawn_points, "wnuen_zone" );
        e_respawn_point = struct::get_array( chosen_respawn_point.target, "targetname" );
        
        foreach ( a_spawn_point in e_respawn_point )
        {
            n_script_int = self getentitynumber() + 1;
            
            if ( a_spawn_point.script_int === n_script_int ) return a_spawn_point;
        }
    }

    level thread debug_message_instant( "^1Doing random location..." );

    // Original code
    if ( a_s_valid_respawn_points.size > 0 )
    {
        chosen_respawn_point = array::random( a_s_valid_respawn_points );
        e_respawn_point = struct::get_array( chosen_respawn_point.target, "targetname" );
        
        foreach ( a_spawn_point in e_respawn_point )
        {
            n_script_int = self getentitynumber() + 1;
            
            if ( a_spawn_point.script_int === n_script_int )
            {
                s_player_respawn = a_spawn_point;
            }
        }
    }
    
    return s_player_respawn;
}


#endregion

#region zm_castle

function firebow_castle_abh(){

    // Print for Tdot
    self IPrintLnBold("ABH logic started");

    player_zone_name = [[@zm_zonemgr<scripts\zm\_zm_zonemgr.gsc>::get_zone_from_position]](self.origin + vectorscale((0, 0, 1), 32), 0);
    
    if ( !isdefined( player_zone_name ) )
    {
        player_zone_name = self.zone_name;
    }
    
    if ( isdefined( player_zone_name ) )
    {
        current_player_zone = level.zones[ player_zone_name ];
    }
    
    a_s_respawn_points = struct::get_array( "player_respawn_point", "targetname" );
    a_s_valid_respawn_points = [];
    
    // Ignores respawn points on zones that are not enabled yet or the current player zone
    foreach ( s_respawn_point in a_s_respawn_points )
    {
        if( is_point_inside_enabled_zone(s_respawn_point.origin, current_player_zone))
        {
            // Safe array insert macro
            if ( !isdefined( a_s_valid_respawn_points ) )
            {
                a_s_valid_respawn_points = [];
            }
            else if ( !isarray( a_s_valid_respawn_points ) )
            {
                a_s_valid_respawn_points = array( a_s_valid_respawn_points );
            }
            
            a_s_valid_respawn_points[ a_s_valid_respawn_points.size ] = s_respawn_point;
        }
    }
    
    // Excludes respawn points
    if ( isdefined( level.zm_bgb_anywhere_but_here_respawn_override ) )
    {
        a_s_valid_respawn_points = [[ level.zm_bgb_anywhere_but_here_respawn_override ]]( a_s_valid_respawn_points );
    }
    
    s_player_respawn = undefined;

    if( is_abh_zone_in_array( a_s_valid_respawn_points, "zone_v10_pad" ) ){
        chosen_respawn_point = get_abh_inside_zone( a_s_valid_respawn_points, "zone_v10_pad" );
        #ifdef dev
            level thread debug_message_instant( "^5Rocket Test zone ^2enabled!" );
        #endif

        e_respawn_point = struct::get_array( chosen_respawn_point.target, "targetname" );
        
        foreach ( a_spawn_point in e_respawn_point )
        {
            n_script_int = self getentitynumber() + 1;
            
            // Reverts abh patch
            level.tdot_abh = true;

            if ( a_spawn_point.script_int === n_script_int ) return a_spawn_point;
        }
    }

    // Original code
    if ( a_s_valid_respawn_points.size > 0 )
    {
        chosen_respawn_point = array::random( a_s_valid_respawn_points );
        e_respawn_point = struct::get_array( chosen_respawn_point.target, "targetname" );
        
        foreach ( a_spawn_point in e_respawn_point )
        {
            n_script_int = self getentitynumber() + 1;
            
            if ( a_spawn_point.script_int === n_script_int )
            {
                s_player_respawn = a_spawn_point;
            }
        }
    }
    
    return s_player_respawn;
}

#endregion