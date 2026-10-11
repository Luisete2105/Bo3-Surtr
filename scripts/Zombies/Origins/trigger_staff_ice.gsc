function watch_ice_staff_step_2(){

	if( level flag::get("ice_puzzle_1_complete") ) {
		foreach(player in level.players) iPrintLnBold("^1Can't practice Ice Step 2 if Step 1 is already completed...");
		return; // Can't do practice if step is already completed
	}

	a_stone_positions = struct::get_array("puzzle_stone_water", "targetname");
	foreach(s_stone in a_stone_positions)
	{
		s_stone thread check_ice_stones();
	}
}

function check_ice_stones(){

	level endon( "ice_puzzle_1_complete" );

	v_up = anglestoup(self.angles);
	v_spawn_pos = self.origin - (64 * v_up);
	self.e_model = spawn("script_model", v_spawn_pos);
	self.e_model.angles = self.angles;
	self.e_model setmodel("p7_zm_ori_note_rock_01_anim_water");
	self.e_model moveto(self.origin, 1, 0.5, 0.5);
	playfx(level._effect["digging"], self.origin);
	self.e_model setcandamage(1);
	self.e_model playloopsound("zmb_squest_ice_stone_flow", 2);

	for(;;)
	{
		self.e_model waittill( "damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weaponname, idflags);

		if(issubstr(weaponname.name, "water"))
		{
	        self.e_model setmodel("p7_zm_ori_note_rock_01_anim");
	        self.e_model clientfield::set("stone_frozen", 1);
            playsoundatposition("zmb_squest_ice_stone_freeze", self.origin);
		}
		else if(!issubstr(weaponname.name, "staff") && issubstr(type, "BULLET"))
		{
	        self.e_model setmodel("p7_zm_ori_note_rock_01_anim_water");
	        self.e_model clientfield::set("stone_frozen", 0);
            playfx(level._effect["ice_explode"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
	        playsoundatposition("zmb_squest_ice_stone_shatter", self.origin);
		}else{
            inflictor iPrintLnBold("^5"+self.targetname+" ^1Invalid weapon hit...");
            continue;
        }
		
        inflictor iPrintLnBold("^5"+self.targetname+" ^2Hit^7!");
	}

}