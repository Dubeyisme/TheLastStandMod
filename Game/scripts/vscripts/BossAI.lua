-- This contains a number of useful AI fetchers, sorters, and modes for the specialised AI packages to use

BOSSAI_CURRENT_TARGET = nil
BOSSAI_CURRENT_BOSS = nil
BOSSAI_CURENT_MODE = 0
BOSSAI_PLAYER_DAMAGE_TRACKER = {}
BOSSAI_CURRENT_AI_TICK_TIMER = 1

--BOSSAI_CURRENT_STATE = 

BOSSAI_AI_STATE = {
	ATTACKING = 1, -- When the boss has a set target to attack
	CASTING = 2, -- When the boss has decided to use an ability
	FLEEING = 3, -- When the boss has decided to flee from a strong attacker
	HUNTING = 4 -- When the boss does not like any of the current targets and requires a new one
}

BOSSAI_ABILITY_COOLDOWN = {0,0,0,0,0}

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

-----------------------------------------------------------------------------------------
-- Initialisation of the AI
-----------------------------------------------------------------------------------------

function BossAI:GetCurrentBoss() return BOSSAI_CURRENT_BOSS end
function BossAI:GetCurrentAbilityCooldowns() return BOSSAI_ABILITY_COOLDOWN end


-- Initialise the Boss' AI
function BossAI:InitBossAI(boss)
	-- Init damage tracker
	BossAI:InitDamageTracker()
	-- Init current mode
	BOSSAI_CURENT_MODE = 0
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
	-- Check if the boss is alive
	if(true) then
		-- Boss is alive
	else
		-- Boss has died, end the round has therefore ended
	end
	-- Check if the wave has ended
	if(true) then
		-- Check which mode we are in
		if(BOSSAI_CURENT_MODE==1) then
			-- Check if HP has dipped below 75%
			if(BOSSAI_CURRENT_BOSS:GetHealth()/BOSSAI_CURRENT_BOSS:GetMaxHealth()<0.75) then
				BOSSAI_CURENT_MODE = 2
			end
		else 
			if (BOSSAI_CURENT_MODE==2) then
				-- Check if HP has dipped below 25%
				if(BOSSAI_CURRENT_BOSS:GetHealth()/BOSSAI_CURRENT_BOSS:GetMaxHealth()<0.25) then
					BOSSAI_CURENT_MODE = 3
				end
			else 
				if(BOSSAI_CURENT_MODE == 3) then
					-- We are in mode 3, no change.
				end
			end
		end
		-- Adjust the aggro to stop caring about those not attacking
		BossAI:AdjustAggro()
		-- Lower Cooldowns
		local i = 0
		for i=1,#BOSSAI_ABILITY_COOLDOWN do
			if(BOSSAI_ABILITY_COOLDOWN[i]>0) then
				BOSSAI_ABILITY_COOLDOWN = BOSSAI_ABILITY_COOLDOWN -1
			end
		end
		Timers:CreateTimer({
	        endTime = 1,
	      callback = function()
	        BossAI:EveryTick()
	      end
	    })	
	else
		--BOSSAI_CURRENT_BOSS
		-- Reset current boss to nothing
		BOSSAI_CURRENT_BOSS = nil
	end
end

-----------------------------------------------------------------------------------------
-- Boss Reaction Functions
-----------------------------------------------------------------------------------------

-- Boss took damage
function BossAI:BossHurt(boss, attacker, damage)
	-- Increment the damage tracker
	BOSSAI_PLAYER_DAMAGE_TRACKER[attacker:GetOwner()] = BOSSAI_PLAYER_DAMAGE_TRACKER[attacker:GetOwner()] + damage
	DebugPrint(BOSSAI_PLAYER_DAMAGE_TRACKER[attacker:GetOwner():GetPlayerID()])

	-- Is there something else we need to do in reaction to taking damage?
end

-- Adjust current aggro every AI tick
function BossAI:AdjustAggro()
	-- Increment aggro for the current target to reduce likely hood of switching targets
	BOSSAI_PLAYER_DAMAGE_TRACKER[BOSSAI_CURRENT_TARGET:GetOwner():GetPlayerID()] = BOSSAI_PLAYER_DAMAGE_TRACKER[BOSSAI_CURRENT_TARGET:GetOwner():GetPlayerID()] + 5
	local i = 0
	-- Reduce aggro for all players
	for i=1,#BOSSAI_PLAYER_DAMAGE_TRACKER do
		BOSSAI_PLAYER_DAMAGE_TRACKER[i] = BOSSAI_PLAYER_DAMAGE_TRACKER[i] - math.ceil(BOSSAI_PLAYER_DAMAGE_TRACKER[i]/60)
		if(BOSSAI_PLAYER_DAMAGE_TRACKER[i]<0) then
			BOSSAI_PLAYER_DAMAGE_TRACKER[i] = 0
		end
	end
end


-----------------------------------------------------------------------------------------
-- Attack AI Functions
-----------------------------------------------------------------------------------------

-- Have a look at https://github.com/MNoya/DotaCraft/blob/master/game/dota_addons/dotacraft/scripts/vscripts/units/aggro_filter.lua
-- from MNoya for inspiration for writing controls

-- Triggered when an enemy hero starts to cast a spell
function BossAI:EnemyHeroStartCast(hero)
	-- Calls any BossAI functions that might react to this
