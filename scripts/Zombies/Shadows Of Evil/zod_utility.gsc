
/*
class csmashable 
{
	var var_afea543d;
	var var_6e27ff4;
	var m_e_trigger;
	var m_a_callbacks;
	var m_a_e_models;
	var m_a_clip;
	var m_func_trig;
	var m_arg;
	var m_b_shader_on;
	var m_a_b_parameters;
	var m_a_nodes;


		m_a_callbacks = [];
		m_a_b_parameters = [];
		m_a_e_models = [];
}


function watch_all_damage(e_clip)
{
    e_clip setcandamage(1);
    while(true)
    {
        e_clip waittill(#"damage", n_amt, e_attacker, v_dir, v_pos, str_type);
        if(isdefined(e_attacker) && isplayer(e_attacker) && (isdefined(e_attacker.beastmode) && e_attacker.beastmode) && str_type === "MOD_MELEE")
        {
            m_e_trigger notify(#"trigger", e_attacker);
            break;
        }
    }
}


foreach(e_clip in m_a_clip)
{
    thread watch_all_damage(e_clip);
}

level.zod_smashables
*/

function smashable_triggers(){

    // Run it for all current players
    foreach( player in GetPlayers()) player thread watch_for_melee();

    // Run it for future players
    for(;;){
        level waittill("connected", player);
        player thread watch_for_melee();
    }

}

function open_all_smashables(){

    if( isdefined( level.host ) ) player = level.host;

    // Maybe we are on a dedicated server,  wait for a player to join
    while( !isdefined( player ) ){
        wait 0.05;
        a_players = GetPlayers();
        if( a_players.size > 0 ) player = GetPlayers()[0];
    }


    foreach( beast_melee in getentarray("beast_melee_only", "script_noteworthy") ){
        level notify("beast_melee", player, beast_melee.origin);
    }

}


function watch_for_melee(){
    self endon( "disconnect" );

    a_beast_melee_only = getentarray("beast_melee_only", "script_noteworthy");

    for(;;){
        self waittill("weapon_melee", weapon);
        //self IPrintLnBold("Melee!");

        // Remove visual point of melee
        if( isdefined( temp_ent ) ) temp_ent delete();
        
        // Calculate beast melee location
        forward = anglestoforward(self getplayerangles());
        up = anglestoup(self getplayerangles());
        meleepos = (self.origin + (15 * up)) + (30 * forward);

        // Create visual object
        temp_ent = spawn("script_model", meleepos );
        temp_ent SetModel( "p7_fxanim_zm_zod_redemption_key_ritual_mod" );

        // Get the Beast Melee Only objects
        t_smashable = ArrayGetClosest( meleepos, a_beast_melee_only );

        // No smashable or not a hit
        if( !isdefined( t_smashable ) || !t_smashable is_smashable_hit(meleepos, 48) ) continue;

        // Print the hit
        self IPrintLnBold("Smashable ^2hit! ^5"+t_smashable.targetname);

        // Not registered?
        if( !isdefined( level.zod_smashables[ t_smashable.targetname ] ) ) continue;
        

        foreach(model in level.zod_smashables[ t_smashable.targetname ].m_a_e_models)
        {
            if(model.targetname == "fxanim_beast_door")
            {
                self IPrintLnBold("Sound ^2"+model.targetname);
                model playsound("zmb_bm_interaction_door");
            }
            else if(model.targetname == "fxanim_crate_breakable_01")
            {
                self IPrintLnBold("Sound ^2"+model.targetname);
                model playsound("zmb_bm_interaction_crate_large");
            }
            else if(model.targetname == "fxanim_crate_breakable_02")
            {
                self IPrintLnBold("Sound ^2"+model.targetname);
                model playsound("zmb_bm_interaction_crate_small");
            }
            else if(model.targetname == "fxanim_crate_breakable_03")
            {
                self IPrintLnBold("Sound ^2"+model.targetname);
                model playsound("zmb_bm_interaction_crate_small");
            }
            else
            {
                #ifdef dev
                    self IPrintLnBold("No sound for ^1"+model.targetname);
                #endif
            }
        }


    }
}


/*
	Name: function_b484a03e
	Namespace: zm_altbody_beast
	Checksum: 0xB66EA038
	Offset: 0x44D0
	Size: 0x7A
	Parameters: 2
	Flags: Linked

    function function_b484a03e(meleepos, radius)
    {
        mins = (radius * -1, radius * -1, radius * -1);
        maxs = (radius, radius, radius);
        return self istouchingvolume(meleepos, mins, maxs);
    }
*/

function is_smashable_hit(meleepos, radius)
{
	mins = (radius * -1, radius * -1, radius * -1);
	maxs = (radius, radius, radius);
	return self istouchingvolume(meleepos, mins, maxs);
}


function infinite_beastmode(){

    for(;;){
        wait 0.05;
        level clientfield::set("bm_superbeast", 1);

        foreach( player in getplayers() ) player.beastlives = 3;
        foreach( kiosk in level.beast_kiosks ) kiosk.is_cooling_down = false;
    }

}
