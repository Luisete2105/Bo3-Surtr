
// self [[level.zombiemode_offhand_weapon_give_override]](weapon) // Self is player and Weapon is a weapon object

/*  How to?
    1) Check if the function exists within the map to override it.
    2) We are overriding initial weapon loadout so they set a var on the player whenever we are giving initial weapons
    3) We return true only if this new var is defined and true
    4) otherwise return the result of the original function pointer or false if undefined
*/

function hook_zombiemode_offhand_weapon_give_override(){

    // Not all maps have this function pointer
    wait_zombiemode_offhand_weapon_give_override();

    level.zombiemode_offhand_weapon_give_override = ::surtr_zombiemode_offhand_weapon_give_override;
    //level thread debug_message( "hook_zombiemode_offhand_weapon_give_override" );
}

function surtr_zombiemode_offhand_weapon_give_override( weapon ){

    #ifdef dev
        /*str_message = "^2";
        str_message += MakeLocalizedString( weapon.rootweapon.displayname )+" ^7is weapclass^5 ";
        str_message += weapon.rootweapon.weapclass;
        level thread debug_message( str_message );

        level thread debug_message( "surtr_zombiemode_offhand_weapon_give_override" );*/
    #endif


    if( !is_tactical_grenade( weapon ) ){
        //self IPrintLnBold( "offhand override "+weapon.name);
        self thread apply_weapon_settings( weapon );
    }

    if( isdefined( level.old_zombiemode_offhand_weapon_give_override ) ) return self [[level.old_zombiemode_offhand_weapon_give_override]]( weapon );
    return false;
}

function wait_zombiemode_offhand_weapon_give_override(){

    switch( MAP_NAME ){

        case SHADOWS_OF_EVIL:
        case THE_GIANT:
        case DER_EISENDRACHE:
        case ZETSUBOU_NO_SHIMA:
        case GOROD_KROVI:
        case REVELATIONS:
        case ASCENSION:
        case MOON:
        case ORIGINS:
        {
            while( !isdefined( level.zombiemode_offhand_weapon_give_override ) ) wait 0.05;
            level.old_zombiemode_offhand_weapon_give_override = level.zombiemode_offhand_weapon_give_override;
        }
    }

}

function weapon_is_tuneable( weapon ){

    switch( weapon.weapclass ){
        case "grenade":
        case "melee":
            return false;
    }

    return true;
}