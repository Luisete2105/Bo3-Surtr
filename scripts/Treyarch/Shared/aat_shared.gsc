/* 283
	Name: get_nonalternate_weapon
	Namespace: aat
	Checksum: 0x8503CB0E
	Offset: 0xDE0
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function get_nonalternate_weapon(weapon)
{
	if(isdefined(weapon) && weapon.isaltmode)
	{
		return weapon.altweapon;
	}
	return weapon;
}

/* 536
	Name: is_exempt_weapon
	Namespace: aat
	Checksum: 0xFC2A3A52
	Offset: 0x1E10
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function is_exempt_weapon(weapon)
{
	weapon = get_nonalternate_weapon(weapon);
	return isdefined(level.aat_exemptions[weapon]);
}

/* 583
	Name: acquire
	Namespace: aat
	Checksum: 0x35532001
	Offset: 0x2188
	Size: 0x25C
	Parameters: 2
	Flags: Linked
*/
function acquire(weapon, name)
{
	if(!(isdefined(level.aat_in_use) && level.aat_in_use))
	{
		return;
	}

	weapon = get_nonalternate_weapon(weapon);
	if(is_exempt_weapon(weapon))
	{
		return;
	}

	if(isdefined(name))
	{
		self.aat[weapon] = name;
	}
	else
	{
		keys = getarraykeys(level.aat);
		arrayremovevalue(keys, "none");
		if(isdefined(self.aat[weapon]))
		{
			arrayremovevalue(keys, self.aat[weapon]);
		}
		rand = randomint(keys.size);
		self.aat[weapon] = keys[rand];
	}
	
	if(weapon == self getcurrentweapon())
	{
		self clientfield::set_to_player("aat_current", level.aat[self.aat[weapon]].clientfield_index);
	}
}

/* 629
 Namespace aat
 Params 1
 Checksum 0x27eb2834, Offset: 0x23f0
 Size: 0xa4
*/
function remove( weapon )
{
    if ( !( isdefined( level.aat_in_use ) && level.aat_in_use ) )
    {
        return;
    }
    
    //assert( isdefined( weapon ), "<dev string:x6fb>" );
    //assert( weapon != level.weaponnone, "<dev string:x721>" );
    weapon = get_nonalternate_weapon( weapon );
    self.aat[ weapon ] = undefined;
}
