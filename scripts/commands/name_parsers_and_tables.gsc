
function basic_parser( old_txt ){

    tok_txt = strTok( old_txt, "_" );
    new_txt = "";

    for( i=0; i < tok_txt.size; i++ ){
    
        new_txt += ToUpper( tok_txt[ i ][ 0 ] );

        // Skip first letter since it's manually added as capital letter
        for( j=1; j < tok_txt[ i ].size; j++){
            new_txt += ToLower( tok_txt[ i ][ j ] );
        }

        // Don't add a space when it's the last token
        if(i != ( tok_txt.size -1 ) ) new_txt += " ";
    }

    return new_txt;
}

#region maps

// Change to desired map
function get_map_name( mapname ){

    if( !isdefined( mapname ) ){
        self debug_message("^1Error, UNDEFINED map name");
        return undefined;
    }

    if( !IsString( mapname ) ){
        self debug_message("^1Error, invalid map name");
        return undefined;
    }

    if( IS_ZOMBIES ){
            
        switch( toLower( mapname ) ){

            case "zm_zod":
            case "zod":
            case "shadows_of_evil":
			case "shadowsofevil":
            case "shadows":
            case "soe":
            {
                return "zm_zod";
            }

            case "zm_factory":
            case "factory":
            case "thegiant":
			case "the_giant":
            case "giant":
            case "tg":
            {
                return "zm_factory";
            }

            case "zm_castle":
            case "castle":
            case "dereisendrache":
			case "der_eisendrache":
            case "der":
            case "de":
            {
                return "zm_castle";
            }

            case "zm_island":
            case "island":
            case "zetsubounoshima":
			case "zetsubou_no_shima":
            case "zetsubou":
            case "zetsu":
            case "zns":
            {
                return "zm_island";
            }

            case "zm_stalingrad":
            case "stalingrad":
            case "gorod_krovi":
			case "gorodkrovi":
            case "gorod":
            case "gk":
            {
                return "zm_stalingrad";
            }

            case "zm_genesis":
            case "genesis":
            case "revelations":
            case "rev":
            {
                return "zm_genesis";
            }

            case "zm_cosmodrome":
            case "cosmodrome":
            case "ascension":
            case "asc":
            {
                return "zm_cosmodrome";
            }

            
            case "zm_prototype":
            case "prototype":
            case "natch_der_untoten":
			case "natchderuntoten":
            case "natch":
            case "ndu":
            {
                return "zm_prototype";
            }

            case "zm_moon":
            case "moon":
            {
                return "zm_moon";
            }

            case "zm_sumpf":
            case "sumpf":
            case "shinonuma":
			case "shi_no_numa":
            case "shino":
            case "snn":
            {
                return "zm_sumpf";
            }

            case "zm_asylum":
            case "asylum":
            case "verruckt":
            case "ver":
            {
                return "zm_asylum";
            }

            case "zm_temple":
            case "temple":
            case "shangrila":
			case "shangri_la":
            case "shang":
            case "sl":
            {
                return "zm_temple";
            }

            case "zm_theater":
            case "theater":
            case "kino_der_toten":
			case "kinodertoten":
            case "kino":
            case "kdt":
            {
                return "zm_theater";
            }

            case "zm_tomb":
            case "tomb":
            case "origins":
            case "ori":
            {
                return "zm_tomb";
            }

            default:
            {
				// Maybe we are on a custom map
				if( mapname == MAP_NAME ) return mapname;

				// Unknown map
                self iPrintLnBold("Error, unknown map name "+mapname);
                return undefined;
            }
        }

    }else{
		level thread debug_message("Currently only supports zombie maps");
		return undefined;
	}

	return undefined;
}

#endregion

#region BGB

