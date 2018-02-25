
-- Create an instance of this class
if TheLastStand == nil then
    DebugPrint( '[TLS] creating The Last Stand' )
    _G.TheLastStand = class({})
end

NUM_WORD_DIGITS = {
  "One",
  "Two",
  "Three",
  "Four",
  "Five",
  "Six",
  "Seven",
  "Eight",
  "Nine"
}

NUM_WORD_TEENS = {
  "Ten",
  "Eleven",
  "Twelve",
  "Thirteen",
  "Fourteen",
  "Fifteen",
  "Sixteen",
  "Seventeen",
  "Eighteen",
  "Nineteen"
}

NUM_WORD_TENS = {
  "Twenty",
  "Thirty",
  "Forty",
  "Fifty",
  "Sixty",
  "Seventy",
  "Eighty",
  "Ninety"
}



-- Points hardcoded into Woodland initialisation
DebugPrint( '[TLS] Initialising Mode' )
SPAWN_POINT = {}
SPAWN_COUNT = 0
ATTACK_POINT = {}
FINAL_POINT = nil
HERO_POINT = nil
BOSS_POINT = nil
BOSS_RADIUS = 0

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
TOTAL_WAVE_TYPES = #WAVE_TYPES

WAVES_TO_COMPLETE = {}
CURRENT_WAVE_TYPE = nil
WAVE_NUMBER = 0
NORMAL_WAVE_COUNTER = 0
BOSS_WAVE_COUNTER = 0
GAME_HAS_STARTED = false

CURRENT_LEVEL = -1 -- Used only for calculating the wave number
CURRENT_ROUND = 0 -- Stores the current round number
NEXT_ROUND = 1 -- Stores the next round number
CURRENT_WAVE = 0 -- Stores the current wave number [Boss waves are 4]
NEXT_WAVE = 1  -- Stores the next wave number [Boss waves are 4]
MULTIPLIER = -0.6 -- Will be 1 at game start
WAVE_DEFAULT_BOUNTY = 300 -- This is how much gold each wave should be worth from level 1
WAVE_BOUNTY_INCREASE = 150 -- This is how much it should increase per wave in a round before multipliers
WAVE_BOUNTY = 0 -- This is how much the wave will be worth
WAVE_CONTENTS = {}
WAVE_CONTENTS_ATTACKING = {}
HERO_TARGETS = {}
PLAYER_COUNT = 0
UNITS_LEFT = 0
FINAL_ENTITY = nil
--FOW_BADGUYS = nil

-- Formatting for text
WAVE_OUTRO_DURATION = 5
WAVE_INTRO_DURATION = 10
STYLE_WAVE_OUTRO = {color="white", ["font-size"]="80px"}
STYLE_WAVE_NUM_INTRO = {color="white", ["font-size"]="80px"}
STYLE_WAVE_TYPE_INTRO = {color="red", ["font-size"]="110px"}


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

function TheLastStand:GameStart()
  TheLastStand:IncrementRound()
  TheLastStand:WaveEnded()
  GAME_HAS_STARTED = true
end


