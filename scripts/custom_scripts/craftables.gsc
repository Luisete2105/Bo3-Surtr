function get_craftables_pieces(){


    if( !isplayer( self ) ) self = level.host;



    foreach( s_craftable in level.zombie_include_craftables )
    {
        foreach( s_piece in s_craftable.a_pieceStubs ){
            
            if( !isDefined( s_piece.pieceSpawn.model ) ){ // Piece already taken
                #ifdef dev
                    self iPrintLnBold("^2Already taken specific piece name: ^5"+s_piece.piecename+"^7 => ^5"+s_craftable.name);
                #endif
                continue;
            }

            self thread [[ @zm_craftables<scripts\zm\craftables\_zm_craftables.gsc>::player_take_piece ]]( s_piece.pieceSpawn );
        }

    }

}

function get_full_craftable_object( craftable_name = undefined ){

    if(!isdefined(craftable_name)){
        level.host iPrintLnBold("^1Error, missing specific craftable name");
        return undefined;
    }


    if( !isplayer( self ) ) self = level.host;


    foreach( s_craftable in level.zombie_include_craftables )
    {
        if( s_craftable.name != craftable_name ) continue; // Wrong craftable

        foreach( s_piece in s_craftable.a_pieceStubs ){
            
            if( !isDefined( s_piece.pieceSpawn.model ) ){ // Piece already taken
                #ifdef dev
                    self iPrintLnBold("^2Already taken specific piece name: ^5"+s_piece.piecename+"^7 => ^5"+s_craftable.name);
                #endif
                continue;
            }

            level.host thread [[ @zm_craftables<scripts\zm\craftables\_zm_craftables.gsc>::player_take_piece ]]( s_piece.pieceSpawn );
        }

    }

}



function get_specific_craftable_piece( craftable_name = undefined, piece_name = undefined ){

    if(!isdefined(craftable_name)){
        self iPrintLnBold("^1Error, missing craftable name");
        return undefined;
    }

    if(!isdefined(piece_name)){
        self iPrintLnBold("^1Error, missing specific piece name");
        return undefined;
    }


    if( !isplayer( self ) ) self = level.host;


    foreach( s_craftable in level.zombie_include_craftables )
    {
        if( s_craftable.name != craftable_name ) continue; // Wrong craftable
        
        foreach( s_piece in s_craftable.a_pieceStubs ){

            if( s_piece.piecename != piece_name ) continue; // Wrong piece
            
            if( !isDefined( s_piece.pieceSpawn.model ) ){ // Piece already taken
                #ifdef dev
                    self iPrintLnBold("^2Already taken specific piece name: ^5"+s_piece.piecename+"^7 => ^5"+s_craftable.name);
                #endif
                return;
            }

            self thread [[ @zm_craftables<scripts\zm\craftables\_zm_craftables.gsc>::player_take_piece ]]( s_piece.pieceSpawn );
            return;
        }

    }

    self iPrintLnBold("^1Error, Can't find specific piece name: ^5"+piece_name+"^7 => ^5"+craftable_name);

}


function complete_craftable( str_craftable_name = undefined )
{

    if(!isDefined(str_craftable_name)){
        level.host iPrintLnBold("^1Error, no craftable name");
        return;
    }


    if( !isplayer( self ) ) self = level.host;


	foreach( uts_craftable in level.a_uts_craftables )
	{
        if( uts_craftable.craftablestub.name != str_craftable_name ) continue; // Skip wrong Craftable

        // is_fully_crafted
        if( is_true( level.craftables_crafted[ uts_craftable.craftablespawn.craftable_name ] ) ){
            self iPrintLnBold("^2Already crafted! ^5"+str_craftable_name);
            continue;
        }

        if( isDefined( uts_craftable.onuse ) ) uts_craftable [[uts_craftable.onuse]]( self );
        self [[ @zm_craftables<scripts\zm\craftables\_zm_craftables.gsc>::player_finish_craftable]] (uts_craftable.craftablespawn);
        self thread [[ @zm_unitrigger<scripts\_zm_unitrigger.gsc>::unregister_unitrigger ]](uts_craftable);
        if(isdefined(uts_craftable.craftablestub.onfullycrafted)) uts_craftable [[ uts_craftable.craftablestub.onfullycrafted ]](); // Craft it

	}


}


function is_fully_crafted( str_cratable = "^1Error, undetermined Craftable" ){


	foreach( uts_craftable in level.a_uts_craftables )
	{
        if( uts_craftable.craftablestub.name != str_cratable ) continue; // Skip wrong Craftable

        return is_true( level.craftables_crafted[ uts_craftable.craftablespawn.craftable_name ] );
	}

    self iPrintLnBold( str_cratable );
    return true; // Return true so we avoid building an unknown object
}