// Returns BGB no nerd name
function parse_bgb_name( old_bgb ){

    old_bgb = get_bgb_name( old_bgb );
    tok_bgb = strTok( old_bgb, "_" );

    new_bgb = "";

    switch( level.bgb[ old_bgb ].limit_type ){

        // Purple
        case "activated":
        {
            new_bgb = "^6";
            break;
        }

        // Green
        case "time":
        {
            new_bgb = "^2";
            break;
        }

        // Blue
        case "rounds":
        {
            new_bgb = "^5";
            break;
        }

        // Yellow
        case "event":
        {
            new_bgb = "^3";
            break;
        }
    }

    // Start at 2 to skip "zm_" & "bgb_"
    for( i=2; i < tok_bgb.size; i++ ){
    
        new_bgb += ToUpper( tok_bgb[ i ][ 0 ] );

        // Skip first letter since it's manually added as capital letter
        for( j=1; j < tok_bgb[ i ].size; j++){
            new_bgb += ToLower( tok_bgb[ i ][ j ] );
        }

        // Don't add a space when it's the last token
        if(i != ( tok_bgb.size -1 ) ) new_bgb += " ";
    }

    return new_bgb;
}

// Returns full BGB code name
function get_bgb_name( bgb_str ){

	// Check for custom BGBs that a mod or custom map may have created
	if( isdefined( level.bgb[ bgb_str ] ) )
		return bgb_str;

	if( isdefined( level.bgb[ "zm_bgb_"+bgb_str ] ) )
		return "zm_bgb_"+bgb_str;

	// Check for possible Treyarch BGB names
	switch( bgb_str ){

		// Classics
			case "always_done_swiftly":
			case "alwaysdoneswiftly":
			case "ads":
				return "zm_bgb_always_done_swiftly";

			case "arms_grace":
			case "armsgrace":
			case "arms":
			case "grace":
			case "ag":
				return "zm_bgb_arms_grace";

			case "coagulant":
			case "coa":
				return "zm_bgb_coagulant";

			case "in_plain_sight":
			case "inplainsight":
			case "ips":
				return "zm_bgb_in_plain_sight";

			case "stock_option":
			case "stockoption":
			case "stock":
			case "option":
			case "so":
				return "zm_bgb_stock_option";

			case "impatient":
			case "imp":
				return "zm_bgb_impatient";

			case "sword_flay":
			case "sword":
			case "flay":
			case "sf":
				return "zm_bgb_sword_flay";

			case "anywhere_but_here":
			case "anywherebuthere":
			case "anywhere":
			case "abh":
				return "zm_bgb_anywhere_but_here";

			case "danger_closest":
			case "dangerclosest":
			case "danger":
			case "closest":
			case "dc":
				return "zm_bgb_danger_closest";

			case "armamental_accomplishment":
			case "armamentalaccomplishment":
			case "armamental":
			case "accomplishment":
			case "aa":
				return "zm_bgb_armamental_accomplishment";

			case "firing_on_all_cylinders":
			case "foac":
				return "zm_bgb_firing_on_all_cylinders";

			case "arsenal_accelerator":
			case "arsenalaccelerator":
			case "arsenal":
			case "accelerator":
			case "ars":
				return "zm_bgb_arsenal_accelerator";

			case "lucky_crit":
			case "luckycrit":
			case "crit": // Lucky could be I'm feelin' lucky
			case "lc":
				return "zm_bgb_lucky_crit";

			case "now_you_see_me":
			case "nowyouseeme":
			case "nysm":
				return "zm_bgb_now_you_see_me";

			case "alchemical_antithesis":
			case "alchemicalantithesis":
			case "alchemical":
			case "antithesis":
			case "alc":
				return "zm_bgb_alchemical_antithesis";

			case "eye_candy":
			case "eyecandy":
			case "ec":
				return "zm_bgb_eye_candy";

			case "newtonian_negation":
			case "newtoniannegation":
			case "nn":
				return "zm_bgb_newtonian_negation";

			case "projectile_vomiting":
			case "projectilevomiting":
			case "pv":
				return "zm_bgb_projectile_vomiting";

			case "tone_death":
			case "tonedeath":
			case "td":
				return "zm_bgb_tone_death";

		// Megas

			case "aftertaste":
			case "aft":
				return "zm_bgb_aftertaste";

			case "board_games":
			case "boardgames":
			case "bg":
				return "zm_bgb_board_games";

			case "board_to_death":
			case "boardtodeath":
			case "btd":
				return "zm_bgb_board_to_death";

			case "burned_out":
			case "burnedout":
			case "bo":
				return "zm_bgb_burned_out";

			case "crawl_space":
			case "crawlspace":
			case "cs":
				return "zm_bgb_crawl_space";

			case "dead_of_nuclear_winter":
			case "deadofnuclearwinter":
			case "donw":
				return "zm_bgb_dead_of_nuclear_winter";

			case "disorderly_combat":
			case "disorderlycombat":
			case "dis":
				return "zm_bgb_disorderly_combat";			

			case "ephemeral_enhancement":
			case "ephemeralenhancement":
			case "ephemeral":
			case "enhancement":
			case "ee":
				return "zm_bgb_ephemeral_enhancement";	

			case "fatal_contraption":
			case "fatalcontraption":
			case "fatal":
			case "contraption":
			case "fc":
				return "zm_bgb_fatal_contraption";	

			case "flavor_hexed":
			case "flavorhexed":
			case "flavor":
			case "hexed":
			case "fh":
				return "zm_bgb_flavor_hexed";	

			case "idle_eyes":
			case "idleeyes":
			case "idle":
			case "idle":
			case "eyes":
			case "ie":
				return "zm_bgb_idle_eyes";

			case "im_feelin_lucky":
			case "imfeelin_lucky":
			case "ifl":
				return "zm_bgb_im_feelin_lucky";	

			case "immolation_liquidation":
			case "immolationliquidation":
			case "immolation":
			case "liquidation":
			case "il":
				return "zm_bgb_immolation_liquidation";

			case "licensed_contractor":
			case "licensedcontractor":
			case "licensed":
			case "contractor":
			case "lic":
				return "zm_bgb_licensed_contractor";

			case "mind_blown":
			case "mindblown":
			case "mind":
			case "blown":
			case "mb":
				return "zm_bgb_mind_blown";

			case "phoenix_up":
			case "phoenixup":
			case "phoenix":
			case "up":
			case "pu":
				return "zm_bgb_phoenix_up";

			case "pop_shocks":
			case "popshocks":
			case "pop":
			case "shocks":
			case "ps":
				return "zm_bgb_pop_shocks";

			case "respin_cycle":
			case "respincycle":
			case "respin":
			case "cycle":
			case "rc":
				return "zm_bgb_respin_cycle";

			case "slaughter_slide":
			case "slaughterslide":
			case "slaughter":
			case "slide":
			case "ss":
				return "zm_bgb_slaughter_slide";

			case "unbearable":
			case "unb":
				return "zm_bgb_unbearable";

			case "unquenchable":
			case "unq":
				return "zm_bgb_unquenchable";

			case "whos_keeping_score":
			case "whoskeepingscore":
			case "wks":
				return "zm_bgb_whos_keeping_score";

			case "bullet_boost":
			case "bulletboost":
			case "bullet":
			case "boost":
			case "bb":
				return "zm_bgb_bullet_boost";

			case "cache_back":
			case "cacheback":
			case "cache":
			case "back":
			case "cb":
				return "zm_bgb_cache_back";

			case "crate_power":
			case "cratepower":
			case "crate": // Power could be wall power
			case "cra":
				return "zm_bgb_crate_power";

			case "extra_credit":
			case "extracredit":
			case "extra":
			case "credit":
			case "ext":
				return "zm_bgb_extra_credit";

			case "fear_in_headlights":
			case "fearinheadlights":
			case "fih":
				return "zm_bgb_fear_in_headlights";

			case "kill_joy":
			case "killjoy":
			case "kill":
			case "joy":
			case "kj":
				return "zm_bgb_kill_joy";

			case "on_the_house":
			case "onthehouse":
			case "oth":
				return "zm_bgb_on_the_house";

			case "soda_fountain":
			case "sodafountain":
			case "soda":
			case "fountain":
			case "sod":
				return "zm_bgb_soda_fountain";

			case "temporal_gift":
			case "temporalgift":
			case "temporal":
			case "gift":
			case "tg":
				return "zm_bgb_temporal_gift";

			case "undead_man_walking":
			case "undeadmanwalking":
			case "umw":
				return "zm_bgb_undead_man_walking";

			case "wall_power":
			case "wallpower":
			case "wall": // Power can also be power crate
			case "wp":
				return "zm_bgb_wall_power";

			case "head_drama":
			case "headdrama":
			case "hd":
				return "zm_bgb_head_drama";

			case "killing_time":
			case "killingtime":
			case "killing":
			case "time":
			case "kt":
				return "zm_bgb_killing_time";

			case "near_death_experience":
			case "neardeathexperience":
			case "nde":
				return "zm_bgb_near_death_experience";

			case "perkaholic":
			case "perka":
			case "perk":
			case "per":
				return "zm_bgb_perkaholic";

			case "power_vacuum":
			case "powervacuum":
			case "power":
			case "vacuum":
			case "pow":
				return "zm_bgb_power_vacuum";

			case "profit_sharing":
			case "profitsharing":
			case "profit":
			case "sharing":
			case "pro":
				return "zm_bgb_profit_sharing";

			case "reign_drops":
			case "reigndrops":
			case "reign":
			case "drops":
			case "rd":
				return "zm_bgb_reign_drops";

			case "round_robbin":
			case "roundrobbin":
			case "round":
			case "robbin":
			case "rr":
				return "zm_bgb_round_robbin";

			case "secret_shopper":
			case "secretshopper":
			case "secret":
			case "shopper":
			case "sec":
				return "zm_bgb_secret_shopper";

			case "self_medication":
			case "selfmedication":
			case "self":
			case "medication":
			case "sm":
				return "zm_bgb_self_medication";

			case "shopping_free":
			case "shoppingfree":
			case "shopping":
			case "free":
			case "sho":
				return "zm_bgb_shopping_free";

	}

	return undefined;
}

