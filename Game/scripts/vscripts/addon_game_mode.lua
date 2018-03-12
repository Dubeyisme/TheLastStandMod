-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

require('internal/util')
require('gamemode')
-- Main game sound file
require('sound')

function Precache( _context )
--[[
  This function is used to precache resources/units/items/abilities that will be needed
  for sure in your game and that will not be precached by hero selection.  When a hero
  is selected from the hero selection screen, the game will precache that hero's assets,
  any equipped cosmetics, and perform the data-driven precaching defined in that hero's
  precache{} block, as well as the precache{} block for any equipped abilities.

  See GameMode:PostLoadPrecache() in gamemode.lua for more information
  ]]

  SoundController:PrecacheSounds(_context)

  DebugPrint("[TLS] Performing pre-load precache")

  -- Ressurrection Resources
  PrecacheResource("particle","particles/econ/events/fall_major_2016/teleport_start_fm06_outerring.vpcf",_context) -- Circle

  PrecacheResource("particle", "particles/items_fx/aegis_respawn.vpcf", _context) -- Respawn
  PrecacheResource("soundfile","sounds/music/dsadowski_01/stingers/respawn.vsnd",_context) -- dsadowski_01.stinger.respawn



  -- Heroes are precache automatically by the game

  -- Villains -----------------------------------------

  -- These are loaded Asynchronously as they will not appear for a good few minutes and so can afford the wait time

  -- Radiant
  PrecacheUnitByNameAsync("npc_dota_hero_treant", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_lone_druid", _context)
  -- Dire
  PrecacheUnitByNameAsync("npc_dota_hero_dark_willow", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_doom_bringer", _context)
  -- Golem
  PrecacheUnitByNameAsync("npc_dota_hero_earth_spirit", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_elder_titan", _context)
  -- Satyr
  PrecacheUnitByNameAsync("npc_dota_hero_nevermore", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_shadow_demon", _context)
  -- Troll
  PrecacheUnitByNameAsync("npc_dota_hero_huskar", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_witch_doctor", _context)
  -- Kobold
  PrecacheUnitByNameAsync("npc_dota_hero_meepo", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_ursa", _context)
  -- Centaur
  PrecacheUnitByNameAsync("npc_dota_hero_centaur", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_abyssal_underlord", _context)
  -- Dragon
  PrecacheUnitByNameAsync("npc_dota_hero_skywrath_mage", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_jakiro", _context)
  -- Zombie
  PrecacheUnitByNameAsync("npc_dota_hero_undying", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_necrolyte", _context)


  -- Hero Abilities used by heroes

  -- These are loaded Asynchronously as we are only using ability sounds and effects and these will not be needed immediately after selection

  PrecacheUnitByNameAsync("npc_dota_hero_abaddon", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_batrider", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_antimage", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_chen", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_crystal_maiden", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_keeper_of_the_light", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_lich", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_gyrocopter", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_naga_siren", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_troll_warlord", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_visage", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_phantom_assassin", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_tidehunter", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_phoenix", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_lycan", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_gyrocopter", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_ember_spirit", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_razor", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_medusa", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_legion_commander", _context)
  PrecacheUnitByNameAsync("npc_dota_hero_tinker", _context)

-- Precache the creeps

-- Radiant
PrecacheUnitByNameAsync("npc_dota_creep_goodguys_melee", _context)
PrecacheUnitByNameAsync("npc_dota_creep_goodguys_ranged", _context)
PrecacheUnitByNameAsync("npc_dota_goodguys_siege", _context)
PrecacheUnitByNameAsync("npc_dota_creep_goodguys_melee_upgraded", _context)
PrecacheUnitByNameAsync("npc_dota_creep_goodguys_ranged_upgraded", _context)
PrecacheUnitByNameAsync("npc_dota_creep_goodguys_melee_upgraded_mega", _context)

-- Dire
PrecacheUnitByNameAsync("npc_dota_creep_badguys_melee", _context)
PrecacheUnitByNameAsync("npc_dota_creep_badguys_ranged", _context)
PrecacheUnitByNameAsync("npc_dota_badguys_siege", _context)
PrecacheUnitByNameAsync("npc_dota_creep_badguys_melee_upgraded", _context)
PrecacheUnitByNameAsync("npc_dota_creep_badguys_ranged_upgraded", _context)
PrecacheUnitByNameAsync("npc_dota_creep_badguys_melee_upgraded_mega", _context)

-- Kobold
PrecacheUnitByNameAsync("npc_dota_neutral_kobold", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_kobold_tunneler", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_kobold_taskmaster", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_gnoll_assassin", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_polar_furbolg_champion", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_polar_furbolg_ursa_warrior", _context)

-- Troll
PrecacheUnitByNameAsync("npc_dota_neutral_dark_troll", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_forest_troll_berserker", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_forest_troll_high_priest", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_ogre_mauler", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_ogre_magi", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_dark_troll_warlord", _context)

-- Golem
PrecacheUnitByNameAsync("npc_dota_neutral_mud_golem_split", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_mud_golem", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_rock_golem", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_granite_golem", _context)

-- Satyr
PrecacheUnitByNameAsync("npc_dota_neutral_satyr_trickster", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_satyr_soulstealer", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_satyr_hellcaller", _context)

-- Centaur
PrecacheUnitByNameAsync("npc_dota_neutral_centaur_outrunner", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_centaur_khan", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_prowler_acolyte", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_prowler_shaman", _context)

-- Dragon
PrecacheUnitByNameAsync("npc_dota_neutral_harpy_scout", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_harpy_storm", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_jungle_stalker", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_elder_jungle_stalker", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_black_drake", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_black_dragon", _context)

-- Zombie
PrecacheUnitByNameAsync("npc_dota_unit_undying_zombie", _context)
PrecacheUnitByNameAsync("npc_dota_unit_undying_zombie_torso", _context)
PrecacheUnitByNameAsync("npc_dota_dark_troll_warlord_skeleton_warrior", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_fel_beast", _context)
PrecacheUnitByNameAsync("npc_dota_neutral_ghost", _context)


end


-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:_InitGameMode()
end