function get_craftable_stub( str_craftable_name, zone_name = undefined ){

    // Error, no craftable
    if(!isDefined(str_craftable_name)){
        level.host iPrintLnBold("^1Error, no craftable name in ^5get_craftable_stub");
        return undefined;
    }

    // Any stub
    if( !isdefined( zone_name ) ){
        foreach(uts_craftable in level.a_uts_craftables)
        {
            if(uts_craftable.craftablestub.name != str_craftable_name) continue; // Wrong craftable
            return uts_craftable; // Craftable found
        }

        level thread debug_message("^1Error, couldn't find craftable ^7'^5"+str_craftable_name+"^7'");
        return undefined;
    }

    // Zone name
    if( IsString( zone_name ) ){
        foreach(uts_craftable in level.a_uts_craftables)
        {
            if(uts_craftable.craftablestub.name != str_craftable_name) continue; // Wrong craftable
            if( isDefined(zone_name) && zone_name != [[@zm_zonemgr<scripts\zm\_zm_zonemgr.gsc>::get_zone_from_position]](uts_craftable.origin, 1) ) continue; // Skip the obj on the undesired zone
            return uts_craftable; // Craftable found
        }

        level thread debug_message("^1Error, couldn't find craftable ^7'^5"+str_craftable_name+"^7' in zone ^2"+zone_name);
        return undefined;
    }

    // Origin
    if( isvec( zone_name ) ){
        foreach(uts_craftable in level.a_uts_craftables)
        {
            if(uts_craftable.craftablestub.name != str_craftable_name) continue; // Wrong craftable

            dist = Abs( Distance( zone_name, uts_craftable.origin ) );
            if( dist > 10 ) continue; // Skip the obj on the undesired zone

            return uts_craftable; // Craftable found
        }

        level thread debug_message("^1Error, couldn't find craftable ^7'^5"+str_craftable_name+"^7' in pos ^2"+zone_name);
        return undefined;
    }


    level thread debug_message("^1Error, unreachable get_craftable_stub ^5"+str_craftable_name);
    return undefined;
}


function craft_open_table_object( str_object, zone_name = undefined ){

    if( !isDefined(str_object) ){
        level thread debug_message("^1Error, no str_object in ^5craft_open_table_object");
        return;
    }

    if( is_object_crafted( str_object ) ){
        level thread debug_message("^1Error, open_table Already crafted: ^5"+str_object);
        return;
    }

    if( !isDefined( get_craftable_stub( str_object ) ) ){ // Error check
        level thread debug_message("^1Error, couldn't find the ^5craftable stub ^1for open table object ^7'^5"+str_object+"^7'");
        return;
    }

    table   = get_craftable_stub( "open_table", zone_name );

    if( !isDefined( table ) ){ // Error check
        level thread debug_message("^1Error, couldn't find one ^5open table ^1for craftable object ^7'^5"+str_object+"^7'");
        return;
    }

    if( !isplayer( self ) ) self = level.host;


    // grab all pieces
    self get_full_craftable_object( str_object );

    table.craftablespawn.n_open_craftable_choice = 0;
    table.a_uts_open_craftables_available = [];

    foreach(uts_craftable in level.a_uts_craftables) // Add possible open craftables to the table
    {
        if( is_true(uts_craftable.craftablestub.is_open_table) && !is_true(uts_craftable.crafted) && uts_craftable.craftablespawn.craftable_name != "open_table") //&& uts_craftable.craftablespawn [[ @zm_craftables<scripts\zm\craftables\_zm_craftables.gsc>::craftable_can_use_shared_piece]]() )
        {
            table.a_uts_open_craftables_available[table.a_uts_open_craftables_available.size] = uts_craftable;
            level.host iPrintLnBold("Open table: ADDED ^5"+uts_craftable.craftablespawn.craftable_name);
        }
    }

    if( table.a_uts_open_craftables_available.size < 1 ){
        level thread debug_message( "^1Error, Object is not available for open tables ^5"+str_object+"^7 | N of objs: "+table.a_uts_open_craftables_available.size );
        return;
    }

    for( i=0; i < table.a_uts_open_craftables_available.size; i++ ){

        level.host iPrintLnBold("Open table: OBJECT AVAILABLE ^2"+table.a_uts_open_craftables_available[ i ].equipname);
        wait 1;

        if( table.a_uts_open_craftables_available[ i ].equipname != str_object ) continue;

        table.n_open_craftable_choice = i;
        level.host iPrintLnBold("Crafting object ^2"+table.a_uts_open_craftables_available[ table.n_open_craftable_choice ].equipname );
        self [[ @zm_craftables<scripts\zm\craftables\_zm_craftables.gsc>::player_craft]]( table.craftablespawn );
        table [[ level.zombie_craftablestubs[ str_object ].onfullycrafted ]]();
        return;
    }
    
    level thread debug_message( "^1Error, Couldn't find Object for open tables ^5"+str_object );
}