#endregion

#region AAT

function get_aat_name( str_aat ){

	// Check for custom BGBs that a mod or custom map may have created
	if( isdefined( level.aat[ str_aat ] ) )
		return str_aat;

	if( isdefined( level.aat[ "zm_aat_"+str_aat ] ) )
		return "zm_aat_"+str_aat;

	if( isdefined( level.aat[ "zm_"+str_aat ] ) )
		return "zm_"+str_aat;

	// Check for possible Treyarch AAT names
	switch( str_aat ){

		case "zm_aat_blast_furnace":
		case "aat_blast_furnace":
		case "zm_blast_furnace":
		case "blast_furnace":
		case "blast":
		case "furnace":
		case "bf":
			return "zm_aat_blast_furnace";

		case "zm_aat_dead_wire":
		case "aat_dead_wire":
		case "zm_dead_wire":
		case "dead_wire":
		case "dead":
		case "wire":
		case "dw":
			return "zm_aat_dead_wire";

		case "zm_aat_fire_works":
		case "aat_fire_works":
		case "zm_fire_works":
		case "fire_works":
		case "fire":
		case "works":
		case "fw":
			return "zm_aat_fire_works";	

		case "zm_aat_thunder_wall":
		case "aat_thunder_wall":
		case "zm_thunder_wall":
		case "thunder_wall":
		case "thunder":
		case "wall":
		case "tw":
			return "zm_aat_thunder_wall";	

		case "zm_aat_turned":
		case "aat_turned":
		case "zm_turned":
		case "turned":
		case "turn":
			return "zm_aat_turned";	

	}

	return undefined;
}

