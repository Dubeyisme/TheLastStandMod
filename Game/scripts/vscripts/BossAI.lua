-- This contains a number of useful AI fetchers, sorters, and modes for the specialised AI packages to use

BOSSAI_CURRENT_TARGET = nil
BOSSAI_REACTION_TARGET = nil
BOSSAI_CURRENT_BOSS = nil
BOSSAI_CURENT_MODE = 0
BOSSAI_PLAYER_DAMAGE_TRACKER = {}
BOSSAI_CURRENT_AI_TICK_TIMER = 2
BOSSAI_DATA = {}
BOSSAI_LEVEL = 1
BOSSAI_FLEE_POINT = nil
BOSSAI_SEARCH_SUCCESS = false

BOSSAI_SWITCH = { -- This is used to control the parser
	MODE = 1,
	ABILITY = 2,
	SPECIAL = 3,
	SETUP = 4,
	CLEANUP = 5,
	REACTION = 6
}

BOSSAI_AI_STATE = {
	NOTHING = 0, -- This state has yet to be initialised
	ATTACKING = 1, -- When the boss has a set target to attack
	CASTING = 2, -- When the boss has decided to use an ability
	FLEEING = 3, -- When the boss has decided to flee from a strong attacker
	HUNTING = 4, -- When the boss does not like any of the current targets and requires a new one
	SPECIAL = 5 -- When the boss is doing something being controlled by a specific AI effect.
}

BOSSAI_CURRENT_PERSONALITY = nil

-- This controls how the boss will prefer to select targets
BOSSAI_PERSONALITY = {
	VINDICTIVE = 1, -- Boss will want to go after the target with the lowest health
	HONOURABLE = 2, -- Boss will want to go after the target with the highest health, and resistance
	OPPORTUNIST = 3, -- Boss will want to go after the closest target
	STUBBORN = 4, -- Boss will want to go after his current target
	GREEDY = 5, -- Only meepo uses this. Goes after hero with most gold.
	RANDOM = 6 -- Boss will randomly pick a target to boost aggro for, but only when hunting
}

BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.NOTHING

-- Create an instance of this class
if BossAI == nil then
    DebugPrint( '[TLS] creating Boss AI' )
    _G.BossAI = class({})
end

-----------------------------------------------------------------------------------------
-- Special AI data for each individual boss
-----------------------------------------------------------------------------------------
	require('special_boss_ai/TreantProtector')
	-- require('special_boss_ai/LoneDruid')
	-- require('special_boss_ai/DarkWillow')
	-- require('special_boss_ai/Doom')
	-- require('special_boss_ai/Meepo')
	-- require('special_boss_ai/Ursa')
	-- require('special_boss_ai/Huskar')
	-- require('special_boss_ai/WitchDoctor')
	-- require('special_boss_ai/EarthSpirit')
	-- require('special_boss_ai/ElderTitan')
	-- require('special_boss_ai/Centaur')
	-- require('special_boss_ai/Underlord')
	-- require('special_boss_ai/ShadowFiend')
	-- require('special_boss_ai/ShadowDemon')
	-- require('special_boss_ai/Skywrath')
	-- require('special_boss_ai/Jakiro')
	-- require('special_boss_ai/Undying')
	-- require('special_boss_ai/Necrophos')


