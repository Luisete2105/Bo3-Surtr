function watch_elec_staff_step_2(){

	if( level flag::get("electric_puzzle_1_complete") ) {
		foreach(player in level.players) iPrintLnBold("^1Can't practice Electric Step 2 if Step 1 is already completed...");
		return; // Can't do practice if step is already completed
	}

    array::thread_all(level.electric_relays, ::check_electric_switch);
}

function check_electric_switch(){
	level endon( "electric_puzzle_1_complete" );

    while( !isDefined(self.trigger_stub) ) wait 0.1;

	for(;;)
	{
		self.trigger_stub waittill( "trigger", player);
        wait 0.05;

        str_target_relay = self.connections[self.position];
		if(isdefined(str_target_relay))
		{
            player iPrintLnBold("^2Correct switch^7"+"^5 "+str_target_relay+"^7!");
		}else{
            player iPrintLnBold("^1Wrong switch position...");
        }

        self.e_switch waittill( "rotatedone" );
	}
}