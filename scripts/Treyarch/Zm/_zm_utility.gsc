/* 674
	Name: round_up_score
	Namespace: zm_utility
	Checksum: 0xEEE93FD0
	Offset: 0x1EA0
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function round_up_score(score, value)
{
	score = int(score);
	new_score = score - (score % value);
	if(new_score < score)
	{
		new_score = new_score + value;
	}
	return new_score;
}

/* 694
	Name: halve_score
	Namespace: zm_utility
	Checksum: 0xD3C43031
	Offset: 0x1F18
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function halve_score(n_score)
{
	n_score = n_score / 2;
	n_score = round_up_score(n_score, 10);
	return n_score;
}

/* 4621
	Name: is_lethal_grenade
	Namespace: zm_utility
	Checksum: 0xBAA63134
	Offset: 0xAA10
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function is_lethal_grenade(weapon)
{
	if(!isdefined(weapon) || !isdefined(level.zombie_lethal_grenade_list))
	{
		return 0;
	}
	return isdefined(level.zombie_lethal_grenade_list[weapon]);
}

/* 4737
	Name: is_tactical_grenade
	Namespace: zm_utility
	Checksum: 0xCB2F886C
	Offset: 0xABD8
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function is_tactical_grenade(weapon)
{
	if(!isdefined(weapon) || !isdefined(level.zombie_tactical_grenade_list))
	{
		return 0;
	}
	return isdefined(level.zombie_tactical_grenade_list[weapon]);
}

/* 4821
	Name: is_placeable_mine
	Namespace: zm_utility
	Checksum: 0x3076F4E7
	Offset: 0xAD20
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function is_placeable_mine(weapon)
{
	if(!isdefined(level.placeable_mines))
	{
		level.placeable_mines = [];
	}
	if(!isdefined(weapon) || weapon == level.weaponnone)
	{
		return 0;
	}
	return isdefined(level.placeable_mines[weapon.name]);
}

/* 4932
	Name: is_melee_weapon
	Namespace: zm_utility
	Checksum: 0x3AEF87F7
	Offset: 0xAF08
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function is_melee_weapon(weapon)
{
	if(!isdefined(weapon) || !isdefined(level.zombie_melee_weapon_list) || weapon == getweapon("none"))
	{
		return 0;
	}
	return isdefined(level.zombie_melee_weapon_list[weapon]);
}

/* 5039
	Name: is_hero_weapon
	Namespace: zm_utility
	Checksum: 0xDAC8D68D
	Offset: 0xB0F0
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function is_hero_weapon(weapon)
{
	if(!isdefined(weapon) || !isdefined(level.zombie_hero_weapon_list))
	{
		return 0;
	}
	return isdefined(level.zombie_hero_weapon_list[weapon]);
}

/* 5189
	Name: is_offhand_weapon
	Namespace: zm_utility
	Checksum: 0x75E67106
	Offset: 0xB3D8
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function is_offhand_weapon(weapon)
{
	return is_lethal_grenade(weapon) || is_tactical_grenade(weapon) || is_placeable_mine(weapon) || is_melee_weapon(weapon) || is_hero_weapon(weapon) || is_equipment(weapon);
}

/* 7122
	Name: is_point_inside_enabled_zone
	Namespace: zm_utility
	Checksum: 0xAF0C32EC
	Offset: 0xEF00
	Size: 0x1A6
	Parameters: 2
	Flags: Linked
*/
function is_point_inside_enabled_zone(v_origin, ignore_zone)
{
	temp_ent = spawn("script_origin", v_origin);
	foreach(zone in level.zones)
	{
		if(!zone.is_enabled) continue;
		if(isdefined(ignore_zone) && zone == ignore_zone) continue;

		foreach(e_volume in zone.volumes)
		{
			if(temp_ent istouching(e_volume))
			{
				temp_ent delete();
				return true;
			}
		}
	}
	
	temp_ent delete();
	return false;
}
