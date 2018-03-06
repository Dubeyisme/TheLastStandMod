-- This file contains all barebones-registered events and has already set up the passed-in parameters for your use.

-- Cleanup a player when they leave
function GameMode:OnDisconnect(keys)
  DebugPrint('[TLS] Player Disconnected ' .. tostring(keys.userid))
  --DebugPrintTable(keys)

  local name = keys.name
  local networkid = keys.networkid
  local reason = keys.reason
  local userid = keys.userid
end

-- The overall game state has changed
function GameMode:OnGameRulesStateChange(keys)
  DebugPrint("[TLS] GameRules State Changed")
  --DebugPrintTable(keys)

  local newState = GameRules:State_Get()
end

-- An NPC has spawned somewhere in game.  This includes heroes
function GameMode:OnNPCSpawned(keys)
  DebugPrint("[TLS] NPC Spawned")
  --DebugPrintTable(keys)

  local npc = EntIndexToHScript(keys.entindex)
end

-- An entity somewhere has been hurt.  This event fires very often with many units so don't do too many expensive
-- operations here
function GameMode:OnEntityHurt(keys)
  -- DebugPrint("[TLS] Entity Hurt")
  --DebugPrintTable(keys)

  local damagebits = keys.damagebits -- This might always be 0 and therefore useless
  if keys.entindex_attacker ~= nil and keys.entindex_killed ~= nil then
    local entCause = EntIndexToHScript(keys.entindex_attacker)
    local entVictim = EntIndexToHScript(keys.entindex_killed)

    -- The ability/item used to damage, or nil if not damaged by an item/ability
    local damagingAbility = nil

    if keys.entindex_inflictor ~= nil then
      damagingAbility = EntIndexToHScript( keys.entindex_inflictor )
    end

    -- If this is a boss round, check boss reaction
    if(TheLastStand:GetCurrentWave()==4) then
        BossAI:BossHurt(TheLastStand:GetWaveContents()[1], entCause, damagebits)
    end

  end
end

-- Revive function caller
function GameMode:OnPlayerKilled(keys)
  DebugPrint("[TLS] OnPlayerKilled")
  DebugPrintTable(keys)
  local plyID = keys.PlayerID
  local hero = nil
  if plyID ~= nil then
    hero = PlayerResource:GetPlayer(plyID):GetAssignedHero()
    -- Send the function off to the hero handlers
    HeroStuff:InitiateReviveCircle(hero)
    -- If this is a boss round, check if the boss needs to mention this
    if(TheLastStand:GetCurrentWave()==4) then
      SoundController:Villain_HeroKilled(TheLastStand:GetWaveContents()[1])
    end
  else
    -- Something went wrong
    DebugPrint("[ERROR] - No hero died")
  end
end

-- An item was picked up off the ground
function GameMode:OnItemPickedUp(keys)
  DebugPrint( '[TLS] OnItemPickedUp' )
  --DebugPrintTable(keys)

  local unitEntity = nil
  if keys.UnitEntitIndex then
    unitEntity = EntIndexToHScript(keys.UnitEntitIndex)
  elseif keys.HeroEntityIndex then
    unitEntity = EntIndexToHScript(keys.HeroEntityIndex)
  end

  local itemEntity = EntIndexToHScript(keys.ItemEntityIndex)
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local itemname = keys.itemname
end

-- A player has reconnected to the game.  This function can be used to repaint Player-based particles or change
-- state as necessary
function GameMode:OnPlayerReconnect(keys)
  DebugPrint( '[TLS] OnPlayerReconnect' )
  --DebugPrintTable(keys) 
end

-- An item was purchased by a player
function GameMode:OnItemPurchased( keys )
  DebugPrint( '[TLS] OnItemPurchased' )
  --DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
  
end

-- An ability was used by a player
function GameMode:OnAbilityUsed(keys)
  DebugPrint('[TLS] AbilityUsed')
  --DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityname = keys.abilityname

  BossAI:EnemyHeroStartCast(player:GetAssignedHero())
  -- All custom spells must go under the above function
end

-- A non-player entity (necro-book, chen creep, etc) used an ability
function GameMode:OnNonPlayerUsedAbility(keys)
  DebugPrint('[TLS] OnNonPlayerUsedAbility')
  --DebugPrintTable(keys)

  local abilityname=  keys.abilityname
end

-- A player changed their name
function GameMode:OnPlayerChangedName(keys)
 DebugPrint('[TLS] OnPlayerChangedName')
  --DebugPrintTable(keys)

  local newName = keys.newname
  local oldName = keys.oldName
end

-- A player leveled up an ability
function GameMode:OnPlayerLearnedAbility( keys)
  DebugPrint('[TLS] OnPlayerLearnedAbility')
  --DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local hero = player:GetAssignedHero()
  local abilityname = keys.abilityname

  if(abilityname=="sniper_shrapnel")then
    hero:AddNewModifier(nil,nil,"modifier_sniper_shrapnel_charge_counter",nil)
  end
  if(abilityname=="treant_natures_guise")then
    DebugPrint("Adding modifier")
    hero:AddNewModifier(nil,nil,"modifier_treant_natures_guise",{attribute = MODIFIER_ATTRIBUTE_PERMANENT})
    DebugPrint("Done adding")
  end
end

-- A channelled ability finished by either completing or being interrupted
function GameMode:OnAbilityChannelFinished(keys)
  DebugPrint('[TLS] OnAbilityChannelFinished')
  --DebugPrintTable(keys)

  local abilityname = keys.abilityname
  local interrupted = keys.interrupted == 1
