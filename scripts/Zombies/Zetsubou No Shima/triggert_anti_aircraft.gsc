function watch_anti_aircraft(){

	s_aa_gun = struct::get("aa_gun_trigger", "targetname");

    if( !isdefined( s_aa_gun ) ){
        level thread debug_message("^1Error, missing t_aa_gun");
        return;
    }

	s_aa_gun.script_unitrigger_type = "unitrigger_box_use";
	s_aa_gun.radius = 64;
	s_aa_gun.cursor_hint = "HINT_NOICON";
    s_aa_gun.require_look_at = true;

    s_aa_gun.prompt_and_visibility_func = ::island_aa_prompt_and_visibility_func;
    wait 0.1;

    /*register = @zm_unitrigger<scripts\zm\_zm_unitrigger.gsc>::register_static_unitrigger;
    if( !isdefined( register ) ){
        level thread debug_message("^1Error, no register function...");
        return;
    }

    if( !IsFunctionPtr( register ) ){
        level thread debug_message("^1Error, register is not a function pointer...");
        return;
    }

    [[ register ]](s_aa_gun, ::island_aa_check_for_interact);*/

    [[ @zm_unitrigger<scripts\zm\_zm_unitrigger.gsc>::register_static_unitrigger ]](s_aa_gun, ::island_aa_check_for_interact);

    t_lookat_doppleganger_enable = getent("t_lookat_doppleganger_enable", "targetname");
    if( isdefined( level.host ) ) level.host SetOrigin( t_lookat_doppleganger_enable.origin );
}






function island_aa_prompt_and_visibility_func(player)
{
    //level thread debug_message("^5island_aa_prompt_and_visibility_func");


    if( !player [[@zm_utility<scripts\zm\_zm_utility.gsc>::is_player_looking_at]]( self.origin, 0.5, 0 ) ){
        //player IPrintLnBold("^1Not looking at...");
		//self sethintstring("");
        self sethintstring("^1Not looking at Anti Aircraft...");
        return false;
    }

    //player IPrintLnBold("^2Looking at!");
    self sethintstring("^5Anti Aircraft ^2Ready to use!");
    return true;
}

function island_aa_check_for_interact()
{
    //level thread debug_message("^5island_aa_check_for_interact");
    snd_fire = false;

	for(;;)
	{
		self waittill("trigger", e_who);
        //level thread debug_message_instant("^5AA ^2INTERACTED!");
        e_who IPrintLnBold("^5Anti Aircraft ^2triggered!");

        if( snd_fire ){
            playsoundatposition("wpn_aa_fire", self.origin);
        }else{
            playsoundatposition("zmb_aa_gun_load", self.origin);
        }

        snd_fire = !snd_fire;
	}
}