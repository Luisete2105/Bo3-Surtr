function watch_ee_control_panel(){

    trig_control_panel = getent("trig_ee_flytrap", "targetname");

    for(;;)
	{
		trig_control_panel waittill( "damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weapon);
        inflictor iPrintLnBold("^5"+trig_control_panel.targetname+" ^2Hit^7!");
	}

}

function watch_ee_hide_and_seek(){

    targets = array( "ee_exp_monkey", "ee_perk_bear", "ee_bowie_bear" );

    for(i=0; i<targets.size; i++){

        target = getentarray( targets[i], "targetname" );
        foreach( ent in target) ent show();

        trigger = getent( "trig_" + targets[i], "targetname" );
        trigger TriggerEnable( true );
        sound = "zmb_flytrap_target_" + (i+1);
        trigger thread watch_trigger_snd( sound );
    }

}

function watch_flytrap_prize(){

    getent( "flytrap_prize", "targetname" ) thread watch_trigger();
}


function watch_ee_extra_events(){

    getentarray("trig_ee", "targetname")[0] notify( "trigger" ); // little note on VMP room
    getent("cipher_brick_main", "script_noteworthy") notify("trigger_activated"); // Encrypted message on VMP room
}

function autocomplete_hidden_perk_quest(){


    trigs = [];
    for(i=0; i<3;i++) trigs[trigs.size] = getEnt( "trigger_teleport_pad_" + i, "targetname" );

    teles = [];
    for(i=0; i<3;i++) teles[teles.size] = getEnt( "tele_help_" + i, "targetname" );

    core = GetEnt( "trigger_teleport_core", "targetname" );

    while( level.active_links < 3 ){
        wait 0.05;

        foreach(trig in trigs) trig notify( "trigger", level.host );
        foreach(tele in teles) tele notify( "trigger", level.host );
        core notify( "trigger", level.host);
    }

    flags = array( "console_one_completed", "console_two_completed", "console_three_completed" );
    foreach( flag in flags )
        level flag::set( flag );
    

    wait 0.1;

    s_console = struct::get( "snowpile_console" );
    s_console notify ( "trigger_activated" );
}