function parse_aat_name( str_aat ){

	// "none" AAT exception
	if( ToLower(str_aat) == "none" ) return "^9None";

    str_new_aat = "";
	switch( str_aat ){

		case "zm_aat_blast_furnace":
		{
			str_new_aat += "^1";
			break;
		}

		case "zm_aat_dead_wire":
		{
			str_new_aat += "^4";
			break;
		}

		case "zm_aat_fire_works":
		{
			str_new_aat += "^3";
			break;
		}

		case "zm_aat_thunder_wall":
		{
			str_new_aat += "^5";
			break;
		}

		case "zm_aat_turned":
		{
			str_new_aat += "^2";
			break;
		}

	}

	tok_aat = strTok( str_aat, "_" );

    // Start at 2 to skip "zm_" & "aat_"
    for( i=2; i < tok_aat.size; i++ ){
    
        str_new_aat += ToUpper( tok_aat[ i ][ 0 ] );

        // Skip first letter since it's manually added as capital letter
        for( j=1; j < tok_aat[ i ].size; j++){
            str_new_aat += ToLower( tok_aat[ i ][ j ] );
        }

        // Don't add a space when it's the last token
        if(i != ( tok_aat.size -1 ) ) str_new_aat += " ";
    }

    return str_new_aat;
}
#endregion

