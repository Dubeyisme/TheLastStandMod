
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

IS_BOSS_WAVE = false

WAVE_TYPES = {
  RADIANT = 1,  
  DIRE = 2,     
  KOBOLD = 3,   
  TROLL = 4,    
  GOLEM = 5,    
  SATYR = 6,    
  CENTAUR = 7,
  DRAGON = 8,
  ZOMBIE = 9 
}

WAVE_TYPES_TEXT_PARSE = {
  "RADIANT",  
  "DIRE",     
  "KOBOLD",   
  "TROLL",    
  "GOLEM",    
  "SATYR",    
  "CENTAUR",
  "DRAGON",
  "ZOMBIE"
}

TOTAL_WAVE_TYPES = #WAVE_TYPES_TEXT_PARSE

SPECIFIC_WAVE_TYPE = {
  RADIANT = {
      {
        {"npc_dota_creep_goodguys_melee","npc_dota_creep_goodguys_ranged"},
        {"npc_dota_creep_goodguys_melee", "npc_dota_creep_goodguys_ranged","npc_dota_goodguys_siege"},
        {"npc_dota_creep_goodguys_melee", "npc_dota_creep_goodguys_ranged","npc_dota_goodguys_siege",  "npc_dota_creep_goodguys_melee_upgraded"},
        {"npc_dota_hero_treant"}
     },{
        {"npc_dota_creep_goodguys_melee_upgraded", "npc_dota_creep_goodguys_ranged_upgraded"},
        {"npc_dota_creep_goodguys_melee_upgraded", "npc_dota_creep_goodguys_ranged_upgraded", "npc_dota_goodguys_siege"},
        {"npc_dota_creep_goodguys_melee_upgraded", "npc_dota_creep_goodguys_ranged_upgraded", "npc_dota_goodguys_siege","npc_dota_creep_goodguys_melee_upgraded_mega"},
        {"npc_dota_hero_lone_druid"}
     }
   }
    ,DIRE = {
      {
        {"npc_dota_creep_badguys_melee","npc_dota_creep_badguys_ranged"},
        {"npc_dota_creep_badguys_melee", "npc_dota_creep_badguys_ranged","npc_dota_badguys_siege"},
        {"npc_dota_creep_badguys_melee", "npc_dota_creep_badguys_ranged","npc_dota_badguys_siege",  "npc_dota_creep_badguys_melee_upgraded"},
        {"npc_dota_hero_dark_willow"}
     },{
        {"npc_dota_creep_badguys_melee_upgraded", "npc_dota_creep_badguys_ranged_upgraded"},
        {"npc_dota_creep_badguys_melee_upgraded", "npc_dota_creep_badguys_ranged_upgraded", "npc_dota_badguys_siege"},
        {"npc_dota_creep_badguys_melee_upgraded", "npc_dota_creep_badguys_ranged_upgraded", "npc_dota_badguys_siege","npc_dota_creep_badguys_melee_upgraded_mega"},
        {"npc_dota_hero_doom_bringer"}
     }
   }
    ,KOBOLD = {
      {
        {"npc_dota_neutral_kobold","npc_dota_neutral_kobold_tunneler"},
        {"npc_dota_neutral_kobold","npc_dota_neutral_kobold_tunneler", "npc_dota_neutral_kobold_taskmaster"},
        {"npc_dota_neutral_kobold","npc_dota_neutral_kobold_tunneler", "npc_dota_neutral_kobold_taskmaster", "npc_dota_neutral_gnoll_assassin"},
        {"npc_dota_hero_meepo"}
     },{
        {"npc_dota_neutral_kobold_tunneler", "npc_dota_neutral_kobold_taskmaster","npc_dota_neutral_gnoll_assassin"},
        {"npc_dota_neutral_kobold_tunneler", "npc_dota_neutral_kobold_taskmaster", "npc_dota_neutral_gnoll_assassin", "npc_dota_neutral_polar_furbolg_champion"},
        {"npc_dota_neutral_kobold_tunneler", "npc_dota_neutral_kobold_taskmaster", "npc_dota_neutral_gnoll_assassin","npc_dota_neutral_polar_furbolg_champion", "npc_dota_neutral_polar_furbolg_ursa_warrior"},
        {"npc_dota_hero_ursa"}
     }
   }
    ,TROLL = {
      {
        {"npc_dota_neutral_dark_troll","npc_dota_neutral_forest_troll_berserker","npc_dota_neutral_forest_troll_high_priest"},
        {"npc_dota_neutral_dark_troll", "npc_dota_neutral_forest_troll_berserker","npc_dota_neutral_forest_troll_high_priest", "npc_dota_neutral_ogre_mauler"},
        {"npc_dota_neutral_dark_troll", "npc_dota_neutral_forest_troll_berserker","npc_dota_neutral_forest_troll_high_priest", "npc_dota_neutral_ogre_mauler", "npc_dota_neutral_ogre_magi"},
        {"npc_dota_hero_huskar"}
     },{
        {"npc_dota_neutral_dark_troll", "npc_dota_neutral_forest_troll_high_priest","npc_dota_neutral_ogre_mauler"},
        {"npc_dota_neutral_dark_troll", "npc_dota_neutral_forest_troll_high_priest", "npc_dota_neutral_ogre_mauler", "npc_dota_neutral_ogre_magi"},
        {"npc_dota_neutral_dark_troll", "npc_dota_neutral_forest_troll_high_priest", "npc_dota_neutral_ogre_mauler","npc_dota_neutral_ogre_magi", "npc_dota_neutral_dark_troll_warlord"},
        {"npc_dota_hero_witch_doctor"}
     }
   }
    ,GOLEM = {
      {
        {"npc_dota_neutral_mud_golem"},
        {"npc_dota_neutral_mud_golem"},
        {"npc_dota_neutral_mud_golem","npc_dota_neutral_rock_golem"},
        {"npc_dota_hero_earth_spirit"}
     },{
        {"npc_dota_neutral_mud_golem"},
        {"npc_dota_neutral_mud_golem","npc_dota_neutral_rock_golem"},
        {"npc_dota_neutral_mud_golem","npc_dota_neutral_rock_golem", "npc_dota_neutral_granite_golem"},
        {"npc_dota_hero_elder_titan"}
     }
   }
    ,SATYR = {
      {
        {"npc_dota_neutral_satyr_trickster"},
        {"npc_dota_neutral_satyr_trickster", "npc_dota_neutral_satyr_soulstealer"},
        {"npc_dota_neutral_satyr_trickster", "npc_dota_neutral_satyr_soulstealer", "npc_dota_neutral_satyr_hellcaller"},
        {"npc_dota_hero_nevermore"}
     },{
        {"npc_dota_neutral_satyr_trickster", "npc_dota_neutral_satyr_soulstealer"},
        {"npc_dota_neutral_satyr_trickster", "npc_dota_neutral_satyr_soulstealer", "npc_dota_neutral_satyr_hellcaller"},
        {"npc_dota_neutral_satyr_trickster", "npc_dota_neutral_satyr_soulstealer", "npc_dota_neutral_satyr_hellcaller", "mark_illusions"},
        {"npc_dota_hero_witch_doctor"}
     }
   }
    ,CENTAUR = {
      {
        {"npc_dota_neutral_centaur_outrunner"},
        {"npc_dota_neutral_centaur_outrunner", "npc_dota_neutral_centaur_khan"},
        {"npc_dota_neutral_centaur_outrunner", "npc_dota_neutral_centaur_khan", "npc_dota_neutral_prowler_acolyte"},
        {"npc_dota_hero_centaur"}
     },{
        {"npc_dota_neutral_centaur_outrunner", "npc_dota_neutral_centaur_khan"},
        {"npc_dota_neutral_centaur_outrunner", "npc_dota_neutral_centaur_khan", "npc_dota_neutral_prowler_acolyte"},
        {"npc_dota_neutral_centaur_outrunner", "npc_dota_neutral_centaur_khan", "npc_dota_neutral_prowler_acolyte","npc_dota_neutral_prowler_shaman"},
        {"npc_dota_hero_abyssal_underlord"}
     }
   }
    ,DRAGON = {
      {
        {"npc_dota_neutral_harpy_scout", "npc_dota_neutral_harpy_storm"},
        {"npc_dota_neutral_harpy_scout", "npc_dota_neutral_harpy_storm", "npc_dota_neutral_jungle_stalker"},
        {"npc_dota_neutral_harpy_scout", "npc_dota_neutral_harpy_storm", "npc_dota_neutral_jungle_stalker", "npc_dota_neutral_elder_jungle_stalker"},
        {"npc_dota_hero_skywrath_mage"}
     },{
        {"npc_dota_neutral_harpy_storm", "npc_dota_neutral_jungle_stalker", "npc_dota_neutral_elder_jungle_stalker"},
        {"npc_dota_neutral_harpy_storm", "npc_dota_neutral_jungle_stalker", "npc_dota_neutral_elder_jungle_stalker", "npc_dota_neutral_black_drake"},
        {"npc_dota_neutral_harpy_storm", "npc_dota_neutral_jungle_stalker", "npc_dota_neutral_elder_jungle_stalker", "npc_dota_neutral_black_drake","npc_dota_neutral_black_dragon"},
        {"npc_dota_hero_jakiro"}
     }
   }
    ,ZOMBIE = {
      {
        {"npc_dota_unit_undying_zombie", "npc_dota_unit_undying_zombie_torso"},
        {"npc_dota_unit_undying_zombie", "npc_dota_unit_undying_zombie_torso", "npc_dota_dark_troll_warlord_skeleton_warrior"},
        {"npc_dota_unit_undying_zombie", "npc_dota_unit_undying_zombie_torso", "npc_dota_dark_troll_warlord_skeleton_warrior", "npc_dota_neutral_fel_beast"},
        {"npc_dota_hero_undying"}
     },{
        {"npc_dota_unit_undying_zombie", "npc_dota_unit_undying_zombie_torso", "npc_dota_dark_troll_warlord_skeleton_warrior"},
        {"npc_dota_unit_undying_zombie", "npc_dota_unit_undying_zombie_torso", "npc_dota_dark_troll_warlord_skeleton_warrior", "npc_dota_neutral_fel_beast"},
        {"npc_dota_unit_undying_zombie", "npc_dota_unit_undying_zombie_torso", "npc_dota_dark_troll_warlord_skeleton_warrior", "npc_dota_neutral_fel_beast","npc_dota_neutral_ghost"},
        {"npc_dota_hero_necrolyte"}
     }
   }
}

