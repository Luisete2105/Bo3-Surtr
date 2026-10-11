# Console Commands

Surtr exposes a number of console commands that you can type into the in-game
keyboard console. Commands are split by **registration file**, which defines
where they are available:

* **Shared** – available in every game mode (campaign, multiplayer, zombies).
  Registered in `scripts/commands/shared_commands.gsc`.
* **Zombie (ZM)** – only available while a zombie map is loaded.
  Registered in `scripts/commands/zm_commands.gsc`.
* **Multiplayer (MP)** – multiplayer-only commands. (None yet.)

> **"Real run" column:** *Yes* means the command is usable without Practice mode.
> *No* means the command is **cheat protected** – you must enable Practice mode
> (with the `Toggle_Practice` command) before it will run.

Commands available only in developer builds (`#ifdef dev`) are **not** listed
here.

---

## Shared (all game modes)

| Name | Other names | Description | Arguments | Real run |
|------|-------------|-------------|-----------|:--------:|
| `Toggle_Practice` | `TogglePractice`, `Practice`, `Pract`, `Prac`, `Pra`, `cheats`, `cheat` | Enable or disable Practice mode to allow cheat-protected commands. | 0 | Yes |
| `Full_Offline` | `FullOffline`, `True_Offline`, `TrueOffline`, `No_Demonware`, `NoDemonware`, `NoDW` | Disconnect from DemonWare, Uno and Umbrella online services. | 0 | Yes |
| `Smite_Chat` | `SmiteChat`, `SC`, `Smite` | Toggle Smite's quick chat command mod. | 0 | Yes |
| `Practice_State` | `PracticeState`, `PS`, `Set_State`, `SetState`, `State` | Set the current practice state. See [Practice States](States.md). | 1 – state name | No |
| `Custom_Save_State` | `CustomSaveState`, `CSS`, `Save_State`, `SaveState`, `SS`, `Save` | Save the current game as a custom save state. | 0 | No |
| `Dvar` | – | Change a Dvar. | 2 – dvar name, value | No |
| `Restore_Dvars` | `RestoreDvars`, `RD` | Restore all changed Dvars to their default values. | 0 | No |
| `Timescale` | `Time` | Set the game engine time scale. | 1 – speed multiplier | No |
| `HuD` | – | Enable or disable a HUD element by name (also used to enable splits). | 1 – hud name | Yes |
| `Bot` | `bots` | Set the number of bots in the game. | 1 – bot count | Yes |
| `Toggle_RTA` | `ToggleRTA`, `RTA` | Enable or disable RTA timing. | 0 | Yes |
| `Livesplit_Autosplit` | `Toggle_Autosplit`, `LivesplitAutosplit`, `Autosplits`, `Autosplit`, `LA` | Enable or disable Livesplit auto-splitting. | 0 | Yes |
| `Livesplit_Split` | `LivesplitSplit`, `Split`, `LS` | Manually trigger a Livesplit split. | 0 | Yes |
| `Livesplit_Unsplit` | `LivesplitUnsplit`, `Unsplit`, `LU` | Manually trigger a Livesplit unsplit. | 0 | Yes |
| `Toggle_Pause` | `TogglePause`, `Pause` | Enable or disable game pause. | 0 | Yes |
| `Fast_Restart` | `Fastrestart`, `FRestart`, `FR`, `FastR` | Quickly restart the game. | 0 | Yes |
| `Map_Restart` | `MapRestart`, `MRestart`, `MR`, `MapR` | Do a full map load/restart. | 0 | Yes |
| `Map` | – | Switch to a different map. | 1 – map name | Yes |
| `Disconnect` | `Dc` | Disconnect from the current game. | 0 | Yes |
| `Toggle_Z_Speed_Values` | `ToggleZSpeedValues`, `TZSV`, `Toggle_Z_Speed`, `ToggleZSpeed`, `TZS` | Enable or disable using the Z axis value when calculating player speed. | 0 | Yes |
| `God` | `Godmode`, `invulnerability` | Toggle invincibility. | 0 | No |
| `No_Target` | `NoTarget`, `NT` | Toggle zombies ignoring you. | 0 | No |
| `No_Clip` | `NoClip`, `NC` | Toggle free-move (no-clip) mode. | 0 | No |
| `Infinite_Ammo` | `InfiniteAmmo`, `IAmmo`, `IA`, `Ammo`, `InfiniteA` | Toggle infinite ammo. | 0 | No |
| `KZ` | `Load_Save_Position`, `LoadSavePosition`, `LSP` | Toggle the load/save position mod (KZ movement-server style). | 0 | No |
| `Camera` | `Cam` | Toggle a camera that follows grenades and projectiles. | 0 | No |
| `Aimbot` | – | Toggle aimbot (currently zombies only). | 0 | No |
| `Third_Person` | `ThirdPerson`, `ThirdP`, `3p` | Enable third-person view. | 0 | No |
| `First_Person` | `FirstPerson`, `FirstP`, `1p` | Enable first-person view. | 0 | No |
| `Character_Body_Type` | `Character_Type`, `Body_Type`, `CharacterBodyType`, `CharacterType`, `BodyType`, `CharBT`, `CBT`, `Player_Body_Type`, `PlayerBT`, `PBT` | Change the player character. | 1 – character name | No |
| `Character_Body_Style` | `Character_Style`, `Body_Style`, `CharacterBodyStyle`, `CharacterStyle`, `BodyStyle`, `CharBS`, `CBS`, `Player_Body_Style`, `PlayerBS`, `PBS` | Change the player body skin. | 1 – body style name | No |
| `Character_Helmet_Style` | `Character_Helmet`, `Helmet_Style`, `CharacterHelmetStyle`, `CharacterHelmet`, `HelmetStyle`, `CharHS`, `CHS`, `Player_Helmet_Style`, `PlayerHS`, `PHS` | Change the player head skin. | 1 – helmet style name | No |
| `Perk` | `specialty` | Toggle a perk. | 1 – perk name | No |
| `Weapon` | `Weap`, `Gun` | Give a weapon. | 1 – weapon name | No |
| `Weapon_Camo` | `WeaponCamo`, `Gun_Camo`, `GunCamo`, `Camo` | Change the current weapon's camo. | 1 – camo name | No |
| `Play_Scene` | `PlayScene`, `Scene` | Force-load a scene. | 1 – scene name | No |

