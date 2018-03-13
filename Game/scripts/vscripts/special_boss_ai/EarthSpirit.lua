-- Earth Spirit extends BOSS AI file
EarthSpirit_ABILITY1 = "earth_spirit_boulder_smash"
EarthSpirit_ABILITY2 = "earth_spirit_magnetize"
EarthSpirit_ABILITY3 = "earth_spirit_geomagnetic_grip"
EarthSpirit_ABILITY4 = "earth_spirit_rolling_boulder"
EarthSpirit_ABILITY5 = "earth_spirit_stone_caller"

-- EarthSpirit has three main abilities to be used in combat. 
	-- The first is to pull distant heroes towards him
	-- The second is to push close heroes away from him
	-- The third is to activate magnetize every so often

-- EarthSpirit has two portions to his fight.
	-- After dropping below 75% HP, starts using spirit stones
	-- After dropping below 25% HP, starts using rolling boulder to reach his current target

-- Init EarthSpirit Protector's Abilities
function BossAI:EarthSpiritInit()
	local boss = BOSSAI_CURRENT_BOSS
	local ability = nil
	-- Add Abilities
	ability = boss:AddAbility(EarthSpirit_ABILITY1)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(EarthSpirit_ABILITY2)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(EarthSpirit_ABILITY3)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(EarthSpirit_ABILITY4)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(EarthSpirit_ABILITY5)
	ability:SetLevel(BOSSAI_LEVEL)
	-- Set personality
	BOSSAI_CURRENT_PERSONALITY = BOSSAI_PERSONALITY.HONOURABLE
end

-- Cleanup the boss
function BossAI:EarthSpiritCleanup()
end

-- Special
function BossAI:EarthSpiritSpecial()
end	

-- Reaction
function BossAI:EarthSpiritReaction()
end	

-- This function runs for EarthSpirit Protector and handles their ability logic
function BossAI:EarthSpiritAbilityLogic()
	local boss = BOSSAI_CURRENT_BOSS
	local mode = BOSSAI_CURENT_MODE
	local target = BOSSAI_CURRENT_TARGET
	local ability = boss:FindAbilityByName(EarthSpirit_ABILITY1)
	-- Check if we can use Boulder Smash
	if(ability:IsCooldownReady())then
		-- Get the closest target
		local pot_close_target = BossAI:NearestTarget(boss:GetOrigin(), BossAI:TargetsInRange(boss:GetOrigin(),300, TheLastStand:GetFilterHeroTargets(true,true,true,true,true,boss)))
		if(pot_close_target~=nil) then
			-- Smack the closest target
			BossAI:SingleTarget(pot_close_target,EarthSpirit_ABILITY1,1,true)
		else
			-- Check if they're within range or exist
			if(target~=nil)then
				if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<300)then
					BossAI:SingleTarget(target,EarthSpirit_ABILITY1,1,true)
				end
			end
		end
	end
	ability = boss:FindAbilityByName(EarthSpirit_ABILITY2)
	-- Check if we can use Magnetize
	if(ability:IsCooldownReady())then
		BossAI:NoTarget(EarthSpirit_ABILITY2,2,true)
	end
	ability = boss:FindAbilityByName(EarthSpirit_ABILITY3)
	-- Check if we can use Geomagnetic Grip
	if(ability:IsCooldownReady())then
		-- Get the closest target
		local pot_dist_target = BossAI:FurthestTarget(boss:GetOrigin(), BossAI:TargetsInRange(boss:GetOrigin(),1100, TheLastStand:GetFilterHeroTargets(true,true,true,true,true,boss)))
		if(pot_dist_target~=nil) then
			-- Smack the closest target
			BossAI:SingleTarget(pot_dist_target,EarthSpirit_ABILITY3,3,true)
		else
			-- Check if they're within range or exist
			if(target~=nil)then
				if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<1100)then
					BossAI:SingleTarget(target,EarthSpirit_ABILITY3,3,true)
				end
			end
		end
	end
	ability = boss:FindAbilityByName(EarthSpirit_ABILITY4)
	-- Check if we can use Rolling Boulder
	if(ability:IsCooldownReady())and(BOSSAI_CURENT_MODE>2)and(target~=nil)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())>300)then
			BossAI:SingleTargetPosition(target,EarthSpirit_ABILITY4,4,false)
		end
	end
	ability = boss:FindAbilityByName(EarthSpirit_ABILITY5)
	-- Check if we can use Spirit Stones
	if(ability:IsCooldownReady())and(BOSSAI_CURENT_MODE>1)then
		BossAI:Position(BossAI:GetPointOnCircumference(TheLastStand:GetBossRadius(),TheLastStand:GetBossPoint()),EarthSpirit_ABILITY5,5,false)
		BossAI:EarthSpiritSpiritStones()
	end
end	

function BossAI:EarthSpiritModeChange()
	local mode = BOSSAI_CURENT_MODE
	local boss = BOSSAI_CURRENT_BOSS
	-- When we first enter mode 3, put bedlam on cd so she can talk
	if(mode==2) then
		boss:FindAbilityByName(EarthSpirit_ABILITY5):StartCooldown(2)
	end
	if(mode==3) then
		boss:FindAbilityByName(EarthSpirit_ABILITY4):StartCooldown(2)
	end
end