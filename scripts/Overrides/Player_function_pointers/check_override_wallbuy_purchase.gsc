// if(player [[player.check_override_wallbuy_purchase]](self.weapon, self))

function surtr_check_override_wallbuy_purchase(weapon, wallbuy){
    self endon("disconnect");

    #ifdef dev
        self IPrintLnBold("surtr_check_override_wallbuy_purchase Start^6");

        if( !isdefined( self ) ) level thread debug_message_instant("Undefined self surtr_check_override_wallbuy_purchase");
        else if( !isPlayer( self ) ) level thread debug_message_instant("Not a player surtr_check_override_wallbuy_purchase");

        if( !isdefined( weapon ) ) level thread debug_message_instant("Undefined weapon surtr_check_override_wallbuy_purchase");
        if( !isdefined( wallbuy ) ) level thread debug_message_instant("Undefined wallbuy surtr_check_override_wallbuy_purchase");
    #endif

    // Widows Override triggered
    if( isdefined( self.old_check_override_wallbuy_purchase ) && self [[ self.old_check_override_wallbuy_purchase ]](weapon, wallbuy) ) return true;

    #ifdef dev
        self IPrintLnBold("Wallbuy not overridden "+weapon.name);
    #endif

    // Not enough money to buy
    if( !self can_buy_wallbuy_weapon( weapon ) ) return false;

    #ifdef dev
        self IPrintLnBold("Wallbuy can buy "+weapon.name);
    #endif

	give_ammo = false;
	if(!is_offhand_weapon(weapon))
	{
		weapon = self get_players_weapon_from_rootweapon(weapon);

        // We don't have the weapon, let's buy it
        if(!isdefined(weapon)) return false;

        self IPrintLnBold("Regular weapon "+weapon.name);

        // Check if we can give ammo so we let the player buy
        stockmax = 0;
        stockmax = weapon.maxammo;
        clipcount = self getweaponammoclip(weapon);
        dw_clipcount = self getweaponammoclip(weapon.dualwieldweapon);
        currstock = self getammocount(weapon);

        self IPrintLnBold( sprintf("if( ( ( {0} - {1} ) + {2}) >= {3})\n {4} >= {3}", currstock, clipcount, dw_clipcount, stockmax, (currstock+clipcount+dw_clipcount)) );
        if( ( ( currstock - clipcount ) + dw_clipcount) >= stockmax )
        {
            give_ammo = false;
        }
        else
        {
            give_ammo = true;
        }

	}
	else if(self has_weapon_or_upgrade(weapon))
	{
        self IPrintLnBold("Has wallbuy weapon "+weapon.name);
		if(self getammocount(weapon) < weapon.maxammo)
		{
            self IPrintLnBold("Ammo count "+self getammocount(weapon)+" max ammo"+weapon.maxammo);
			give_ammo = true;
		}
	}else{
        return false;
    }

    self IPrintLnBold("Give ammo? "+weapon.name+" "+give_ammo);

    // We have the weapon AND we can't buy Ammo for this weapon
    if( !give_ammo ) return true;

    #ifdef dev
        self IPrintLnBold("Giving ammo to weapon "+weapon.name);
    #endif

    // Give the ammo and let the player purchase it
    self givemaxammo(weapon);
    alt_weap = weapon.altweapon;
    if(level.weaponnone != alt_weap)
    {
        self givemaxammo(alt_weap);
    }

    return false;
}

function can_buy_wallbuy_weapon( weapon ){
    self endon("disconnect");

    // Shopping free is active
    if( self.bgb == "zm_bgb_shopping_free" ) return true;
    // Secret Shopper is active
    else if( self.bgb == "zm_bgb_secret_shopper" && !is_wonder_weapon(weapon) ) return self can_buy_cost_of_weapon( weapon );
    // Check if we have enough money to buy the Wallbuy
    else return self can_buy_cost( weapon );
}

function can_buy_cost_of_weapon(w_current, n_base_non_wallbuy_cost = 750, n_upgraded_non_wallbuy_cost = 5000)
{
    self endon("disconnect");

	w_root = w_current.rootweapon;
	if(is_weapon_upgraded(w_root)) w_root = get_base_weapon(w_root);

	if(self has_upgrade(w_root))
	{
		if(is_wallbuy(w_root)) n_ammo_cost = 4000;
		else n_ammo_cost = n_upgraded_non_wallbuy_cost;
	}
	else
	{
		if(is_wallbuy(w_root)) n_ammo_cost = halve_score( get_ammo_cost(w_root) );
		else n_ammo_cost = n_base_non_wallbuy_cost;
	}
	return self.score >= n_ammo_cost;
}

function can_buy_cost( weapon )
{
    self endon("disconnect");

    if( is_weapon_upgraded( weapon ) ) return self.score >= 4500;
	return self.score >= get_ammo_cost( weapon );
}