end

-- A player leveled up
function GameMode:OnPlayerLevelUp(keys)
  DebugPrint('[TLS] OnPlayerLevelUp')
  --DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local level = keys.level
end

-- A player last hit a creep, a tower, or a hero
function GameMode:OnLastHit(keys)
  DebugPrint('[TLS] OnLastHit')
  --DebugPrintTable(keys)

  local isFirstBlood = keys.FirstBlood == 1
  local isHeroKill = keys.HeroKill == 1
  local isTowerKill = keys.TowerKill == 1
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local killedEnt = EntIndexToHScript(keys.EntKilled)
end

-- A tree was cut down by tango, quelling blade, etc
function GameMode:OnTreeCut(keys)
  DebugPrint('[TLS] OnTreeCut')
  --DebugPrintTable(keys)

  local treeX = keys.tree_x
  local treeY = keys.tree_y
end

-- A player took damage from a tower
function GameMode:OnPlayerTakeTowerDamage(keys)
  DebugPrint('[TLS] OnPlayerTakeTowerDamage')
  --DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local damage = keys.damage
end

-- A player picked a hero
function GameMode:OnPlayerPickHero(keys)
  DebugPrint('[TLS] OnPlayerPickHero')
  --DebugPrintTable(keys)

  local heroClass = keys.hero
  local heroEntity = EntIndexToHScript(keys.heroindex)
  local player = EntIndexToHScript(keys.player)
end

-- A player killed another player in a multi-team context
function GameMode:OnTeamKillCredit(keys)
  DebugPrint('[TLS] OnTeamKillCredit')
  --DebugPrintTable(keys)

  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local victimPlayer = PlayerResource:GetPlayer(keys.victim_userid)
  local numKills = keys.herokills
  local killerTeamNumber = keys.teamnumber
end

-- An entity died
function GameMode:OnEntityKilled( keys )
  DebugPrint( '[TLS] OnEntityKilled Called' )
  --DebugPrintTable( keys )
  

  -- The Unit that was Killed
  local killedUnit = EntIndexToHScript( keys.entindex_killed )
  -- The Killing entity
  local killerEntity = nil

  if keys.entindex_attacker ~= nil then
    killerEntity = EntIndexToHScript( keys.entindex_attacker )
  end

  -- The ability/item used to kill, or nil if not killed by an item/ability
  local killerAbility = nil

  if keys.entindex_inflictor ~= nil then
    killerAbility = EntIndexToHScript( keys.entindex_inflictor )
  end

  local damagebits = keys.damagebits -- This might always be 0 and therefore useless

  UnitAbilities:CheckActionOnDeath(killedUnit)
end



-- This function is called 1 to 2 times as the player connects initially but before they 
-- have completely connected
function GameMode:PlayerConnect(keys)
  DebugPrint('[TLS] PlayerConnect')
  DebugPrintTable(keys)
  local playerID = keys.index+1
  if(GameMode:CheckPlayers(playerID)) then
    DebugPrint("Adding Player")
    TheLastStand:AddPlayerTargets(playerID)
    TheLastStand:SetPlayerCount(TheLastStand:GetPlayerCount()+1)
  end
end

-- Check if the player has already been added
function GameMode:CheckPlayers(pid)
  local players = TheLastStand:GetPlayerTargets()
  local i = 0
  for i=1,#players do
    if(players[i]==pid) then
      return false
    end
  end
  return true
end

-- This function is called once when the player fully connects and becomes "Ready" during Loading
function GameMode:OnConnectFull(keys)
  DebugPrint('[TLS] OnConnectFull')
  --DebugPrintTable(keys)
  local entIndex = keys.index+1
  -- The Player entity of the joining user
  local ply = EntIndexToHScript(entIndex)
  
  -- The Player ID of the joining player
  local playerID = ply:GetPlayerID()
  if(GameMode:CheckPlayers(playerID)) then
    DebugPrint("Adding Player")
    TheLastStand:AddPlayerTargets(playerID)
    TheLastStand:SetPlayerCount(TheLastStand:GetPlayerCount()+1)
  end
end

-- This function is called whenever illusions are created and tells you which was/is the original entity
function GameMode:OnIllusionsCreated(keys)
  DebugPrint('[TLS] OnIllusionsCreated')
  --DebugPrintTable(keys)

  local originalEntity = EntIndexToHScript(keys.original_entindex)
end

-- This function is called whenever an item is combined to create a new item
function GameMode:OnItemCombined(keys)
  DebugPrint('[TLS] OnItemCombined')
  --DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end
  local player = PlayerResource:GetPlayer(plyID)

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
end

-- This function is called whenever an ability begins its PhaseStart phase (but before it is actually cast)
function GameMode:OnAbilityCastBegins(keys)
  DebugPrint('[TLS] OnAbilityCastBegins')
  --DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityName = keys.abilityname
end

-- This function is called whenever any player sends a chat message to team or All
function GameMode:OnPlayerChat(keys)
  local teamonly = keys.teamonly
  local userID = keys.userid
  local playerID = self.vUserIds[userID]:GetPlayerID()

  local text = keys.text
    DebugPrint("Raw: "..text)
  if(text:sub(0,1)==".") then
    if(CHEATS) then
      GameMode:ParseText(text:sub(2),playerID)
    end
  end
end
DebugPrint('[---------------------------------------------------------------------] events!\n\n')
