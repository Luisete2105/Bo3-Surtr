function watch_for_weather_vane(){
    level endon( "end_of_game" );

    // trigger ( -184, 1879, 1233 )
    // model ( -184, 1878, 1196 )

    fake_weather_vane =  Spawn( "script_model", ( -184, 1879, 1233 ) );
    fake_weather_vane.targetname = "fake_weather_vane";
    fake_weather_vane.angles = ( 0, 0, 0 );
    fake_weather_vane SetModel( "defaultactor" );
    fake_weather_vane Hide();


    for(;;){
        foreach( player in getplayers() ) player thread check_weather_vane_hit();
        level waittill( "connected" );
    }

}

function check_weather_vane_hit(){

    level endon( "end_of_game" );
    self endon( "disconnect" );

    self notify( "watch_weather_vane" );
    self endon( "watch_weather_vane" );

    fake_weather_vane = GetEnt("fake_weather_vane", "targetname");

    //aq_es_weather_vane = getent("aq_es_weather_vane", "targetname");
    //aq_es_weather_vane_trig = getent("aq_es_weather_vane_trig", "targetname");

    for(;;){

        self waittill( "projectile_impact", weapon, point, radius );
        fake_weather_vane.health = 7777777;
        

        if( !isdefined( weapon ) || !isdefined( weapon.name ) ) continue; // Can't get weapon info
        if( !issubstr( weapon.name, "elemental_bow" ) ) continue; // Wrong weapon
        if( !isdefined( point ) ) continue;

        //self IPrintLnBold( "Distance = ^5"+abs( Distance( point, fake_weather_vane.origin ) ) );

        if( distance( point, fake_weather_vane.origin ) <= 77 ){ // Check by distance
            self iPrintLnBold("^5Weather Vane ^2Hit^7!");
            //self playsound("evt_arrow_souls_ready");
            self playsound("zmb_arrow_reforged");
            //self playsound("uin_igc_skip"); // Deafens the player LOOOOOL
        }

        /*impact = spawn("script_origin", point);
        if( impact isTouching( fake_weather_vane ) ){ // Check by hitbox
            self iPrintLnBold("SIUUUUUU");
            self playsound("zmb_beacon_ignite");
        }
        impact delete();*/


    }

}