-- This is where we catch and prep for everything after each wave
function TheLastStand:WaveEnded()
  -- Announce the wave has been cleared
  if(GAME_HAS_STARTED) then
    -- Here we put things we do every round
    Notifications:TopToTeam(DOTA_TEAM_GOODGUYS,{text="Wave Cleared", duration=WAVE_OUTRO_DURATION, style=STYLE_WAVE_OUTRO})
    -- PLAY A SOUND OUTSIDE SOUND CONTROLLER
    EmitAnnouncerSoundForTeam("ui.npe_objective_complete", DOTA_TEAM_GOODGUYS)
  else
    -- Here we put first round only things
  end
  -- Increment wave number
  TheLastStand:IncrementWaveType()
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
  -- Announce that a wave has begun through text
  local text_array = TheLastStand:AnnounceWaveText(CURRENT_WAVE, CURRENT_ROUND, CURRENT_LEVEL, CURRENT_WAVE_TYPE) -- [1] is the wave number, [2] is the type
  Notifications:TopToTeam(DOTA_TEAM_GOODGUYS,{text=text_array[1], duration=WAVE_INTRO_DURATION, style=STYLE_WAVE_NUM_INTRO})
  Notifications:TopToTeam(DOTA_TEAM_GOODGUYS,{text=text_array[2], duration=WAVE_INTRO_DURATION, style=STYLE_WAVE_TYPE_INTRO})
    -- PLAY A SOUND OUTSIDE SOUND CONTROLLER
  EmitAnnouncerSoundForTeam("ui.npe_objective_given", DOTA_TEAM_GOODGUYS)
  -- Launch Hero Speaker
  SoundController:Hero_WaveStart(HERO_TARGETS)
  -- Generate wave
  if(CURRENT_WAVE~=4) then
    -- Generate a non-boss wave for waves 1, 2, and 3
    local UnitList = TheLastStand:ReturnList(CURRENT_WAVE_TYPE, CURRENT_WAVE, CURRENT_ROUND) -- List of valid types for wave 2
    local UnitCount = TheLastStand:ReturnUnitCount(CURRENT_WAVE_TYPE, CURRENT_WAVE, CURRENT_ROUND) -- List of the amount per type for wave 2
    -- Work out the bounty and XP for the waves using the default bounty and increase per wave
    TheLastStand:CalculateWaveBounty(UnitCount,(WAVE_DEFAULT_BOUNTY+WAVE_BOUNTY_INCREASE*CURRENT_WAVE))
    -- Create wave
    TheLastStand:CreateWave(UnitList, UnitCount)
  else
    -- Generate a boss wave
  end
end

-- This calculates how much each creep should be worth in the wave based on the goal per round
function TheLastStand:CalculateWaveBounty(UnitCount,goal)
  local bounty = 0
  local num = 0
  local i
  for i=1,#UnitCount do
    num = num + UnitCount[i]
  end
  WAVE_BOUNTY = math.floor(goal/num)
  DebugPrint("Difference: "..tostring((WAVE_BOUNTY*num)-goal))
end

-- Sort out the next set of waves
function TheLastStand:IncrementRound()
  CURRENT_ROUND = NEXT_ROUND
  MULTIPLIER=MULTIPLIER+0.5
  NEXT_ROUND=NEXT_ROUND+1
  -- If they survive through all available rounds, loop back around to 1
  if(NEXT_ROUND==3)then
    NEXT_ROUND = 1
  end
  -- We just incremented to Round 1, increment level
  if(CURRENT_ROUND==1)then
    CURRENT_LEVEL=CURRENT_LEVEL+1 -- Mark how many times they've survived through the set - this is a multiplier for score
    MULTIPLIER=MULTIPLIER+1.0
  end
  -- Sort out the waves to complete
  WAVES_TO_COMPLETE = {}
 -- Set up wave types
  local g, h, i = 0
  local random_array = {}
  -- Fill Waves_To_Complete twice with each wave type and a random array
  for i=1, TOTAL_WAVE_TYPES do
    table.insert(WAVES_TO_COMPLETE, WAVE_TYPES[i])
    table.insert(random_array,RandomInt(1,100))
  end
  -- Randomise the order of waves to be completed
  local temp = 0
  for g = 1, TOTAL_WAVE_TYPES-1 do
    for h = 2, TOTAL_WAVE_TYPES do
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
  WAVE_NUMBER=1
  CURRENT_WAVE_TYPE = WAVES_TO_COMPLETE[WAVE_NUMBER]
end

function TheLastStand:IncrementWaveType()
  CURRENT_WAVE = NEXT_WAVE
  MULTIPLIER=MULTIPLIER+0.1
  NEXT_WAVE=NEXT_WAVE+1
  if(NEXT_WAVE==4)then -- Should be 5 for bosses, skipping atm
    NEXT_WAVE = 1
  end
  -- If we've reached the end of a wave, better select the next wave
  if(CURRENT_WAVE == 1) then
    if(WAVE_NUMBER < TOTAL_WAVE_TYPES) then
      WAVE_NUMBER=WAVE_NUMBER+1
      CURRENT_WAVE_TYPE = WAVES_TO_COMPLETE[WAVE_NUMBER]
    else
      -- We have gone through every wave, move to the next round
      TheLastStand:IncrementRound()
    end
  end
end

