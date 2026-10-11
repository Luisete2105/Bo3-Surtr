# To Do

Planned work for Surtr. Items are grouped by area, and map-specific work is
listed per map. Difficulty is noted at the end of each item
(**Hard**, **Medium**, **Easy**).

---

## Before public release

_Nothing listed yet._

---

## After initial release

### HUDs
- [ ] Rework HUDs so they never overflow the config-string index (BG cached strings). **Hard**

### Stability and errors
- [ ] Fix all "Developer 2" errors. **Hard**
- [ ] Remove lazy links (may not be possible while keeping everything working on all game modes). **Hard**

### States
- [ ] Rework States to work like Commands/HUDs, with multiple valid names. **Hard**
- [ ] God mode is not always given correctly when saving the setting in Practice mode (can no longer reproduce; use `hud wt` and `hud lt` to debug). **Medium**

### Weapons
- [ ] Remove all `zm_weapons::weapon_give` lazy links (recreate the weapon settings 1-to-1 instead). **Hard**
- [ ] Camo command glitches with the Varix optic attachment: it takes the weapon and gives it back without attachments. Check `Toggle_Automatic_Attachments`. **Medium**
- [ ] Gun/weapon commands don't give the PaP camo. **Easy**
- [ ] Gun/weapon commands give a "Dev 2" error. **Easy**

### Code quality
- [ ] Organise the code (for real). **Medium**
- [ ] Change all possible custom Dvars to world vars (needs some refactor). **Medium**

---

## Maybe add

### HUDs and UI
- [ ] Save config-string index in `DisplayFeedMessage( str_message )`: add a second parameter (label + text) to reuse common texts like `^2Enabled!` or `^1Disabled...`. **Hard**
- [ ] Check if the player has the up/down arrow keys bound; pressing them while the Surtr console is open should select the previous/next valid command. **Medium**

### Timing and splits
- [ ] Use campaign stats to save data such as attempts and PB of splits. **Hard**
- [ ] Add a warning for "MAAAARTES A LA NOOOOCHEEEEEEE" (Tuesday 12am UTC+1). Use the same message format as the Bo3 2023 / not-using-T7-patch warning. **Hard**

### Commands
- [ ] Weapon name parser (type `rk5` and translate to `pistol_burst`) plus a weapon lookup table. **Medium**
- [ ] A command to change which tag the aimbot aims at. **Easy**
- [ ] A command to decide the `zm_zod` train location, instead of always running it on `main.gsc`. **Easy**
- [ ] Make all 1-line functions a define. **Easy**

### States
- [ ] Save states should remember how many zombies are alive with their locations, how many to spawn and how many to respawn. **Medium**
- [ ] Make save states remember the ammo of weapons, attachments and camo. **Easy**
- [ ] Save states should remember your special grenade and whether you had a hero weapon. **Easy**

### Map-specific

#### Shadows Of Evil (`zm_zod`)
- [ ] Basic practice patch for SoE. **Easy**
- [ ] SoE Margwa practice that actually works. **Easy**

#### Origins (`zm_tomb`)
- [ ] Basic practice patch for Origins. **Easy**
- [ ] Origins trio skip practice? **Hard**

#### Der Eisendrache (`zm_castle`)
- [ ] `zm_maps\Castle` files are not organised (DE support is going to be dropped for the initial release). **Hard**

### Gameplay fixes
- [ ] Gravity spikes glitch when the ammo command is active: after placing them you can't pull them out even if you pick them up; you must give yourself the weapon again. **Medium**

### Mod compatibility
- [ ] On the KZ mod, check if the player is in beast mode. **Easy**
