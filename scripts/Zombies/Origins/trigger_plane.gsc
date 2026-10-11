function stwb_spawns(){

    level thread spawn_biplane();
    level thread spawn_pilot();

    level.callbackvehicledamage = ::ee_plane_vehicledamage;

    if( level flag::get( "ee_mech_zombie_fight_completed" ) ) return;

    level wait_till( "ee_mech_zombie_fight_completed" );
    wait 5;
    level.callbackvehicledamage = ::ee_plane_vehicledamage;
}

function ee_plane_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{

    //if( isDefined(self.targetname) ) level.host iPrintLnBold("self.targetname: ^5"+self.targetname);
    //if( isDefined( self.vehicletype ) ) //level.host iPrintLnBold( self.vehicletype ); // Origins tank => "tank_mark_iv_zm"

    if( is_true( self.lui_trainner ) ){
        eattacker iPrintLnBold( "^5"+self.targetname+" ^2Hit^7!" );
        eattacker playsound("wpn_rocket_explode");
        self notify( "plane_reset" );
        return 0;
    }

	if(isdefined(level.a_func_vehicle_damage_override[self.vehicletype])) // zm_tomb.gsc
	{
        //level.host iPrintLnBold("Found damage override for ^5"+self.vehicletype);
		return level.a_func_vehicle_damage_override[self.vehicletype];
	}

	if(isplayer(eattacker) && self.vehicletype == "biplane_zm" && !self flag::get("biplane_down") && self.targetname == "air_crystal_biplane" ) // zm_tomb_main_quest.gsc
	{
		self flag::set("biplane_down");
		level notify("biplane_down");
	}
    
	if(self.vehicletype == "biplane_zm" && !self flag::get("biplane_down") && self.targetname == "zombie_blood_biplane" ) // zm_tomb_ee_main_step_5.gsc
	{
		if(isplayer(eattacker) && eattacker.zombie_vars["zombie_powerup_zombie_blood_on"])
		{
			self flag::set("biplane_down");
		}
		return 0;
	}

	return idamage;
}

function spawn_pilot(){

    z_pilot_positions = struct::get_array( "pilot_goal", "script_noteworthy" );
    z_dig_spawner = getentarray( "zombie_spawner_dig", "script_noteworthy" )[0];

    //level.host iPrintLnBold();

    foreach( index, z_pos in z_pilot_positions ){

        z_pilot = undefined;
        z_pilot = zombie_utility::spawn_zombie( z_dig_spawner, "zombie_blood_pilot" );
        wait 0.2;

        z_pilot setCanDamage( true );
        z_pilot setentitypaused( true );
        z_pilot.maxhealth = 7777777;
        z_pilot.health = 7777777;

        z_pilot.test_zombie = true; // Avoids death by insta kill
        z_pilot.pilot_spawn = "z_pilot_"+index;

        z_pilot.actor_damage_func = ::zpilot_print; // Overrides damage functions
        z_pilot.ignore_round_spawn_failsafe = true;
        z_pilot.ignore_enemy_count = true;
        z_pilot.ignore_nuke = true;
        z_pilot.ignore_round_robbin_death = true;
        z_pilot.completed_emerging_into_playable_area = true;
        z_pilot.no_powerups = true;
        z_pilot notify( "completed_emerging_into_playable_area" );
        z_pilot.b_ignore_cleanup = true;
        z_pilot ForceTeleport( z_pos.origin, z_pos.angles, 0);

    }

}

function zpilot_print( einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex ){

    eattacker iPrintLnBold( "^5Hit ^7by ^1"+idamage+"^7 [^5"+shitloc+"^7] | ^5"+self.pilot_spawn );
    return 0;
}

function spawn_biplane(){

    lui_plane = spawnvehicle("biplane_zm", (0,0,0), (0,0,0), "zm_biplane");
    lui_plane.health = 10000;
    lui_plane setcandamage(1);
	lui_plane setforcenocull();
    lui_plane attachpath( getvehiclenode("biplane_start", "targetname") );
    //lui_plane setspeed(15, 3, 1); // Slow speed
    lui_plane setspeed(75, 15, 5); // Default speed
    lui_plane startpath();
    lui_plane.lui_trainner = true;

    for(;;){
        //wait 7; // default time
        lui_plane util::waittill_any_timeout(7, "plane_reset" );
        lui_plane attachpath( getvehiclenode("biplane_start", "targetname") );
    }

}

function remove_plane_fire_fx(){

    e_fx_tag = getent("air_crystal_biplane_tag", "targetname");
    if( !isDefined(e_fx_tag)) return; // it's probably already destroyed
    e_fx_tag clientfield::set("plane_fx", 0);
}

