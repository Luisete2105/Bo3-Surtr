function watch_beacons(){
    level endon( "end_of_game" );

    foreach( beacon in getentarray( "aq_es_beacon_trig", "script_noteworthy" ) ){
        if( !is_true( beacon.b_lit ) ){
            s_beacon = struct::get(beacon.target);

            if( !isdefined( s_beacon.mdl_fx_anchor ) ){
                s_beacon.mdl_fx_anchor = util::spawn_model("tag_origin", s_beacon.origin);
                s_beacon.mdl_fx_anchor clientfield::set("beacon_fx", 1);
            }

        }
    }

    for(;;){
        foreach( player in getplayers() ) player thread check_beacon_hit();
        level waittill( "connected" );
    }


}

function check_beacon_hit(){
    level endon( "end_of_game" );
    self endon( "disconnect" );

    self notify( "watch_beacons" );
    self endon( "watch_beacons" );

    for(;;){

        self waittill( "projectile_impact", weapon, point, radius );

        if( !isdefined( weapon ) || !isdefined( weapon.name ) || !isdefined( point ) ) continue;
        if( is_bow_upgraded( weapon ) ) continue;

        impact = spawn("script_origin", point);

        foreach( beacon in getentarray("aq_es_beacon_trig", "script_noteworthy")){
            if( impact isTouching( beacon ) ){
                self iPrintLnBold("^5"+beacon.targetname+" ^2Hit^7!");
                beacon playsound("zmb_beacon_ignite");
                break;
            }
        }

        impact delete();

    }
}

function is_bow_upgraded( weapon ){

    if( !isDefined( weapon ) || !IsWeapon( weapon ) ) return false;
    return issubstr(weapon.name, "elemental_bow_demongate") || issubstr(weapon.name, "elemental_bow_rune_prison") || issubstr(weapon.name, "elemental_bow_storm") || issubstr(weapon.name, "elemental_bow_wolf_howl" );
}