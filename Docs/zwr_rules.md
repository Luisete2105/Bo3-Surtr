Surtr will always have an option to help any run verifier to approve or deny a run.
This is a list of rules that were at least enforced once on a run and no longer (or never) appear on Zombies World Records site.
If you ever had one of your runs denied due to an unlisted run on the site and it doesn't appear here, please contact me to add it.
These rules don't need to be true, just enforced.

| Rule | Reason | Is it true? | How does Surtr prevent this |
|------|---------|------------|---------|
| `No more than 1 HUD.` | It's impossible to have more than 1 HUD in the game | Blatantly false, the average player knows this without checking the code. On The Giant, when activating the Teleports, the stopwatch HUD is 2 elements. The [Watch Glass](https://github.com/ate47/bo3-source/blob/fe040b1187b4850fe8da3c78b703c986c87d1028/scripts/zm/_zm_timer.gsc#L55) and the [Clock Hand](https://github.com/ate47/bo3-source/blob/fe040b1187b4850fe8da3c78b703c986c87d1028/scripts/zm/_zm_timer.gsc#L70). Usually when you see a progress bar, it's 3 elements. A [bar fill](https://github.com/ate47/bo3-source/blob/fe040b1187b4850fe8da3c78b703c986c87d1028/scripts/shared/hud_util_shared.gsc#L567) with a [frame](https://github.com/ate47/bo3-source/blob/fe040b1187b4850fe8da3c78b703c986c87d1028/scripts/shared/hud_util_shared.gsc#L601) and a [background](https://github.com/ate47/bo3-source/blob/fe040b1187b4850fe8da3c78b703c986c87d1028/scripts/shared/hud_util_shared.gsc#L633). | Surtr shows the HUDs used at the end of the game |
`Speedmeter can not use game engine values.` | It's impossible to get the speed value of a player without using a 3rd party tool. Since it's not a tool provided by Treyarch on the mod tools, it's not allowed | Obviously false. Literally every 3D game uses the player's speed a lot to calculate things and CoD is no exception, [Treyarch's API method `GetVelocity`](https://discord.com/channels/230615005194616834/262197972517781504/1545131175423639684). Gorod Krovi when [Mecha Nikolay](https://github.com/ate47/bo3-source/blob/fe040b1187b4850fe8da3c78b703c986c87d1028/scripts/zm/zm_siegebot_nikolai.gsc#L470) jumps near a player and pushes them, Moon to calculate [Gravity](https://github.com/ate47/bo3-source/blob/fe040b1187b4850fe8da3c78b703c986c87d1028/scripts/zm/zm_moon_gravity.gsc#L509) speed for the player or Shangri-La [Waterfall's Trap](https://github.com/ate47/bo3-source/blob/fe040b1187b4850fe8da3c78b703c986c87d1028/scripts/zm/zm_temple_traps.gsc#L618). | Surtr has the normal Velocity meter with api function. 
| `No Custom Functions.` | Modifications to the game that are not possible within the Mod Tools that Treyarch provided are not allowed | There is no true or false to this because it's just a rule that could be allowed. However, if we have to classify this, it's false because almost every mod nowadays uses .lua scripts which are not shipped with Treyarch mod tools, it's community-made [L3akMod](https://wiki.modme.co/wiki/black_ops_3/Lua-(LUI).html). In fact, there are unsafe lua functions that are NOT recommended to run at all, usually Bo3 custom clients have them disabled unless you launch Bo3 with `-unsafe-lua` arg, ZWR currently accepts mods with unsafe lua functions, even those that run custom DLLs. | Surtr is a .gsc only mod, it can't use Lua functions and will never load a DLL. However, custom compiler functions may fall into this category, and Surtr will display if a custom compiler function was used at the end of the game with this message `Custom Compiler Function Used #getkey`. If you don't want to use it, just compile Surtr without #getkey symbol.|
| `A mod can not include a Round Timer unless it's toggled through a console.` | Just a decision made by the ZWR team | Again, there isn't any true/false on this decision, I guess it's just that they don't want to allow classic mod menus to be used. BUT if we have to choose if it's true or false it's again a FALSE, Scrappy's BO3 [Practice Tool](https://github.com/Joshr520/BO3-Practice-Tool/tree/593fcde5eb836f64b97a619db11618838eddb075) uses an external program with UI to toggle it and it's allowed.| Surtr uses console input commands that can be called by any player, also it will show at the end of the game if a Round Timer has been used.|
| `FMJ Attachment is not allowed.` | It's a multiplayer-only attachment AND that glitch is not possible on all platforms | Both reasons are false. Not a MultiPlayer exclusive attachment, in Campaign it's a normal [unlockable](https://github.com/ate47/bo3-source/blob/fe040b1187b4850fe8da3c78b703c986c87d1028/gamedata/stats/cp/cp_statstable.csv#L3) attachment just by leveling up the weapons. On Zombies, you get that attachment whenever you use the [Pack a Punch](https://github.com/ate47/bo3-source/blob/fe040b1187b4850fe8da3c78b703c986c87d1028/scripts/zm/_zm_weapons.gsc#L2800). You can absolutely do this glitch on any platform, [PC](https://www.youtube.com/watch?v=BppBXqtpk3s), [Playstation](https://www.youtube.com/watch?v=vocR4d84Q4o) and [Xbox](https://www.youtube.com/watch?v=ns-Kw0RChq8).| Surtr has the `Toggle_MP_Attachments` weapon option to disable them; if active it will be shown at the end of the game.|
`Initial Pistol can not have any attachments.` | If you play on Coop, with certain gum combination, you can get a raygun while downed instead of the pistol. | It's true! (I have never checked this by myself and I don't care, so I will just assume it's real). | Surtr has the `Toggle_Initial_Pistol_Attachments` weapon option to disable it, if active it will be shown at game end.|


Here is a comparison of whether each mod does something to **prevent** breaking a rule (not whether the rule itself is true).

**Legend:** ✅ = Yes (green tick) · ❌ = No (red cross) · — = Void (the mod doesn't have that feature)

| Mod | Repository |
| --- | --- |
| Surtr | https://github.com/Luisete2105/bo3-surtr |
| Bo3 Practice Tool | https://github.com/Joshr520/BO3-Practice-Tool/ |
| Speedrun Mod | https://github.com/charlbbbbb/bo3-livesplit |

### ZWR rules

| Rule | Surtr | Bo3 Practice Tool | Speedrun Mod |
|------|:-----:|:-----------------:|:------------:|
| 1. `No more than 1 HUD` | ✅ | ❌ | ❌ |
| 2. `Speedmeter can not use game engine values` | ✅ | — | — |
| 3. `No Custom Functions` | ✅ | ❌ | ❌ |
| 4. `A mod can not include a Round Timer unless it's toggled through a console` | ✅ | ❌ | — |
| 5. `FMJ Attachment is not allowed` | ✅ | ❌ | — |
| 6. `Initial Pistol can not have any attachments` | ✅ | ❌ | ❌ |

### QoL (Quality of Life)

| Feature | Surtr | Bo3 Practice Tool | Speedrun Mod |
|---------|:-----:|:-----------------:|:------------:|
| 1. Compatible with all Bo3 versions | ✅ | ❌ | ❌ |
| 2. Compatible with T7 Patch | ✅ | ❌ | ❌ |
| 3. Autosplitter working for all players | ✅ | ❌ | ❌ |
| 4. No changing original game files | ✅ | ❌ | ❌ |
| 5. Manual splitting | ✅ | ❌ | ❌ |
| 6. Lets you use a gum even if you have 0 | ✅ | ❌ | ✅ |
| 7. Allows non-host binds | ✅ | ❌ | ✅ |