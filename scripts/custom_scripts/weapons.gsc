// Correct way to check if a weapon has an altweapon (mainly used to avoid CI when trying to change a camo)
function is_altweapon( weapon ){

    if( !isdefined( weapon ) ) return false; // Undefined check
    if( !IsWeapon( weapon ) ) return false; // Not a weapon
    if( weapon.isaltmode ) return true; // Current weapon has alt weapon and it's active
    return weapon.altweapon.isaltmode; // Current weapon doesn't have alt mode active but maybe its alt weapon has it active
}

// Get the actual built weapon from a root weapon
function get_players_weapon_from_rootweapon( weapon ){

    weapon = weapon.rootweapon;

    foreach( w_list in self GetWeaponsListPrimaries() ){
        if( w_list.rootweapon == weapon ) return w_list;
        if( w_list.rootweapon == level.zombie_weapons[ weapon ].upgrade ) return w_list;
    }

    // Undefined is an expected valid value
    return undefined;
}

// Get current AAT
function get_aat_for_weapon( weapon ){
    weapon = get_nonalternate_weapon(weapon);
    //name = "none";
    if( !isdefined( self.aat ) ) return name;
    
    if(isdefined(self.aat[weapon]))
    {
        name = self.aat[weapon];
    }

    return name;
}

// Get base weapon from buildkits
function get_buildkit_Weapon( weapon ){

    weapon = get_nonalternate_weapon( weapon );
    b_upgraded = is_weapon_upgraded( weapon );
    base_weapon = self getbuildkitweapon(weapon.rootweapon, b_upgraded);

    return base_weapon;
}

// Check if weapon has an attachment that should not be ignored
function weapon_has_any_non_ignored_attachment( weapon ){

    foreach( attachment in weapon.attachments ){
        if( !IsInArray(IGNORED_ATTACHMENTS, attachment) ) return true;
    }

    return false;
}

// Check if weapon supports a valid attachment
function weapon_supports_any_non_ignored_attachment( weapon ){

    foreach( attachment in weapon.rootweapon.supportedattachments ){
        if( !IsInArray(IGNORED_ATTACHMENTS, attachment) ) return true;
    }

    return false;

}

// Check if weapon supports StatTrak attachment
function weapon_supports_sttattrak( weapon ){

    return ( (weapon.rootweapon.supportedattachments.size > 0) && IsInArray(weapon.rootweapon.supportedattachments, ATTACHMENT_STATTRAK) );
}


// Weapon's config flags
function enable_weapon_flag_bit( bit ){

	// Undefined BIT
	if( !isdefined( bit ) ){
		level thread debug_message( sprintf("^1Error, missing ^5BIT ^1in function ^6{1}", "BIT", "enable_weapon_flag_bit") );
		return;
	}

	FLAG_SAVED_WEAPON_SETTINGS |= bit;
}

function disable_weapon_flag_bit( bit ){

	// Undefined BIT
	if( !isdefined( bit ) ){
		level thread debug_message( sprintf("^1Error, missing ^5BIT ^1in function ^6{0}", "disable_weapon_flag_bit") );
		return;
	}

	FLAG_SAVED_WEAPON_SETTINGS &= ~bit;
}

function is_any_weapon_setting_enabled(){

	return FLAG_SAVED_WEAPON_SETTINGS > 0;
}

function is_weapon_setting_bit_enabled( bit ){

	// Undefined BIT
	if( !isdefined( bit ) ){
		level thread debug_message( sprintf("^1Error, missing ^5BIT ^1in function ^6{0}", "is_weapon_setting_bit_enabled") );
		return false;
	}

    // is it possible that the host (or other player) loads before the gameplay init event happens? specially on fast_restarts
    wait_for_active_weapon_settings();

	return (FLAG_SAVED_WEAPON_SETTINGS & bit);
}

function is_weapon_setting_bit_active( bit ){

	// Undefined BIT
	if( !isdefined( bit ) ){
		level thread debug_message( sprintf("^1Error, missing ^5BIT ^1in function ^6{0}", "is_weapon_setting_bit_active") );
		return false;
	}

	return(FLAG_ACTIVE_WEAPON_SETTINGS & bit);
}

function wait_for_active_weapon_settings(){
    
    // I think this never happens
    if( !isdefined( FLAG_SAVED_WEAPON_SETTINGS ) ) level thread debug_message("Undefined FLAG_SAVED_WEAPON_SETTINGS");
    while( !isdefined( FLAG_SAVED_WEAPON_SETTINGS ) ) wait 0.05;
}