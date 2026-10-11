/*302
		Name: is_moving
		Namespace: czmtrain
		Checksum: 0x4DB9E472
		Offset: 0x7928
		Size: 0x22
		Parameters: 0
		Flags: Linked

    // Original
	function is_moving()
	{
		return self flag::get("moving");
	}
*/
function is_moving()
{
    return level.o_zod_train flag::get("moving");
}

/* 1958
    Name: get_current_destination
    Namespace: czmtrain
    Checksum: 0xB5995F60
    Offset: 0x2A18
    Size: 0x5E
    Parameters: 0
    Flags: Linked

    // Original
    function get_current_destination()
    {
        if(m_a_s_stations[m_str_station].b_left_path_active)
        {
            return m_a_s_stations[m_str_station].left_path;
        }
        return m_a_s_stations[m_str_station].right_path;
    }
*/

// Currently Classes are not supported in Serious T7 Compiler
function get_current_destination(){


    if( level.o_zod_train.m_a_s_stations[ level.o_zod_train.m_str_station ].b_left_path_active)
    {
        return level.o_zod_train.m_a_s_stations[ level.o_zod_train.m_str_station ].left_path;
    }
    return level.o_zod_train.m_a_s_stations[ level.o_zod_train.m_str_station ].right_path;
}

/* 1975
		Name: get_current_station
		Namespace: czmtrain
		Checksum: 0x82585757
		Offset: 0x2A00
		Size: 0xA
		Parameters: 0
		Flags: Linked

    // Original
	function get_current_station()
	{
		return m_str_station;
	}
*/
// Currently Classes are not supported in Serious T7 Compiler
function get_current_station()
{
    return level.o_zod_train.m_str_station;
}

/* 2019
		Name: get_train_vehicle
		Namespace: czmtrain
		Checksum: 0x4B6CC725
		Offset: 0x27B8
		Size: 0xA
		Parameters: 0
		Flags: Linked
	
    // Current
	function get_train_vehicle()
	{
		return m_vh_train;
	}
*/
function get_train_vehicle()
{
    return level.o_zod_train.m_vh_train;
}