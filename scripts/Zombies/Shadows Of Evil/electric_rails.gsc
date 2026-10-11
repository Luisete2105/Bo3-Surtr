function electric_rails(){
    for(i = 1; i < 4; i++)
	{
        // TODO: do proper checks to know if we shouldn't do this (EE step already completed )
		level thread watch_electric_rails(i);
	}
}

function watch_electric_rails(index){
    level endon("ee_final_boss_defeated");
	level endon("ee_final_boss_staggered");
    
	str_targetname = "ee_district_rail_electrified_" + index;
	t_elec_rail = getent(str_targetname, "targetname");
	mdl_rail = getent(t_elec_rail.target, "targetname");
	mdl_rail thread watch_lightning_damage(t_elec_rail);
	mdl_rail clientfield::set("ee_rail_electricity_state", 0);
	for(;;)
	{
		t_elec_rail waittill("trigger", player);
        player IPrintLnBold( sprintf("^5{0} ^2Hit!", str_targetname) );
        mdl_rail thread iluminate_rail(index);
	}
}

function iluminate_rail(index){
    self notify("rail_iluminate");
    self endon("rail_iluminate");

    str_scenename = get_electric_rail_scene(index);
    self clientfield::set("ee_rail_electricity_state", 1);
    level thread scene::play(str_scenename);
    showmiscmodels("train_rail_glow_" + index);
    hidemiscmodels("train_rail_wet_" + index);

    wait 1;
    self clientfield::set("ee_rail_electricity_state", 0);
    level thread scene::stop(str_scenename);
    showmiscmodels("train_rail_wet_" + index);
    hidemiscmodels("train_rail_glow_" + index);
}

function get_electric_rail_scene(index)
{
	switch(index)
	{
		case 1:
		{
			return "p7_fxanim_zm_zod_train_rail_spark_canal_bundle";
		}
		case 2:
		{
			return "p7_fxanim_zm_zod_train_rail_spark_waterfront_bundle";
		}
		case 3:
		{
			return "p7_fxanim_zm_zod_train_rail_spark_footlight_bundle";
		}
	}
}