-- Creates the text to be displayed on screen and returns the text and intro in a table
function TheLastStand:AnnounceWaveText(wave, round, level, ttype)
  local text = ""
  local wave_type_text = ""
  local wave_intro_text = ""
  if(wave==4)then
     -- This is a boss wave, record boss number
     BOSS_WAVE_COUNTER = BOSS_WAVE_COUNTER + 1
    wave_type_text = "Boss Round "..TheLastStand:NumToText(BOSS_WAVE_COUNTER).."."
    wave_intro_text = TheLastStand:BossIntro(ttype,round)
  else
     -- This is a nonboss wave, record wave number
    NORMAL_WAVE_COUNTER = NORMAL_WAVE_COUNTER + 1
     DebugPrint(tostring(level)..":"..tostring(round)..":"..tostring(wave))
    wave_type_text = "Wave "..TheLastStand:NumToText(NORMAL_WAVE_COUNTER).."."
    wave_intro_text = TheLastStand:TypeToText(ttype,round)
  end
  return {wave_type_text,wave_intro_text}
end

-- Takes an integer and returns the actual word: Cannot handle integers higher than 99. Current game max is 54
function TheLastStand:NumToText(num)
  if(num<10) then
    -- This is only a single number, easy
    return NUM_WORD_DIGITS[num]
  else
    -- This isn't a single number, a bit trickier
    if(num<20) then
      -- Still simple, return a teen
      return NUM_WORD_TEENS[num-9]
    else
        -- number is higher than 19 so composite number time
      if(num<100) then
        local tens = tonumber(tostring(num):sub(0,1))-1
        local digit = tonumber(tostring(num):sub(2))
        DebugPrint("Ten: "..tens.." Unit:"..digit)
        if(digit == 0) then
          return NUM_WORD_TENS[tens] -- number ends in 0
        else
          return NUM_WORD_TENS[tens].." "..NUM_WORD_DIGITS[digit] -- number ends in digit
        end
      end
    end
  end
end

-- For announcing the waves
function TheLastStand:TypeToText(ttype,round)
  if(round==1) then
    if(ttype == "Radiant") then return "Radiant" end
    if(ttype == "Dire") then return "Dire" end
    if(ttype == "Kobold") then return "Kobold" end
    if(ttype == "Troll") then return "Troll" end
    if(ttype == "Golem") then return "Golem" end
    if(ttype == "Satyr") then return "Satyr" end
    if(ttype == "Centaur") then return "Centaur" end
    if(ttype == "Dragon") then return "Dragon" end
    if(ttype == "Zombie") then return "Zombie" end
  elseif(round==2) then
    if(ttype == "Radiant") then return "Radiant" end
    if(ttype == "Dire") then return "Dire" end
    if(ttype == "Kobold") then return "Kobold" end
    if(ttype == "Troll") then return "Troll" end
    if(ttype == "Golem") then return "Golem" end
    if(ttype == "Satyr") then return "Satyr" end
    if(ttype == "Centaur") then return "Centaur" end
    if(ttype == "Dragon") then return "Dragon" end
    if(ttype == "Zombie") then return "Zombie" end
  end    
  return ""
end

-- For announcing the boss battles
function TheLastStand:BossIntro(ttype,round)
  if(round==1) then
    if(ttype == "Radiant") then return "Treant Protector" end
    if(ttype == "Dire") then return "Dark Willow" end
    if(ttype == "Kobold") then return "Meepo" end
    if(ttype == "Troll") then return "Huskar" end
    if(ttype == "Golem") then return "Earth Spirit" end
    if(ttype == "Satyr") then return "Shadow Fiend" end
    if(ttype == "Centaur") then return "Centaur" end
    if(ttype == "Dragon") then return "Skywrath" end
    if(ttype == "Zombie") then return "Undying" end
  elseif(round==2) then
    if(ttype == "Radiant") then return "Lone Druid" end
    if(ttype == "Dire") then return "Doom" end
    if(ttype == "Kobold") then return "Ursa" end
    if(ttype == "Troll") then return "Witch Doctor" end
    if(ttype == "Golem") then return "Elder Titan" end
    if(ttype == "Satyr") then return "Shadow Demon" end
    if(ttype == "Centaur") then return "Underlord" end
    if(ttype == "Dragon") then return "Jakiro" end
    if(ttype == "Zombie") then return "Necrophos" end
  end    
  return ""
