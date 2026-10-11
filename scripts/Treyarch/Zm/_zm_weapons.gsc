/* 1671
	Name: get_ammo_cost
	Namespace: zm_weapons
	Checksum: 0xEBBF3F4F
	Offset: 0x4B20
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function get_ammo_cost(weapon)
{
	return level.zombie_weapons[weapon].ammo_cost;
}

/* 1945
	Name: get_base_weapon
	Namespace: zm_weapons
	Checksum: 0xB299AED7
	Offset: 0x5358
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function get_base_weapon(upgradedweapon)
{
	upgradedweapon = get_nonalternate_weapon(upgradedweapon); // We already have get_nonalternate_weapon on shared/aat_shared.gsc
	upgradedweapon = upgradedweapon.rootweapon;
	if(isdefined(level.zombie_weapons_upgraded[upgradedweapon]))
	{
		return level.zombie_weapons_upgraded[upgradedweapon];
	}
	return upgradedweapon;
}

/* 2022
	Name: weapon_supports_aat
	Namespace: zm_weapons
	Checksum: 0xC916A679
	Offset: 0x56B8
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function weapon_supports_aat(weapon)
{
	if(weapon == level.weaponnone || weapon == level.weaponzmfists)
	{
		return false;
	}

	weapontopack = get_nonalternate_weapon(weapon); // We already have get_nonalternate_weapon on shared/aat_shared.gsc
	rootweapon = weapontopack.rootweapon;
	if(!is_weapon_upgraded(rootweapon))
	{
		return false;
	}

	if(!is_exempt_weapon(weapontopack))
	{
		return true;
	}

	return false;
}

/* 2058
	Name: is_weapon_upgraded
	Namespace: zm_weapons
	Checksum: 0x242DAD3F
	Offset: 0x5770
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function is_weapon_upgraded(weapon)
{
	if(weapon == level.weaponnone || weapon == level.weaponzmfists)
	{
		return false;
	}
	weapon = get_nonalternate_weapon(weapon); // We already have get_nonalternate_weapon on shared/aat_shared.gsc
	rootweapon = weapon.rootweapon;
	if(isdefined(level.zombie_weapons_upgraded[rootweapon]))
	{
		return true;
	}
	return false;
}

/* 2155
	Name: has_upgrade
	Namespace: zm_weapons
	Checksum: 0xE88737DD
	Offset: 0x5AF8
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function has_upgrade(weapon)
{
	weapon = get_nonalternate_weapon(weapon); // We already have get_nonalternate_weapon on shared/aat_shared.gsc
	rootweapon = weapon.rootweapon;
	has_upgrade = 0;

	if(isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade)) has_upgrade = self HasWeapon(level.zombie_weapons[rootweapon].upgrade, true);

	// Didn't delete because maybe user is playing a custom map or a mod that includes ballistic knife
	if(!has_upgrade && rootweapon.isballisticknife) has_weapon = self has_upgraded_ballistic_knife();

	return has_upgrade;
}

/* 2180
	Name: has_weapon_or_upgrade
	Namespace: zm_weapons
	Checksum: 0x9C58DBF8
	Offset: 0x5BF8
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function has_weapon_or_upgrade(weapon)
{
	weapon = get_nonalternate_weapon(weapon); // We already have get_nonalternate_weapon on shared/aat_shared.gsc
	rootweapon = weapon.rootweapon;
	upgradedweaponname = rootweapon;

	if(isdefined(level.zombie_weapons[rootweapon]) && isdefined(level.zombie_weapons[rootweapon].upgrade)) upgradedweaponname = level.zombie_weapons[rootweapon].upgrade;
	has_weapon = false;

	// Check if we have the weapon
	if(isdefined(level.zombie_weapons[rootweapon])) has_weapon = self HasWeapon(rootweapon, true) || self has_upgrade(rootweapon);
	// Didn't delete because maybe user is playing a custom map or a mod that includes ballistic knife
	if(!has_weapon && level.weaponballisticknife == rootweapon) has_weapon = self has_any_ballistic_knife();
	// Check if it's equipment
	if(!has_weapon && is_equipment(rootweapon)) has_weapon = self is_active(rootweapon);

	return has_weapon;
}

/* 3974
	Name: is_wallbuy
	Namespace: zm_weapons
	Checksum: 0xF7745372
	Offset: 0xAD68
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function is_wallbuy(w_to_check)
{
	w_base = get_base_weapon(w_to_check);
	foreach(s_wallbuy in level._spawned_wallbuys)
	{
		if(s_wallbuy.weapon == w_base)
		{
			return true;
		}
	}
	return false;
}

/* 3996
	Name: is_wonder_weapon
	Namespace: zm_weapons
	Checksum: 0x9164F3BF
	Offset: 0xAE30
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function is_wonder_weapon(w_to_check)
{
	w_base = get_base_weapon(w_to_check);
	if(isdefined(level.zombie_weapons[w_base]) && level.zombie_weapons[w_base].is_wonder_weapon)
	{
		return true;
	}
	return false;
}