
-- Create an instance of this class
if TheLastStand == nil then
    DebugPrint( '[TLS] creating The Last Stand' )
    _G.TheLastStand = class({})
end

-- Points hardcoded into Woodland initialisation
DebugPrint( '[TLS] Initialising Mode' )
SPAWN_POINT = {}
SPAWN_COUNT = 0
ATTACK_POINT = {}
FINAL_POINT = nil
HERO_POINT = nil
BOSS_POINT = nil
BOSS_RADIUS = 0

TOTAL_WAVE_TYPES = 9
WAVE_TYPES = {
  "Radiant",  -- 1
  "Dire",     -- 2
  "Kobold",   -- 3
  "Troll",    -- 4
  "Golem",    -- 5
  "Satyr",    -- 6
  "Centaur",  -- 7
  "Dragon",   -- 8
  "Zombie"    -- 9
}

WAVES_COMPLETE = {}
WAVES_TO_COMPLETE = {}
CURRENT_WAVE_TYPE = nil
WAVE_NUMBER = 0

CURRENT_LEVEL = 0
CURRENT_ROUND = 0
NEXT_ROUND = 1
CURRENT_WAVE = 0
NEXT_WAVE = 1
MULTIPLIER = 0.65 -- Will be 1 at game start
WAVE_CONTENTS = {}
WAVE_CONTENTS_ATTACKING = {}
HERO_TARGETS = {}
PLAYER_COUNT = 0
UNITS_LEFT = 0
FINAL_ENTITY = nil
--FOW_BADGUYS = nil

MELEE_ABILITIES = {}
RANGED_ABILITIES = {}
DEFENCE_ABILITIES = {}
DebugPrint( '[TLS] Done initialising Mode' )



DebugPrint( '[TLS] Setting up WOODLAND' )
-- Map specific point initialisation
if GetMapName() == "woodland" then

  -- Initial Spawn Point for Waves
  SPAWN_POINT[1] = Vector(-7744, 7744, 0)
  SPAWN_POINT[2] = Vector(-1920, 7616, 0)
  SPAWN_POINT[3] = Vector(6080, 7552, 0)
  SPAWN_POINT[4] = Vector(7808, 1856, 0)
  SPAWN_POINT[5] = Vector(7680, -3456, 0)
  SPAWN_POINT[6] = Vector(7808, -7616, 0)
  SPAWN_COUNT = 6

  -- Initial Attack Objective Entity and Points
  ATTACK_POINT[1] = Vector(-6720, -1280, 128)
  ATTACK_POINT[2] = Vector(-3764, 464, 128)
  ATTACK_POINT[3] = Vector(-468, 1763, 128)
  ATTACK_POINT[4] = Vector(1294, 91, 128)
  ATTACK_POINT[5] = Vector(176, -5755, 128)
  ATTACK_POINT[6] = Vector(1238, -4045, 128)

  -- Attack move to this point via the initial objective
  FINAL_POINT = Vector(-1600, -2176, 128)
  --FOW_BADGUYS = AddFOWViewer(DOTA_TEAM_GOODGUYS,FINAL_POINT,72000,360,false)

  -- Hero convene point for special events
  HERO_POINT = Vector(-2432, -4160,  256)

  -- Boss Fight Radius - don't leave this radius from the boss point
  BOSS_POINT = Vector(-1344, -2368, 128)
  BOSS_RADIUS = 2112
end
DebugPrint( '[TLS] Done setting up WOODLAND' )

-- This is where we catch and prep for everything after each wave
function TheLastStand:WaveEnded()
  -- Increment wave number
  TheLastStand:IncrementWaveType()
  if(CURRENT_WAVE == 1) then
    -- Round must have ended, prep the next round
    TheLastStand:RoundEnded()
  end
  -- Clear the old wave contents if anything left by mistake
  WAVE_CONTENTS = {}
  WAVE_CONTENTS_ATTACKING = {}
  -- Set timer for next wave

    Timers:CreateTimer({
        endTime = 10,
      callback = function()
        TheLastStand:WaveStart()
      end
    })
