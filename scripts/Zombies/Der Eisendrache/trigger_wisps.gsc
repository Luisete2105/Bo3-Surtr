function watch_ee_wisps(){

    wisps = getentarray("activate_teleporter_object", "targetname");
    foreach( wisp in wisps){
        wisp thread wisp_watcher();
    }
}

function wisp_watcher(player){

	self setcandamage(1);
	self.health = 999999;

	s_fx = struct::get(self.target, "targetname");
	s_fx fx::play("battery_charge", s_fx.origin, undefined, "delete_fx", 0, undefined, 1);

	for(;;){
		wait 0.05;
		self waittill( "damage", n_damage, e_attacker, v_direction, v_point, str_means_of_death, str_tag_name, str_model_name, str_part_name, w_weapon );
		if( is_bow_upgraded( w_weapon ) )
		{
			e_attacker iPrintLnBold( "^5"+self.targetname+" ^2Hit^7!" );
			playsoundatposition( "zmb_object_success", (0, 0, 0) );
			wait 0.1;
		}
	}
}