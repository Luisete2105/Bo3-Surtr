
function print_new_bgb(){

    level thread DisplayFeedMessage( "^8Players' gums are:" );

    foreach( player in getplayers() ){

        foreach( index, bgb in player.bgb_pack ){

            level thread DisplayFeedMessage( ""+ player get_player_text_color() + player.name + " ^8 " + ( index + 1 ) + " | " + parse_bgb_name( bgb ) );
            wait 1;
        }

        wait 2;
    }


}