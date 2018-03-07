-- This contains a number of useful AI fetchers, sorters, and modes for the specialised AI packages to use

BOSSAI_CURRENT_TARGET = nil
BOSSAI_REACTION_TARGET = nil
BOSSAI_CURRENT_BOSS = nil
BOSSAI_CURENT_MODE = 0
BOSSAI_PLAYER_DAMAGE_TRACKER = {}
BOSSAI_CURRENT_AI_TICK_TIMER = 1
BOSSAI_DATA = {}
BOSSAI_LEVEL = 1

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
	HUNTING = 4 -- When the boss does not like any of the current targets and requires a new one
}

BOSSAI_CURRENT_PERSONALITY = nil

-- This controls how the boss will prefer to select targets
BOSSAI_PERSONALITY = {
	VINDICTIVE = 1, -- Boss will want to go after the target with the lowest health
	HONOURABLE = 2, -- Boss will want to go after the target with the highest health, and resistance
	OPPORTUNIST = 3, -- Boss will want to go after the closest target
	STUBBORN = 4, -- Boss will want to go after his current target
	GREEDY = 5 -- Only meepo uses this. Goes after hero with most gold.
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
	BOSSAI_DATA = {}
	-- Set new Boss
	BOSSAI_CURRENT_BOSS = boss
	-- Choose boss event
	BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.NOTHING
	-- Choose Boss Level
	BOSSAI_LEVEL = TheLastStand:GetPlayerCount()
	-- Setup boss
	BossAI:BossParser(BOSSAI_SWITCH.SETUP)
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
			--Check if health is over 25, if it is then stop fleeing
			if(boss:GetHealth()/boss:GetMaxHealth()>0.25) then
				BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.NOTHING
				ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_STOP, Queue = false})
			end
		end
		if(BOSSAI_CURRENT_STATE==BOSSAI_AI_STATE.CASTING)then
			--We're casting, are we still doing it?
			if(boss:IsChanneling()==false)then
				-- We've stopped casting, let's start attacking
				BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.NOTHING
				ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_STOP, Queue = false})
			end
		end
		-- Are we doing nothing? Then go attack the ancient
		if(BOSSAI_CURRENT_STATE==BOSSAI_AI_STATE.NOTHING)then
			BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.HUNTING
  			ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = TheLastStand:GetFinalPoint(), Queue = true})
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
		-- Check ability logic
		BossAI:BossParser(BOSSAI_SWITCH.ABILITY)
		-- Check special logic
		BossAI:BossParser(BOSSAI_SWITCH.SPECIAL)
		-- Recall this function next tick
		Timers:CreateTimer({
	        endTime = 1,
	      callback = function()
	        BossAI:EveryTick()
	      end
	    })	
	else
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
	BOSSAI_PLAYER_DAMAGE_TRACKER[attacker:GetOwner()] = BOSSAI_PLAYER_DAMAGE_TRACKER[attacker:GetOwner()] + damage
	--DebugPrint(BOSSAI_PLAYER_DAMAGE_TRACKER[attacker:GetOwner():GetPlayerID()])

	-- Is there something else we need to do in reaction to taking damage?
end

