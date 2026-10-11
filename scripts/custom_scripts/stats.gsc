function is_super_ee_completed(){

    return self getdstat("PlayerStatsList", "DARKOPS_GENESIS_SUPER_EE", "StatValue") > 0;
}


function set_super_ee_stat( b_complete ){

    a_str_maps = array("ZOD", "FACTORY", "CASTLE", "ISLAND", "STALINGRAD", "GENESIS" );
    foreach( str_map in a_str_maps ){
        self setdstat("PlayerStatsList", "DARKOPS_"+str_map+"_EE", "StatValue", b_complete );
        self setdstat("PlayerStatsList", "DARKOPS_"+str_map+"_SUPER_EE", "StatValue", b_complete );
    }
}