end

function TheLastStand:WaveStart()
  -- Generate a new wave
  DebugPrint("[TLS] Current Multiplier : "..tostring(MULTIPLIER))
  if(CURRENT_WAVE~=4) then
    -- Generate a non-boss wave for waves 1, 2, and 3
    local UnitList = TheLastStand:ReturnList(CURRENT_WAVE_TYPE, CURRENT_WAVE, CURRENT_ROUND) -- List of valid types for wave 2
    local UnitCount = TheLastStand:ReturnUnitCount(CURRENT_WAVE_TYPE, CURRENT_WAVE, CURRENT_ROUND) -- List of the amount per type for wave 2
    TheLastStand:CreateWave(UnitList, UnitCount)
  else
    -- Generate a boss wave
  end
end

-- This is where we catch and prep for everything after each round
function TheLastStand:RoundEnded()
  -- Increment Round number
  TheLastStand:IncrementRound()
end

function TheLastStand:IncrementRound()
  CURRENT_ROUND = NEXT_ROUND
  MULTIPLIER=MULTIPLIER+0.1
  NEXT_ROUND=NEXT_ROUND+1
  if(NEXT_ROUND==3)then
    NEXT_ROUND = 1
  end
  -- We just incremented to Round 1, increment level
  if(NEXT_ROUND==2)then
    CURRENT_LEVEL=CURRENT_LEVEL+1
    MULTIPLIER=MULTIPLIER+0.2
  end
  -- Mark the previous round's completion for type
  if(CURRENT_WAVE_TYPE==nil)then
    -- This is the very first round, set up the wave types
    local g, h, i = 0
    local random_array = {}
    -- Initialise the tracker
    for i=1, TOTAL_WAVE_TYPES do
      table.insert(WAVES_COMPLETE, 0)
    end
    -- Fill Waves_To_Complete twice with each wave type and a random array
    for i=1, TOTAL_WAVE_TYPES do
      table.insert(WAVES_TO_COMPLETE, WAVE_TYPES[i])
      table.insert(WAVES_TO_COMPLETE, WAVE_TYPES[i])
      table.insert(random_array,RandomInt(1,100))
      table.insert(random_array,RandomInt(1,100))
    end
    -- Randomise the order of waves to be completed
    local temp = 0
    for g = 1, TOTAL_WAVE_TYPES*2-1 do
      for h = 2, TOTAL_WAVE_TYPES*2 do
        if(random_array[g]<random_array[h])then
          temp = random_array[g]
          random_array[g] = random_array[h]
          random_array[h] = temp
          temp = WAVES_TO_COMPLETE[g]
          WAVES_TO_COMPLETE[g] = WAVES_TO_COMPLETE[h]
          WAVES_TO_COMPLETE[h] = temp
        end
      end
    end
    WAVE_NUMBER = 1
  else
    -- Increment the previosly completed wave type
    WAVE_NUMBER=WAVE_NUMBER+1
  end
    -- Mark what our current wave type is
    CURRENT_WAVE_TYPE = WAVES_TO_COMPLETE[WAVE_NUMBER]
end

function TheLastStand:IncrementWaveType()
  CURRENT_WAVE = NEXT_WAVE
  MULTIPLIER=MULTIPLIER+0.05
  NEXT_WAVE=NEXT_WAVE+1
  if(NEXT_WAVE==4)then -- Should be 5 for bosses, skipping atm
    NEXT_WAVE = 1
  end
end

