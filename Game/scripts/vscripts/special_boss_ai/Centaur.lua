-- Text About Hero
Centaur_ABILITY1 = "centaur_double_edge"
Centaur_ABILITY2 = "centaur_hoof_stomp"
Centaur_ABILITY3 = "centaur_stampede"
Centaur_ABILITY4 = "centaur_return"




-- Init
function BossAI:CentaurInit()
	local boss = BOSSAI_CURRENT_BOSS
	local ability = nil
	-- Add Abilities
	ability = boss:AddAbility(Centaur_ABILITY1)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Centaur_ABILITY2)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Centaur_ABILITY3)
	ability:SetLevel(BOSSAI_LEVEL)
	-- Set personality
	BOSSAI_CURRENT_PERSONALITY = BOSSAI_PERSONALITY.HONOURABLE
end

-- Cleanup the boss
function BossAI:CentaurCleanup()
end

-- Reaction
function BossAI:CentaurReaction()
end	

-- Special
function BossAI:CentaurSpecial()
end

-- Ability Logic
function BossAI:CentaurAbilityLogic()
	local boss = BOSSAI_CURRENT_BOSS
	local mode = BOSSAI_CURENT_MODE
	local target = BOSSAI_CURRENT_TARGET
	local ability = boss:FindAbilityByName(Centaur_ABILITY1)
	-- Use double edge
	if(ability:IsCooldownReady())and(BOSSAI_CURENT_MODE>2)and(target~=nil)then
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<200)then
			BossAI:SingleTarget(target,Centaur_ABILITY1,1,true)
		end
	end
	ability = boss:FindAbilityByName(Centaur_ABILITY2)
	-- Check if we can use Overgrowth
	if(ability:IsCooldownReady())and(target~=nil)then
		-- Check if they're within range
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<300)then
			BossAI:NoTarget(Centaur_ABILITY2,2,true)
		end
	end
	ability = boss:FindAbilityByName(Centaur_ABILITY3)
	-- Check if we can use Overgrowth
	if(ability:IsCooldownReady())then
		BossAI:NoTarget(Centaur_ABILITY3,3,true)
	end
end	

-- Mode Change
function BossAI:CentaurModeChange()
	local mode = BOSSAI_CURENT_MODE
	local boss = BOSSAI_CURRENT_BOSS
	if(mode==2) then
		-- Gain return
		ability = boss:AddAbility(Centaur_ABILITY4)
		ability:SetLevel(BOSSAI_LEVEL)
	end
	if(mode==3) then
		-- Start using double edge, increase healing rate to compensate
		boss:SetBaseHealthRegen(boss:GetHealthRegen()+(2.75)*BOSSAI_LEVEL*TheLastStand:GetMultiplier())
		boss:FindAbilityByName(Centaur_ABILITY1):StartCooldown(2)
	end
end