#region PERKS

function get_perk_name( str_perk ){
	
	// Full name
	if( isdefined( level._custom_perks[ str_perk ] ) ) // Check if the name is already a good name
		return str_perk;

	// Prefix + name
	if( isdefined( level._custom_perks[ "specialty_"+str_perk ] ) ) // Check if the name is already a good name but without the prefix
		return "specialty_"+str_perk;

	switch( str_perk ){

		// Zombie Perks
			case "specialty_quickrevive":
			case "quick_revive":
			case "quickrevive":
			case "qrevive":
			case "quickr":
			case "quick":
			case "revive":
			case "qr":
				return "specialty_quickrevive";

			case "specialty_armorvest":
			case "armorvest":
			case "armor":
			case "vest":
			case "armorv":
			case "avest":
			case "juggernaut":
			case "jugger":
			case "jugg":
			case "jug":
				return "specialty_armorvest";

			case "specialty_fastreload":
			case "fastreload":
			case "fastr":
			case "freload":
			case "fast":
			case "reload":
			case "speedcola":
			case "speed":
			case "cola":
				return "specialty_fastreload";

			case "specialty_doubletap2":
			case "specialty_doubletap":
			case "doubletap2":
			case "doubletap":
			case "doublet2":
			case "doublet":
			case "dtap2":
			case "dtap":
			case "dt2":
			case "dt":
				return "specialty_doubletap2";

			case "specialty_staminup":
			case "staminup":
			case "stamu":
			case "sup":
			case "stam":
			case "su":
				return "specialty_staminup";

			case "specialty_widowswine":
			case "widowswine":
			case "widowsw":
			case "wwine":
			case "widows":
			case "widow":
			case "wi":
			case "ww":
				return "specialty_widowswine";

			case "specialty_deadshot":
			case "deadshot":
			case "deads":
			case "dshot":
			case "daiquiri":
			case "dquiri":
			case "daiq":
			case "dai":
			case "da":
			case "ds":
				return "specialty_deadshot";

			case "specialty_additionalprimaryweapon":
			case "additionalprimaryweapon":
			case "additionalprimary":
			case "additionalweapon":
			case "primaryweapon":
			case "additionalpw":
			case "aprimaryweapon":
			case "aprimary":
			case "aweapon":
			case "apweapon":
			case "apw":
			case "mule_kick":
			case "mulekick":
			case "mulek":
			case "mkick":
			case "mule":
			case "kick":
				return "specialty_additionalprimaryweapon";

			case "specialty_electriccherry":
			case "electriccherry":
			case "electricc":
			case "echerry":
			case "electric":
			case "cherry":
				return "specialty_electriccherry";

		// Other perks

			case "specialty_fireproof":
			case "fireproof":
			case "fproof":
			case "fire":
			case "proof":
			case "firep":
			//case "fp": // Too common
				return "specialty_fireproof";

			case "specialty_bulletflinch":
			case "bulletflinch":
			case "bflinch":
			case "bulletf":
			//case "bullet": // too common
			case "flinch":
			case "bf":
				return "specialty_bulletflinch";

			case "specialty_flashprotection":
			case "flashprotection":
			case "flashp":
			case "fprotection":
			case "flash":
			//case "protection": // too common
			//case "fp": // too common
				return "specialty_flashprotection";

			case "specialty_flakjacket":
			case "flakjacket":
			case "fjacket":
			case "flakj":
			case "flak":
			case "jacket":
			case "fj":
				return "specialty_flakjacket";

			case "specialty_immuneemp":
			case "immuneemp":
			case "iemp":
			case "immune":
			case "immune":
			case "emp":
			case "ie":
				return "specialty_immuneemp";

			case "specialty_healthregen":
			case "healthregen":
			case "hregen":
			case "healthr":
			case "health":
			case "regen":
			case "hr":
				return "specialty_healthregen";

			case "specialty_detectexplosive":
			case "detectexplosive":
			case "dexplosive":
			case "detecte":
			case "detect":
			case "explosive":
			case "de":
				return "specialty_detectexplosive";

			// does nothing?
			case "specialty_null":
			case "null":
				return "specialty_null";

			// Unused specialty?
			case "specialty_weapon_":
			case "weapon_":
				return "specialty_weapon_";

			case "specialty_bulletdamage":
			case "bulletdamage":
			case "bdamage":
			case "bulletd":
			//case "bullet": // too common
			case "damage":
			case "bd":
				return "specialty_bulletdamage";

			case "specialty_stunprotection":
			case "stunprotection":
			case "sprotection":
			case "stunp":
			case "stun":
			//case "protection": // too common
			case "sp":
				return "specialty_stunprotection";

			case "specialty_proximityprotection":
			case "proximityprotection":
			case "pprotection":
			case "proximityp":
			case "proximity":
			//case "protection": // too common
			case "pp":
				return "specialty_proximityprotection";

			case "specialty_gpsjammer":
			case "gpsjammer":
			case "gjammer":
			case "gpsj":
			case "gps":
			case "jammer":
			case "gj":
				return "specialty_gpsjammer";

			case "specialty_jetcharger":
			case "jetcharger":
			case "jcharger":
			case "jetc":
			case "jet":
			case "charger":
			case "jc":
				return "specialty_jetcharger";

			case "specialty_overcharge":
			case "overcharge":
			case "ocharge":
			case "over":
			case "charger":
			case "oc":
				return "specialty_overcharge";

			// Tracker
			case "specialty_tracker":
			case "tracker":
				return "specialty_tracker";

			// Tracker Jammer
			case "specialty_trackerjammer":
			case "trackerjammer":
				return "specialty_trackerjammer";

			// Detect Nearby Enemies
			case "specialty_detectnearbyenemies":
			case "detectnearbyenemies":
				return "specialty_detectnearbyenemies";

			// Sixth Sense Jammer
			case "specialty_sixthsensejammer":
			case "sixthsensejammer":
				return "specialty_sixthsensejammer";

			// Loudenemies
			case "specialty_loudenemies":
			case "loudenemies":
				return "specialty_loudenemies";

			// Quieter
			case "specialty_quieter":
			case "quieter":
				return "specialty_quieter";

			// Anteup
			case "specialty_anteup":
			case "anteup":
				return "specialty_anteup";

			// Sengren Jammer
			case "specialty_sengrenjammer":
			case "sengrenjammer":
				return "specialty_sengrenjammer";

			// No Motion Sensor
			case "specialty_nomotionsensor":
			case "nomotionsensor":
				return "specialty_nomotionsensor";

			// Earn More Momentum
			case "specialty_earnmoremomentum":
			case "earnmoremomentum":
				return "specialty_earnmoremomentum";

			// Immune Counter UAV
			case "specialty_immunecounteruav":
			case "immunecounteruav":
				return "specialty_immunecounteruav";

			// Extra Ammo
			case "specialty_extraammo":
			case "extraammo":
				return "specialty_extraammo";

			// Armor Piercing
			case "specialty_armorpiercing":
			case "armorpiercing":
				return "specialty_armorpiercing";

			// Spray Fire
			case "specialty_sprintfire":
			case "sprintfire":
				return "specialty_sprintfire";

			// Fall Height
			case "specialty_fallheight":
			case "fallheight":
				return "specialty_fallheight";

			// Longer Sprint
			case "specialty_longersprint":
			case "longersprint":
				return "specialty_longersprint";

			// Move Faster
			case "specialty_movefaster":
			case "movefaster":
				return "specialty_movefaster";

			// Jet No Radar
			case "specialty_jetnoradar":
			case "jetnoradar":
				return "specialty_jetnoradar";

			// Jet Quiet
			case "specialty_jetquiet":
			case "jetquiet":
				return "specialty_jetquiet";

			// Fast Ladder Climb
			case "specialty_fastladderclimb":
			case "fastladderclimb":
				return "specialty_fastladderclimb";

			// Fast Mantle
			case "specialty_fastmantle":
			case "fastmantle":
				return "specialty_fastmantle";

			// Bullet Accuracy
			case "specialty_bulletaccuracy":
			case "bulletaccuracy":
				return "specialty_bulletaccuracy";

			// Stalker
			case "specialty_stalker":
			case "stalker":
				return "specialty_stalker";

			// Two Grenades
			case "specialty_twogrenades":
			case "twogrenades":
				return "specialty_twogrenades";

			// Fast Weapon Switch
			case "specialty_fastweaponswitch":
			case "fastweaponswitch":
				return "specialty_fastweaponswitch";

			// Not Targeted By AI Tank
			case "specialty_nottargetedbyaitank":
			case "nottargetedbyaitank":
				return "specialty_nottargetedbyaitank";

			// Not Targeted By Air Support
			case "specialty_nottargetedbyairsupport":
			case "nottargetedbyairsupport":
				return "specialty_nottargetedbyairsupport";

			// Not Targeted By Robot
			case "specialty_nottargetedbyrobot":
			case "nottargetedbyrobot":
				return "specialty_nottargetedbyrobot";

			// No Killstreak Reticle
			case "specialty_nokillstreakreticle":
			case "nokillstreakreticle":
				return "specialty_nokillstreakreticle";

			// Show Enemy Vehicles
			case "specialty_showenemyvehicles":
			case "showenemyvehicles":
				return "specialty_showenemyvehicles";

			// Killstreak
			case "specialty_killstreak":
			case "killstreak":
				return "specialty_killstreak";

			// Microwave Protection
			case "specialty_microwaveprotection":
			case "microwaveprotection":
				return "specialty_microwaveprotection";

			// Not Targeted By RAPS
			case "specialty_nottargetedbyraps":
			case "nottargetedbyraps":
				return "specialty_nottargetedbyraps";

			// Show Enemy Equipment
			case "specialty_showenemyequipment":
			case "showenemyequipment":
				return "specialty_showenemyequipment";

			// No Name
			case "specialty_noname":
			case "noname":
				return "specialty_noname";

			// Scavenger
			case "specialty_scavenger":
			case "scavenger":
				return "specialty_scavenger";

			// Not Targeted By Sentry
			case "specialty_nottargetedbysentry":
			case "nottargetedbysentry":
				return "specialty_nottargetedbysentry";

			// Show Score Streak Icons
			case "specialty_showscorestreakicons":
			case "showscorestreakicons":
				return "specialty_showscorestreakicons";

			// Immune NV Thermal
			case "specialty_immunenvthermal":
			case "immunenvthermal":
				return "specialty_immunenvthermal";

			// Immune Trigger C4
			case "specialty_immunetriggerc4":
			case "immunetriggerc4":
				return "specialty_immunetriggerc4";

			// Immune Trigger Shock
			case "specialty_immunetriggershock":
			case "immunetriggershock":
				return "specialty_immunetriggershock";

			// Immune Trigger Betty
			case "specialty_immunetriggerbetty":
			case "immunetriggerbetty":
				return "specialty_immunetriggerbetty";

			// Immune Smoke
			case "specialty_immunesmoke":
			case "immunesmoke":
				return "specialty_immunesmoke";


		}

	// Perk doesn't exist?
	return undefined;
}