-- Boss strings
	-- if(unit:GetName() == "npc_dota_hero_treant") then return var.TRN end
	-- if(unit:GetName() == "npc_dota_hero_lone_druid") then return var.LON end
	-- if(unit:GetName() == "npc_dota_hero_dark_willow") then return var.DKW end
	-- if(unit:GetName() == "npc_dota_hero_doom_bringer") then return var.DOM end
	--if(unit:GetName() == "npc_dota_hero_earth_spirit") then return var.EAS end
	-- if(unit:GetName() == "npc_dota_hero_elder_titan") then return var.ELT end
	-- if(unit:GetName() == "npc_dota_hero_nevermore") then return var.NEV end
	-- if(unit:GetName() == "npc_dota_hero_shadow_demon") then return var.SHD end
	-- if(unit:GetName() == "npc_dota_hero_huskar") then return var.HUS end
	--  if(unit:GetName() == "npc_dota_hero_witch_doctor") then return var.WDO end
	--  if(unit:GetName() == "npc_dota_hero_meepo") then return var.MEE end
	--  if(unit:GetName() == "npc_dota_hero_ursa") then return var.URS end
	-- if(unit:GetName() == "npc_dota_hero_centaur") then return var.CEN end
	-- if(unit:GetName() == "npc_dota_hero_abyssal_underlord") then return var.ABY end
	--  if(unit:GetName() == "npc_dota_hero_skywrath_mage") then return var.SKY end
	--  if(unit:GetName() == "npc_dota_hero_jakiro") then return var.JAK end
	--  if(unit:GetName() == "npc_dota_hero_undying") then return var.UND end
	-- if(unit:GetName() == "npc_dota_hero_necrolyte") then return var.NEC end



-- This function calls individual boss events based on what the switch is
function BossAI:BossParser(switch)
	local name = BOSSAI_CURRENT_BOSS:GetName()
	-- This switch handles the mode segment
	if(switch == BOSSAI_SWITCH.MODE) then
		if(name == "npc_dota_hero_treant") then BossAI:TreantModeChange() end
	end
	-- This switch handles the ability segment
	if(switch == BOSSAI_SWITCH.ABILITY) then
		if(name == "npc_dota_hero_treant") then BossAI:TreantAbilityLogic() end
	end
	-- This switch handles the special/unique segment
	if(switch == BOSSAI_SWITCH.SPECIAL) then
	end
	-- This switch handles the initialisation of the boss
	if(switch == BOSSAI_SWITCH.SETUP) then
		if(name == "npc_dota_hero_treant") then BossAI:TreantInit() end
	end
	-- This switch handles the cleanup of the boss
	if(switch == BOSSAI_SWITCH.CLEANUP) then
		if(name == "npc_dota_hero_treant") then BossAI:TreantCleanup() end
	end
	-- This switch handles the reaction to a hero using an ability
	if(switch == BOSSAI_SWITCH.REACTION) then
		if(name == "npc_dota_hero_treant") then BossAI:TreantHeroCastAbility() end
	end
end


-----------------------------------------------------------------------------------------
-- Initialisation of the AI
-----------------------------------------------------------------------------------------

function BossAI:GetCurrentBoss() return BOSSAI_CURRENT_BOSS end


-- Initialise the Boss' AI
function BossAI:InitBossAI(boss)
	-- Clear boss data
	BOSSAI_DATA = {
		EFFECT={}
	}
	-- Set new Boss
	BOSSAI_CURRENT_BOSS = boss
	-- Choose boss event
	BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.NOTHING
	-- Choose Boss Level
	BOSSAI_LEVEL = TheLastStand:GetPlayerCount()
	-- Setup boss
	BossAI:BossParser(BOSSAI_SWITCH.SETUP)
	-- Init current target
	BOSSAI_CURRENT_TARGET = nil
	-- Init damage tracker
	BossAI:InitDamageTracker()
	-- Init current mode
	BOSSAI_CURENT_MODE = 1
	-- Start running AI
	BossAI:EveryTick()
end

-- Reinitialises the damage tracker, setting it up for the next round
function BossAI:InitDamageTracker()
	local playerlist = TheLastStand:GetPlayerTargets()
	BOSSAI_PLAYER_DAMAGE_TRACKER = {}
	local i = 0
	for i=1,#playerlist do
		table.insert(BOSSAI_PLAYER_DAMAGE_TRACKER,0)
	end
	for i=1,#playerlist do
		BOSSAI_PLAYER_DAMAGE_TRACKER[playerlist[i]] = 0
	end
end

-----------------------------------------------------------------------------------------
-- Boss Every Tick
-----------------------------------------------------------------------------------------

