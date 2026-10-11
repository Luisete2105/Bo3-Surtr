/* 1614
	Name: is_lightning_weapon
	Namespace: zm_altbody_beast
	Checksum: 0x7C1ED15
	Offset: 0x4670
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function is_lightning_weapon(weapon)
{
	if(!isdefined(weapon))
	{
		return false;
	}
	if(weapon == getweapon("zombie_beast_lightning_dwl") || weapon == getweapon("zombie_beast_lightning_dwl2") || weapon == getweapon("zombie_beast_lightning_dwl3"))
	{
		return true;
	}
	return false;
}

/* 2255
	Name: watch_lightning_damage
	Namespace: zm_altbody_beast
	Checksum: 0x67D0EBD9
	Offset: 0x5BB8
	Size: 0x240
	Parameters: 1
	Flags: Linked
*/
function watch_lightning_damage(triggers)
{
	self endon("delete");
	self setcandamage(1);
	while(isdefined(triggers))
	{
		self waittill("damage", amount, attacker, direction, point, mod, tagname, modelname, partname, weapon);
		if(is_lightning_weapon(weapon) && isdefined(attacker) && amount > 0)
		{
			if(isdefined(attacker))
			{
				attacker notify("shockable_shocked");
			}
			if(isdefined(level._effect["beast_shock_box"]))
			{
				forward = anglestoforward(self.angles);
				playfx(level._effect["beast_shock_box"], self.origin, forward);
			}
			if(!isdefined(triggers))
			{
				return;
			}
			if(isarray(triggers))
			{
				foreach(trigger in triggers)
				{
					if(isdefined(trigger))
					{
						trigger useby(attacker);
					}
				}
			}
			else
			{
				triggers useby(attacker);
			}
		}
	}
}