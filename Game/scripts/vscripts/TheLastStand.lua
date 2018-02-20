
-- Points hardcoded into Woodland initialisation
SPAWN_POINT = {}
SPAWN_COUNT = 0
ATTACK_POINT = {}
FINAL_POINT = nil
HERO_POINT = nil
BOSS_POINT = nil
BOSS_RADIUS = 0

TOTAL_WAVE_TYPES = 9
WAVE_TYPES = {
  T_Radiant = 1,
  T_Dire = 2,
  T_Kobold = 3,
  T_Troll = 4,
  T_Golem = 5,
  T_Satyr = 6,
  T_Centaur = 7,
  T_Dragon = 8,
  T_Zombie = 9
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
MULTIPLIER = 1
WAVE_CONTENTS = {}
HERO_TARGETS = {}
PLAYER_COUNT = 0
UNITS_LEFT = 0

MELEE_ABILITIES = {}
RANGED_ABILITIES = {}
DEFENCE_ABILITIES = {}

-- Create an instance of this class
if TheLastStand == nil then
    DebugPrint( '[TLS] creating The Last Stand' )
    _G.TheLastStand = class({})
end



-- Map specific point initialisation
if GetMapName() == "woodland" then

  -- Initial Spawn Point for Waves
  SPAWN_POINT[1] = Vector(-8061, 8080, 0)
  SPAWN_POINT[2] = Vector(-1352, 7999, 0)
  SPAWN_POINT[3] = Vector(7545, 7891, 0)
  SPAWN_POINT[4] = Vector(8011, 2011, 0)
  SPAWN_POINT[5] = Vector(8064, -2880, 0)
  SPAWN_POINT[6] = Vector(8060, -8058, 0)
  SPAWN_COUNT = 6

  -- Initial Attack Objective
  ATTACK_POINT[1] = Vector(-6720, -1280, 128)
  ATTACK_POINT[2] = Vector(-3764, 464, 128)
  ATTACK_POINT[3] = Vector(-468, 1763, 128)
  ATTACK_POINT[4] = Vector(1294, 91, 128)
  ATTACK_POINT[5] = Vector(176, -5755, 128)
  ATTACK_POINT[6] = Vector(1238, -4045, 128)

  -- Attack move to this point via the initial objective
  FINAL_POINT = Vector(-1600, -2176, 128)

  -- Hero convene point for special events
  HERO_POINT = Vector(-2432, -4160,  256)

  -- Boss Fight Radius - don't leave this radius from the boss point
  BOSS_POINT = Vector(-1344, -2368, 128)
  BOSS_RADIUS = 2112
end


-- Collect Wave Information for the start of each new round.
function TheLastStand:CreepSpawnerRoundSetup()
  DebugPrint("[TLS] Creep Spawner Round Setup")

  -- Decide which round we are spawning 
  local ttype = CURRENT_WAVE_TYPE
  local round = CURRENT_ROUND -- Should be 1 or 2
  -- Build the list of what to spawn for each of the three waves and the Boss wave
  local UnitList1 = GameMode:ReturnList(ttype, round, 1) -- List of valid types for wave 1
  local UnitCount1 = GameMode:ReturnUnitCount(ttype, round, 1) -- List of the amount per type for wave 1
  local UnitList2 = GameMode:ReturnList(ttype, round, 2) -- List of valid types for wave 2
  local UnitCount2 = GameMode:ReturnUnitCount(ttype, round, 2) -- List of the amount per type for wave 2
  local UnitList3 = GameMode:ReturnList(ttype, round, 3) -- List of valid types for wave 3
  local UnitCount3 = GameMode:ReturnUnitCount(ttype, round, 3) -- List of the amount per type for wave 3
  --local UnitList4 = GameMode:ReturnList(ttype, round, 4) -- List of valid types for boss wave
  --local UnitCount4 = GameMode:ReturnUnitCount(ttype, round, 4) -- List of the amount per type for boss wave
  local 

  -- Clear the old wave contents
  WAVE_CONTENTS = {}

  -- Control the round, calling the spawn wave function three times, and the spawn boss wave function once


  -- WAVE_CONTENTS <- going to fill this with all the current entities
  -- SPAWN_POINT <- where we might be spawning monsters
  -- ATTACK_POINT <- The first point they must attack move to
  -- FINAL_POINT <- The final point they must attack move to


  -- Compile the numbers and initiate the round control
end


function TheLastStand:IncrementRound()
  CURRENT_ROUND = NEXT_ROUND
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
      table.insert(WAVES_TO_COMPLETE[i], WAVE_TYPES[i])
      table.insert(WAVES_TO_COMPLETE[TOTAL_WAVE_TYPES+i], WAVE_TYPES[i])
      table.insert(random_array[i],RandomInt(1,100))
      table.insert(random_array[i+TOTAL_WAVE_TYPES],RandomInt(1,100))
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
    WAVES_COMPLETE[WAVE_TYPES[CURRENT_WAVE_TYPE]]=WAVES_COMPLETE[WAVE_TYPES[CURRENT_WAVE_TYPE]]+1
    WAVE_NUMBER=WAVE_NUMBER+1
  end
  -- Mark what our current wave type is and prepare it
  CURRENT_WAVE_TYPE = WAVES_TO_COMPLETE[WAVE_NUMBER]
  GameMode:CreepSpawnerRoundSetup()
end

function TheLastStand:IncrementWave()
  CURRENT_WAVE = NEXT_WAVE
  MULTIPLIER=MULTIPLIER+0.1
  NEXT_WAVE=NEXT_WAVE+1
  if(NEXT_WAVE==5)then
    NEXT_WAVE = 1
  end
end

function TheLastStand:TypeToText(ttype)
  local text = ""
  if(CURRENT_ROUND==1) then
    if(ttype == T_Radiant) then text = "Radiant" end
    if(ttype == T_Dire) then text = "Dire" end
    if(ttype == T_Kobold) then text = "Kobold" end
    if(ttype == T_Troll) then text = "Troll" end
    if(ttype == T_Golem) then text = "Golem" end
    if(ttype == T_Satyr) then text = "Satyr" end
    if(ttype == T_Centaur) then text = "Centaur" end
    if(ttype == T_Dragon) then text = "Dragon" end
    if(ttype == T_Zombie) then text = "Zombie" end
  elseif(CURRENT_ROUND==2) then
    if(ttype == T_Radiant) then text = "Radiant" end
    if(ttype == T_Dire) then text = "Dire" end
    if(ttype == T_Kobold) then text = "Kobold" end
    if(ttype == T_Troll) then text = "Troll" end
    if(ttype == T_Golem) then text = "Golem" end
    if(ttype == T_Satyr) then text = "Satyr" end
    if(ttype == T_Centaur) then text = "Centaur" end
    if(ttype == T_Dragon) then text = "Dragon" end
    if(ttype == T_Zombie) then text = "Zombie" end
  end    
  return text
end

function TheLastStand:BossIntro(ttype)
  local text = ""
  if(CURRENT_ROUND==1) then
    if(ttype == T_Radiant) then text = "Treant Protector" end
    if(ttype == T_Dire) then text = "Dark Willow" end
    if(ttype == T_Kobold) then text = "Meepo" end
    if(ttype == T_Troll) then text = "Huskar" end
    if(ttype == T_Golem) then text = "Earth Spirit" end
    if(ttype == T_Satyr) then text = "Shadow Fiend" end
    if(ttype == T_Centaur) then text = "Centaur" end
    if(ttype == T_Dragon) then text = "Skywrath" end
    if(ttype == T_Zombie) then text = "Undying" end
  elseif(CURRENT_ROUND==2) then
    if(ttype == T_Radiant) then text = "Lone Druid" end
    if(ttype == T_Dire) then text = "Doom" end
    if(ttype == T_Kobold) then text = "Ursa" end
    if(ttype == T_Troll) then text = "Witch Doctor" end
    if(ttype == T_Golem) then text = "Elder Titan" end
    if(ttype == T_Satyr) then text = "Shadow Demon" end
    if(ttype == T_Centaur) then text = "Underlord" end
    if(ttype == T_Dragon) then text = "Jakiro" end
    if(ttype == T_Zombie) then text = "Necrophos" end
  end    
  return text
end

-- Creates a wave based on Unit Types Listed and Unit Counts Listed per unit type, then orders them to move to the attack point
function TheLastStand:CreateWave(UnitTypesListed, UnitCountsListed)
  local g,h,i,j,k = nil
  local unit = nil
  local point = {}
  local random_array = {}
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
        unit = CreateUnit(UnitTypesListed[i], SPAWN_POINT[point[h]], true, nil, nil, DOTA_TEAM_BADGUYS)
        GameMode:UpgradeCreep(unit)
        unit:MoveToPositionAggressive(ATTACK_POINT[point[h]])
        table.insert(WAVE_CONTENTS,unit)
        UNITS_LEFT=UNITS_LEFT+1
      end
    end
  end
end

function TheLastStand:RemoveFromWaveContent(unit)
  local i,j = 0
  for i,j in pairs(WAVE_CONTENTS) do
    if(j==unit)then
      table.remove(WAVE_CONTENTS,i)
      UNITS_LEFT=UNITS_LEFT-1
      break
    end
  end
end

function TheLastStand:UpgradeCreep(unit)
  -- Get unit details
  local hp = unit:GetMaxHealth()
  local hr = unit:GetHealthRegen()
  local mr = unit:GetManaRegen()
  local arm = unit:GetPhysicalArmorBaseValue()
  local mag = unit:GetBaseMagicalResistanceValue()
  local admin = unit:GetBaseDamageMin()
  local admax = unit:GetBaseDamageMax()
  -- Change unit values based on level multiplier
  hp=hp*MULTIPLIER
  hr=hr*MULTIPLIER
  mr=mr*MULTIPLIER
  arm=arm*MULTIPLIER
  mag=mag*MULTIPLIER
  admin=admin*MULTIPLIER
  admax=admax*MULTIPLIER
  -- Set unit details
  unit:SetBaseMaxHealth(hp)
  unit:SetBaseHealthRegen(hr)
  unit:SetBaseManaRegen(mr)
  unit:SetPhysicalArmorBaseValue(arm)
  unit:SetBaseMagicalResistanceValue(mag)
  unit:SetBaseDamageMin(math.floor(admin))
  unit:SetBaseDamageMax(math.floor(admax))
end

-- Fetch the list of valid units that can be spawned
function TheLastStand:ReturnList(ttype, wave, round)
  local list = {}

 -- WAVE_TYPES = {"Radiant" = 1,"Dire" = 2,"Kobold" = 3,"Troll" = 4,"Golem" = 5,"Satyr" = 6,"Centaur" = 7,"Dragon" = 8,"Zombie" = 9"}

 if(ttype==WAVE_TYPES[T_Radiant])then
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
 if(ttype==WAVE_TYPES[T_Dire])then
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
 if(ttype==WAVE_TYPES[T_Kobold])then
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
 if(ttype==WAVE_TYPES[T_Troll])then
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
 if(ttype==WAVE_TYPES[T_Golem])then
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
 if(ttype==WAVE_TYPES[T_Satyr])then
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
 if(ttype==WAVE_TYPES[T_Centaur])then
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
 if(ttype==WAVE_TYPES[T_Dragon])then
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
 if(ttype==WAVE_TYPES[T_Zombie])then
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

 if(ttype==WAVE_TYPES[T_Radiant] or ttype==WAVE_TYPES[T_Dire])then
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
 if(ttype==WAVE_TYPES[T_Kobold])then
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
 if(ttype==WAVE_TYPES[T_Troll])then
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
 if(ttype==WAVE_TYPES[T_Golem])then
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
 if(ttype==WAVE_TYPES[T_Satyr])then
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
 if(ttype==WAVE_TYPES[T_Centaur])then
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
 if(ttype==WAVE_TYPES[T_Dragon])then
  if(round==1) then
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
 if(ttype==WAVE_TYPES[T_Zombie])then
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