end



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
	function BossAI:NearestTarget(boss_unit_point)
		local i=0
		local herotargets = TheLastStand:GetHeroTargets()
		local targetposlist = {}
		local returndist = 100000
		local targetdistlist = {}
		local pointi = -1
		-- Fetch the positions of each enemy hero
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive())then
				table.insert(targetposlist,herotargets[i]:GetOrigin())
			end
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistance(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(returndist>targetdistlist[i])then
				returndist = targetdistlist[i]
				pointi = i
			end
		end
		return targetposlist[pointi]
	end

	-- Returns the furthest enemy hero handle
	function BossAI:FurthestTarget(boss_unit_point)
		local i=0
		local herotargets = TheLastStand:GetHeroTargets()
		local targetposlist = {}
		local returndist = 0
		local targetdistlist = {}
		local pointi = -1
		-- Fetch the positions of each enemy hero
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive())then
				table.insert(targetposlist,herotargets[i]:GetOrigin())
			end
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistance(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(returndist<targetdistlist[i])then
				returndist = targetdistlist[i]
				pointi = i
			end
		end
		return targetposlist[pointi]
	end

	-- Returns a list of enemy hero handles that are closer than dist
	function BossAI:TargetsInRange(boss_unit_point,rangedist)
		--DebugPrint("Targets In Range: Point")
		--DebugPrint(boss_unit_point)
		local i=0
		local herotargets = TheLastStand:GetHeroTargets()
		local targetposlist = {}
		local targetdistlist = {}
		local returnlist = {}
		-- Fetch the positions of each enemy hero
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive())then
				table.insert(targetposlist,herotargets[i]:GetOrigin())
			end
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistance(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(rangedist>=targetdistlist[i])then
				table.insert(returnlist,targetposlist[i])
			end
		end
		return returnlist
	end

	-- Returns a list of enemy hero handles that are further than dist
	function BossAI:TargetsOutOfRange(boss_unit_point,rangedist)
		local i=0
		local herotargets = TheLastStand:GetHeroTargets()
		local targetposlist = {}
		local targetdistlist = {}
		local returnlist = {}
		-- Fetch the positions of each enemy hero
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive())then
				table.insert(targetposlist,herotargets[i]:GetOrigin())
			end
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistance(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=1,#targetposlist do
			if(rangedist<targetdistlist[i])then
				table.insert(returnlist,targetposlist[i])
			end
		end
		return returnlist
	end

	-- Takes an array of target vectors and a starting vector and returns a list of distances
	function BossAI:TargetDistance(targetposlist, startpos)
		--DebugPrint("Target Distance: Point")
		--DebugPrint(startpos)
		local i=0
		local returnlist = {}
		local x1,y1
		local x2 = startpos.x
		local y2 = startpos.y
		for i=1,#targetposlist do
			x1 = targetposlist[i].x
			y1 = targetposlist[i].y
			table.insert(returnlist,math.sqrt((x2-x1)^2 + (y2-y1)^2))
		end
		return returnlist
	end


-----------------------------------------------------------------------------------------
-- Fetch Hero Data
-----------------------------------------------------------------------------------------
	
	-- Returns a list of key pairs with the ID and the HP of the remaining heroes.
	function BossAI:GetTargetsHP()
		local returnlist = {}
		local herotargets = TheLastStand:GetHeroTargets()
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,{i,herotargets[i]:GetHealth()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the HP Percentage of the remaining heroes.
	function BossAI:GetTargetsHPPercent()
		local returnlist = {}
		local herotargets = TheLastStand:GetHeroTargets()
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,{i,herotargets[i]:GetHealth()/herotargets[i]:GetMaxHealth()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the MP of the remaining heroes.
	function BossAI:GetTargetsMP()
		local returnlist = {}
		local herotargets = TheLastStand:GetHeroTargets()
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,{i,herotargets[i]:GetMana()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the HP Percentage of the remaining heroes.
	function BossAI:GetTargetsMPPercent()
		local returnlist = {}
		local herotargets = TheLastStand:GetHeroTargets()
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,{i,herotargets[i]:GetMana()/herotargets[i]:GetMaxMana()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the move speed of the remaining heroes.
	function BossAI:GetTargetsMoveSpeed()
		local returnlist = {}
		local herotargets = TheLastStand:GetHeroTargets()
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,{i,herotargets[i]:GetIdealSpeed()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the attack ranges of the remaining heroes.
	function BossAI:GetTargetsAttackRange()
		local returnlist = {}
		local herotargets = TheLastStand:GetHeroTargets()
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,{i,herotargets[i]:GetBaseAttackRange()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the physical resistance of the remaining heroes.
	function BossAI:GetTargetsArmor()
		local returnlist = {}
		local herotargets = TheLastStand:GetHeroTargets()
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,{i,herotargets[i]:GetPhysicalArmorValue()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the magical resistance of the remaining heroes.
	function BossAI:GetTargetsMagicResist()
		local returnlist = {}
		local herotargets = TheLastStand:GetHeroTargets()
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,{i,herotargets[i]:GetMagicalArmorValue()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the primary attributes of the remaining heroes.
	function BossAI:GetTargetsPrimaryAttribute()
		local returnlist = {}
		local herotargets = TheLastStand:GetHeroTargets()
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,{i,herotargets[i]:GetPrimaryAttribute()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the current banked gold of the remaining heroes.
	function BossAI:GetTargetsGold()
		local returnlist = {}
		local herotargets = TheLastStand:GetHeroTargets()
		local i = 0
		for i=1,#herotargets do
			if(herotargets[i]:IsAlive()) then
				table.insert(returnlist,{i,herotargets[i]:GetGold()})
			end
		end
		return returnlist
	end

DebugPrint('[---------------------------------------------------------------------] boss AI!\n\n')