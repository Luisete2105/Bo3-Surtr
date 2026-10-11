# Practice States

Practice states let you jump straight into a specific setup (a practice
scenario, an Easter Egg step, a patch, etc.) instead of replaying the map from
the start.

* **Set/load a state:** `Practice_State <name>` (aliases: `PracticeState`,
  `PS`, `Set_State`, `SetState`, `State`). This command is **cheat
  protected**, so Practice mode must be enabled first.
* **Save a custom state:** `Custom_Save_State` (aliases: `CustomSaveState`,
  `CSS`, `Save_State`, `SaveState`, `SS`, `Save`) saves the current game as
  the `custom` state for the current map.
* To disable the active state, use one of: `0`, `false`, `disable`,
  `deactivate`, `stop`, `none`, `nan`, `no`, `default`, `reset`, `restart`,
  `normal`, or an empty value.

States are stored per map, so they only apply to the map you are on. Source:
`scripts/Mods/practice_defaults.gsc` and `scripts/Mods/practice_save_states.gsc`.

## What a saved state stores

A `custom` state records the following for the current map:

* **Power** – whether power is on and any custom power flags.
* **Blockers** – opened doors, opened airlocks and still-closed debris.
* **Barriers** – the state of every zombie barrier.
* **Easter Egg steps** – the completed EE step list (only for maps that expose
  EE steps).
* **Round** – the current round number.
* **Per player** – score (points), position, angles, stance and velocity;
  weapons and their alternate ammo types; owned perks; and the current
  GobbleGum plus its remaining uses and the randomized gum cycle.

Ammo (clip, reserve, grenades, equipment) is **not** saved or restored.

---

## General (all maps)

| State name | Description |
|------------|-------------|
| `custom` | Loads your saved custom state for the current map (see above). |

---

## Shadows Of Evil (`zm_zod`)

| State name | Description |
|------------|-------------|
| `patch` | Patches GobbleGums (`zod_bgb`), overrides the wasp/raps special rounds based on player count, and sets the EE characters after the game starts. |
| `abh` | Boss Rush variant: overrides the ABH EE locations and patches GobbleGums. Only registered while the Boss Rush mod is active. |

## The Giant (`zm_factory`)

| State name | Description |
|------------|-------------|
| `patch` | Off-the-record EE run patch: overrides the ABH EE locations (reverted after the EE completes), patches GobbleGums, and patches zombie spawn locations (reverted once the east door is opened). |
| `forbidden` | Rounds SR "forbidden" ABH strat: overrides the ABH locations, patches GobbleGums, and shows a notification for the new ABH location. |

## Der Eisendrache (`zm_castle`)

| State name | Description |
|------------|-------------|
| `firebow` | "6 dogs" setup: patches GobbleGums, forces the next dog round to round 6, patches zombie spawns (reverted after all dragons are fed), and feeds the Great Hall and Courtyard dragons. |
| `abh` | "5 dogs" setup: forces the next dog round to round 5, patches GobbleGums, overrides the ABH EE locations (reverted once the ABH flag is set), and feeds the Great Hall and Courtyard dragons. |

## Gorod Krovi (`zm_stalingrad`)

| State name | Description |
|------------|-------------|
| `patch` | General patch: patches GobbleGums, plus a "perfect dragon" (only fires during the fire-zombie/egg-roast challenge) and a "perfect cylinder" (guaranteed cylinder drop pods until 3 map pieces are collected). |
| `gersh` | Starts the Gersh challenge: opens all doors, gives every player the upgraded Ray Gun Mark 3 + Dragon Strike and Perkaholic, sets score to 7777777, teleports everyone to the judicial zone, and adds a waypoint on Gersh until the challenge ends. |
| `download` | Starts the Download challenge: opens all, sets the dragon-wings/PaP flags, gives the upgraded Ray Gun Mark 3, Dragon Strike and Perkaholic + Anywhere But Here, equips dragon wings, teleports to the judicial zone, and shortens the download time. |
| `sophia` | Starts the Sophia challenge: opens all, sets the dragon-wings/PaP flags, gives the upgraded Ray Gun Mark 3, Dragon Strike and Perkaholic + Idle Eyes, equips dragon wings, teleports to the bunker zone, sets the delivered weapon cores, and freezes player controls for 60 seconds. |

## Origins (`zm_tomb`)

| State name | Description |
|------------|-------------|
| `ice` | Ice staff practice: opens all doors and gramophone doors plus the Agartha zone, activates the generators, teleports players to teleporter #4 and gives the ice staff (`staff_water`). |
| `air` | Air (wind) staff practice: same opening/generator setup, teleports to teleporter #2 and gives the wind staff (`staff_air`). |
| `lightning` | Lightning (electric) staff practice: same opening/generator setup, teleports to teleporter #3 and gives the electric staff (`staff_lightning`). |
| `fire` | Fire staff practice: same opening/generator setup, teleports through the chamber exit trigger, gives the fire staff (`staff_fire`) and, if the fire staff is not fully charged, force-completes fire puzzle step 1. |
| `patch` | General Origins patch: forces the weather (rain on round 2, snow on rounds 3-4), forces the ice staff parts to drop on the first dig, keeps both robot feet open, and forces Shopping Free / Reign Drops first in the GobbleGum cycle. |
| `petthedog` | "Pet the Dog" final setup: opens all, completes the Secure the Keys step, gives Perkaholic + Self Medication, replaces weapons with upgraded Boomhilda, upgraded fire staff and STG-44, gives all beacons, fills the soul boxes, builds and picks up the Maxis drone, sets round 15 and score 20000, and teleports the host to the final area. |

---

Other maps (`asylum`, `sumpf`, `prototype`, `theater`, `cosmodrome`, `temple`,
`moon`, `genesis`, `island`) define no map-specific states – only `custom` is
available there.
