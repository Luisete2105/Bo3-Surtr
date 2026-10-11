function watch_air_staff_step_2(){

	if( level flag::get("air_puzzle_1_complete") ) {
		foreach(player in level.players) iPrintLnBold("^1Can't practice Air Step 2 if Step 1 is already completed...");
		return; // Can't do practice if step is already completed
	}

    a_smoke_pos = struct::get_array("puzzle_smoke_origin", "targetname");
    foreach( smoke_pos in a_smoke_pos ){
        smoke_pos thread check_smoke_pos();
    }
}

function check_smoke_pos(){

	level endon("air_puzzle_1_complete");

	self thread delete_on_air_1_completed();

	self.lui_e_fx = spawn("script_model", self.origin);
	self.lui_e_fx.angles = self.angles;
	self.lui_e_fx setmodel("tag_origin");
	self.lui_e_fx playloopsound("zmb_squest_wind_incense_loop", 2);
	playfxontag(level._effect["air_puzzle_smoke"], self.lui_e_fx, "tag_origin");


	s_dest = struct::get("puzzle_smoke_dest", "targetname");
	v_to_dest = vectornormalize(s_dest.origin - self.origin);
	f_min_dot = cos(self.script_int);

	self.lui_detector_brush = getent(self.target, "targetname");
	self.lui_detector_brush setcandamage(1);
	self.lui_solved = 0;

	for(;;)
	{
		self.lui_detector_brush waittill( "damage", damage, attacker, direction_vec, point, mod, tagname, modelname, partname, weaponname);
		if(weaponname.name == "staff_air")
		{
			new_yaw = math::vec_to_angles(direction_vec);
			new_orient = (0, new_yaw, 0);
			self.lui_e_fx rotateto(new_orient, 1, 0.3, 0.3);
			self.lui_e_fx waittill( "rotatedone" );
			f_dot = vectordot(v_to_dest, direction_vec);
			self.lui_solved = f_dot > f_min_dot;

			if(!self.lui_solved)
			{
                attacker iPrintLnBold( "^1Bad ^7angle | ^1"+f_dot+" ^7> "+f_min_dot );
			}
			else
			{
                attacker iPrintLnBold( "^2Good ^7angle | ^2"+f_dot+" ^7> "+f_min_dot );
			}

		}

	}

}

function delete_on_air_1_completed(){

	level waittill("air_puzzle_1_complete");

	self.lui_e_fx delete();
	self.lui_detector_brush = undefined;
	self.lui_solved = false;

}