function TheLastStand:TypeToText(ttype)
  local text = ""
  if(CURRENT_ROUND==1) then
    if(ttype == "Radiant") then text = "Radiant" end
    if(ttype == "Dire") then text = "Dire" end
    if(ttype == "Kobold") then text = "Kobold" end
    if(ttype == "Troll") then text = "Troll" end
    if(ttype == "Golem") then text = "Golem" end
    if(ttype == "Satyr") then text = "Satyr" end
    if(ttype == "Centaur") then text = "Centaur" end
    if(ttype == "Dragon") then text = "Dragon" end
    if(ttype == "Zombie") then text = "Zombie" end
  elseif(CURRENT_ROUND==2) then
    if(ttype == "Radiant") then text = "Radiant" end
    if(ttype == "Dire") then text = "Dire" end
    if(ttype == "Kobold") then text = "Kobold" end
    if(ttype == "Troll") then text = "Troll" end
    if(ttype == "Golem") then text = "Golem" end
    if(ttype == "Satyr") then text = "Satyr" end
    if(ttype == "Centaur") then text = "Centaur" end
    if(ttype == "Dragon") then text = "Dragon" end
    if(ttype == "Zombie") then text = "Zombie" end
  end    
  return text
end

function TheLastStand:BossIntro(ttype)
  local text = ""
  if(CURRENT_ROUND==1) then
    if(ttype == "Radiant") then text = "Treant Protector" end
    if(ttype == "Dire") then text = "Dark Willow" end
    if(ttype == "Kobold") then text = "Meepo" end
    if(ttype == "Troll") then text = "Huskar" end
    if(ttype == "Golem") then text = "Earth Spirit" end
    if(ttype == "Satyr") then text = "Shadow Fiend" end
    if(ttype == "Centaur") then text = "Centaur" end
    if(ttype == "Dragon") then text = "Skywrath" end
    if(ttype == "Zombie") then text = "Undying" end
  elseif(CURRENT_ROUND==2) then
    if(ttype == "Radiant") then text = "Lone Druid" end
    if(ttype == "Dire") then text = "Doom" end
    if(ttype == "Kobold") then text = "Ursa" end
    if(ttype == "Troll") then text = "Witch Doctor" end
    if(ttype == "Golem") then text = "Elder Titan" end
    if(ttype == "Satyr") then text = "Shadow Demon" end
    if(ttype == "Centaur") then text = "Underlord" end
    if(ttype == "Dragon") then text = "Jakiro" end
    if(ttype == "Zombie") then text = "Necrophos" end
  end    
  return text
end

-- Creates a wave based on Unit Types Listed and Unit Counts Listed per unit type, then orders them to move to the attack point
function TheLastStand:CreateWave(UnitTypesListed, UnitCountsListed)
  local g,h,i,j,k = nil
  local unit = nil
  local point = {}
  local random_array = {}
  DebugPrint("[TLS] Creating a "..CURRENT_WAVE_TYPE.." wave #"..tostring(CURRENT_WAVE))
  -- Randomise the spawn points to be used
  for h = 1, SPAWN_COUNT do
    point[h] = h
    random_array[h] = RandomInt(1,100)
  end
  local temp = 0
  for g = 1, SPAWN_COUNT-1 do
    for h = 2, SPAWN_COUNT do
      if(random_array[g]<random_array[h])then
        temp = random_array[g]
        random_array[g] = random_array[h]
        random_array[h] = temp
        temp = point[g]
        point[g] = point[h]
        point[h] = temp
      end
    end
  end
  for h = 1, PLAYER_COUNT do
    for i,j in pairs(UnitTypesListed)do
      for k=1, UnitCountsListed[i] do
        if(UnitTypesListed[i] ~= "mark_illusions") then
          unit = CreateUnitByName(UnitTypesListed[i], SPAWN_POINT[point[h]], true, nil, nil, DOTA_TEAM_BADGUYS)
          TheLastStand:UpgradeCreep(unit)
        else
          -- Create illusion and modify it to match a hero
          local target = HERO_TARGETS[h]
          local ability_slot
          unit = CreateUnitByName(target:GetName(), SPAWN_POINT[point[h]], true, nil, nil, DOTA_TEAM_BADGUYS)
          for i = 1, target:GetLevel() - 1 do
            unit:HeroLevelUp(false)
          end
          -- Set abilities to look the same
          unit:SetAbilityPoints(0) 
          for ability_slot = 0, 15 do
            local target_ability = target:GetAbilityByIndex(ability_slot) 
            if target_ability then
              local target_ability_level = target_ability:GetLevel() 
              local target_ability_name = target_ability:GetAbilityName() 
              local illusion_ability = unit:FindAbilityByName(target_ability_name) 
              illusion_ability:SetLevel(target_ability_level) 
            end
          end
          -- Set items to be the same
          for item_slot = 0, 5 do
            local item = target:GetItemInSlot(item_slot) 
            if item then
              local item_name = item:GetName() 
              local new_item = CreateItem(item_name, unit, unit) 
              unit:AddItem(new_item) 
            end
          end
          unit:AddNewModifier(nil, nil, "modifier_illusion", {duration = -1, outgoing_damage = 0.5, incoming_damage = 1.5})
          unit:MakeIllusion()
          unit:SetRenderColor(0,0,255)
        end
        -- Upgrade the creep to match the heroes based on multiplier
        unit.disable_autoattack = 0
        ExecuteOrderFromTable({ UnitIndex = unit:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = ATTACK_POINT[point[h]], Queue = true})
        ExecuteOrderFromTable({ UnitIndex = unit:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = FINAL_POINT, Queue = true})
        table.insert(WAVE_CONTENTS,unit)
        table.insert(WAVE_CONTENTS_ATTACKING,false)
        UNITS_LEFT=UNITS_LEFT+1
      end
    end
  end
  -- Call the AI timer to take control
  --BossAI:SleepAttackPrioritySimple()
