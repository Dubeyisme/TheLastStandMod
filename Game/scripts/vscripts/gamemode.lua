-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode
TLS_VERSION = "1.00"


-- This is only for testing, disable before release
CHEATS = true
if(CHEATS) then DebugPrint( '[TLS] CHEATS ARE ACTIVE' ) end

if GameMode == nil then
    DebugPrint( '[TLS] creating game mode' )
    _G.GameMode = class({})
end



-- This library allow for easily delayed/timed actions
require('libraries/timers')
-- This library can be used for advancted physics/motion/collision of units.  See PhysicsReadme.txt for more information.
require('libraries/physics')
-- This library can be used for advanced 3D projectile systems.
require('libraries/projectiles')
-- This library can be used for sending panorama notifications to the UIs of players/teams/everyone
require('libraries/notifications')
-- This library can be used for starting customized animations on units from lua
require('libraries/animations')
-- This library can be used to synchronize client-server data via player/client-specific nettables
require('libraries/playertables')
-- This library can be used to create container inventories or container shops
require('libraries/containers')
-- This library provides an automatic graph construction of path_corner entities within the map
require('libraries/pathgraph')
-- This library (by Noya) provides player selection inspection and management from server lua
require('libraries/selection')

-- These internal libraries set up barebones's events and processes.  Feel free to inspect them/change them if you need to.
require('internal/gamemode')
require('internal/events')

-- The main game mode
require('TheLastStand')
-- Main game controller for the bosses, all other bosses share this AI package
require('BossAI')
-- Main game sound file
require('sound')
-- Controls unit abilities
require("unit_abilities")

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')


-- Parse text and implement test code
function GameMode:ParseText(text,pid)
  local i
  local ParsedText = {}
  local temp
  local player = PlayerResource:GetPlayer(pid)
  local hero = player:GetAssignedHero()
  DebugPrint("Processed:-: ")
  for i in string.gmatch(text, "%S+") do
    table.insert(ParsedText,i)
    DebugPrint(i)
  end
  -- Test for one of the following functions

  if(ParsedText[1]=="attackmove") then
    ExecuteOrderFromTable({ UnitIndex = hero:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = FINAL_POINT, Queue = false})
  end
  -- Fix up your hero
  if(ParsedText[1]=="hp") then hero:SetHealth(hero:GetMaxHealth()) end
  if(ParsedText[1]=="mp") then hero:SetMana(hero:GetMaxMana()) end
  if(ParsedText[1]=="gold") then PlayerResource:SetGold(pid,PlayerResource:GetGold(pid)+(ParsedText[2]),true) end
  if(ParsedText[1]=="lvl") then 
    local lvl = hero:GetLevel()
    if(lvl<ParsedText[2]+0) then
      for i=lvl,ParsedText[2]-1 do
        hero:HeroLevelUp(false)
      end
      hero:HeroLevelUp(true)
    end
  end
  if(ParsedText[1]=="refresh") then
    local ability = nil
    for i=0,hero:GetAbilityCount()-1 do
      ability = hero:GetAbilityByIndex(i)
      if(ability ~= nil) then ability:EndCooldown() end
    end
  end
end


--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
  precache the precache{"} block statement of the unit and all precache{"} block statements for every Ability# 
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).

  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function GameMode:PostLoadPrecache()
  DebugPrint("[TLS] Performing Post-Load precache")    
  --PrecacheItemByNameAsync("item_example_item", function(...) end)
  --PrecacheItemByNameAsync("example_ability", function(...) end)

  --PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
  --PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()
  DebugPrint("[TLS] First Player has loaded")
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()
  DebugPrint("[TLS] All Players have loaded into the game")
end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function GameMode:OnHeroInGame(hero)
  DebugPrint("[TLS] Hero spawned in game for first time -- " .. hero:GetUnitName())
  local i = 0
  local ability = nil
  -- Add this player's hero to the list of possible boss targets
  table.insert(HERO_TARGETS,hero)
  DebugPrint(GetTeamName(hero:GetTeamNumber()))
  PLAYER_COUNT = PLAYER_COUNT+1

  -- Some heros spawn with abilities levelled incorrectly, fix this
  for i=0,23 do
    ability = hero:GetAbilityByIndex(i)
    if(ability~=nil)then
      ability:SetLevel(0)
    end
  end

  if(hero:GetUnitName()=="npc_dota_hero_riki") then
    for i=0,hero:GetModifierCount() do
      local s = hero:GetModifierNameByIndex(i)
      DebugPrint("Modifier "..s.." removed")
      hero:RemoveModifierByName(s)  
    end
  end

  -- This line for example will set the starting gold of every hero to 500 unreliable gold
  --hero:SetGold(500, false)

  -- These lines will create an item and add it to the player, effectively ensuring they start with the item

  --[[ --These lines if uncommented will replace the W ability of any hero that loads into the game
    --with the "example_ability" ability

  local abil = hero:GetAbilityByIndex(1)
  hero:RemoveAbility(abil:GetAbilityName())
  hero:AddAbility("example_ability")]]
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function GameMode:OnGameInProgress()
  DebugPrint("[TLS] The game has officially begun")
    TheLastStand:GameStart()
end



-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
  GameMode = self
  --DebugPrint('[TLS] Starting to load The Last Stand gamemode...')

  -- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
  --Convars:RegisterCommand( "command_example", Dynamic_Wrap(GameMode, 'ExampleConsoleCommand'), "A console command example", FCVAR_CHEAT )

  --DebugPrint('[TLS] Done loading The Last Stand gamemode!\n\n')
end
DebugPrint('[---------------------------------------------------------------------] game mode!\n\n')