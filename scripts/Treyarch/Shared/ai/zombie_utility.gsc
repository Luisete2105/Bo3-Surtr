/*
	Name: ai_calculate_health
	Namespace: zombie_utility
	Checksum: 0x27390E04
	Offset: 0x4F98
	Size: 0x106
	Parameters: 1
	Flags: Linked
*/
function ai_calculate_health(round_number)
{
	level.zombie_health = level.zombie_vars["zombie_health_start"];
	for(i = 2; i <= round_number; i++)
	{
		if(i >= 10)
		{
			old_health = level.zombie_health;
			level.zombie_health = level.zombie_health + (int(level.zombie_health * level.zombie_vars["zombie_health_increase_multiplier"]));
			if(level.zombie_health < old_health)
			{
				level.zombie_health = old_health;
				return;
			}
			continue;
		}
		level.zombie_health = int(level.zombie_health + level.zombie_vars["zombie_health_increase"]);
	}
}