end

-- Creates a wave based on Unit Types Listed and Unit Counts Listed per unit type, then orders them to move to the attack point
function TheLastStand:CreateWave(UnitTypesListed, UnitCountsListed)
  local g,h,i,j,k,l = nil
  local unit = nil
  local point = {}
  local ability = nil
  local random_array = {}
  DebugPrint("[TLS] Creating a "..CURRENT_WAVE_TYPE.." wave #"..tostring(CURRENT_WAVE))
  -- Randomise the spawn points to be used
  for h = 1, SPAWN_COUNT do
    point[h] = h
    random_array[h] = RandomInt(1,100)
  end
  local temp = 0
  -- Order the spawn points randomly so that you do not know the direction they will spawn
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
  -- Spawn a wave for each player
  for h = 1, PLAYER_COUNT do
    for i,j in pairs(UnitTypesListed)do
      for k=1, UnitCountsListed[i] do
        if(UnitTypesListed[i] ~= "mark_illusions") then
          unit = TheLastStand:CreateWaveUnitAtPlace(UnitTypesListed[i], SPAWN_POINT[point[h]], nil, DOTA_TEAM_BADGUYS, false, true)
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
        ExecuteOrderFromTable({ UnitIndex = unit:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = ATTACK_POINT[point[h]], Queue = true})
        ExecuteOrderFromTable({ UnitIndex = unit:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = FINAL_POINT, Queue = true})
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

-- Creates a unit for the wave and may give it attack orders or a bounty if desired
function TheLastStand:CreateWaveUnitAtPlace(unit_name, position, owner, team, issue_orders, give_bounty)
  local unit = nil
  unit = CreateUnitByName(unit_name, position, true, owner, owner, team)
  unit.disable_autoattack = 0
  if(issue_orders)then
    ExecuteOrderFromTable({ UnitIndex = unit:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = FINAL_POINT, Queue = true})
  end
  UNITS_LEFT=UNITS_LEFT+1
  TheLastStand:UpgradeCreep(unit, give_bounty)
  table.insert(WAVE_CONTENTS,unit)
  table.insert(WAVE_CONTENTS_ATTACKING,false)
  return unit
end

-- Upgrade a single creep based on the multiplier and fixes their abilities
function TheLastStand:UpgradeCreep(unit, give_bounty)
  DebugPrint("[TLS] Upgrading creep")
  -- Get unit details
  local ability = nil
  local i = 0
  local hp = unit:GetMaxHealth()
  local hr = unit:GetHealthRegen()
  local mr = unit:GetManaRegen()
  local arm = unit:GetPhysicalArmorBaseValue()
  local mag = unit:GetBaseMagicalResistanceValue()
  local admin = unit:GetBaseDamageMin()
  local admax = unit:GetBaseDamageMax()
  local bxp = 0
  local bg = 0
  if(give_bounty)then
    bxp = (WAVE_BOUNTY*1.45)/2  -- This controls gold and xp per wave
    bg = (WAVE_BOUNTY)/2 -- This controls gold and xp per wave
  end
  -- Change unit values based on level multiplier
  hp=math.floor(hp*MULTIPLIER)
  hr=(hr*MULTIPLIER)
  mr=(mr*MULTIPLIER)
  arm=(arm*MULTIPLIER)
  mag=math.floor(mag*MULTIPLIER)
  admin=math.floor(admin*MULTIPLIER)
  admax=math.floor(admax*MULTIPLIER)
  bxp=math.floor(bxp*MULTIPLIER)
  bg=math.floor(bg*MULTIPLIER)
  -- Set unit details
  if(unit:HasFlyMovementCapability())then
    local ms = unit:GetBaseMoveSpeed()
    ms=RandomInt(ms-10,ms+10)
    unit:SetBaseMoveSpeed(ms)
  end
  unit:SetMaxHealth(hp)
  unit:SetHealth(hp)
  unit:SetBaseHealthRegen(hr)
  unit:SetBaseManaRegen(mr)
  unit:SetPhysicalArmorBaseValue(arm)
  unit:SetBaseMagicalResistanceValue(mag)
  unit:SetBaseDamageMin(admin)
  unit:SetBaseDamageMax(admax)
  unit:SetDeathXP(bxp)
  unit:SetMaximumGoldBounty(bg)
  unit:SetMinimumGoldBounty(bg)
  -- Fix abilities
  for i=0,6 do
    ability = unit:GetAbilityByIndex(i)
    if(ability~=nil)then
      ability:SetLevel(1)
    end
  end
