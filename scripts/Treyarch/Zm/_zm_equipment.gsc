/* 718
	Name: is_active
	Namespace: zm_equipment
	Checksum: 0xA213C068
	Offset: 0x1CA0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function is_active(equipment)
{
	if(!isdefined(self.current_equipment_active) || !isdefined(self.current_equipment_active[equipment]))
	{
		return 0;
	}
	return self.current_equipment_active[equipment];
}


/* 939
	Name: is_equipment
	Namespace: zm_equipment
	Checksum: 0x5FA83105
	Offset: 0x2508
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function is_equipment(weapon)
{
	if(!isdefined(weapon) || !isdefined(level.zombie_equipment_list))
	{
		return 0;
	}
	return isdefined(level.zombie_equipment_list[weapon]);
}