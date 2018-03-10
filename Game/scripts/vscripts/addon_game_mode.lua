-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

require('internal/util')
require('gamemode')
-- Main game sound file
require('sound')

function Precache( context )
--[[
  This function is used to precache resources/units/items/abilities that will be needed
  for sure in your game and that will not be precached by hero selection.  When a hero
  is selected from the hero selection screen, the game will precache that hero's assets,
  any equipped cosmetics, and perform the data-driven precaching defined in that hero's
  precache{} block, as well as the precache{} block for any equipped abilities.

  See GameMode:PostLoadPrecache() in gamemode.lua for more information
  ]]

  SoundController:PrecacheSounds(context)

  DebugPrint("[TLS] Performing pre-load precache")

  -- Ressurrection Resources
  PrecacheResource("particle","particles/econ/events/fall_major_2016/teleport_start_fm06_outerring.vpcf",context) -- Circle

  PrecacheResource("particle", "particles/items_fx/aegis_respawn.vpcf", context) -- Respawn
  PrecacheResource("soundfile","sounds/music/dsadowski_01/stingers/respawn.vsnd",context) -- dsadowski_01.stinger.respawn



  -- Heroes are precache automatically by the game

  -- Villains -----------------------------------------

  -- These are loaded Asynchronously as they will not appear for a good few minutes and so can afford the wait time

  -- Radiant
  PrecacheUnitByNameAsync("npc_dota_hero_treant", context)
  PrecacheUnitByNameAsync("npc_dota_hero_lone_druid", context)
  -- Dire
  PrecacheUnitByNameAsync("npc_dota_hero_dark_willow", context)
  PrecacheUnitByNameAsync("npc_dota_hero_doom_bringer", context)
  -- Golem
  PrecacheUnitByNameAsync("npc_dota_hero_earth_spirit", context)
  PrecacheUnitByNameAsync("npc_dota_hero_elder_titan", context)
  -- Satyr
  PrecacheUnitByNameAsync("npc_dota_hero_nevermore", context)
  PrecacheUnitByNameAsync("npc_dota_hero_shadow_demon", context)
  -- Troll
  PrecacheUnitByNameAsync("npc_dota_hero_huskar", context)
  PrecacheUnitByNameAsync("npc_dota_hero_witch_doctor", context)
  -- Kobold
  PrecacheUnitByNameAsync("npc_dota_hero_meepo", context)
  PrecacheUnitByNameAsync("npc_dota_hero_ursa", context)
  -- Centaur
  PrecacheUnitByNameAsync("npc_dota_hero_centaur", context)
  PrecacheUnitByNameAsync("npc_dota_hero_abyssal_underlord", context)
  -- Dragon
  PrecacheUnitByNameAsync("npc_dota_hero_skywrath_mage", context)
  PrecacheUnitByNameAsync("npc_dota_hero_jakiro", context)
  -- Zombie
  PrecacheUnitByNameAsync("npc_dota_hero_undying", context)
  PrecacheUnitByNameAsync("npc_dota_hero_necrolyte", context)


  -- Hero Abilities used by heroes

  -- These are loaded Asynchronously as we are only using ability sounds and effects and these will not be needed immediately after selection

  PrecacheUnitByNameAsync("npc_dota_hero_abaddon", context)
  PrecacheUnitByNameAsync("npc_dota_hero_batrider", context)
  PrecacheUnitByNameAsync("npc_dota_hero_antimage", context)
  PrecacheUnitByNameAsync("npc_dota_hero_chen", context)
  PrecacheUnitByNameAsync("npc_dota_hero_crystal_maiden", context)
  PrecacheUnitByNameAsync("npc_dota_hero_keeper_of_the_light", context)
  PrecacheUnitByNameAsync("npc_dota_hero_lich", context)
  PrecacheUnitByNameAsync("npc_dota_hero_gyrocopter", context)
  PrecacheUnitByNameAsync("npc_dota_hero_naga_siren", context)
  PrecacheUnitByNameAsync("npc_dota_hero_troll_warlord", context)
  PrecacheUnitByNameAsync("npc_dota_hero_visage", context)
  PrecacheUnitByNameAsync("npc_dota_hero_phantom_assassin", context)
  PrecacheUnitByNameAsync("npc_dota_hero_tidehunter", context)
  PrecacheUnitByNameAsync("npc_dota_hero_phoenix", context)
  PrecacheUnitByNameAsync("npc_dota_hero_lycan", context)
  PrecacheUnitByNameAsync("npc_dota_hero_gyrocopter", context)
  PrecacheUnitByNameAsync("npc_dota_hero_ember_spirit", context)
  PrecacheUnitByNameAsync("npc_dota_hero_razor", context)
  PrecacheUnitByNameAsync("npc_dota_hero_medusa", context)
  PrecacheUnitByNameAsync("npc_dota_hero_legion_commander", context)