---

## Zombie (ZM)

| Name | Other names | Description | Arguments | Real run |
|------|-------------|-------------|-----------|:--------:|
| `Open_All` | `OpenAll` | Open all doors, debris, airlocks and activate all power. | 0 | No |
| `Enable_Special_Triggers` | `EnableSpecialTriggers`, `EST` | Activate some map triggers with text/sound notification (for example the Wisps on Der Eisendrache). | 0 | No |
| `Go_To_Round` | `GoToRound`, `GTR`, `Round` | Switch to the desired round. | 1 – round number | No |
| `Open_All_ZBarriers` | `Open_All_Barriers`, `Open_Barriers`, `OpenAllZBarriers`, `OpenAllBarriers`, `OpenBarriers`, `OAZB`, `OAB`, `OB` | Open all zombie barriers. | 0 | No |
| `Close_All_ZBarriers` | `Close_All_Barriers`, `Close_Barriers`, `CloseAllZBarriers`, `CloseAllBarriers`, `CloseBarriers`, `CAZB`, `CAB`, `CB` | Close all zombie barriers. | 0 | No |
| `Toggle_Force_Full_Easter_Egg` | `Force_Full_Easter_Egg`, `Full_Easter_Egg`, `ToggleForceFullEasterEgg`, `ForceFullEasterEgg`, `FullEasterEgg`, `TFFEE`, `FFEE`, `FEE` | Toggle forcing a full Easter Egg on maps (you still have to do all the steps). | 0 | Yes |
| `Toggle_DE_Easter_Egg_Ranked` | `DE_Easter_Egg_Ranked`, `DE_EasterEgg_Ranked`, `ToggleDEEasterEggRanked`, `DEEasterEggRanked`, `TDEEER`, `DEEER` | Toggle forcing the Der Eisendrache ranked bow logic for Easter Egg steps. | 0 | Yes |
| `Livesplit_Round_Split` | `Livesplit_Split_Round`, `LivesplitRoundSplit`, `LivesplitSplitRound`, `Round_Split`, `Split_Round`, `LRS`, `LSR` | Manually split the round timer. | 0 | Yes |
| `Split_Rounds` | `SplitRounds`, `SR` | Let Livesplit automatically split on round transitions. | 0 | Yes |
| `Activate_Common_EE_Splits` | `ActivateCommonEESplits`, `ACEES`, `Common_EE_Splits`, `CommonEESplits`, `CEES` | Enable all common Easter Egg splits at once (real EE progress only, no made-up splits). | 0 | Yes |
| `Toggle_Hide_EE_Splits` | `ToggleHideEESplits`, `THEES`, `Hide_EE_Splits`, `HideEESplits`, `HEES` | Toggle hiding the in-game Easter Egg splits. | 0 | Yes |
| `Toggle_Super_EE` | `ToggleSuperEE`, `TSEE` | Toggle having completed the Super Easter Egg. | 0 | No |
| `Toggle_MP_Attachments` | `ToggleMPAttachments`, `TMPA` | Remove multiplayer attachments from weapons. | 0 | Yes |
| `Toggle_Automatic_Attachments` | `ToggleAutomaticAttachments`, `TAA` | Give attachments to weapons that support them when the player has none (enabled by default offline or with a mod). | 0 | Yes |
| `Toggle_StatTrak` | `ToggleStatTrak`, `TS`, `TST` | Add the StatTrak attachment to weapons. | 0 | Yes |
| `Toggle_Random_Camo` | `ToggleRandomCamo`, `Toggle_Camo`, `TRC`, `TC` | Give a random camouflage to weapons that don't have one assigned. | 0 | Yes |
| `Toggle_Initial_Pistol_Attachments` | `ToggleInitialPistolAttachments`, `TIPA` | Remove attachments from the initial pistols only. | 0 | Yes |
| `Gum` | `BGB`, `Gobble_Gum`, `GobbleGum` | Give the desired GobbleGum. | 1 – gum name | No |
| `Alternative_Ammo_Type` | `AAT`, `AlternativeAmmoType` | Set the desired alternative ammo type (AAT) for the current weapon. | 1 – AAT name | No |
| `Points` | `Score` | Set the score to the desired amount. | 1 – score | No |
| `Initial_Players_Spawns` | `InitialPlayersSpawns`, `IPS` | Spawn player models on the initial player spawn locations. | 0 | No |
| `Delete_Initial_Players_Spawns` | `DeleteInitialPlayersSpawns`, `DIPS` | Remove the spawned player models from the initial player spawn locations. | 0 | No |
| `Player_Respawn_Points` | `PlayerRespawnPoints`, `PRP` | Spawn player models on the player respawn point locations. | 0 | No |
| `Delete_Player_Respawn_Points` | `DeletePlayerRespawnPoints`, `DPRP` | Remove the spawned player models from the player respawn point locations. | 0 | No |
| `Easter_Egg` | `EasterEgg`, `EE` | Autocomplete an Easter Egg step. See [EE Step Autocompleter](EE_Autocomplete.md). | 1 – EE step name | No |

---

## Multiplayer (MP)

| Name | Other names | Description | Arguments | Real run |
|------|-------------|-------------|-----------|:--------:|
| _(none yet)_ | | | | |

---

To add a new command, register it with `register_keyboard_console_command` in the
appropriate file (`shared_commands.gsc` for shared, `zm_commands.gsc` for zombie
commands) and then update this document.
