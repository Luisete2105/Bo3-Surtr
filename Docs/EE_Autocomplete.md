# EE Step Autocompleter

Some Easter Egg steps can be completed automatically. Run:

```
Easter_Egg <step>
```

Aliases: `EasterEgg`, `EE`. The command is **cheat protected**, so Practice
mode must be enabled first. Each step name is listed per map below.

Only the maps shown here register any autocomplete steps. Every other map
(Shadows Of Evil, Zetsubou No Shima, Shangri-La, Gorod Krovi, Revelations,
Ascension, Moon, …) has no autocomplete steps. Source:
`scripts/Zombies/ee_utility.gsc` and the per-map `*_quest.gsc` files.

---

## The Giant (`zm_factory`)

| Step | Function | Description |
|------|----------|-------------|
| `button` | `factory_button` | Shoot the out-of-bounds (OOB) button. |
| `hns` | `factory_hns` | Hit all 3 Hide-and-Seek targets. |
| `em` | `hit_exp_monkey` | Hit the Experiment Monkey target. |
| `bb` | `hit_bowie_bear` | Hit the Bowie Bear target. |
| `pb` | `hit_perk_bear` | Hit the Perk Bear target. |
| `whns` | `wait_for_hide_and_seek` | Wait until the Hide-and-Seek targets become ready. |

---

## Der Eisendrache (`zm_castle`)

| Step | Function | Description |
|------|----------|-------------|
| `dragons` | `castle_dragons` | Turn on power if needed and feed all 3 dragons (unlocks the base bow). |
| `start` | `castle_start` | Upgrade/obtain the bow and start the wisp step. |
| `tp` | `castle_tp` | First wisp / time-travel step: see the safe-box code and pick up the fuse and canister. |
| `simon` | `castle_simon` | Place the fuse, open the safe box, place the Death Ray parts, do Simon Says, do the second wisps, call Dempsey and get the golden rod. |
| `keeper` | `castle_keeper` | Place the golden rod, fill the Keeper's soul stones, see him and place the canister. |
| `bossfight` | `castle_bossfight` | Plant Ragnarok gravity spikes, then start and win the giant-Keeper bossfight. |
| `mbk` | `castle_mbk` | "My Brother's Keeper": place the summoning key on the pyramid and finish the EE. |

> These steps have no comments in the source; their descriptions are inferred
> from the step functions.

---

## Origins (`zm_tomb`)

| Step | Function | Description |
|------|----------|-------------|
| `staffs` | `tomb_staffs` | Build staffs – open the map, activate the generators/Agartha and build all 4 elemental staffs. |
| `stk` | `tomb_stk` | Secure the keys – upgrade all 4 staffs. |
| `afd` | `tomb_afd` | Ascend from darkness – place the upgraded staffs on the robots' heads. |
| `rf` | `tomb_rf` | Rain fire – activate the fire-link button and open the panzer hole. |
| `uth` | `tomb_uth` | Unleash the Horde – send the Maxis drone and kill the panzers. |
| `stwb` | `tomb_stwb` | Skewer the winged beast – destroy the zombie plane and retrieve the Maxis drone. |
| `wafoi` | `tomb_wafoi` | Wield a Fist of Iron – fill the soul boxes and give/upgrade the one-inch punch. |
| `rh` | `tomb_rh` | Raise Hell – activate and fill the Agartha portal souls. |
| `freedom` | `tomb_freedom` | Freedom (final step) – send the Maxis drone to its goal and teleport players to the final portal. |
| `wfqcb` | `wait_for_quadrotor_custom_behavior` | Wait until the Maxis drone custom behavior is enabled. |
| `tgq` | `tomb_give_quadrotor` | Give/restore the saved Maxis drone to the player who had it. |
| `abq` | `autocomplete_beacon_quest` | Auto-complete the one-inch-punch beacon quest / save its progress. |
| `aesm` | `activate_ee_sam_portal` | Insert the saved staffs into the Agartha (Samantha) portal. |
| `tfps` | `tomb_fill_portal_souls` | Fill/save the Agartha portal souls (templar kills). |
| `tfsb` | `tomb_fill_soul_box` | Fill the one-inch-punch soul boxes. |
| `tgoiptp` | `tomb_give_one_inch_punch_to_player` | Give players the one-inch punch and the kills needed to upgrade it. |
| `zplane` | `tomb_zombie_plane` | Destroy the zombie plane. |
| `zpilot` | `tomb_zombie_pilot` | Kill the zombie pilot. |
| `gud` | `tomb_get_upgraded_drone` | Pick up the upgraded Maxis drone. |
| `uth_drone` | `tomb_uth_drone` | Send the Maxis drone to the panzer hole. |
| `panzers` | `tomb_uth_panzers` | Kill all the EE panzers (mechz). |
| `fl` | `tomb_fire_link` | Activate the robot's fire-link button. |
| `ph` | `tomb_panzer_hole` | Open the panzer hole (throw the beacon). |
| `pafd` | `tomb_place_afd` | Re-place the saved staffs on the robots (partial Ascend from Darkness). |
| `ip1` | `ice_puzzle_1` | Ice staff puzzle step 1 (shoot the gem-matching tiles). |
| `ip2` | `ice_puzzle_2` | Ice staff puzzle step 2 (freeze the stones). |
| `iu` | `ice_upgrade` | Ice staff upgrade. |
| `ap1` | `air_puzzle_1` | Air staff puzzle step 1 (move the ceiling rings). |
| `ap2` | `air_puzzle_2` | Air staff puzzle step 2 (move the smoke through the detectors). |
| `au` | `air_upgrade` | Air staff upgrade. |
| `ep1` | `electric_puzzle_1` | Electric staff puzzle step 1 (play the piano chords). |
| `ep2` | `electric_puzzle_2` | Electric staff puzzle step 2 (activate the electric relays). |
| `eu` | `electric_upgrade` | Electric staff upgrade. |
| `fp1` | `fire_puzzle_1` | Fire staff puzzle step 1 (fill the sacrifice volume). |
| `fp2` | `fire_puzzle_2` | Fire staff puzzle step 2 (light the torches). |
| `fu` | `fire_upgrade` | Fire staff upgrade. |

> A couple of the Origins source comments are mislabelled (`freedom` and `tgq`);
> their descriptions above follow the actual step functions.