end

-- Takes a unit and removes it from the wave. If it was not in the wave, returns false.
function TheLastStand:RemoveFromWaveContent(unit)
  local i,j = 0
  for i,j in pairs(WAVE_CONTENTS) do
    if(j==unit)then
      table.remove(WAVE_CONTENTS,i)
      table.remove(WAVE_CONTENTS_ATTACKING,i)
      UNITS_LEFT=UNITS_LEFT-1
      DebugPrint("[TLS] Unit removed from wave - Left:"..tostring(UNITS_LEFT))
      if(UNITS_LEFT==0) then
        -- The round must be over
      DebugPrint("[TLS] Wave ended")
      TheLastStand:WaveEnded()

      end
      return true
    end
  end
  DebugPrint("[TLS] No unit to remove from wave")
  return false
end

-- Upgrade a single creep based on the multiplier
function TheLastStand:UpgradeCreep(unit)
  -- Get unit details
  local hp = unit:GetMaxHealth()
  local hr = unit:GetHealthRegen()
  local mr = unit:GetManaRegen()
  local arm = unit:GetPhysicalArmorBaseValue()
  local mag = unit:GetBaseMagicalResistanceValue()
  local admin = unit:GetBaseDamageMin()
  local admax = unit:GetBaseDamageMax()
  local bxp = unit:GetDeathXP()*1.5
  local bg = unit:GetDeathXP()*2
  -- Change unit values based on level multiplier
  hp=hp*MULTIPLIER
  hr=hr*MULTIPLIER
  mr=mr*MULTIPLIER
  arm=arm*MULTIPLIER
  mag=mag*MULTIPLIER
  admin=admin*MULTIPLIER
  admax=admax*MULTIPLIER
  bxp=bxp*MULTIPLIER
  bg=bg*MULTIPLIER
  -- Set unit details
  unit:SetMaxHealth(hp)
  unit:SetHealth(hp)
  unit:SetBaseHealthRegen(hr)
  unit:SetBaseManaRegen(mr)
  unit:SetPhysicalArmorBaseValue(arm)
  unit:SetBaseMagicalResistanceValue(mag)
  unit:SetBaseDamageMin(math.floor(admin))
  unit:SetBaseDamageMax(math.floor(admax))
  unit:SetDeathXP(math.floor(bxp))
  unit:SetMaximumGoldBounty(math.floor(bg))
  unit:SetMinimumGoldBounty(math.floor(bg))
end

