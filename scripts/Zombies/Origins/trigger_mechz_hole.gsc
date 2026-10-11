function general_watch_ee_mechz_hole(){

    foreach(player in level.players){
        player thread watch_ee_mechz_hole();
    }

}

function watch_ee_mechz_hole(){

    t_hole = getent("fire_link_damage", "targetname");

    for(;;){
        self waittill( "grenade_fire", grenade, weapon );
        if( weapon != level.w_beacon) continue;

        grenade waittill("stationary");
        if( grenade isTouching( t_hole ) ){
            self iPrintLnBold( "^5"+t_hole.targetname+" ^2Hit^7!" );
        }
    }

}