-- Precache the creeps

-- Radiant
PrecacheUnitByNameAsync("npc_dota_creep_goodguys_melee", context)
PrecacheUnitByNameAsync("npc_dota_creep_goodguys_ranged", context)
PrecacheUnitByNameAsync("npc_dota_goodguys_siege", context)
PrecacheUnitByNameAsync("npc_dota_creep_goodguys_melee_upgraded", context)
PrecacheUnitByNameAsync("npc_dota_creep_goodguys_ranged_upgraded", context)
PrecacheUnitByNameAsync("npc_dota_creep_goodguys_melee_upgraded_mega", context)

-- Dire
PrecacheUnitByNameAsync("npc_dota_creep_badguys_melee", context)
PrecacheUnitByNameAsync("npc_dota_creep_badguys_ranged", context)
PrecacheUnitByNameAsync("npc_dota_badguys_siege", context)
PrecacheUnitByNameAsync("npc_dota_creep_badguys_melee_upgraded", context)
PrecacheUnitByNameAsync("npc_dota_creep_badguys_ranged_upgraded", context)
PrecacheUnitByNameAsync("npc_dota_creep_badguys_melee_upgraded_mega", context)

-- Kobold
PrecacheUnitByNameAsync("npc_dota_neutral_kobold", context)
PrecacheUnitByNameAsync("npc_dota_neutral_kobold_tunneler", context)
PrecacheUnitByNameAsync("npc_dota_neutral_kobold_taskmaster", context)
PrecacheUnitByNameAsync("npc_dota_neutral_gnoll_assassin", context)
PrecacheUnitByNameAsync("npc_dota_neutral_polar_furbolg_champion", context)
PrecacheUnitByNameAsync("npc_dota_neutral_polar_furbolg_ursa_warrior", context)

-- Troll
PrecacheUnitByNameAsync("npc_dota_neutral_dark_troll", context)
PrecacheUnitByNameAsync("npc_dota_neutral_forest_troll_berserker", context)
PrecacheUnitByNameAsync("npc_dota_neutral_forest_troll_high_priest", context)
PrecacheUnitByNameAsync("npc_dota_neutral_ogre_mauler", context)
PrecacheUnitByNameAsync("npc_dota_neutral_ogre_magi", context)
PrecacheUnitByNameAsync("npc_dota_neutral_dark_troll_warlord", context)

-- Golem
PrecacheUnitByNameAsync("npc_dota_neutral_mud_golem_split", context)
PrecacheUnitByNameAsync("npc_dota_neutral_mud_golem", context)
PrecacheUnitByNameAsync("npc_dota_neutral_rock_golem", context)
PrecacheUnitByNameAsync("npc_dota_neutral_granite_golem", context)

-- Satyr
PrecacheUnitByNameAsync("npc_dota_neutral_satyr_trickster", context)
PrecacheUnitByNameAsync("npc_dota_neutral_satyr_soulstealer", context)
PrecacheUnitByNameAsync("npc_dota_neutral_satyr_hellcaller", context)

-- Centaur
PrecacheUnitByNameAsync("npc_dota_neutral_centaur_outrunner", context)
PrecacheUnitByNameAsync("npc_dota_neutral_centaur_khan", context)
PrecacheUnitByNameAsync("npc_dota_neutral_prowler_acolyte", context)
PrecacheUnitByNameAsync("npc_dota_neutral_prowler_shaman", context)

-- Dragon
PrecacheUnitByNameAsync("npc_dota_neutral_harpy_scout", context)
PrecacheUnitByNameAsync("npc_dota_neutral_harpy_storm", context)
PrecacheUnitByNameAsync("npc_dota_neutral_jungle_stalker", context)
PrecacheUnitByNameAsync("npc_dota_neutral_elder_jungle_stalker", context)
PrecacheUnitByNameAsync("npc_dota_neutral_black_drake", context)
PrecacheUnitByNameAsync("npc_dota_neutral_black_dragon", context)

-- Zombie
PrecacheUnitByNameAsync("npc_dota_unit_undying_zombie", context)
PrecacheUnitByNameAsync("npc_dota_unit_undying_zombie_torso", context)
PrecacheUnitByNameAsync("npc_dota_dark_troll_warlord_skeleton_warrior", context)
PrecacheUnitByNameAsync("npc_dota_neutral_fel_beast", context)
PrecacheUnitByNameAsync("npc_dota_neutral_ghost", context)


end


-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:_InitGameMode()
end