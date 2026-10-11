// For TDOT
/* zm_castle_weap_quest_upgrade<scripts\zm\zm_castle_weap_quest_upgrade.gsc>::function_88082ccd(){
	/#
		level endon(#"hash_e09edb0");
	#/

	//level thread debug_message("Hello 1");

    self [[ @zm_castle_weap_quest_upgrade<scripts\zm\zm_castle_weap_quest_upgrade.gsc>::function_3313abd5 ]]();
	while(true)
	{
		self.t_unitrigger waittill("trigger", e_who);
		if(e_who === level.var_c62829c7)
		{
			//zm_unitrigger::unregister_unitrigger(self.t_unitrigger);
			[[ @zm_unitrigger<scripts\_zm_unitrigger.gsc>::unregister_unitrigger ]]( self.t_unitrigger );
			break;
		}
	}

	//level thread debug_message("Los dosh");

	e_who playrumbleonentity("zm_castle_quest_interact_rumble");
	level.func_rune_prison_disconnect = undefined;
	level notify(#"hash_40e6d9e7");
	/#
		level flag::set("");
	#/
	var_2716c17 = struct::get_array("aq_rp_fireplace_struct", "targetname");
	//var_7f680434 = array::random(var_2716c17);
    var_7f680434 = var_2716c17[1];
    level [[ @zm_castle_weap_quest_upgrade<scripts\zm\zm_castle_weap_quest_upgrade.gsc>::function_16248b25 ]]( var_7f680434.script_int );
	var_235830d3 = var_7f680434.script_noteworthy;
	var_42d1b62e = getentarray("aq_rp_runic_circle", "script_noteworthy");
	foreach(var_9c1f46d7 in var_42d1b62e)
	{
		if(var_9c1f46d7.script_label != var_235830d3)
		{
            var_9c1f46d7 thread [[ @zm_castle_weap_quest_upgrade<scripts\zm\zm_castle_weap_quest_upgrade.gsc>::function_aea90ad4 ]]();
		}
	}
	var_11307e05 = getentarray("aq_rp_runic_circle_symbol", "script_noteworthy");
	foreach(var_92fe416a in var_11307e05)
	{
		if(var_92fe416a.script_label != var_235830d3)
		{
            var_92fe416a thread [[ @zm_castle_weap_quest_upgrade<scripts\zm\zm_castle_weap_quest_upgrade.gsc>::function_561d0d99 ]]();
		}
	}
	var_faf17913 = getentarray("aq_rp_runic_circle_volume", "script_noteworthy");
	foreach(var_9ea56658 in var_faf17913)
	{
		if(var_9ea56658.script_label != var_235830d3)
		{
			var_9ea56658 delete();
			continue;
		}
		var_7a76a496 = var_9ea56658;
	}
	var_7a76a496.var_336f1366 = var_7f680434;
	var_9c1f46d7 = getent(var_7a76a496.target, "targetname");
	var_9c1f46d7 clientfield::set("runic_circle_fx", 1);

	level thread debug_message("Pet the ^5DOG");

	return var_7a76a496;
}*/