function is_object_crafted( str_object = undefined ){

    if( !isDefined( str_object ) ){
        level thread debug_message("^1Error, no str_object in ^5is_open_table_object_crafted");
        return false;
    }

    stub = get_craftable_stub( str_object );

    return isdefined( stub ) && isdefined( stub.crafted ) && stub.crafted;
}



function grab_crafted_item( str_craftable = undefined ){

    if( !isDefined(str_craftable) ){ // Undefined name
        level thread debug_message("^1Error, no str_object in ^5grab_crafted_item");
        return;
    }

    if( !isPlayer(self) ){ // Check self is valid player

        level thread debug_message_instant("^1Error, self is not a player in ^5grab_crafted_item");
        level thread debug_message_instant("Using host as default player ^5"+level.host.name);
        self = level.host;
    }

    obj = spawnstruct();

    foreach( uts in level.a_uts_craftables ){
        wait 0.05;

        if( uts.craftablestub.name != str_craftable ) continue;

        level.host iPrintLnBold( uts.craftablestub.name+" ^2Found!" );
        obj.stub = uts;

        if(isdefined( self.screecher_weapon))
        {
            self iPrintLnBold( "^1Can't grab craftable^7 screecher_weapon" );
            return;
        }
        if(isdefined(level.custom_craftable_validation))
        {
            valid = obj [[level.custom_craftable_validation]](self);
            if(!valid)
            {
                self iPrintLnBold( "^1Can't grab craftable^7 level.custom_craftable_validation" );
                return;
            }
        }
        if(!( isdefined(obj.stub.crafted) && obj.stub.crafted ) )
        {
            self iPrintLnBold( "^1Can't grab craftable^7 crafted" );
            return;
        }
        if( ![[@zm_utility<scripts\zm\_zm_utility.gsc>::is_player_valid]]( self ) )
        {
            self [[@zm_utility<scripts\zm\_zm_utility.gsc>::ignore_triggers]]( 0.5 );
            self iPrintLnBold( "^1Can't grab craftable^7 is_player_valid" );
            return;
        }
        if( self [[@zm_equipment<scripts\zm\_zm_equipment.gsc>::has_player_equipment]]( obj.stub.weaponname ) )
        {
            self iPrintLnBold( "^1Can't grab craftable^7 has_player_equipment" );
            return;
        }
        if(isdefined(level.zombie_craftable_persistent_weapon))
        {
            if(obj [[level.zombie_craftable_persistent_weapon]](self))
            {
                self iPrintLnBold( "^1Can't grab craftable^7 level.zombie_craftable_persistent_weapon" );
                return;
            }
        }
        if(isdefined(level.zombie_custom_equipment_setup))
        {
            if(obj [[level.zombie_custom_equipment_setup]](self))
            {
                //self iPrintLnBold( "^1Cant grab craftable^7 level.zombie_custom_equipment_setup" );
                #ifdef dev
                    self iPrintLnBold( "^2Grabbed with custom ^5zombie_custom_equipment_setup^7!" );
                #endif
                return;
            }
        }
        if(![[@zm_equipment<scripts\zm\_zm_equipment.gsc>::is_limited]]( obj.stub.weaponname ) || ![[@zm_equipment<scripts\zm\_zm_equipment.gsc>::is_limited]]( obj.stub.weaponname ) )
        {
            self iPrintLnBold( "^5Good?" );

            self [[@zm_equipment<scripts\zm\_zm_equipment.gsc>::buy]]( obj.stub.weaponname );
            self giveweapon(obj.stub.weaponname);
            self [[@zm_equipment<scripts\zm\_zm_equipment.gsc>::start_ammo]]( obj.stub.weaponname );
            self notify(obj.stub.weaponname.name + "_pickup_from_table");
            if(isdefined(level.zombie_include_craftables[uts.stub.equipname].onbuyweapon))
            {
                obj [[level.zombie_include_craftables[uts.stub.equipname].onbuyweapon]](self);
            }
            else if(obj.stub.weaponname != "keys_zm")
            {
                self setactionslot(1, "weapon", obj.stub.weaponname);
            }
            
        }

        level thread debug_message_instant("^1Error, Unknown at ^7grab_crafted_item");
        return;
    }

}
