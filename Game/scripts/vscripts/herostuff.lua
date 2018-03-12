if HeroStuff == nil then
    DebugPrint( '[TLS] creating hero stuff module' )
    _G.HeroStuff = class({})
end

HEROSTUFF_CIRCLE_RADIUS = 200
HEROSTUFF_CIRCLE_DATA = {}
HEROSTUFF_HEROES_BEING_REVIVED = 0
HEROSTUFF_TIME_BETWEEN_CHECKS = 0.25
HEROSTUFF_TIME_CIRCLE_DRAWN = HEROSTUFF_TIME_BETWEEN_CHECKS+0.02
HEROSTUFF_TIME_TO_REVIVE = 30
HEROSTUFF_CIRCLE_X = 100
HEROSTUFF_CIRCLE_Y = 180
HEROSTUFF_CIRCLE_HEIGHT = 400
HEROSTUFF_INITIAL_PARTICLE = "particles/econ/events/fall_major_2016/teleport_start_fm06_outerring.vpcf"
HEROSTUFF_RESPAWN_PARTICLE = "particles/items_fx/aegis_respawn.vpcf"
HEROSTUFF_HERO_INDEX = 0

-- 
function HeroStuff:InitiateReviveCircle(_hero)
	--DebugPrint("Initiate Revive Circle")
	-- Init the circle data
	HEROSTUFF_HEROES_BEING_REVIVED = HEROSTUFF_HEROES_BEING_REVIVED + 1
	-- Check if the number of heroes needing to be revived is equal to the number of heroes in the game
	--DebugPrint("Dead Hero to Alive Heroes")
	DebugPrint(HEROSTUFF_HEROES_BEING_REVIVED)
	DebugPrint(TheLastStand:GetPlayerCount())
	DebugPrint(#TheLastStand:GetPlayerTargets())
	if(HEROSTUFF_HEROES_BEING_REVIVED==TheLastStand:GetPlayerCount())then
		-- The game has been lost
		TheLastStand:GameLost()
	end
	local isbeingrevived = false
	HEROSTUFF_HERO_INDEX = HEROSTUFF_HERO_INDEX + 1
	local HEROSTUFF_HERO_INDEX = HEROSTUFF_HERO_INDEX
	local i = 0
	local dummy = CreateUnitByName("npc_dummy_unit", _hero:GetOrigin(), false, _hero, _hero, DOTA_TEAM_GOODGUYS)
	GameMode:FixDummy(dummy)
	-- Set the hero to respawn on the spot
	_hero:SetRespawnPosition(_hero:GetOrigin())
	-- Create the circle
	local particle = ParticleManager:CreateParticle(HEROSTUFF_INITIAL_PARTICLE, PATTACH_ABSORIGIN, dummy)

	-- Assign the circle data
	table.insert(HEROSTUFF_CIRCLE_DATA,{
		INDEX = HEROSTUFF_HERO_INDEX,
		DUMMY = dummy,
		POINT = _hero:GetOrigin(), 
		HERO = _hero,
		REVIVING = isbeingrevived,
		TIME = HEROSTUFF_TIME_TO_REVIVE,
		PARTICLE = particle
	})
	-- Call the check and balance now that it has been initialised
	HeroStuff:CircleCheckIfHeroReviving(HEROSTUFF_HERO_INDEX)
end

-- This is called to check if the hero is being revived and is recalled ever point until it is no longer needed
function HeroStuff:CircleCheckIfHeroReviving(_herostuff_hero_index)
	--DebugPrint("Circle Check If Hero Reviving")
	local i = 0
	local hero_num = -1
	for i=1,#HEROSTUFF_CIRCLE_DATA do
		if(HEROSTUFF_CIRCLE_DATA[i].INDEX == _herostuff_hero_index) then hero_num=i break end
	end
	local point = HEROSTUFF_CIRCLE_DATA[hero_num].POINT
	--DebugPrint(point)
	-- Check if someone is in range
	local heroes = BossAI:TargetsInRange(point,HEROSTUFF_CIRCLE_RADIUS,TheLastStand:GetFilterHeroTargets(true,false,false,true,false,nil)) -- Uses BossAi as it contains the helper functions
	if(#heroes>0)then
		HEROSTUFF_CIRCLE_DATA[hero_num].REVIVING = true
	end
	-- Is the hero being revived?
	if(HEROSTUFF_CIRCLE_DATA[hero_num].REVIVING) then
		-- Call circle timer running
		HeroStuff:CircleTimerRunning(hero_num)
	else
		if(HEROSTUFF_CIRCLE_DATA[hero_num].TIME<HEROSTUFF_TIME_TO_REVIVE) then
			HEROSTUFF_CIRCLE_DATA[hero_num].TIME = HEROSTUFF_CIRCLE_DATA[hero_num].TIME + 1
			HeroStuff:DrawCircleTimer(hero_num)
		end
  		-- Recurse this function
	    Timers:CreateTimer({
	        endTime = HEROSTUFF_TIME_BETWEEN_CHECKS,
	      callback = function()
	        HeroStuff:CircleCheckIfHeroReviving(hero_num)
	      end
	    })	
	end
end

-- Runs whilst timing the revival process
function HeroStuff:CircleTimerRunning(_herostuff_hero_index)
	--DebugPrint("Circle Timer Running")
	local i = 0
	local hero_num = -1
	for i=1,#HEROSTUFF_CIRCLE_DATA do
		if(HEROSTUFF_CIRCLE_DATA[i].INDEX == _herostuff_hero_index) then hero_num=i break end
	end
	local point = HEROSTUFF_CIRCLE_DATA[hero_num].POINT
	-- Check if someone is in range
	HEROSTUFF_CIRCLE_DATA[hero_num].REVIVING = false
	local heroes = BossAI:TargetsInRange(point,HEROSTUFF_CIRCLE_RADIUS,TheLastStand:GetFilterHeroTargets(true,false,false,true,false,nil)) -- Uses BossAi as it contains the helper functions
	if(#heroes>0)then
		HEROSTUFF_CIRCLE_DATA[hero_num].REVIVING = true
	end

	if(HEROSTUFF_CIRCLE_DATA[hero_num].REVIVING) then
		-- Reduce the timer and redraw the circle
		HEROSTUFF_CIRCLE_DATA[hero_num].TIME = HEROSTUFF_CIRCLE_DATA[hero_num].TIME - 1
		HeroStuff:DrawCircleTimer(hero_num)
		-- Check if the timer has been completed
		if(HEROSTUFF_CIRCLE_DATA[hero_num].TIME<1)then
			-- Respawn the hero
			local hero = HEROSTUFF_CIRCLE_DATA[hero_num].HERO
			hero:RespawnHero(false, false)
			SoundController:RespawnStinger(hero)
			SoundController:Hero_Revived(hero)
			-- Remove the circle
			ParticleManager:DestroyParticle(HEROSTUFF_CIRCLE_DATA[hero_num].PARTICLE,true)
			UTIL_Remove(HEROSTUFF_CIRCLE_DATA[hero_num].DUMMY)
			hero:SetHealth(math.floor(hero:GetMaxHealth()/4))
			hero:SetMana(math.floor(hero:GetMaxMana()/4))
			-- Remove this data from the data table
			table.remove(HEROSTUFF_CIRCLE_DATA[hero_num])
			HEROSTUFF_HEROES_BEING_REVIVED = HEROSTUFF_HEROES_BEING_REVIVED -1
			-- Create and destroy a particle
			local particle = ParticleManager:CreateParticle(HEROSTUFF_RESPAWN_PARTICLE, PATTACH_ABSORIGIN, hero)
		    Timers:CreateTimer({
		        endTime = 5,
		      callback = function()
				ParticleManager:DestroyParticle(particle,false)
		      end
		    })
		else
	  		-- Recurse this function
		    Timers:CreateTimer({
		        endTime = HEROSTUFF_TIME_BETWEEN_CHECKS,
		      callback = function()
		        HeroStuff:CircleCheckIfHeroReviving(hero_num)
		      end
		    })
		end
	else
		-- Recall waiting period
	    Timers:CreateTimer({
	        endTime = HEROSTUFF_TIME_BETWEEN_CHECKS,
	      callback = function()
	        HeroStuff:CircleCheckIfHeroReviving(hero_num)
	      end
	    })
	end
end

-- Graphic displaying time to revive
function HeroStuff:DrawCircleTimer(_hero_num)
	local hero = HEROSTUFF_CIRCLE_DATA[_hero_num].HERO
	local midpoint = HEROSTUFF_CIRCLE_DATA[_hero_num].POINT
	local x = HEROSTUFF_CIRCLE_X
	local y = HEROSTUFF_CIRCLE_Y
	local height = HEROSTUFF_CIRCLE_HEIGHT
	-- Draw background
	DebugDrawCircle(
		Vector(midpoint.x - x, midpoint.y - y, midpoint.z + height), -- pos
		Vector(0, 0, 0), -- colour
		255, -- alpha
		HEROSTUFF_TIME_TO_REVIVE,
		false,
		HEROSTUFF_TIME_CIRCLE_DRAWN
		)
	-- Draw foreground
	DebugDrawCircle(
		Vector(midpoint.x - x, midpoint.y - y, midpoint.z + height+1), -- pos
		Vector(0, 255, 255), -- colour
		255, -- alpha
		HEROSTUFF_CIRCLE_DATA[_hero_num].TIME,
		false,
		HEROSTUFF_TIME_CIRCLE_DRAWN
		)
end