function parse_perk_name( str_perk ){

	// Perk doesn't exist
	if( !isdefined( get_perk_name( str_perk ) ) ) return str_perk;

	str_perk = get_perk_name( str_perk );
	a_str_tok = StrTok(str_perk, "_" );

    str_new_perk = "";

	// Give color to the perk only for zombie mode
	if( IS_ZOMBIES ){

		switch( str_perk ){

			case "specialty_quickrevive":
			{
				str_new_perk += "^5";
				break;
			}

			case "specialty_armorvest":
			{
				str_new_perk += "^1";
				break;
			}

			case "specialty_fastreload":
			{
				str_new_perk += "^2";
				break;
			}

			case "specialty_doubletap2":
			{
				str_new_perk += "^9";
				break;
			}

			case "specialty_staminup":
			{
				str_new_perk += "^3";
				break;
			}

			case "specialty_widowswine":
			{
				str_new_perk += "^8";
				break;
			}

			case "specialty_deadshot":
			{
				str_new_perk += "^8";
				break;
			}

			case "specialty_additionalprimaryweapon":
			{
				str_new_perk += "^2";
				break;
			}

			case "specialty_electriccherry":
			{
				str_new_perk += "^4";
				break;
			}
			
			// Custom perk?
			default:
			{
				str_new_perk += "^6";
				break;
			}

		}		

	}else{
		str_new_perk += "^2";
	}

	// Some perks are known with a name different to the one on the code
	switch( str_perk ){
		case "specialty_quickrevive":
		return str_new_perk+"Quick Revive";

		case "specialty_armorvest":
		return str_new_perk+"Juggernaut";

		case "specialty_fastreload":
		return str_new_perk+"Speed Cola";

		case "specialty_doubletap2":
		return str_new_perk+"Double Tap";

		case "specialty_staminup":
		return str_new_perk+"Stamin-Up";

		case "specialty_widowswine":
		return str_new_perk+"Widow's Wine";

		case "specialty_deadshot":
		return str_new_perk+"Deadshot Daiquiri";

		case "specialty_additionalprimaryweapon":
		return str_new_perk+"Mule Kick";

		case "specialty_electriccherry":
		return str_new_perk+"Electric Cherry";
	}

    // Start at 1 to skip "specialty_"
    for( i=1; i < a_str_tok.size; i++ ){
		
		// Make first letter capital
        str_new_perk += ToUpper( a_str_tok[ i ][ 0 ] );

        // Skip first letter since it's manually added as capital letter
        for( j=1; j < a_str_tok[ i ].size; j++){
            str_new_perk += ToLower( a_str_tok[ i ][ j ] );
        }

        // Don't add a space when it's the last token
        if(i != ( a_str_tok.size -1 ) ) str_new_perk += " ";
    }

    return str_new_perk;
}

#endregion