-- Fetch the list of valid units that can be spawned
function TheLastStand:ReturnList(ttype, wave, round)
  local list = {}

 -- WAVE_TYPES = {"Radiant" = 1,"Dire" = 2,"Kobold" = 3,"Troll" = 4,"Golem" = 5,"Satyr" = 6,"Centaur" = 7,"Dragon" = 8,"Zombie" = 9"}
 DebugPrint("[TLS] TTYPE - "..ttype)
 if(ttype==WAVE_TYPES[1])then
  DebugPrint("[TLS] Radiant Wave Type: "..WAVE_TYPES[1])
  if(round==1) then
    if(wave == 1) then
      list = {"npc_dota_creep_goodguys_melee",
        "npc_dota_creep_goodguys_ranged"}
    elseif(wave == 2) then
      list = {"npc_dota_creep_goodguys_melee", 
        "npc_dota_creep_goodguys_ranged",
        "npc_dota_goodguys_siege"}
    elseif(wave == 3) then
      list = {"npc_dota_creep_goodguys_melee", 
        "npc_dota_creep_goodguys_ranged",
        "npc_dota_goodguys_siege",  
        "npc_dota_creep_goodguys_melee_upgraded"}
    elseif(wave == 4) then
      -- list = boss 1
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {"npc_dota_creep_goodguys_melee_upgraded", 
        "npc_dota_creep_goodguys_ranged_upgraded"}
    elseif(wave == 2) then
      list = {"npc_dota_creep_goodguys_melee_upgraded", 
        "npc_dota_creep_goodguys_ranged_upgraded", 
        "npc_dota_goodguys_siege"}
    elseif(wave == 3) then
      list = {"npc_dota_creep_goodguys_melee_upgraded", 
        "npc_dota_creep_goodguys_ranged_upgraded", 
        "npc_dota_goodguys_siege",
        "npc_dota_creep_goodguys_melee_upgraded_mega"}
    elseif(wave == 4) then
      -- list = boss 2
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[2])then
  DebugPrint("[TLS] Dire Wave Type: "..WAVE_TYPES[2])
  if(round==1) then
    if(wave == 1) then
      list = {"npc_dota_creep_badguys_melee",
        "npc_dota_creep_badguys_ranged"}
    elseif(wave == 2) then
      list = {"npc_dota_creep_badguys_melee", 
        "npc_dota_creep_badguys_ranged",
        "npc_dota_badguys_siege"}
    elseif(wave == 3) then
      list = {"npc_dota_creep_badguys_melee", 
        "npc_dota_creep_badguys_ranged",
        "npc_dota_badguys_siege",  
        "npc_dota_creep_badguys_melee_upgraded"}
    elseif(wave == 4) then
      -- list = boss 1
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {"npc_dota_creep_badguys_melee_upgraded", 
        "npc_dota_creep_badguys_ranged_upgraded"}
    elseif(wave == 2) then
      list = {"npc_dota_creep_badguys_melee_upgraded", 
        "npc_dota_creep_badguys_ranged_upgraded", 
        "npc_dota_badguys_siege"}
    elseif(wave == 3) then
      list = {"npc_dota_creep_badguys_melee_upgraded", 
        "npc_dota_creep_badguys_ranged_upgraded", 
        "npc_dota_badguys_siege",
        "npc_dota_creep_badguys_melee_upgraded_mega"}
    elseif(wave == 4) then
      -- list = boss 2
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[3])then
  DebugPrint("[TLS] Kobold Wave Type: "..WAVE_TYPES[3])
  if(round==1) then
    if(wave == 1) then
      list = {"npc_dota_neutral_kobold",
        "npc_dota_neutral_kobold_tunneler"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_kobold",
        "npc_dota_neutral_kobold_tunneler", 
        "npc_dota_neutral_kobold_taskmaster"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_kobold",
        "npc_dota_neutral_kobold_tunneler", 
        "npc_dota_neutral_kobold_taskmaster", 
        "npc_dota_neutral_gnoll_assassin"}
    elseif(wave == 4) then
      -- list = boss 1
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {"npc_dota_neutral_kobold_tunneler", 
        "npc_dota_neutral_kobold_taskmaster",
        "npc_dota_neutral_gnoll_assassin"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_kobold_tunneler", 
        "npc_dota_neutral_kobold_taskmaster", 
        "npc_dota_neutral_gnoll_assassin", 
        "npc_dota_neutral_polar_furbolg_champion"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_kobold_tunneler", 
        "npc_dota_neutral_kobold_taskmaster", 
        "npc_dota_neutral_gnoll_assassin",
        "npc_dota_neutral_polar_furbolg_champion", 
        "npc_dota_neutral_polar_furbolg_ursa_warrior"}
    elseif(wave == 4) then
      -- list = boss 2
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[4])then
  DebugPrint("[TLS] Troll Wave Type: "..WAVE_TYPES[4])
  if(round==1) then
    if(wave == 1) then
      list = {"npc_dota_neutral_dark_troll",
        "npc_dota_neutral_forest_berserker",
        "npc_dota_neutral_forest_high_priest"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_dark_troll", 
        "npc_dota_neutral_fores4_berserker",
        "npc_dota_neutral_fores4_high_priest", 
        "npc_dota_neutral_ogre_mauler"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_dark_troll", 
        "npc_dota_neutral_forest_berserker",
        "npc_dota_neutral_forest_high_priest", 
        "npc_dota_neutral_ogre_mauler", 
        "npc_dota_neutral_ogre_magi"}
    elseif(wave == 4) then
      -- list = boss 1
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {"npc_dota_neutral_dark_troll", 
        "npc_dota_neutral_forest_high_priest",
        "npc_dota_neutral_ogre_mauler"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_dark_troll", 
        "npc_dota_neutral_forest_high_priest", 
        "npc_dota_neutral_ogre_mauler", 
        "npc_dota_neutral_ogre_magi"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_dark_troll", 
        "npc_dota_neutral_forest_high_priest", 
        "npc_dota_neutral_ogre_mauler",
        "npc_dota_neutral_ogre_magi", 
        "npc_dota_neutral_dark_troll_warlord"}
    elseif(wave == 4) then
      -- list = boss 2
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[5])then
  DebugPrint("[TLS] Golem Wave Type: "..WAVE_TYPES[5])
  if(round==1) then
    if(wave == 1) then
      list = {"npc_dota_neutral_mud_golem_split"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_mud_golem_split", 
        "npc_dota_neutral_mud_golem"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_mud_golem_split", 
        "npc_dota_neutral_mud_golem", 
        "npc_dota_neutral_rock_golem"}
    elseif(wave == 4) then
      -- list = boss 1
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {"npc_dota_neutral_mud_golem_split", 
        "npc_dota_neutral_mud_golem"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_mud_golem_split", 
        "npc_dota_neutral_mud_golem", 
        "npc_dota_neutral_rock_golem"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_mud_golem_split", 
        "npc_dota_neutral_mud_golem", 
        "npc_dota_neutral_rock_golem", 
        "npc_dota_neutral_granite_golem"}
    elseif(wave == 4) then
      -- list = boss 2
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[6])then
  DebugPrint("[TLS] Satyr Wave Type: "..WAVE_TYPES[6])
  if(round==1) then
    if(wave == 1) then
      list = {"npc_dota_neutral_satyr_trickster"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_satyr_trickster", 
        "npc_dota_neutral_satyr_soulstealer"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_satyr_trickster", 
        "npc_dota_neutral_satyr_soulstealer", 
        "npc_dota_neutral_satyr_hellcaller"}
    elseif(wave == 4) then
      -- list = boss 1
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {"npc_dota_neutral_satyr_trickster", 
        "npc_dota_neutral_satyr_soulstealer"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_satyr_trickster", 
        "npc_dota_neutral_satyr_soulstealer", 
        "npc_dota_neutral_satyr_hellcaller"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_satyr_trickster", 
        "npc_dota_neutral_satyr_soulstealer", 
        "npc_dota_neutral_satyr_hellcaller", 
        "mark_illusions"}
    elseif(wave == 4) then
      -- list = boss 2
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[7])then
  DebugPrint("[TLS] Centaur Wave Type: "..WAVE_TYPES[7])
  if(round==1) then
    if(wave == 1) then
      list = {"npc_dota_neutral_centaur_outrunner"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_centaur_outrunner", 
        "npc_dota_neutral_centaur_khan"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_centaur_outrunner", 
        "npc_dota_neutral_centaur_khan", 
        "npc_dota_neutral_prowler_acolyte"}
    elseif(wave == 4) then
      -- list = boss 1
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {"npc_dota_neutral_centaur_outrunner", 
        "npc_dota_neutral_centaur_khan"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_centaur_outrunner", 
        "npc_dota_neutral_centaur_khan", 
        "npc_dota_neutral_prowler_acolyte"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_centaur_outrunner", 
        "npc_dota_neutral_centaur_khan", 
        "npc_dota_neutral_prowler_acolyte",
        "npc_dota_neutral_prowler_shaman"}
    elseif(wave == 4) then
      -- list = boss 2
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[8])then
  DebugPrint("[TLS] Dragon Wave Type: "..WAVE_TYPES[8])
  if(round==1) then
    if(wave == 1) then
      list = {"npc_dota_neutral_harpy_scout", 
        "npc_dota_neutral_harpy_storm"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_harpy_scout", 
        "npc_dota_neutral_harpy_storm", 
        "npc_dota_neutral_jungle_stalker"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_harpy_scout", 
        "npc_dota_neutral_harpy_storm", 
        "npc_dota_neutral_jungle_stalker", 
        "npc_dota_neutral_elder_jungle_stalker"}
    elseif(wave == 4) then
      -- list = boss 1
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {"npc_dota_neutral_harpy_storm", 
        "npc_dota_neutral_jungle_stalker", 
        "npc_dota_neutral_elder_jungle_stalker"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_harpy_storm", 
        "npc_dota_neutral_jungle_stalker", 
        "npc_dota_neutral_elder_jungle_stalker", 
        "npc_dota_neutral_black_drake"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_harpy_storm", 
        "npc_dota_neutral_jungle_stalker", 
        "npc_dota_neutral_elder_jungle_stalker", 
        "npc_dota_neutral_black_drake",
        "npc_dota_neutral_black_dragon"}
    elseif(wave == 4) then
      -- list = boss 2
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[9])then
  DebugPrint("[TLS] Zombie Wave Type: "..WAVE_TYPES[9])
  if(round==1) then
    if(wave == 1) then
      list = {"npc_dota_unit_undying_zombie", 
        "npc_dota_unit_undying_zombie_torso"}
    elseif(wave == 2) then
      list = {"npc_dota_unit_undying_zombie", 
        "npc_dota_unit_undying_zombie_torso", 
        "npc_dota_dark_troll_warlord_skeleton_warrior"}
    elseif(wave == 3) then
      list = {"npc_dota_unit_undying_zombie", 
        "npc_dota_unit_undying_zombie_torso", 
        "npc_dota_dark_troll_warlord_skeleton_warrior", 
        "npc_dota_neutral_fel_beast"}
    elseif(wave == 4) then
      -- list = boss 1
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {"npc_dota_unit_undying_zombie", 
        "npc_dota_unit_undying_zombie_torso", 
        "npc_dota_dark_troll_warlord_skeleton_warrior"}
    elseif(wave == 2) then
      list = {"npc_dota_unit_undying_zombie", 
        "npc_dota_unit_undying_zombie_torso", 
        "npc_dota_dark_troll_warlord_skeleton_warrior", 
        "npc_dota_neutral_fel_beast"}
    elseif(wave == 3) then
      list = {"npc_dota_unit_undying_zombie", 
        "npc_dota_unit_undying_zombie_torso", 
        "npc_dota_dark_troll_warlord_skeleton_warrior", 
        "npc_dota_neutral_fel_beast",
        "npc_dota_neutral_ghost"}
    elseif(wave == 4) then
      -- list = boss 2
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
  return list