SPECIFIC_WAVE_COUNT = {
  RADIANT = {
      {
        {8,2},
        {8,3,1},
        {8,3,1,1},
        {1}
     },{
        {4,2},
        {5,3,1},
        {5,3,1,1},
        {1}
     }
   }
    ,DIRE = {
      {
        {8,2},
        {8,3,1},
        {8,3,1,1},
        {1}
     },{
        {4,2},
        {5,3,1},
        {5,3,1,1},
        {1}
     }
   }
    ,KOBOLD = {
      {
        {7,3},
        {14,4,1},
        {18,5,1,2},
        {1}
     },{
        {5,1,2},
        {10,1,2,1},
        {10,1,2,2,1},
        {1}
     }
   }
    ,TROLL = {
      {
        {3,5,1},
        {3,5,1,1},
        {3,5,1,2,1},
        {1}
     },{
        {5,1,1},
        {5,1,2,1},
        {5,2,2,1,1},
        {1}
     }
   }
    ,GOLEM = {
      {
        {2},
        {4},
        {4,1},
        {1}
     },{
        {4},
        {4,1},
        {4,2,1},
        {1}
     }
   }
    ,SATYR = {
      {
        {6},
        {6,1},
        {6,2,1},
        {1}
     },{
        {6,2},
        {6,2,1},
        {6,2,1,1},
        {1}
     }
   }
    ,CENTAUR = {
      {
        {4},
        {4,1},
        {4,1,1},
        {1}
     },{
        {4,1},
        {4,1,1},
        {4,1,2,1},
        {1}
     }
   }
    ,DRAGON = {
      {
        {2,1},
        {2,1,1},
        {3,2,1,1},
        {1}
     },{
        {2,1,1},
        {2,2,1,1},
        {2,2,1,2,1},
        {1}
     }
   }
    ,ZOMBIE = {
      {
        {8,3},
        {8,3,5},
        {8,3,5,2},
        {1}
     },{
        {8,3,5},
        {8,3,5,2},
        {8,3,5,2,1},
        {1}
     }
   }
}

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
MULTIPLIER_INCREMENT = 0.5 -- Increment the multiplier by this much base
BOSS_MULTIPLIER = 0
WAVE_DEFAULT_BOUNTY = 300 -- This is as much gold as each wave should be worth from level 1
WAVE_BOUNTY_INCREASE = 50 -- This is as much XP it should increase per wave in a round before multipliers
WAVE_BOUNTY = 0 -- This is how much the wave will be worth
WAVE_CONTENTS = {}
WAVE_CONTENTS_ATTACKING = {}
HERO_TARGETS = {}
PLAYERS = {}
PLAYER_COUNT = 0
UNITS_LEFT = 0
FINAL_ENTITY = nil

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