end

-- Upgrades the boss
function TheLastStand:UpgradeBoss(boss, give_bounty)
  -- Get the values
  local modelscale = boss:GetModeScale()
  local acquisitionrange = 1800
  local range = boss:GetAttackRange(boss)
  local str = boss:GetStrength()
  local agi = boss:GetAgility()
  local int = boss:GetIntellect()
  local bxp = 0
  local bg = 0
  if(give_bounty)then
    bxp = (WAVE_BOUNTY*1.45)/2  -- This controls gold and xp per wave
    bg = (WAVE_BOUNTY)/2 -- This controls gold and xp per wave
  end
  -- Affect the values
  modelscale = modelscale*2
  range=range*2
  bxp=bxp*MULTIPLIER
  bg=bg*MULTIPLIER
  int=int*MULTIPLIER
  int=int*MULTIPLIER
  agi=agi*MULTIPLIER
  str=str*MULTIPLIER
  -- Set unit details
  if(unit:HasFlyMovementCapability())then
    local ms = unit:GetBaseMoveSpeed()
    ms=RandomInt(ms-5,ms+5)
    unit:SetBaseMoveSpeed(ms)
  end
  boss:SetModelScale(modelscale)
  boss:SetAcquisitionRange(acquisitionrange)
  boss:SetAttackRange(range)
  boss:SetDeathXP(math.floor(bxp))
  boss:SetMaximumGoldBounty(math.floor(bg))
  boss:SetMinimumGoldBounty(math.floor(bg))
  boss:SetStrength(str)
  boss:SetAgility(agi)
  boss:SetIntellect(int)
  -- Recalculate health, armour, etc based on gains
  boss:CalculateStatBonus()
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
        "npc_dota_neutral_forest_troll_berserker",
        "npc_dota_neutral_forest_troll_high_priest"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_dark_troll", 
        "npc_dota_neutral_forest_troll_berserker",
        "npc_dota_neutral_forest_troll_high_priest", 
        "npc_dota_neutral_ogre_mauler"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_dark_troll", 
        "npc_dota_neutral_forest_troll_berserker",
        "npc_dota_neutral_forest_troll_high_priest", 
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
        "npc_dota_neutral_forest_troll_high_priest",
        "npc_dota_neutral_ogre_mauler"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_dark_troll", 
        "npc_dota_neutral_forest_troll_high_priest", 
        "npc_dota_neutral_ogre_mauler", 
        "npc_dota_neutral_ogre_magi"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_dark_troll", 
        "npc_dota_neutral_forest_troll_high_priest", 
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
      list = {"npc_dota_neutral_mud_golem"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_mud_golem"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_mud_golem",
        "npc_dota_neutral_rock_golem"}
    elseif(wave == 4) then
      -- list = boss 1
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {"npc_dota_neutral_mud_golem"}
    elseif(wave == 2) then
      list = {"npc_dota_neutral_mud_golem",
        "npc_dota_neutral_rock_golem"}
    elseif(wave == 3) then
      list = {"npc_dota_neutral_mud_golem",
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
      list = {7,
        3}
    elseif(wave == 2) then
      list = {14,
        4, 
        1}
    elseif(wave == 3) then
      list = {18,
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
      list = {2}
    elseif(wave == 2) then
      list = {4}
    elseif(wave == 3) then
      list = {4, 
        1}
    elseif(wave == 4) then
      list = {1}
    else
      --something went wrong
    end
  elseif (round==2) then
    if(wave == 1) then
      list = {4}
    elseif(wave == 2) then
      list = {4, 
        1}
    elseif(wave == 3) then
      list = {4, 
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

-- One of the heroes announces the game has begun
function TheLastStand:HeroCallStartBattle()

end

DebugPrint('[---------------------------------------------------------------------] the last stand!\n\n')