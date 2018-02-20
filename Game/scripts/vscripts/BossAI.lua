-- This contains a number of useful AI fetchers, sorters, and modes for the specialised AI packages to use

-- Create an instance of this class
if BossAI == nil then
    DebugPrint( '[TLS] creating Boss AI' )
    _G.BossAI = class({})
end

-----------------------------------------------------------------------------------------
-- Special AI data for each individual boss
-----------------------------------------------------------------------------------------
-- require('special_boss_ai/TreantProtector')
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
-- Distance Calculators
-----------------------------------------------------------------------------------------

	-- Returns the closest enemy hero handle
	function BossAI:NearestTarget(boss_unit_point)
		local i=0
		local targetposlist = {}
		local returndist = 100000
		local targetdistlist = {}
		local pointi = -1
		-- Fetch the positions of each enemy hero
		for i=0,#HERO_TARGETS do
			table.insert(targetposlist,HERO_TARGETS[i]:GetOrigin()
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistance(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=0,#HERO_TARGETS do
			if(returndist>targetdistlist[i])then
				returndist = targetdistlist[i]
				pointi = i
			end
		end
		return HERO_TARGETS[pointi]
	end

	-- Returns the furthest enemy hero handle
	function BossAI:FurthestTarget(boss_unit_point)
		local i=0
		local targetposlist = {}
		local returndist = 0
		local targetdistlist = {}
		local pointi = -1
		-- Fetch the positions of each enemy hero
		for i=0,#HERO_TARGETS do
			table.insert(targetposlist,HERO_TARGETS[i]:GetOrigin()
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistance(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=0,#HERO_TARGETS do
			if(returndist<targetdistlist[i])then
				returndist = targetdistlist[i]
				pointi = i
			end
		end
		return HERO_TARGETS[pointi]
	end

	-- Returns a list of enemy hero handles that are closer than dist
	function BossAI:TargetsInRange(boss_unit_point,rangedist)
		local i=0
		local targetposlist = {}
		local targetdistlist = {}
		local returnlist = {}
		-- Fetch the positions of each enemy hero
		for i=0,#HERO_TARGETS do
			table.insert(targetposlist,HERO_TARGETS[i]:GetOrigin()
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistance(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=0,#HERO_TARGETS do
			if(rangedist>=targetdistlist[i])then
				table.insert(returnlist,HERO_TARGETS[i])
			end
		end
		return returnlist
	end

	-- Returns a list of enemy hero handles that are further than dist
	function BossAI:TargetsOutOfRange(boss_unit_point,rangedist)
		local i=0
		local targetposlist = {}
		local targetdistlist = {}
		local returnlist = {}
		-- Fetch the positions of each enemy hero
		for i=0,#HERO_TARGETS do
			table.insert(targetposlist,HERO_TARGETS[i]:GetOrigin()
		end
		-- Fetch the distance between each enemy hero
		targetdistlist = BossAI:TargetDistance(targetposlist,boss_unit_point)
		-- Work out which is the closest target
		for i=0,#HERO_TARGETS do
			if(rangedist<targetdistlist[i])then
				table.insert(returnlist,HERO_TARGETS[i])
			end
		end
		return returnlist
	end

	-- Takes an array of target vectors and a starting vector and returns a list of distances
	function BossAI:TargetDistance(targetposlist, startpos)
		local i=0
		local returnlist = {}
		local x1,y1
		local x2 = startpos['x']
		local y2 = startpos['y']
		for i=0,#targetposlist do
			x1 = targetposlist[i]['x']
			y1 = targetposlist[i]['y']
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
		local i = 0
		for i=0,#HERO_TARGETS do
			if(HERO_TARGETS[i]:IsAlive()) then
				table.insert(returnlist,{i,HERO_TARGETS[i]:GetHealth()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the HP Percentage of the remaining heroes.
	function BossAI:GetTargetsHPPercent()
		local returnlist = {}
		local i = 0
		for i=0,#HERO_TARGETS do
			if(HERO_TARGETS[i]:IsAlive()) then
				table.insert(returnlist,{i,HERO_TARGETS[i]:GetHealth()/HERO_TARGETS[i]:GetMaxHealth()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the MP of the remaining heroes.
	function BossAI:GetTargetsMP()
		local returnlist = {}
		local i = 0
		for i=0,#HERO_TARGETS do
			if(HERO_TARGETS[i]:IsAlive()) then
				table.insert(returnlist,{i,HERO_TARGETS[i]:GetMana()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the HP Percentage of the remaining heroes.
	function BossAI:GetTargetsMPPercent()
		local returnlist = {}
		local i = 0
		for i=0,#HERO_TARGETS do
			if(HERO_TARGETS[i]:IsAlive()) then
				table.insert(returnlist,{i,HERO_TARGETS[i]:GetMana()/HERO_TARGETS[i]:GetMaxMana()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the move speed of the remaining heroes.
	function BossAI:GetTargetsMoveSpeed()
		local returnlist = {}
		local i = 0
		for i=0,#HERO_TARGETS do
			if(HERO_TARGETS[i]:IsAlive()) then
				table.insert(returnlist,{i,HERO_TARGETS[i]:GetIdealSpeed()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the attack ranges of the remaining heroes.
	function BossAI:GetTargetsAttackRange()
		local returnlist = {}
		local i = 0
		for i=0,#HERO_TARGETS do
			if(HERO_TARGETS[i]:IsAlive()) then
				table.insert(returnlist,{i,HERO_TARGETS[i]:GetBaseAttackRange()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the physical resistance of the remaining heroes.
	function BossAI:GetTargetsArmor()
		local returnlist = {}
		local i = 0
		for i=0,#HERO_TARGETS do
			if(HERO_TARGETS[i]:IsAlive()) then
				table.insert(returnlist,{i,HERO_TARGETS[i]:GetPhysicalArmorValue()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the magical resistance of the remaining heroes.
	function BossAI:GetTargetsMagicResist()
		local returnlist = {}
		local i = 0
		for i=0,#HERO_TARGETS do
			if(HERO_TARGETS[i]:IsAlive()) then
				table.insert(returnlist,{i,HERO_TARGETS[i]:GetMagicalArmorValue()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the primary attributes of the remaining heroes.
	function BossAI:GetTargetsPrimaryAttribute()
		local returnlist = {}
		local i = 0
		for i=0,#HERO_TARGETS do
			if(HERO_TARGETS[i]:IsAlive()) then
				table.insert(returnlist,{i,HERO_TARGETS[i]:GetPrimaryAttribute()})
			end
		end
		return returnlist
	end

	-- Returns a list of key pairs with the ID and the current banked gold of the remaining heroes.
	function BossAI:GetTargetsGold()
		local returnlist = {}
		local i = 0
		for i=0,#HERO_TARGETS do
			if(HERO_TARGETS[i]:IsAlive()) then
				table.insert(returnlist,{i,HERO_TARGETS[i]:GetGold()})
			end
		end
		return returnlist
	end
