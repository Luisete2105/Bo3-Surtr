

function genesis_keeper_started(){

    if( !isdefined( level.ai_companion ) ) return false;
    return is_true( level.ai_companion.var_57376ff1 );
}

function genesis_ee_end(){

    level waittill( #"hash_91a3107" );
    return true;
}