BOSS_CONTROLLER = nil

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

  -- Hero convene point for special events
  HERO_POINT = Vector(-2432, -4160,  256)

  -- Boss Fight Radius - don't leave this radius from the boss point
  BOSS_POINT = Vector(-1344, -2368, 128)
  BOSS_RADIUS = 2112
end
DebugPrint( '[TLS] Done setting up WOODLAND' )

  --FOW_BADGUYS = CreateUnitByName("npc_dummy_unit_vision",FINAL_POINT,false,BOSS_CONTROLLER,BOSS_CONTROLLER,DOTA_TEAM_BADGUYS)
  --FOW_BADGUYS:FindAbilityByName("dummy_unit"):SetLevel(1)

-- Starts the game
function TheLastStand:GameStart()
  TheLastStand:IncrementRound()
  TheLastStand:WaveEnded()
  GAME_HAS_STARTED = true
  math.randomseed(TheLastStand:GetSeed())
  TheLastStand:AddVillainController()
end

-- Adds a computer player
function TheLastStand:AddVillainController()
  -- Close off remaining slots for the good guys
  GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, PLAYER_COUNT)
  -- Open a slot for the badguy
  GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 1)
  Tutorial:AddBot("","","Overseer's Pet",false)
  DebugPrint(PLAYER_COUNT)
  BOSS_CONTROLLER = PlayerResource:GetPlayer(PLAYER_COUNT)
  local event_data = {
  userid=PlayerResource:GetSteamID(PLAYER_COUNT),
  oldname=PlayerResource:GetPlayerName(PLAYER_COUNT),
  newname="Overseer"}
  DebugPrintTable(event_data)
  --SendToServerConsole("")
  CustomGameEventManager:Send_ServerToAllClients("player_changename",event_data)
