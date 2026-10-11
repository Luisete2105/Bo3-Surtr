/*
	Name: register
	Namespace: system
	Checksum: 0x893F9999
	Offset: 0xC8
	Size: 0x174
	Parameters: 4
	Flags: Linked
*/
//function register(str_system, func_preinit, func_postinit, reqs = [])
/*detour system<scripts\shared\system_shared.gsc>::register(str_system, func_preinit, func_postinit, reqs = [])
{

	if(isdefined(level.system_funcs) && isdefined(level.system_funcs[str_system]))
	{
		/#
			assertmsg(("" + str_system) + "");
		#/
		return;
	}

	if(!isdefined(level.system_funcs))
	{
		level.system_funcs = [];
	}

    if( isdefined( str_system ) ){
        switch( str_system ){
            case "zm_castle_weap_quest_upgrade":
            {
                //level thread debug_message("^2Detour Relink: ^5"+str_system);
                compiler::relinkdetours();
                break;
            }
        }
    }

	level.system_funcs[str_system] = spawnstruct();
	level.system_funcs[str_system].prefunc = func_preinit;
	level.system_funcs[str_system].postfunc = func_postinit;
	level.system_funcs[str_system].reqs = reqs;
	level.system_funcs[str_system].predone = !isdefined(func_preinit);
	level.system_funcs[str_system].postdone = !isdefined(func_postinit);
	level.system_funcs[str_system].ignore = 0;
}*/
