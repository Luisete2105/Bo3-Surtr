/*
	Name: wait_till
	Namespace: flag
	Checksum: 0x9C60C397
	Offset: 0x648
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
/*function wait_till(str_flag)
{
	self endon(#"death");
	while(!get(str_flag))
	{
		self waittill(str_flag);
	}
}*/

// Modified to avoid Developer 2 errors
function wait_till( str_flag )
{
    // Undefined check
    if( !isdefined( str_flag ) ){
        level thread debug_message( "^1Missing ^5str_flag ^1in function ^6wait_till" );
        return;
    }

    if( !isdefined( self.flag ) ) self.flag = [];
    if( !isdefined( self.flag[str_flag] ) ) self.flag[str_flag] = false;

	self endon("death");
	while(!self.flag[str_flag])
	{
		self waittill(str_flag);
	}
}