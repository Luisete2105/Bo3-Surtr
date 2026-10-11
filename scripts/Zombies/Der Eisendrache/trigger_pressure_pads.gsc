function activate_pressure_pads(){

    a_grav_pad_triggers = getentarray("grav_pad_trigger", "targetname");

    foreach( grav_pad_trigger in a_grav_pad_triggers ) grav_pad_trigger thread fake_player_pressure();

    level thread inf_gravity();
}

function fake_player_pressure(){

    if( isdefined( level.host ) ) player = level.host;
    else player = getplayers()[ 0 ];

    self LinkTo(player, "tag_origin");
    self.original_position = self.origin;
    self moveto( player.origin, 0.5 );
    self waittill( "movedone" );
    wait 0.1;

    level wait_till("pressure_pads_activated");

    self Unlink();
    self moveto( self.original_position, 0.5 );
    self waittill( "movedone" );
    self.original_position = undefined;
}

function inf_gravity(){
    level endon( "end_of_game" );

    for(;;){
        level flag::set("low_grav_on");
        level flag::wait_till_clear("low_grav_on");
    }
}