end

-- Fetch the amount of units that can be spawned
function TheLastStand:ReturnUnitCount(ttype, wave, round)
  local list = {}

 -- WAVE_TYPES = {"Radiant" = 1,"Dire" = 2,"Kobold" = 3,"Troll" = 4,"Golem" = 5,"Satyr" = 6,"Centaur" = 7,"Dragon" = 8,"Zombie" = 9"}

 if(ttype==WAVE_TYPES[1] or ttype==WAVE_TYPES[2])then -- Radiant/Dire
  if(round==1) then
    if(wave == 1) then
      list = {8,
        2}
    elseif(wave == 2) then
      list = {8, 
        3,
        1}
    elseif(wave == 3) then
      list = {8, 
        3,
        1,  
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {4, 
        2}
    elseif(wave == 2) then
      list = {5, 
        3, 
        1}
    elseif(wave == 3) then
      list = {5, 
        3, 
        1,
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[3])then -- Kobold
  if(round==1) then
    if(wave == 1) then
      list = {15,
        3}
    elseif(wave == 2) then
      list = {20,
        4, 
        1}
    elseif(wave == 3) then
      list = {25,
        5, 
        1, 
        2}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {5, 
        1,
        2}
    elseif(wave == 2) then
      list = {10, 
        1, 
        2, 
        1}
    elseif(wave == 3) then
      list = {10, 
        1, 
        2,
        2, 
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[4])then -- Troll
  if(round==1) then
    if(wave == 1) then
      list = {3,
        5,
        1}
    elseif(wave == 2) then
      list = {3, 
        5,
        1, 
        1}
    elseif(wave == 3) then
      list = {3, 
        5,
        1, 
        2, 
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {5, 
        1,
        1}
    elseif(wave == 2) then
      list = {5, 
        1, 
        2, 
        1}
    elseif(wave == 3) then
      list = {5, 
        2, 
        2,
        1, 
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[5])then -- Golem
  if(round==1) then
    if(wave == 1) then
      list = {4}
    elseif(wave == 2) then
      list = {4, 
        4}
    elseif(wave == 3) then
      list = {4, 
        4, 
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {4, 
        4}
    elseif(wave == 2) then
      list = {4, 
        4, 
        1}
    elseif(wave == 3) then
      list = {4, 
        4, 
        2, 
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[6])then -- Satyr
  if(round==1) then
    if(wave == 1) then
      list = {6}
    elseif(wave == 2) then
      list = {6, 
        1}
    elseif(wave == 3) then
      list = {6, 
        2, 
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {6, 
        2}
    elseif(wave == 2) then
      list = {6, 
        2, 
        1}
    elseif(wave == 3) then
      list = {6, 
        2, 
        1, 
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[7])then -- Centaur
  if(round==1) then
    if(wave == 1) then
      list = {4}
    elseif(wave == 2) then
      list = {4, 
        1}
    elseif(wave == 3) then
      list = {4, 
        1, 
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {4, 
        1}
    elseif(wave == 2) then
      list = {4, 
        1, 
        1}
    elseif(wave == 3) then
      list = {4, 
        1, 
        2,
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[8])then -- Dragon
  if(round==1) then
    if(wave == 1) then
      list = {2, 
        1}
    elseif(wave == 2) then
      list = {2, 
        1, 
        1}
    elseif(wave == 3) then
      list = {3, 
        2, 
        1, 
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {2, 
        1, 
        1}
    elseif(wave == 2) then
      list = {2, 
        2, 
        1, 
        1}
    elseif(wave == 3) then
      list = {2, 
        2, 
        1, 
        2,
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
 if(ttype==WAVE_TYPES[9])then -- Zombie
  if(round==1) then
    if(wave == 1) then
      list = {8, 
        3}
    elseif(wave == 2) then
      list = {8, 
        3, 
        5}
    elseif(wave == 3) then
      list = {8, 
        3, 
        5, 
        2}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {8, 
        3, 
        5}
    elseif(wave == 2) then
      list = {8, 
        3, 
        5, 
        2}
    elseif(wave == 3) then
      list = {8, 
        3, 
        5, 
        2,
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  else
    -- Something went wrong
  end
 end
  return list
end

