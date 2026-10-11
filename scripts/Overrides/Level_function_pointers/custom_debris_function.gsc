//level.custom_debris_function
//self [[level.custom_debris_function]]();

function fix_undefined_target_blockers(){
    
    //self notify( "kill_debris_prompt_thread" ); // We get this notify whenever a debris has been opened

    //level notify( #"junk purchased" ); // We get this notify whenever a debris has been opened

    //level.custom_debris_function = ::surtr_custom_debris_function;
}

function surtr_custom_debris_function(){

    if( !isdefined( self.target ) ) self.target = "";

    logPrint("custom_debris_function");
    level thread debug_message("Fixing debris think");
    if( isdefined( level.host ) ) level.host setOrigin(self.origin);
}