function BossAI:EveryTick()
	local boss_alive = false
	local boss = BOSSAI_CURRENT_BOSS
	-- Check if the boss is alive
	if(boss:GetHealth()>0.5) then
		-- Boss is alive
		boss_alive = true
		-- Work out what to do with the state if we've stopped, finished casting, or are fleeing
		if(BOSSAI_CURRENT_STATE==BOSSAI_AI_STATE.FLEEING)then
			-- Do we have a flee point?
			if(BOSSAI_FLEE_POINT==nil)then
				-- Pick a flee point
				local fleepointlist1 = TheLastStand:GetSpawnPoints()
				BOSSAI_FLEE_POINT = fleepointlist1[RandomInt(1,#fleepointlist1)]
			end
			--Check if health is over .25, if it is then stop fleeing
			if(boss:GetHealth()/boss:GetMaxHealth()>0.25) then
				BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.NOTHING
				BOSSAI_FLEE_POINT = nil -- Remove the last used flee point
				ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_STOP, Queue = false})
			end
		end
		if(BOSSAI_CURRENT_STATE==BOSSAI_AI_STATE.CASTING)then
			--We're casting, are we still doing it?
			if(boss:IsChanneling()==false)then
				-- We've stopped casting, mark that we're doing nothing
				BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.NOTHING
				ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_STOP, Queue = false})
			end
		end
		-- Are we doing nothing? Then go hunting
		if(BOSSAI_CURRENT_STATE==BOSSAI_AI_STATE.NOTHING)then
			BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.HUNTING
		end
	else
		boss_alive = false
		-- Boss has died, end the round has therefore ended
	end
	-- Check if the wave has ended
	if(boss_alive) then
		-- Check which mode we are in
		if(BOSSAI_CURENT_MODE==1) then
			-- Check if HP has dipped below 75%
			if(boss:GetHealth()/boss:GetMaxHealth()<0.75) then
				BOSSAI_CURENT_MODE = 2
				--Announce that we've changed mode
				SoundController:Villain_Hurt(boss, BOSSAI_CURENT_MODE)
				-- Check if we need to do something for the switch
				BossAI:BossParser(BOSSAI_SWITCH.MODE)
			end
		else 
			if (BOSSAI_CURENT_MODE==2) then
				-- Check if HP has dipped below 25%
				if(boss:GetHealth()/boss:GetMaxHealth()<0.25) then
					BOSSAI_CURENT_MODE = 3
					--Announce that we've changed mode
					SoundController:Villain_Hurt(boss, BOSSAI_CURENT_MODE)
					-- Check if we need to do something for the switch
					BossAI:BossParser(BOSSAI_SWITCH.MODE)
				end
			else 
				if(BOSSAI_CURENT_MODE == 3) then
					-- We are in mode 3, no change.
				end
			end
		end
		-- Adjust the aggro to stop caring about those not attacking
		BossAI:AdjustAggro()
		-- Choose target
		BossAI:ChooseNewTarget()
		-- Check ability logic if not silenced
		if(boss:IsSilenced()==false)and(boss:IsStunned()==false)then
			BossAI:BossParser(BOSSAI_SWITCH.ABILITY)
		end
		-- Check special logic
		if(BOSSAI_CURRENT_STATE==BOSSAI_AI_STATE.SPECIAL)then
			BossAI:BossParser(BOSSAI_SWITCH.SPECIAL)
		end
		-- Check if we're still hunting
		if(BOSSAI_CURRENT_STATE==BOSSAI_AI_STATE.HUNTING)then
  			ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = TheLastStand:GetFinalPoint(), Queue = false})
		end
		-- Check if we're attacking
		if(BOSSAI_CURRENT_STATE==BOSSAI_AI_STATE.ATTACKING)then
			if(BOSSAI_CURRENT_TARGET~=nil)then -- Order a target attack
				ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET, TargetIndex  = BOSSAI_CURRENT_TARGET:entindex(), Queue = false})
			else -- Order a generic attack
  				ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = TheLastStand:GetFinalPoint(), Queue = false})
			end
		end
		-- Check if we're fleeing
		if(BOSSAI_CURRENT_STATE==BOSSAI_AI_STATE.FLEEING)then
			-- Bravely run away towards our flee point
			if(BossAI:TargetDistance(BOSSAI_FLEE_POINT, boss:GetOrigin())<300)then -- Are we near our flee point?
				-- Pick a new flee point
				local fleepointlist2 = TheLastStand:GetSpawnPoints()
				BOSSAI_FLEE_POINT = fleepointlist2[RandomInt(1,#fleepointlist2)]
  			end
  			-- Get closer!
  			ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION, Position = BOSSAI_FLEE_POINT, Queue = false})
		end
		-- Recall this function next tick
		Timers:CreateTimer({
	        endTime = 1,
	      callback = function()
	        BossAI:EveryTick()
	      end
	    })	
	else
		-- Note that the boss wave has ended
		TheLastStand:SetIsBossWave(false)
		-- Wait a moment for talking to happen, then end the round
		Timers:CreateTimer({
	        endTime = 3,
	      callback = function()
			-- Cleanup boss
			BossAI:BossParser(BOSSAI_SWITCH.CLEANUP)
			-- Remove the dead boss
			UTIL_Remove(boss)
			-- Reset current boss to nothing
			BOSSAI_CURRENT_BOSS = nil
	      end
	    })	
	end
