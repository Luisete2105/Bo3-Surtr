//stub [[level._zm_build_trigger_from_unitrigger_stub_override]](player))

function _zm_build_trigger_from_unitrigger_stub_override(player = undefined){

    if( isDefined(player) && isPlayer(player) ){
        level.host iPrintLnBold("trigger meant for ^5"+player.name);
        wait 2;
    }

    if(isDefined(self.targetname)){
        level.host iPrintLnBold("Target ^5"+self.targetname);
    }

    level.host setOrigin( self.origin );
    return false;
}