-- Adjust current aggro every AI tick
function BossAI:AdjustAggro()
	-- Debugging variables
	local s = "Current Aggro "
	-- Increase or Decrease aggro based on personality
	local herotargets = TheLastStand:GetHeroTargets()
	local boss = BOSSAI_CURRENT_BOSS
	local closest_player = BossAI:NearestTarget(boss:GetOrigin(),herotargets):GetOwner():GetPlayerID()
	local furthest_player = BossAI:FurthestTarget(boss:GetOrigin(),herotargets):GetOwner():GetPlayerID()
	local target = nil
	-- Increment aggro for the current target to reduce likely hood of switching targets
	if(BOSSAI_CURRENT_TARGET~=nil)then
		BOSSAI_PLAYER_DAMAGE_TRACKER[BOSSAI_CURRENT_TARGET:GetOwner():GetPlayerID()] = BOSSAI_PLAYER_DAMAGE_TRACKER[BOSSAI_CURRENT_TARGET:GetOwner():GetPlayerID()] + 5
	end
	local i = 0
	local temp1 = 0
	local temp2 = 0
	-- Increase aggro for the closest target
	BOSSAI_PLAYER_DAMAGE_TRACKER[closest_player] = BOSSAI_PLAYER_DAMAGE_TRACKER[closest_player]+5
	-- Decrease aggro for the furthest target
	BOSSAI_PLAYER_DAMAGE_TRACKER[furthest_player] = BOSSAI_PLAYER_DAMAGE_TRACKER[furthest_player]-5
	
	-- Personality factors
	if(BOSSAI_CURRENT_PERSONALITY==BOSSAI_PERSONALITY.VINDICTIVE)then -- Increase aggro for lowest health
		local targets_health = BossAI:GetTargetsHP(herotargets)
		temp1 = 10000
		temp2 = 0
		-- Work out which i is the one we want
		for i=1,#herotargets do
			if(herotargets[i]:IsInvisible()==false)and(herotargets[i]:IsInvulnerable()==false) then -- Make sure we can even see or attack this target
				if(targets_health[i]<temp1)then
					temp1 = targets_health[i]
					temp2 = i
				end
			end
		end
		BOSSAI_PLAYER_DAMAGE_TRACKER[temp2] = BOSSAI_PLAYER_DAMAGE_TRACKER[temp2]+5
	end
	if(BOSSAI_CURRENT_PERSONALITY==BOSSAI_PERSONALITY.HONOURABLE)then -- Increase aggro for most resistance
		local targets_armour = BossAI:GetTargetsArmor(herotargets)
		local targets_magic = BossAI:GetTargetsMagicResist(herotargets)
		temp1 = 0
		temp2 = 0
		-- Merge the values
		for i=1,#targets_armour do
			targets_armour[i] = targets_armour[i]+targets_magic[i]
		end
		-- Work out which i is the one we want
		for i=1,#herotargets do
			if(herotargets[i]:IsInvisible()==false)and(herotargets[i]:IsInvulnerable()==false) then -- Make sure we can even see or attack this target
				if(targets_armour[i]>temp1)then
					temp1 = targets_armour[i]
					temp2 = i
				end
			end
		end
		BOSSAI_PLAYER_DAMAGE_TRACKER[temp2] = BOSSAI_PLAYER_DAMAGE_TRACKER[temp2]+5
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
		temp1 = 0
		temp2 = 0
		-- Work out which i is the one we want
		for i=1,#herotargets do
			if(herotargets[i]:IsInvisible()==false)and(herotargets[i]:IsInvulnerable()==false) then -- Make sure we can even see or attack this target
				if(wealth_of_targets[i]>temp1)then
					temp1 = wealth_of_targets[i]
					temp2 = i
				end
			end
		end
		BOSSAI_PLAYER_DAMAGE_TRACKER[temp2] = BOSSAI_PLAYER_DAMAGE_TRACKER[temp2]+5
	end


	-- Reduce aggro for all players
	for i=1,#BOSSAI_PLAYER_DAMAGE_TRACKER do
		BOSSAI_PLAYER_DAMAGE_TRACKER[i] = BOSSAI_PLAYER_DAMAGE_TRACKER[i] - math.ceil(BOSSAI_PLAYER_DAMAGE_TRACKER[i]/60)
		if(BOSSAI_PLAYER_DAMAGE_TRACKER[i]<0) then
			BOSSAI_PLAYER_DAMAGE_TRACKER[i] = 0
		end
		-- Add current aggro
		s=s.." | "..tostring(BOSSAI_PLAYER_DAMAGE_TRACKER[i])
	end
	--DebugPrint(s)
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
	local i =0
	local temp1 = 0
	local temp2 = 0
	local herotargets = TheLastStand:GetHeroTargets()
	for i=1,#BOSSAI_PLAYER_DAMAGE_TRACKER do
		if(BOSSAI_PLAYER_DAMAGE_TRACKER[i]>temp1) then
			temp2 = i
			temp1 = BOSSAI_PLAYER_DAMAGE_TRACKER[i]
		end
	end
	BOSSAI_CURRENT_TARGET = herotargets[temp2]
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
		local targetposlist = {}
		local returndist = 10000
		local targetdistlist = {}
		local pointi = -1
		-- Fetch the positions of each enemy hero
		for i=1,#herotargets do
			--DebugPrint(herotargets[i]:GetOrigin())
			table.insert(targetposlist,herotargets[i]:GetOrigin())
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistanceList(targetposlist,boss_unit_point)
		--DebugPrint("Calculating")
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(returndist>targetdistlist[i])and(herotargets[i]:IsAlive())then
				--DebugPrint(targetdistlist[i])
				returndist = targetdistlist[i]
				pointi = i
			end
		end
		return herotargets[pointi]
	end

	-- Returns the furthest enemy hero handle
	function BossAI:FurthestTarget(boss_unit_point, herotargets)
		local i=0
		local targetposlist = {}
		local returndist = 0
		local targetdistlist = {}
		local pointi = -1
		-- Fetch the positions of each enemy hero
		for i=1,#herotargets do
			table.insert(targetposlist,herotargets[i]:GetOrigin())
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistanceList(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(returndist<targetdistlist[i])and(herotargets[i]:IsAlive())then
				returndist = targetdistlist[i]
				pointi = i
			end
		end
		return herotargets[pointi]
	end

	-- Returns a list of enemy hero handles that are closer than dist
	function BossAI:TargetsInRange(boss_unit_point,rangedist, herotargets)
		--DebugPrint("Targets In Range: Point")
		--DebugPrint(boss_unit_point)
		local i=0
		local targetposlist = {}
		local targetdistlist = {}
		local returnlist = {}
		-- Fetch the positions of each enemy hero
		for i=1,#herotargets do
			table.insert(targetposlist,herotargets[i]:GetOrigin())
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistanceList(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(rangedist>=targetdistlist[i])and(herotargets[i]:IsAlive())then
				table.insert(returnlist,herotargets[i])
			end
		end
		return returnlist
	end

	-- Returns a list of enemy hero handles that are further than dist
	function BossAI:TargetsOutOfRange(boss_unit_point,rangedist,herotargets)
		local i=0
		local targetposlist = {}
		local targetdistlist = {}
		local returnlist = {}
		-- Fetch the positions of each enemy hero
		for i=1,#herotargets do
			table.insert(targetposlist,herotargets[i]:GetOrigin())
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistanceList(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(rangedist<targetdistlist[i])and(herotargets[i]:IsAlive())then
				table.insert(returnlist,herotargets[i])
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
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,herotargets[i]:GetHealth())
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the HP Percentage of the remaining heroes.
	function BossAI:GetTargetsHPPercent(herotargets)
		local returnlist = {}
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,herotargets[i]:GetHealth()/herotargets[i]:GetMaxHealth())
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the MP of the remaining heroes.
	function BossAI:GetTargetsMP(herotargets)
		local returnlist = {}
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,herotargets[i]:GetMana())
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the HP Percentage of the remaining heroes.
	function BossAI:GetTargetsMPPercent(herotargets)
		local returnlist = {}
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,herotargets[i]:GetMana()/herotargets[i]:GetMaxMana())
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the move speed of the remaining heroes.
	function BossAI:GetTargetsMoveSpeed(herotargets)
		local returnlist = {}
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,herotargets[i]:GetIdealSpeed())
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the attack ranges of the remaining heroes.
	function BossAI:GetTargetsAttackRange(herotargets)
		local returnlist = {}
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,herotargets[i]:GetBaseAttackRange())
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the physical resistance of the remaining heroes.
	function BossAI:GetTargetsArmor(herotargets)
		local returnlist = {}
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,herotargets[i]:GetPhysicalArmorValue())
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the magical resistance of the remaining heroes.
	function BossAI:GetTargetsMagicResist(herotargets)
		local returnlist = {}
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,herotargets[i]:GetMagicalArmorValue())
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the primary attributes of the remaining heroes.
	function BossAI:GetTargetsPrimaryAttribute(herotargets)
		local returnlist = {}
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,herotargets[i]:GetPrimaryAttribute())
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the current banked gold of the remaining heroes.
	function BossAI:GetTargetsGold(herotargets)
		local returnlist = {}
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,herotargets[i]:GetGold())
			end
		end
		return returnlist
	end

DebugPrint('[---------------------------------------------------------------------] boss AI!\n\n')