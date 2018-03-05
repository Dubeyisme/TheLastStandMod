if HeroStuff == nil then
    DebugPrint( '[TLS] creating hero stuff module' )
    _G.HeroStuff = class({})
end

CIRCLE_RADIUS = 200
CIRCLE_DATA = {}
HEROES_BEING_REVIVED = 0
TIME_BETWEEN_CHECKS = 0.25
TIME_CIRCLE_DRAWN = TIME_BETWEEN_CHECKS+0.02
TIME_TO_REVIVE = 30
CIRCLE_X = 100
CIRCLE_Y = 180
CIRCLE_HEIGHT = 400
INITIAL_PARTICLE = "particles/econ/events/fall_major_2016/teleport_start_fm06_outerring.vpcf"
RESPAWN_PARTICLE = "particles/items_fx/aegis_respawn.vpcf"
HERO_INDEX = 0

-- 
function HeroStuff:InitiateReviveCircle(hero)
	-- Init the circle data
	HEROES_BEING_REVIVED = HEROES_BEING_REVIVED + 1
	-- Check if the number of heroes needing to be revived is equal to the number of heroes in the game
	DebugPrint("Dead Hero to Alive Heroes")
	DebugPrint(HEROES_BEING_REVIVED)
	DebugPrint(TheLastStand:GetPlayerCount())
	DebugPrint(#TheLastStand:GetPlayerTargets())
	if(HEROES_BEING_REVIVED==TheLastStand:GetPlayerCount())then
		-- The game has been lost
		TheLastStand:GameLost()
	end
	local isbeingrevived = false
	HERO_INDEX = HERO_INDEX + 1
	local hero_index = HERO_INDEX
	local i = 0
	local ability = nil
	local dummy = CreateUnitByName("npc_dummy_unit", hero:GetOrigin(), false, hero, hero, DOTA_TEAM_GOODGUYS)
	-- Fix abilities
	  for i=0,6 do
	    ability = dummy:GetAbilityByIndex(i)
	    if(ability~=nil)then
	      ability:SetLevel(1)
	    end
	  end
	-- Set the hero to respawn on the spot
	hero:SetRespawnPosition(hero:GetOrigin())
	-- Create the circle
	local particle = ParticleManager:CreateParticle(INITIAL_PARTICLE, PATTACH_ABSORIGIN, dummy)

	-- Assign the circle data
	table.insert(CIRCLE_DATA,{
		INDEX = hero_index,
		DUMMY = dummy,
		POINT = hero:GetOrigin(), 
		HERO = hero,
		REVIVING = isbeingrevived,
		TIME = TIME_TO_REVIVE,
		PARTICLE = particle
	})
	-- Call the check and balance now that it has been initialised
	HeroStuff:CircleCheckIfHeroReviving(hero_index)
end

-- This is called to check if the hero is being revived and is recalled ever point until it is no longer needed
function HeroStuff:CircleCheckIfHeroReviving(hero_index)
	local i = 0
	local hero_num = -1
	for i=1,#CIRCLE_DATA do
		if(CIRCLE_DATA[i].INDEX == hero_index) then hero_num=i break end
	end
	local point = CIRCLE_DATA[hero_num].POINT
	--DebugPrint("Circle Check If Hero Reviving: Point")
	--DebugPrint(point)
	-- Check if someone is in range
	local heroes = BossAI:TargetsInRange(point,CIRCLE_RADIUS) -- Uses BossAi as it contains the helper functions
	if(#heroes>0)then
		CIRCLE_DATA[hero_num].REVIVING = true
	end
	-- Is the hero being revived?
	if(CIRCLE_DATA[hero_num].REVIVING) then
		-- Call circle timer running
		HeroStuff:CircleTimerRunning(hero_num)
	else
		if(CIRCLE_DATA[hero_num].TIME<TIME_TO_REVIVE) then
			CIRCLE_DATA[hero_num].TIME = CIRCLE_DATA[hero_num].TIME + 1
			HeroStuff:DrawCircleTimer(hero_num)
		end
  		-- Recurse this function
	    Timers:CreateTimer({
	        endTime = TIME_BETWEEN_CHECKS,
	      callback = function()
	        HeroStuff:CircleCheckIfHeroReviving(hero_num)
	      end
	    })	
	end
end

-- Runs whilst timing the revival process
function HeroStuff:CircleTimerRunning(hero_index)
	local i = 0
	local hero_num = -1
	for i=1,#CIRCLE_DATA do
		if(CIRCLE_DATA[i].INDEX == hero_index) then hero_num=i break end
	end
	local point = CIRCLE_DATA[hero_num].POINT
	-- Check if someone is in range
	CIRCLE_DATA[hero_num].REVIVING = false
	local heroes = BossAI:TargetsInRange(point,CIRCLE_RADIUS) -- Uses BossAi as it contains the helper functions
	if(#heroes>0)then
		CIRCLE_DATA[hero_num].REVIVING = true
	end

	if(CIRCLE_DATA[hero_num].REVIVING) then
		-- Reduce the timer and redraw the circle
		CIRCLE_DATA[hero_num].TIME = CIRCLE_DATA[hero_num].TIME - 1
		HeroStuff:DrawCircleTimer(hero_num)
		-- Check if the timer has been completed
		if(CIRCLE_DATA[hero_num].TIME<1)then
			-- Respawn the hero
			local hero = CIRCLE_DATA[hero_num].HERO
			hero:RespawnHero(false, false)
			SoundController:RespawnStinger(hero)
			SoundController:Hero_Revived(hero)
			-- Remove the circle
			ParticleManager:DestroyParticle(CIRCLE_DATA[hero_num].PARTICLE,true)
			UTIL_Remove(CIRCLE_DATA[hero_num].DUMMY)
			hero:SetHealth(math.floor(hero:GetMaxHealth()/4))
			hero:SetMana(math.floor(hero:GetMaxMana()/4))
			-- Remove this data from the data table
			table.remove(CIRCLE_DATA[hero_num])
			HEROES_BEING_REVIVED = HEROES_BEING_REVIVED -1
			-- Create and destroy a particle
			local particle = ParticleManager:CreateParticle(RESPAWN_PARTICLE, PATTACH_ABSORIGIN, hero)
		    Timers:CreateTimer({
		        endTime = 5,
		      callback = function()
				ParticleManager:DestroyParticle(particle,false)
		      end
		    })
		else
	  		-- Recurse this function
		    Timers:CreateTimer({
		        endTime = TIME_BETWEEN_CHECKS,
		      callback = function()
		        HeroStuff:CircleCheckIfHeroReviving(hero_num)
		      end
		    })
		end
	else
		-- Recall waiting period
	    Timers:CreateTimer({
	        endTime = TIME_BETWEEN_CHECKS,
	      callback = function()
	        HeroStuff:CircleCheckIfHeroReviving(hero_num)
	      end
	    })
	end
end

-- Graphic displaying time to revive
function HeroStuff:DrawCircleTimer(hero_num)
	local hero = CIRCLE_DATA[hero_num].HERO
	local midpoint = CIRCLE_DATA[hero_num].POINT
	local x = CIRCLE_X
	local y = CIRCLE_Y
	local height = CIRCLE_HEIGHT
	-- Draw background
	DebugDrawCircle(
		Vector(midpoint.x - x, midpoint.y - y, midpoint.z + height), -- pos
		Vector(0, 0, 0), -- colour
		255, -- alpha
		TIME_TO_REVIVE,
		false,
		TIME_CIRCLE_DRAWN
		)
	-- Draw foreground
	DebugDrawCircle(
		Vector(midpoint.x - x, midpoint.y - y, midpoint.z + height+1), -- pos
		Vector(0, 255, 255), -- colour
		255, -- alpha
		CIRCLE_DATA[hero_num].TIME,
		false,
		TIME_CIRCLE_DRAWN
		)
end