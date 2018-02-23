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
  PrecacheResource("particle", "particles/items_fx/aegis_respawn.vpcf", context) -- Respawn
  PrecacheResource("particle", "particles/items_fx/aegis_respawn_spotlight.vpcf", context) -- Final Revival
  PrecacheResource("soundfile","sounds/music/dsadowski_01/stingers/respawn.vsnd",context) -- dsadowski_01.stinger.respawn



  -- Heroes -----------------------------------------

  -- These are loaded Synchronously as they may be picked instantly

  -- Strength
  PrecacheUnitByNameSync("npc_dota_hero_omniknight", context)
  PrecacheUnitByNameSync("npc_dota_hero_kunkka", context)
  PrecacheUnitByNameSync("npc_dota_hero_beastmaster", context)
  -- Agility
  PrecacheUnitByNameSync("npc_dota_hero_riki", context)
  PrecacheUnitByNameSync("npc_dota_hero_sniper", context)
  PrecacheUnitByNameSync("npc_dota_hero_pangolier", context)
  -- Intelligence
  PrecacheUnitByNameSync("npc_dota_hero_lina", context)
  PrecacheUnitByNameSync("npc_dota_hero_techies", context)
  PrecacheUnitByNameSync("npc_dota_hero_furion", context)
  PrecacheUnitByNameSync("npc_dota_hero_winter_wyvern", context)

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
  PrecacheUnitByNameAsync("npc_dota_hero_naga_siren", context)
  PrecacheUnitByNameAsync("npc_dota_hero_troll_warlord", context)
  PrecacheUnitByNameAsync("npc_dota_hero_visage", context)
  PrecacheUnitByNameAsync("npc_dota_hero_phantom_assassin", context)
  PrecacheUnitByNameAsync("npc_dota_hero_tidehunter", context)
  PrecacheUnitByNameAsync("npc_dota_hero_phoenix", context)
  PrecacheUnitByNameAsync("npc_dota_hero_lycan", context)
  PrecacheUnitByNameAsync("npc_dota_hero_gyrocopter", context)
end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:_InitGameMode()
end