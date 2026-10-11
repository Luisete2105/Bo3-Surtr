function add_ee_commands(){
    
    level.ee_steps = [];
    level.ee_being_completed = 0;

    switch( MAP_NAME ){

        case "zm_zod":
        {

            break;
        }
        case "zm_factory":
        {
            level factory_gsc_ee_init();
            level.get_ee_steps = ::factory_get_ee_steps;
            break;
        }
        case "zm_castle":
        {
            level castle_gsc_ee_init();
            level.get_ee_steps = ::castle_get_ee_steps;
            break;
        }
        case "zm_island":
        {

            break;
        }
        case "zm_stalingrad":
        {

            break;
        }
        case "zm_genesis":
        {

            break;
        }
        case "zm_asylum":
        {

            break;
        }
        case "zm_sumpf":
        {

            break;
        }
        case "zm_prototype":
        {

            break;
        }
        case "zm_theater":
        {

            break;
        }
        case "zm_cosmodrome":
        {

            break;
        }
        case "zm_temple":
        {
            
            break;
        }
        case "zm_moon":
        {

            break;
        }
        case "zm_tomb":
        {
            level tomb_gsc_ee_init();
            level.get_ee_steps = ::tomb_get_ee_steps;
            break;
        }

    }
    
}


function add_autocomplete_step( step_name = undefined, step_func = undefined){

    if( !isdefined( step_name ) || !IsString( step_name ) ){ // Invalid name
        
        level thread debug_message( "^1Error^7, not defined or not a string on ^5add_autocomplete_step..." );
        return;
    }

    if( isdefined( level.ee_steps[ step_name ] ) ){ // Step already defined
        
        level thread debug_message( "^1Error^7, step ^5"+step_name+"^7 is already created..." );
        return;
    }

    if( !isdefined( step_func ) || !IsFunctionPtr( step_func ) ){ // Invalid function pointer
        
        level thread debug_message( "^1Error^7, not defined or not a funcptr on ^5add_autocomplete_step..." );
        return;
    }

    level.ee_steps[ step_name ] = step_func;
}

function get_step_function( step_name = undefined ){

    if( !isdefined( step_name ) ){
        
        level thread debug_message( "^1Error^7, step name not defined in ^5get_step_function" );
        return undefined;
    }

    if( !isdefined( level.ee_steps[ step_name ] ) ){
        
        level thread debug_message( "^1Error^7, step ^5"+step_name+"^7 doesn't exist" );
        return undefined;
    }

    return level.ee_steps[ step_name ];
}

function ee_autocomplete_start(){

    level.ee_being_completed++;
    setdvar(DVAR_TIMESCALE, "10");
}

function ee_autocomplete_end( text = undefined ){

    level.ee_being_completed--;
    if( !level.ee_being_completed ) setdvar(DVAR_TIMESCALE, "1");

    if( !isdefined( text ) || !IsString( text ) ){
		level thread debug_message( text_error()+"Invalid text in ^5ee_autocomplete_end" );
		return;
	}
    IPrintLnBoldAllPlayers( text );
}