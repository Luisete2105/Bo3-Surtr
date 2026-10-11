function watch_fire_staff_step_2(){

	if( level flag::get("fire_puzzle_1_complete") ) {
		foreach(player in level.players) iPrintLnBold("^1Can't practice Fire Step 2 if Step 1 is already completed...");
		return; // Can't do practice if step is already completed
	}

	a_ternary = getentarray("fire_torch_ternary", "script_noteworthy");
    //level debug_message("Ternary size = "+a_ternary.size); // This must be 4, 1 per code on the wall

	foreach(e_number in a_ternary)
	{
		e_number show();
		e_target_torch = struct::get(e_number.target, "targetname");
		e_target_torch.b_correct_torch = 1;
		//e_target_torch thread check_fire_torch(); // This way we only give hitbox to the right torches
	}


    a_torches = struct::get_array("church_torch_target", "script_noteworthy");
	array::thread_all(a_torches, ::check_fire_torch);

}

function check_fire_torch(){

	level endon( "fire_puzzle_1_complete" );

	max_hit_distance_sq = 4096;
    w_staff_fire = level.a_elemental_staffs["staff_fire"].w_weapon;

	for(;;)
	{
		level waittill( "fire_staff_explosion", v_point, e_projectile);

		dist_sq = distancesquared(v_point, self.origin);
		if(dist_sq > max_hit_distance_sq)
		{
			continue;
		}
		foreach(player in level.players)
		{
			if(player hasweapon( w_staff_fire ))
			{
                if( is_true( self.b_correct_torch ) ){
                    player iPrintLnBold("^5"+self.targetname+" ^2Hit^7!");
                }else{
                    player iPrintLnBold("^5"+self.targetname+" ^1Incorrect torch...");
                }

			}
		}

		wait(2);
	}
}