end


-----------------------------------------------------------------------------------------
-- Boss Aggro Functions
-----------------------------------------------------------------------------------------

-- Boss took damage
function BossAI:BossHurt(boss, attacker, damage)
	-- Increment the damage tracker
	BOSSAI_PLAYER_DAMAGE_TRACKER[attacker:GetOwner():GetPlayerID()] = BOSSAI_PLAYER_DAMAGE_TRACKER[attacker:GetOwner():GetPlayerID()] + damage
	--DebugPrint(BOSSAI_PLAYER_DAMAGE_TRACKER[attacker:GetOwner():GetPlayerID()])

	-- Is there something else we need to do in reaction to taking damage?
end

-- Adjust current aggro every AI tick
function BossAI:AdjustAggro()
	-- Debugging variables
	local s = "Current Aggro "
	local s2 = "Current Aggro "
	local debughero = TheLastStand:GetHeroTargets()
	-- Increase or Decrease aggro based on personality
	local herotargets = TheLastStand:GetFilterHeroTargets(true,true,true,true) -- Filter out alive,invis,invuln,outofgame
	local boss = BOSSAI_CURRENT_BOSS
	local closest_hero = BossAI:NearestTarget(boss:GetOrigin(),herotargets)
	local furthest_hero = BossAI:FurthestTarget(boss:GetOrigin(),herotargets)
	local closest_player,furthest_player = nil
	local target = nil
	local i = 0
	local selectionfilter = 0
	local selectednumber = 0
	BOSSAI_SEARCH_SUCCESS = true
	-- Increment aggro for the current target to reduce likely hood of switching targets
	if(BOSSAI_CURRENT_TARGET~=nil)then
		--DebugPrint(BOSSAI_CURRENT_TARGET:GetName())
		BOSSAI_PLAYER_DAMAGE_TRACKER[BOSSAI_CURRENT_TARGET:GetOwner():GetPlayerID()] = BOSSAI_PLAYER_DAMAGE_TRACKER[BOSSAI_CURRENT_TARGET:GetOwner():GetPlayerID()] + 5
	end
	-- Try and fetch the closest hero and player
	if(closest_hero~=nil)then 
		if(closest_hero:GetOwner()~=nil) then
			closest_player = closest_hero:GetOwner():GetPlayerID() 
		end
	end
	if(furthest_hero~=nil)then 
		if(furthest_hero:GetOwner()~=nil) then
			furthest_player = furthest_hero:GetOwner():GetPlayerID() 
		end
	end
	-- If we got them, proceed
	if(closest_player~=nil)and(furthest_player~=nil)then
		-- Increase aggro for the closest target
		BOSSAI_PLAYER_DAMAGE_TRACKER[closest_player] = BOSSAI_PLAYER_DAMAGE_TRACKER[closest_player]+5
		-- Decrease aggro for the furthest target
		BOSSAI_PLAYER_DAMAGE_TRACKER[furthest_player] = BOSSAI_PLAYER_DAMAGE_TRACKER[furthest_player]-5
		
		-- Personality factors
		if(BOSSAI_CURRENT_PERSONALITY==BOSSAI_PERSONALITY.VINDICTIVE)then -- Increase aggro for lowest health
			local targets_health = BossAI:GetTargetsHPPercent(herotargets)
			selectionfilter = 1000
			selectednumber = 0
			-- Work out which i is the one we want
			for i=1,#targets_health do
				if(herotargets[i]:IsInvisible()==false)and(herotargets[i]:IsInvulnerable()==false)and(herotargets[i]:IsAlive()) then -- Make sure we can even see or attack this target
					if(targets_health[i]<selectionfilter)and(herotargets[i]:IsAlive())then -- This runs asynchronosly, make sure hero hasn't died between frames.
						selectionfilter = targets_health[i]
						selectednumber = i
					end
				end
			end
			BOSSAI_PLAYER_DAMAGE_TRACKER[selectednumber] = BOSSAI_PLAYER_DAMAGE_TRACKER[selectednumber]+5
		end
		if(BOSSAI_CURRENT_PERSONALITY==BOSSAI_PERSONALITY.HONOURABLE)then -- Increase aggro for most resistance
			local targets_armour = BossAI:GetTargetsArmor(herotargets)
			local targets_magic = BossAI:GetTargetsMagicResist(herotargets)
			selectionfilter = 0
			selectednumber = 0
			-- Merge the values
			for i=1,#targets_armour do
				targets_armour[i] = targets_armour[i]+targets_magic[i]
			end
			-- Work out which i is the one we want
			for i=1,#targets_armour do
				if(herotargets[i]:IsInvisible()==false)and(herotargets[i]:IsInvulnerable()==false)and(herotargets[i]:IsAlive()) then -- Make sure we can even see or attack this target
					if(targets_armour[i]>selectionfilter)and(herotargets[i]:IsAlive())then -- This runs asynchronosly, make sure hero hasn't died between frames.
						selectionfilter = targets_armour[i]
						selectednumber = i
					end
				end
			end
			BOSSAI_PLAYER_DAMAGE_TRACKER[selectednumber] = BOSSAI_PLAYER_DAMAGE_TRACKER[selectednumber]+5
		end
		if(BOSSAI_CURRENT_PERSONALITY==BOSSAI_PERSONALITY.OPPORTUNIST)then -- Increase aggro for the closest target
			BOSSAI_PLAYER_DAMAGE_TRACKER[closest_player] = BOSSAI_PLAYER_DAMAGE_TRACKER[closest_player]+5
		end
		if(BOSSAI_CURRENT_PERSONALITY==BOSSAI_PERSONALITY.STUBBORN)then -- Increase aggro for current target if we have one
			if(BOSSAI_CURRENT_TARGET~=nil)then
				BOSSAI_PLAYER_DAMAGE_TRACKER[BOSSAI_CURRENT_TARGET:GetOwner():GetPlayerID()] = BOSSAI_PLAYER_DAMAGE_TRACKER[BOSSAI_CURRENT_TARGET:GetOwner():GetPlayerID()] + 5
			end
		end
		if(BOSSAI_CURRENT_PERSONALITY==BOSSAI_PERSONALITY.GREEDY)then -- Increase aggro for richest target
			local wealth_of_targets = BossAI:GetTargetsGold(herotargets)
			selectionfilter = 0
			selectednumber = 0
			-- Work out which i is the one we want
			for i=1,#wealth_of_targets do
				if(herotargets[i]:IsInvisible()==false)and(herotargets[i]:IsInvulnerable()==false)and(herotargets[i]:IsAlive()) then -- Make sure we can even see or attack this target
					if(wealth_of_targets[i]>selectionfilter)and(herotargets[i]:IsAlive())then -- This runs asynchronosly, make sure hero hasn't died between frames.
						selectionfilter = wealth_of_targets[i]
						selectednumber = i
					end
				end
			end
			BOSSAI_PLAYER_DAMAGE_TRACKER[selectednumber] = BOSSAI_PLAYER_DAMAGE_TRACKER[selectednumber]+5
		end
		if(BOSSAI_CURRENT_PERSONALITY==BOSSAI_PERSONALITY.RANDOM)then -- Increase aggro randomly if we're hunting. Gives a massive boost to ensure the target is random
			if(BOSSAI_CURRENT_STATE==BOSSAI_AI_STATE.HUNTING)then
				selectednumber=RandomInt(1,#herotargets)
				BOSSAI_PLAYER_DAMAGE_TRACKER[selectednumber] = BOSSAI_PLAYER_DAMAGE_TRACKER[selectednumber]+100
			end
		end
	else
		-- We couldn't find any players
		BOSSAI_SEARCH_SUCCESS = false
	end

	-- Reduce aggro for all players
	for i=1,#BOSSAI_PLAYER_DAMAGE_TRACKER do
		BOSSAI_PLAYER_DAMAGE_TRACKER[i] = math.ceil(BOSSAI_PLAYER_DAMAGE_TRACKER[i] - math.ceil(BOSSAI_PLAYER_DAMAGE_TRACKER[i]/10))
		if(BOSSAI_PLAYER_DAMAGE_TRACKER[i]<0) then
			BOSSAI_PLAYER_DAMAGE_TRACKER[i] = 0
		end
		-- Add current aggro
		s2 = s2.." | "..string.gsub(debughero[i]:GetName(),"npc_dota_hero_","")
		s=s.." |        "..tostring(BOSSAI_PLAYER_DAMAGE_TRACKER[i])
	end
	DebugPrint(s2)
	DebugPrint(s)
end

-- Triggered when an enemy hero starts to cast a spell
function BossAI:EnemyHeroStartCast(hero)
	DebugPrint("Enemy hero used ability")
	-- Calls any BossAI functions that might react to this
	BOSSAI_REACTION_TARGET = hero
	BossAI:BossParser(BOSSAI_SWITCH.REACTION)
end

-----------------------------------------------------------------------------------------
-- Personality AI Functions
-----------------------------------------------------------------------------------------

function BossAI:ChooseNewTarget()
	-- See who is causing the most aggro and select them
	if(BOSSAI_SEARCH_SUCCESS)then
		local i =0
		local aggrolevel = -1
		local aggroindex = -1
		local herotargets = TheLastStand:GetHeroTargets()
		for i=1,#BOSSAI_PLAYER_DAMAGE_TRACKER do
			if(BOSSAI_PLAYER_DAMAGE_TRACKER[i]>aggrolevel)and(herotargets[i]:IsAlive())and(herotargets[i]:IsInvisible()==false)and(herotargets[i]:IsInvulnerable()==false)and(herotargets[i]:IsOutOfGame()==false) then
				aggroindex = i
				aggrolevel = BOSSAI_PLAYER_DAMAGE_TRACKER[i]
			end
		end
		if(aggroindex==-1)then
			-- we were unsuccessful
			BOSSAI_CURRENT_TARGET = nil
			BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.HUNTING
		else
			BOSSAI_CURRENT_TARGET = herotargets[aggroindex]
			BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.ATTACKING
		end
	else
		-- we were unsuccessful
		BOSSAI_CURRENT_TARGET = nil
		BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.HUNTING
	end
end




-----------------------------------------------------------------------------------------
-- Attack AI Functions
-----------------------------------------------------------------------------------------

-- Have a look at https://github.com/MNoya/DotaCraft/blob/master/game/dota_addons/dotacraft/scripts/vscripts/units/aggro_filter.lua
-- from MNoya for inspiration for writing controls




-- Timer that controls aggro for simple creeps
function BossAI:SleepAttackPrioritySimple()
		-- Set timer to next recall
		Timers:CreateTimer({
    		endTime = 5,
			callback = function()
				BossAI:WakeCheckAttackPrioritySimple()
			end
		})
end
--
function BossAI:WakeCheckAttackPrioritySimple()
	local wavecontent = TheLastStand:GetWaveContents()
	local waveattacking = TheLastStand:GetWaveContentsAttacking()
	local finalpoint = TheLastStand:GetFinalPoint()
	local i
	if(#wavecontent~=0)then
		-- Continue, we have units to work with
		for i=1,#wavecontent do
    		ExecuteOrderFromTable({ UnitIndex = wavecontent[i]:entindex(), OrderType = DOTA_UNIT_ORDER_STOP, Queue = false})
			--DebugPrint("[AI] Fetch closest enemy unit")
			-- First check if anything is in range, if it is - attack it
			waveattacking[i] = BossAI:AssessAggroSimple(wavecontent[i])
			TheLastStand:SetWaveContentsAttacking(waveattacking[i], i)
			-- Check to see if we lost track
			if(waveattacking[i] == false)then
				-- Reassign attack vector
        		ExecuteOrderFromTable({ UnitIndex = wavecontent[i]:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = finalpoint, Queue = false})
			end
		end
		-- Set timer to next recall
		--DebugPrint("Check again in 5")
		Timers:CreateTimer({
    		endTime = 2.5,
			callback = function()
				BossAI:WakeCheckAttackPrioritySimple()
			end
		})
	end
	-- Do not recall SleepAttackPrioritySimple
end

-- Checks if there are any enemies in range and attacks them if there are, returns false if none found
function BossAI:AssessAggroSimple(unit)
	--DebugPrint("[AI] Fetching....")
	local enemies = FindUnitsInRadius(DOTA_TEAM_BADGUYS,unit:GetOrigin(),nil,unit:GetAcquisitionRange(),DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_ALL,DOTA_UNIT_TARGET_FLAG_NONE,FIND_CLOSEST,false)
	local target = nil
	PrintTable(enemies)
	if(#enemies>0)then
		target = enemies[1]
	end
	if(target ~= nil)then
    	ExecuteOrderFromTable({ UnitIndex = unit:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET, TargetIndex = target:entindex(), Queue = false})
    	return true
    else
    	return false
    end
end
	

-----------------------------------------------------------------------------------------
-- Distance Calculators
-----------------------------------------------------------------------------------------

	-- Returns the closest enemy hero handle
	function BossAI:NearestTarget(boss_unit_point, herotargets)
		--DebugPrint("NearestTarget")
		local i=0
		local heroes = herotargets
		local targetposlist = {}
		local returndist = 10000
		local herolist = {}
		local targetdistlist = {}
		local pointi = -1
		-- Fetch the positions of each enemy hero
		for i=1,#heroes do
			table.insert(targetposlist,heroes[i]:GetOrigin())
			table.insert(herolist,heroes[i])
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistanceList(targetposlist,boss_unit_point)
		--DebugPrint("Calculating")
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(returndist>targetdistlist[i])then
				--DebugPrint(targetdistlist[i])
				returndist = targetdistlist[i]
				pointi = i
			end
		end
		return herolist[pointi]
	end

	-- Returns the furthest enemy hero handle
	function BossAI:FurthestTarget(boss_unit_point, herotargets)
		local i=0
		local heroes = herotargets
		local targetposlist = {}
		local returndist = 0
		local herolist = {}
		local targetdistlist = {}
		local pointi = -1
		-- Fetch the positions of each enemy hero
		for i=1,#heroes do
			table.insert(targetposlist,heroes[i]:GetOrigin())
			table.insert(herolist,heroes[i])
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistanceList(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(returndist<targetdistlist[i])then
				returndist = targetdistlist[i]
				pointi = i
			end
		end
		return herolist[pointi]
	end

	-- Returns a list of enemy hero handles that are closer than dist
	function BossAI:TargetsInRange(boss_unit_point,rangedist, herotargets)
		--DebugPrint("Targets In Range: Point")
		--DebugPrint(boss_unit_point)
		local heroes = herotargets
		local i=0
		local targetposlist = {}
		local herolist = {}
		local targetdistlist = {}
		local returnlist = {}
		-- Fetch the positions of each enemy hero
		--DebugPrint(#heroes)
		for i=1,#heroes do
			table.insert(targetposlist,heroes[i]:GetOrigin())
			table.insert(herolist,heroes[i])
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistanceList(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(targetdistlist[i]<rangedist)then
				table.insert(returnlist,herolist[i])
			end
		end
		return returnlist
	end

	-- Returns a list of enemy hero handles that are further than dist
	function BossAI:TargetsOutOfRange(boss_unit_point,rangedist,herotargets)
		local i=0
		local heroes = herotargets
		local targetposlist = {}
		local herolist = {}
		local targetdistlist = {}
		local returnlist = {}
		-- Fetch the positions of each enemy hero
		for i=1,#heroes do
			table.insert(targetposlist,heroes[i]:GetOrigin())
			table.insert(herolist,heroes[i])
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistanceList(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(targetdistlist[i]>rangedist)then
				table.insert(returnlist,herolist[i])
			end
		end
		return returnlist
	end

	-- Takes an array of target vectors and a starting vector and returns a list of distances
	function BossAI:TargetDistanceList(targetposlist, startpos)
		local returnlist = {}
		local i=0
		for i=1,#targetposlist do
			table.insert(returnlist,BossAI:TargetDistance(targetposlist[i], startpos))
		end
		return returnlist
	end

	-- Takes an single target vector and a starting vector and returns the distance
	function BossAI:TargetDistance(targetpos, startpos)
		return math.sqrt((startpos.x-targetpos.x)^2 + (startpos.y-targetpos.y)^2)
	end


-----------------------------------------------------------------------------------------
-- Fetch Hero Data
-----------------------------------------------------------------------------------------
	
	-- Returns a list of key pairs with the ID and the HP of the remaining heroes.
	function BossAI:GetTargetsHP(herotargets)
		local returnlist = {}
		local heroes = herotargets
		local i = 0
		for i=1,#heroes do
			table.insert(returnlist,heroes[i]:GetHealth())
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the HP Percentage of the remaining heroes.
	function BossAI:GetTargetsHPPercent(herotargets)
		local returnlist = {}
		local heroes = herotargets
		local i = 0
		for i=1,#heroes do
			table.insert(returnlist,heroes[i]:GetHealth()/heroes[i]:GetMaxHealth())
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the MP of the remaining heroes.
	function BossAI:GetTargetsMP(herotargets)
		local returnlist = {}
		local heroes = herotargets
		local i = 0
		for i=1,#heroes do
			table.insert(returnlist,heroes[i]:GetMana())
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the HP Percentage of the remaining heroes.
	function BossAI:GetTargetsMPPercent(herotargets)
		local returnlist = {}
		local heroes = herotargets
		local i = 0
		for i=1,#heroes do
			table.insert(returnlist,heroes[i]:GetMana()/heroes[i]:GetMaxMana())
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the move speed of the remaining heroes.
	function BossAI:GetTargetsMoveSpeed(herotargets)
		local returnlist = {}
		local heroes = herotargets
		local i = 0
		for i=1,#heroes do
			table.insert(returnlist,heroes[i]:GetIdealSpeed())
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the attack ranges of the remaining heroes.
	function BossAI:GetTargetsAttackRange(herotargets)
		local returnlist = {}
		local heroes = herotargets
		local i = 0
		for i=1,#heroes do
			table.insert(returnlist,heroes[i]:GetBaseAttackRange())
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the physical resistance of the remaining heroes.
	function BossAI:GetTargetsArmor(herotargets)
		local returnlist = {}
		local heroes = herotargets
		local i = 0
		for i=1,#heroes do
			table.insert(returnlist,heroes[i]:GetPhysicalArmorValue())
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the magical resistance of the remaining heroes.
	function BossAI:GetTargetsMagicResist(herotargets)
		local returnlist = {}
		local heroes = herotargets
		local i = 0
		for i=1,#heroes do
			table.insert(returnlist,heroes[i]:GetMagicalArmorValue())
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the primary attributes of the remaining heroes.
	function BossAI:GetTargetsPrimaryAttribute(herotargets)
		local returnlist = {}
		local heroes = herotargets
		local i = 0
		for i=1,#heroes do
			table.insert(returnlist,heroes[i]:GetPrimaryAttribute())
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the current banked gold of the remaining heroes.
	function BossAI:GetTargetsGold(herotargets)
		local returnlist = {}
		local heroes = herotargets
		local i = 0
		for i=1,#heroes do
			table.insert(returnlist,heroes[i]:GetGold())
		end
		return returnlist
	end

DebugPrint('[---------------------------------------------------------------------] boss AI!\n\n')