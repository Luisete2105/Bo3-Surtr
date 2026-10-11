function watch_trigger(){

    for(;;){
        wait 0.05;
        self waittill( "trigger", player );
        player iPrintLnBold("^5"+self.targetname+" ^2hit^7!");
    }

}

function watch_trigger_snd( sound ){

    for(;;){
        self waittill( "trigger", player );
        self playsound( sound );
        player iPrintLnBold("^5"+self.targetname+" ^2hit^7!");
    }

}

// Based on Scrappy's Practice Tool
function build_and_activate_trigger_from_unitrigger_stub(stub)
{

    if(!isdefined(stub)){
        //self iPrintLnBold("^1Error, no STUB detected");
        return;
    }

    trig = [[@zm_unitrigger<scripts\zm\_zm_unitrigger.gsc>::check_and_build_trigger_from_unitrigger_stub]](stub, self);
    //trig = zm_unitrigger::check_and_build_trigger_from_unitrigger_stub(stub, self);

    if(!isdefined(trig)){
        self iPrintLnBold("^1Error, no trigger detected 1");
        return;
    }

    // Mandatory values
    if( !isdefined( trig.origin ) )         trig.origin = isdefined(stub.origin) ? stub.origin : (0,0,0);
    if( !isdefined( trig.angles ) )         trig.angles = isdefined(stub.angles) ? stub.angles : (0,0,0);

    // Fixed values in case they don't exist
    if( !isdefined( trig.radius ) )         trig.radius         = isdefined(stub.radius) ? stub.radius : 64;
    if( !isdefined( trig.script_height ) )  trig.script_height  = isdefined(stub.script_height) ? stub.script_height : 64;
    if( !isdefined( trig.script_width ) )   trig.script_width   = isdefined(stub.script_width) ? stub.script_width : 64;
    if( !isdefined( trig.script_length ) )  trig.script_length  = isdefined(stub.script_length) ? stub.script_length : 64;

    // Extra values in case they exist
    if( !isdefined( trig.script_noteworthy )&& isdefined( stub.script_noteworthy ) )    trig.script_noteworthy = stub.script_noteworthy;
    if( !isdefined( trig.targetname )       && isdefined( stub.targetname ) )           trig.targetname = stub.targetname;
    if( !isdefined( trig.target )           && isdefined( stub.target ) )               trig.target = stub.target;
    if( !isdefined( trig.weapon )           && isdefined( stub.weapon ) )               trig.weapon = stub.weapon;
    if( !isdefined( trig.clientfieldname )  && isdefined( stub.clientfieldname ) )      trig.clientfieldname = stub.clientfieldname;
    if( !isdefined( trig.usetime )          && isdefined( stub.usetime ) )              trig.usetime = stub.usetime;

    trig [[@zm_unitrigger<scripts\zm\_zm_unitrigger.gsc>::assess_and_apply_visibility]](trig, trig,stub, self, 1);

    trig.origin = self.origin;
    wait 0.1; // just in case
    

    if( isPlayer( self ) ){
        trig.origin = self.origin;
        trig notify("trigger", self);
    }
	else{
        trig.origin = level.host.origin;
        trig notify( "trigger", level.host );
    }
    
	wait 0.05; // just in case

	if( isdefined( trig ) )
	{
        [[@zm_unitrigger<scripts\zm\_zm_unitrigger.gsc>::unregister_unitrigger]](trig);
		//zm_unitrigger::unregister_unitrigger(trig);
	}

}

function get_trigger_from_origin( position = undefined, zone_name = undefined ){

    if( !isdefined( position ) ){
        //level thread debug_message( "^1No position to search the trigger!" );
        return undefined;
    }

    if( isdefined( zone_name ) && isdefined( level.zones[ zone_name ] ) ){

        for( i=0; i<level.zones[ zone_name ].unitrigger_stubs.size; i++){
            if( abs( distance( level.zones[ zone_name ].unitrigger_stubs[i].origin, position) ) < 10  ){
                #ifdef dev
                    //level thread debug_message( "Trigger found at ^5"+zone_name+" ^7Nº^5"+i );
                #endif
                return level.zones[ zone_name ].unitrigger_stubs[i];
            }
        }

        //level thread debug_message( "^1Error, couldn't find the trigger..." );
        return undefined;
    }

    best = undefined;

    foreach( zone_name, zone in level.zones ){


        for( i=0; i<zone.unitrigger_stubs.size; i++){

            if( !isdefined( best ) ){
                best = zone.unitrigger_stubs[i];
            }
            else{
                if( abs( distance( zone.unitrigger_stubs[i].origin, position) ) <  abs( distance( best.origin, position) ) ){
                    best = zone.unitrigger_stubs[i];
                }
            }

            if( abs( distance( zone.unitrigger_stubs[i].origin, position) ) < 10  ){
                #ifdef dev
                    //level thread debug_message( "Trigger found at ^5"+zone_name+" ^7Num ^5"+i );
                #endif
                return zone.unitrigger_stubs[i];
            }
        }

    }

    //level thread debug_message( "^1Error, couldn't find the trigger..." );
    //level.host setOrigin( best.origin );
    return undefined;

}