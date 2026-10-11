# HUD Elements

HUDs (Heads-Up Displays) are visual overlays that display information on
screen. They are enabled or disabled with the `HuD` command followed by the
HUD name (any of its valid names).

HUDs are split by **registration file**:

* **Shared** – available in every game mode, registered in
  `scripts/Huds/shared_HuD.gsc`.
* **Zombie (ZM)** – only available while a zombie map is loaded, registered in
  `scripts/Huds/zm_HuD.gsc`.
* **Multiplayer (MP)** – multiplayer-only HUDs. (None yet.)

Registration fields used below:

* **Scope** – **Global** (`GLOBAL_HUD`) HUDs hold one shared value; **Player**
  (`PLAYER_HUD`) HUDs hold a value per player.
* **Maps** – `All maps` or a specific map. Map-exclusive HUDs only register
  while that map is loaded.

> **"Real run" column:** *Yes* means the HUD is usable without Practice mode.
> *No* means the HUD is **cheat protected** – you must enable Practice mode
> (with the `Toggle_Practice` command) before it can be used.

HUDs available only in developer builds (`#ifdef dev`) are **not** listed here.
LiveSplit auto-splits are documented separately in [Splits](Splits.md).

---

## Shared (all game modes)

### All maps

| Name | Other names | Description | Scope | Maps | Real run |
|------|-------------|-------------|-------|------|:--------:|
| `Game_Identifier` | `GameIdentifier`, `AntiSplice`, `AntiCheat` | Shows the Surtr game identifier (anti-splice / anti-cheat marker). | Global | All maps | Yes |
| `Game_Time` | `GameTime`, `Game`, `Game_Timer`, `GameTimer`, `Time` | Displays the current game time. | Global | All maps | Yes |
| `UTC_Date` | `UTCDate`, `Date` | Displays the current UTC date. | Global | All maps | Yes |
| `UTC_Time` | `UTCTime` | Displays the current UTC time. | Global | All maps | Yes |
| `Speed_Meter` | `SpeedMeter`, `Velocity_Meter`, `VelocityMeter`, `Velocity`, `Speed` | Shows the current player speed using the API method. | Player | All maps | Yes |
| `Speed_Meter_Old` | `SpeedMeterOld`, `Velocity_Meter_Old`, `VelocityMeterOld`, `Velocity_Old`, `VelocityOld`, `Speed_Old`, `SpeedOld` | Shows the current player speed calculated with the old speed math. | Player | All maps | Yes |
| `XUID` | – | Displays the player's XUID. | Player | All maps | Yes |
| `GetGuid` | `Guid` | Displays the player's GUID. | Player | All maps | No |

---

## Zombie (ZM)

### All maps

| Name | Other names | Description | Scope | Maps | Real run |
|------|-------------|-------------|-------|------|:--------:|
| `Seconds_Per_Horde` | `SPH` | Seconds per horde. | Global | All maps | No |
| `Round_Time` | `RoundTime`, `RT`, `Round_Timer`, `RoundTimer` | Current round time. | Global | All maps | Yes |
| `Zombie_Cleanup` | `ZombieCleanup`, `ZC`, `Zombie_Despawn`, `ZombieDespawn`, `ZD` | Time until zombies are cleaned up. (Not accurate on Zetsubou No Shima.) | Global | All maps | Yes |
| `Zombies_Alive` | `ZombiesAlive`, `ZAlive` | Number of zombies currently alive. | Global | All maps | No |
| `Zombies_Respawn` | `ZombiesRespawn`, `ZRespawn` | Number of zombies left to respawn. | Global | All maps | No |
| `Zombies_Spawn` | `ZombiesSpawn`, `ZSpawn` | Number of zombies to spawn. | Global | All maps | No |
| `Zombies_Locations` | `ZombiesLocations`, `ZLocations` | Locations of the alive zombies. | Global | All maps | No |
| `Out_Of_Bounds_Check` | `OutOfBoundsCheck`, `OOBC`, `Out_Of_Bounds`, `OutOfBounds`, `OOB` | Whether the player is out of bounds. | Player | All maps | No |
| `Player_Zone` | `PlayerZone`, `Zone_Name`, `ZoneName`, `Zone` | Name of the zone the player is in. | Player | All maps | No |

### Shadows Of Evil (`zm_zod`)

| Name | Other names | Description | Scope | Maps | Real run |
|------|-------------|-------------|-------|------|:--------:|
| `Ritual` | `Defend_Area`, `DefendArea` | Ritual (defend area) progress. (Debugging for ScottyDogs.) | Player | Shadows Of Evil | No |

### The Giant (`zm_factory`)

_No map-exclusive HUDs (see [Splits](Splits.md) for its auto-splits)._

### Der Eisendrache (`zm_castle`)

| Name | Other names | Description | Scope | Maps | Real run |
|------|-------------|-------------|-------|------|:--------:|
| `Keeper_Souls` | `KeeperSouls` | Keeper soul stones progress. (Practice.) | Global | Der Eisendrache | No |
| `Box_Code` | `BoxCode` | The mystery box safe code. (Debugging.) | Global | Der Eisendrache | No |

### Zetsubou No Shima (`zm_island`)

_No map-exclusive HUDs (see [Splits](Splits.md) for its auto-splits)._

### Gorod Krovi (`zm_stalingrad`)

| Name | Other names | Description | Scope | Maps | Real run |
|------|-------------|-------------|-------|------|:--------:|
| `Terminal_Armory` | `TerminalArmory`, `Armory` | Armory terminal status. (Practice.) | Global | Gorod Krovi | No |
| `Terminal_Barracks` | `TerminalBarracks`, `Barracks` | Barracks terminal status. (Practice.) | Global | Gorod Krovi | No |
| `Terminal_Command` | `TerminalCommand`, `Command` | Command terminal status. (Practice.) | Global | Gorod Krovi | No |
| `Terminal_Factory` | `TerminalFactory`, `Factory` | Factory terminal status. (Practice.) | Global | Gorod Krovi | No |
| `Terminal_Library` | `TerminalLibrary`, `Library` | Library terminal status. (Practice.) | Global | Gorod Krovi | No |
| `Terminal_Store` | `TerminalStore`, `Store` | Store terminal status. (Practice.) | Global | Gorod Krovi | No |

### Revelations (`zm_genesis`)

_No map-exclusive HUDs (see [Splits](Splits.md) for its auto-splits)._

### Origins (`zm_tomb`)

_No map-exclusive HUDs (see [Splits](Splits.md) for its auto-splits)._

---

## Multiplayer (MP)

| Name | Other names | Description | Scope | Maps | Real run |
|------|-------------|-------------|-------|------|:--------:|
| _(none yet)_ | | | | | |

---

To add a new HUD, call `register_hud` in the appropriate file
(`shared_HuD.gsc` for shared or `zm_HuD.gsc` for zombie HUDs) and update this
document.
