/* 420
	Name: has_any_ballistic_knife
	Namespace: zm_melee_weapon
	Checksum: 0xED60EBE7
	Offset: 0x10D8
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function has_any_ballistic_knife()
{
	primaryweapons = self getweaponslistprimaries();
	for(i = 0; i < primaryweapons.size; i++)
	{
		if(primaryweapons[i].isballisticknife)
		{
			return true;
		}
	}
	return false;
}

/* 442
	Name: has_upgraded_ballistic_knife
	Namespace: zm_melee_weapon
	Checksum: 0x9C70B984
	Offset: 0x1150
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function has_upgraded_ballistic_knife()
{
	primaryweapons = self getweaponslistprimaries();
	for(i = 0; i < primaryweapons.size; i++)
	{
		if(primaryweapons[i].isballisticknife && is_weapon_upgraded(primaryweapons[i]))
		{
			return true;
		}
	}
	return false;
}