end

-- Fetches the Random seed
function TheLastStand:GetSeed()
  local s=GetSystemTime()
  local p="(%d+):(%d+):(%d+)"
  local hour,min,sec=s:match(p)
  local int = tonumber(hour..min..sec)
  return int
end

-- End the game
function TheLastStand:GameEnd()

end

-- If not everyone has picked their heroes, pick heroes for them
function TheLastStand:ForcePickHeroes()
  if(#PLAYERS ~= #HERO_TARGETS) then
    for i=1,#PLAYERS do
      if(PlayerResource:HasSelectedHero(PLAYERS[i])==false)then
        PlayerResource:GetPlayer(PLAYERS[i]):MakeRandomHeroSelection()
      end
    end
  end
end

-- Game Lost
function TheLastStand:GameLost()
  local boss = BossAI:GetCurrentBoss()
  if(boss~=nil)then
    -- Boss round, boss won. Make it announce it's victory
    SoundController:Villain_Victory(boss)
  end
  GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
  TheLastStand:GameEnd()
end

-- Game Won
function TheLastStand:GameWon()
  GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
  TheLastStand:GameEnd()
end

-- Getters
function TheLastStand:IsBossWave() return IS_BOSS_WAVE end
function TheLastStand:GetSpawnPoints() return SPAWN_POINT end
function TheLastStand:GetCurrentWave() return CURRENT_WAVE end
function TheLastStand:GetCurrentRound() return CURRENT_ROUND end
function TheLastStand:GetCurrentLevel() return CURRENT_LEVEL end
function TheLastStand:GetWaveContents() return WAVE_CONTENTS end
function TheLastStand:GetWaveContentsAttacking() return WAVE_CONTENTS_ATTACKING end
function TheLastStand:GetMultiplier() return MULTIPLIER end
function TheLastStand:GetPlayerCount() return PLAYER_COUNT end
function TheLastStand:GetHeroTargets() return HERO_TARGETS end
function TheLastStand:GetFilterHeroTargets(alive,invis,invuln,outofgame) --Filter out heroes
  --DebugPrintTable("HERO_TARGETS")
  local targets = {}
  local i = 0
  local addtolist = false
  for i=1,#HERO_TARGETS do
    addtolist = true
    if(alive)then addtolist=HERO_TARGETS[i]:IsAlive() end -- Filter out dead heroes?
    if(invis)then if(HERO_TARGETS[i]:IsInvisible())then addtolist=false end end -- Filter our invisible heroes?
    if(invuln)then if(HERO_TARGETS[i]:IsInvulnerable())then addtolist=false end end -- Filter out invulnerable heroes?
    if(outofgame)then if(HERO_TARGETS[i]:IsOutOfGame())then addtolist=false end end -- Filter out missing heroes?
    if(addtolist)then table.insert(targets,HERO_TARGETS[i]) end
  end
  --DebugPrintTable("RETURNING HERO_TARGETS")
  return targets
end
function TheLastStand:GetPlayerTargets() return PLAYERS end
function TheLastStand:GetUnitsLeft() return UNITS_LEFT end
function TheLastStand:GetGameHasStarded() return GAME_HAS_STARTED end
function TheLastStand:GetWaveTypes() return WAVE_TYPES end
function TheLastStand:GetTotalWaveTypes() return TOTAL_WAVE_TYPES end
function TheLastStand:GetFinalPoint() return FINAL_POINT end
function TheLastStand:GetBossPoint() return BOSS_POINT end
function TheLastStand:GetBossRadius() return BOSS_RADIUS end

-- Setters
function TheLastStand:SetIsBossWave(bool) IS_BOSS_WAVE=bool end
function TheLastStand:SetPlayerCount(count) DebugPrint("[Player Count] Player count set") PLAYER_COUNT = count end
function TheLastStand:AddHeroTargets(hero) DebugPrint("[Hero Targets] Hero Added") table.insert(HERO_TARGETS,hero) end
function TheLastStand:AddPlayerTargets(playerID) DebugPrint("[Player Targets] Player "..tostring(playerID).." Added") table.insert(PLAYERS,playerID) end
function TheLastStand:SetWaveContentsAttacking(content, i) WAVE_CONTENTS_ATTACKING[i] = content end


-- This is where we catch and prep for everything after each wave
function TheLastStand:WaveEnded()
  -- Announce the wave has been cleared
  if(GAME_HAS_STARTED) then
    -- Here we put things we do every round
    Notifications:TopToTeam(DOTA_TEAM_GOODGUYS,{text="Wave Cleared", duration=WAVE_OUTRO_DURATION, style=STYLE_WAVE_OUTRO})
    -- PLAY A SOUND OUTSIDE SOUND CONTROLLER
    EmitAnnouncerSoundForTeam("ui.npe_objective_complete", DOTA_TEAM_GOODGUYS)

    -- Pay out the heroes
    TheLastStand:GiftGoldAndXP()
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
  CURRENT_WAVE_TYPE = WAVE_TYPES.RADIANT
  local text_array = TheLastStand:AnnounceWaveText(CURRENT_WAVE, CURRENT_ROUND, CURRENT_LEVEL, CURRENT_WAVE_TYPE) -- [1] is the wave number, [2] is the type
  Notifications:TopToTeam(DOTA_TEAM_GOODGUYS,{text=text_array[1], duration=WAVE_INTRO_DURATION, style=STYLE_WAVE_NUM_INTRO})
  Notifications:TopToTeam(DOTA_TEAM_GOODGUYS,{text=text_array[2], duration=WAVE_INTRO_DURATION, style=STYLE_WAVE_TYPE_INTRO})
    -- PLAY A SOUND OUTSIDE SOUND CONTROLLER
  EmitAnnouncerSoundForTeam("ui.npe_objective_given", DOTA_TEAM_GOODGUYS)
  -- Launch Hero Speaker
  SoundController:Hero_WaveStart(HERO_TARGETS)
  local UnitList = TheLastStand:ReturnList(CURRENT_WAVE_TYPE, CURRENT_WAVE, CURRENT_ROUND) -- List of valid types for wave 2
  local UnitCount = TheLastStand:ReturnUnitCount(CURRENT_WAVE_TYPE, CURRENT_WAVE, CURRENT_ROUND) -- List of the amount per type for wave 2
  TheLastStand:CalculateWaveBounty(UnitCount,(WAVE_DEFAULT_BOUNTY+WAVE_BOUNTY_INCREASE*CURRENT_WAVE))
  -- Generate wave
  if(IS_BOSS_WAVE==false) then
    -- Generate a non-boss wave for waves 1, 2, and 3
    TheLastStand:CreateWave(UnitList, UnitCount)
  else
    -- Generate a boss wave
    TheLastStand:CreateBoss(UnitList, UnitCount)
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
  DebugPrint("Increment Round")
  CURRENT_ROUND = NEXT_ROUND
  MULTIPLIER=MULTIPLIER+MULTIPLIER_INCREMENT
  NEXT_ROUND=NEXT_ROUND+1
  -- If they survive through all available rounds, loop back around to 1
  if(NEXT_ROUND==3)then
    NEXT_ROUND = 1
  end
  -- We just incremented to Round 1, increment level
  if(CURRENT_ROUND==1)then
    CURRENT_LEVEL=CURRENT_LEVEL+1 -- Mark how many times they've survived through the set - this is a multiplier for score
    MULTIPLIER=MULTIPLIER+MULTIPLIER_INCREMENT+MULTIPLIER_INCREMENT
  end
  -- Sort out the waves to complete
  WAVES_TO_COMPLETE = {}
 -- Set up wave types
  local g, h, i = 0
  local random_array = {}
  -- Fill Waves_To_Complete twice with each wave type and a random array
  --DebugPrint("Create Wave Types: "..tostring(TOTAL_WAVE_TYPES))
  for i=1, TOTAL_WAVE_TYPES do
    --DebugPrint(i)
    table.insert(WAVES_TO_COMPLETE, i)
    table.insert(random_array,RandomInt(1,100))
  end
  -- Randomise the order of waves to be completed
  --DebugPrint("Sort Wave Types")
  local temp = 0
  for g = 1, TOTAL_WAVE_TYPES-1 do
    for h = 2, TOTAL_WAVE_TYPES do
      if(random_array[g]<random_array[h])then
        temp = random_array[g]
        random_array[g] = random_array[h]
        random_array[h] = temp
        temp = WAVES_TO_COMPLETE[g]
        --DebugPrint(WAVES_TO_COMPLETE[g])
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
  MULTIPLIER=MULTIPLIER+MULTIPLIER_INCREMENT/5
  NEXT_WAVE=NEXT_WAVE+1
  -- Control when the next boss wave appears
  if(CURRENT_WAVE==4)then
    IS_BOSS_WAVE=true
  else
    IS_BOSS_WAVE=false -- Double check variable, making certain it is false
  end
  if(NEXT_WAVE==5)then -- Should be 5 for bosses, skipping atm
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
  if(IS_BOSS_WAVE)then
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
    if(ttype == WAVE_TYPES.RADIANT) then return "Radiant" end
    if(ttype == WAVE_TYPES.DIRE) then return "Dire" end
    if(ttype == WAVE_TYPES.KOBOLD) then return "Kobold" end
    if(ttype == WAVE_TYPES.TROLL) then return "Troll" end
    if(ttype == WAVE_TYPES.GOLEM) then return "Golem" end
    if(ttype == WAVE_TYPES.SATYR) then return "Satyr" end
    if(ttype == WAVE_TYPES.CENTAUR) then return "Centaur" end
    if(ttype == WAVE_TYPES.DRAGON) then return "Dragon" end
    if(ttype == WAVE_TYPES.ZOMBIE) then return "Zombie" end
  elseif(round==2) then
    if(ttype == WAVE_TYPES.RADIANT) then return "Radiant" end
    if(ttype == WAVE_TYPES.DIRE) then return "Dire" end
    if(ttype == WAVE_TYPES.KOBOLD) then return "Kobold" end
    if(ttype == WAVE_TYPES.TROLL) then return "Troll" end
    if(ttype == WAVE_TYPES.GOLEM) then return "Golem" end
    if(ttype == WAVE_TYPES.SATYR) then return "Satyr" end
    if(ttype == WAVE_TYPES.CENTAUR) then return "Centaur" end
    if(ttype == WAVE_TYPES.DRAGON) then return "Dragon" end
    if(ttype == WAVE_TYPES.ZOMBIE) then return "Zombie" end
  end    
  return ""
end

-- For announcing the boss battles
function TheLastStand:BossIntro(ttype,round)
  if(round==1) then
    if(ttype == WAVE_TYPES.RADIANT) then return "Treant Protector" end
    if(ttype == WAVE_TYPES.DIRE) then return "Dark Willow" end
    if(ttype == WAVE_TYPES.KOBOLD) then return "Meepo" end
    if(ttype == WAVE_TYPES.TROLL) then return "Huskar" end
    if(ttype == WAVE_TYPES.GOLEM) then return "Earth Spirit" end
    if(ttype == WAVE_TYPES.SATYR) then return "Shadow Fiend" end
    if(ttype == WAVE_TYPES.CENTAUR) then return "Centaur" end
    if(ttype == WAVE_TYPES.DRAGON) then return "Skywrath" end
    if(ttype == WAVE_TYPES.ZOMBIE) then return "Undying" end
  elseif(round==2) then
    if(ttype == WAVE_TYPES.RADIANT) then return "Lone Druid" end
    if(ttype == WAVE_TYPES.DIRE) then return "Doom" end
    if(ttype == WAVE_TYPES.KOBOLD) then return "Ursa" end
    if(ttype == WAVE_TYPES.TROLL) then return "Witch Doctor" end
    if(ttype == WAVE_TYPES.GOLEM) then return "Elder Titan" end
    if(ttype == WAVE_TYPES.SATYR) then return "Shadow Demon" end
    if(ttype == WAVE_TYPES.CENTAUR) then return "Underlord" end
    if(ttype == WAVE_TYPES.DRAGON) then return "Jakiro" end
    if(ttype == WAVE_TYPES.ZOMBIE) then return "Necrophos" end
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
  IS_BOSS_WAVE = false
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
          unit = TheLastStand:CreateWaveUnitAtPlace(UnitTypesListed[i], SPAWN_POINT[point[h]], BOSS_CONTROLLER, DOTA_TEAM_BADGUYS, false, true)
        else
          -- Create illusion and modify it to match a hero
          local target = HERO_TARGETS[h]
          local ability_slot
          unit = CreateUnitByName(target:GetName(), SPAWN_POINT[point[h]], true, BOSS_CONTROLLER, BOSS_CONTROLLER, DOTA_TEAM_BADGUYS)
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
      --DebugPrint("[TLS] Unit removed from wave - Left:"..tostring(UNITS_LEFT))
      if(UNITS_LEFT==0) then
        -- The round must be over
      --DebugPrint("[TLS] Wave ended")
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

-- Creates a boss unit for the wave and initiates their AI
function TheLastStand:CreateBoss(UnitTypesListed, UnitCountsListed)
  local point = ATTACK_POINT[RandomInt(1,SPAWN_COUNT)]
  IS_BOSS_WAVE = true-- Just in case we missed setting this to true (probably created via cheats)
  -- Create boss
  local unit = CreateUnitByName(UnitTypesListed[1], point, true, BOSS_CONTROLLER, BOSS_CONTROLLER, DOTA_TEAM_BADGUYS)
  -- Boss announces start
  SoundController:Villain_BattleStart(unit)
  -- Boss added to wave contents
  UNITS_LEFT=UNITS_LEFT+1
  table.insert(WAVE_CONTENTS,unit)
  table.insert(WAVE_CONTENTS_ATTACKING,false)
  -- Upgrade boss
   TheLastStand:UpgradeBoss(unit)
  -- Start the AI
  BossAI:InitBossAI(unit)
end 

-- Gift the heroes gold and xp
function TheLastStand:GiftGoldAndXP()
  local i=0
  local xp = (((WAVE_DEFAULT_BOUNTY+WAVE_BOUNTY_INCREASE*CURRENT_WAVE)*1.15))*MULTIPLIER
  local bounty = ((WAVE_DEFAULT_BOUNTY+WAVE_BOUNTY_INCREASE*CURRENT_WAVE))*MULTIPLIER
  for i=1,#HERO_TARGETS do
    HERO_TARGETS[i]:AddExperience(xp, DOTA_ModifyXP_Unspecified, false, true)
    PlayerResource:ModifyGold(PLAYERS[i],bounty,true,DOTA_ModifyGold_Unspecified)
  end
end

-- Upgrade a single creep based on the multiplier and fixes their abilities
function TheLastStand:UpgradeCreep(unit, give_bounty)
  --DebugPrint("[TLS] Upgrading creep")
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
    -- Removed the final impartation in case I wish to add it in again
    --bxp = (WAVE_BOUNTY*1.45)/2  -- This controls gold and xp per wave
    --bg = (WAVE_BOUNTY)/2 -- This controls gold and xp per wave
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
function TheLastStand:UpgradeBoss(boss)
  -- Set the new boss multiplier
  local hero_target_num = #HERO_TARGETS/5
  BOSS_MULTIPLIER = MULTIPLIER+hero_target_num
  -- Get the values
  local basehp = boss:GetBaseMaxHealth()
  local modelscale = boss:GetModelScale()
  local acquisitionrange = 1800
    local str = boss:GetBaseStrength()
  local agi = boss:GetBaseAgility()
  local int = boss:GetBaseIntellect()
  -- Affect the values
  modelscale = modelscale+BOSS_MULTIPLIER/10
  DebugPrint("MULTIPLIER")
  DebugPrint(MULTIPLIER)
  DebugPrint("BOSS_MULTIPLIER")
  DebugPrint(BOSS_MULTIPLIER)
  DebugPrint("CURRENT_LEVEL")
  DebugPrint(CURRENT_LEVEL)
  int=int*BOSS_MULTIPLIER*2*hero_target_num
  agi=agi*BOSS_MULTIPLIER*2*hero_target_num
  str=str*BOSS_MULTIPLIER*5*(hero_target_num+1)
  basehp=(basehp*BOSS_MULTIPLIER*2*hero_target_num)+str*20
  DebugPrint(basehp)
  -- Set the values
  boss:SetBaseStrength(str)
  boss:SetBaseAgility(agi)
  boss:SetBaseIntellect(int)
  -- Recalculate health, armour, etc based on gains
  boss:CalculateStatBonus()
  boss:SetModelScale(modelscale)
  boss:SetAcquisitionRange(acquisitionrange)
  boss:SetDeathXP(0)
  boss:SetMaximumGoldBounty(0)
  boss:SetMinimumGoldBounty(0)
  --boss:SetBaseMaxHealth(basehp)
  --boss:SetHealth(basehp)
end

function TheLastStand:ParseWaveVar(var, wavetype)
  -- Villains
  if(wavetype == WAVE_TYPES.RADIANT) then return var.RADIANT end
  if(wavetype == WAVE_TYPES.DIRE) then return var.DIRE end
  if(wavetype == WAVE_TYPES.KOBOLD) then return var.KOBOLD end
  if(wavetype == WAVE_TYPES.TROLL) then return var.TROLL end
  if(wavetype == WAVE_TYPES.GOLEM) then return var.GOLEM end
  if(wavetype == WAVE_TYPES.SATYR) then return var.SATYR end
  if(wavetype == WAVE_TYPES.CENTAUR) then return var.CENTAUR end
  if(wavetype == WAVE_TYPES.DRAGON) then return var.DRAGON end
  if(wavetype == WAVE_TYPES.ZOMBIE) then return var.ZOMBIE end
end


-- Fetch the list of valid units that can be spawned
function TheLastStand:ReturnList(ttype, wave, round)
  local list = TheLastStand:ParseWaveVar(SPECIFIC_WAVE_TYPE, ttype)[round][wave]
  return list
end

-- Fetch the amount of units that can be spawned
function TheLastStand:ReturnUnitCount(ttype, wave, round)
  local list =  TheLastStand:ParseWaveVar(SPECIFIC_WAVE_COUNT, ttype)[round][wave]
  return list
end

-- One of the heroes announces the game has begun
function TheLastStand:HeroCallStartBattle()

end

DebugPrint('[---------------------------------------------------------------------] the last stand!\n\n')