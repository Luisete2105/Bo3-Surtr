function is_bgb_consumable( str_bgb ){

    // We are doing extra checks because maybe the player is using a mod that changes how BGB work, this way we avoid Dev 2 errors
    return isdefined( level.bgb ) && isdefined( level.bgb[ str_bgb ] ) && isdefined( level.bgb[ str_bgb ].consumable ) && level.bgb[ str_bgb ].consumable;
}

function avoid_bgb_use(){
    self endon("disconnect");
    self endon("finished_reporting_consumables");

    // Wait for BGB stats to be created
    self waittill( "bgb_weapon_cycling" );

    //level thread debug_message( sprintf("{0}{1} ^7finished loading BGBs",self get_player_text_color(), self.name ) );

    // There are no consumable gums to track
    if( self.bgb_stats.size == 0 ) return;

    // Set max possible amount of tokens
    foreach(s_bgb_stat in self.bgb_stats) s_bgb_stat.bgb_available_at_start = 255;

    for(;;){
        self waittill( "bgb_gumball_anim_give", str_bgb );

        // Classic gum
        if( !is_bgb_consumable( str_bgb ) ) continue;

        // There are side EEs to get BGBs
        else if( !IsInArray( self.bgb_pack, str_bgb) ) continue;

        // Unexpected, player is using a mod?
        else if( !is_practice_enabled() && !isdefined( self.bgb_stats[ str_bgb ] ) ){
            level thread debug_message( sprintf("{0}{1} ^1Used an unexpected BGB? ^5{2}",self get_player_text_color(), self.name, str_bgb ) );
            continue;
        }

        // Token not consumed yet?
        else if( self.bgb_stats[ str_bgb ].bgb_used_this_game == 0 ){
            // If practice mode is enabled, then player could have used gsc_bgb command
            if( !is_practice_enabled() ) level thread debug_message( sprintf("{0}{1} ^1BGB not consumed yet? ^5{2}",self get_player_text_color(), self.name, str_bgb ) );
            continue;
        }

        self.bgb_stats[ str_bgb ].bgb_used_this_game = 0; // Set the uses of this gum to 0, this way the game won't subtract any bgb token from the player
        self.bgb_stats[ str_bgb ].bgb_available_at_start --; // Instead, we reduce the N of bgb tokens left this game to use. We do this to keep original game's logic, maybe High Rounders will try to use more than 255 tokens in a game
    }
}


function track_gum_category(){
    self endon("disconnect");

    // Set initial Gum Category in case anyone uses a BGB
    if( !isdefined( level.new_category ) ) level.new_category = CATEGORY_CLASSIC_GUM;

    // Wait for BGB stats to be created
    self waittill( "bgb_weapon_cycling" );

    // Update what would be the Gum Category if a gum is ever used
    foreach( str_bgb in self.bgb_pack ){
        // Any is the maximum category, no need to check anymore
        if( IsInArray(BGB_ANY, str_bgb) ){
            level.new_category = CATEGORY_ANY_GUM;
            return;
        }
        // Mega Gum is being used
        else if( is_bgb_consumable( str_bgb ) && level.new_category == CATEGORY_CLASSIC_GUM ){
            level.new_category = CATEGORY_MEGA_GUM;
        }
    }

    // Wait for the first gum to be taken from the BGB machine
    if( !isdefined( level.gum_category ) ) self waittill( "bgb_gumball_anim_give", str_bgb );

    // Set the new category
    if( !isdefined( level.gum_category ) || level.gum_category != level.new_category ) level.gum_category = level.new_category;
}