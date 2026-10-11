/*
	Name: is_teleport_landing_valid
	Namespace: zm_tomb_teleporter
	Checksum: 0xBC98AC65
	Offset: 0x2870
	Size: 0xF2
	Parameters: 2
	Flags: Linked
*/
function is_teleport_landing_valid(s_pos, n_radius)
{
	n_radius_sq = n_radius * n_radius;
	a_players = getplayers();
	foreach(e_player in a_players)
	{
		if(distance2dsquared(s_pos.origin, e_player.origin) < n_radius_sq)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: get_free_teleport_pos
	Namespace: zm_tomb_teleporter
	Checksum: 0x36C867A9
	Offset: 0x2970
	Size: 0xF0
	Parameters: 2
	Flags: Linked
*/
function get_free_teleport_pos(player, a_structs)
{
	n_player_radius = 64;
	while(true)
	{
		a_players = getplayers();
		foreach(s_pos in a_structs)
		{
			if(is_teleport_landing_valid(s_pos, n_player_radius))
			{
				return s_pos;
			}
		}
		wait(0.05);
	}
}
