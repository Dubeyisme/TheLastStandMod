-- Text About Hero
Undying_ABILITY1 = "undying_tombstone"
Undying_ABILITY2 = "undying_decay"
Undying_ABILITY3 = "undying_soul_rip"
Undying_ABILITY4 = "undying_flesh_golem"




-- Init
function BossAI:UndyingInit()
	local boss = BOSSAI_CURRENT_BOSS
	local ability = nil
	-- Add Abilities
	ability = boss:AddAbility(Undying_ABILITY1)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Undying_ABILITY2)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Undying_ABILITY3)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Undying_ABILITY4)
	ability:SetLevel(BOSSAI_LEVEL)
	-- Set personality
	BOSSAI_CURRENT_PERSONALITY = BOSSAI_PERSONALITY.OPPORTUNIST
end

-- Cleanup the boss
function BossAI:UndyingCleanup()
end

-- Reaction
function BossAI:UndyingReaction()
end	

-- Special
function BossAI:UndyingSpecial()
end

-- Ability Logic
function BossAI:UndyingAbilityLogic()
	local boss = BOSSAI_CURRENT_BOSS
	local mode = BOSSAI_CURENT_MODE
	local target = BOSSAI_CURRENT_TARGET
	local ability = boss:FindAbilityByName(Undying_ABILITY1)
	-- Check if we can use Tombstone
	if(ability:IsCooldownReady())then
		BossAI:Position(BossAI:GetPointOnCircumference(TheLastStand:GetBossRadius(),TheLastStand:GetBossPoint()),Undying_ABILITY1,1,true)
	end
	ability = boss:FindAbilityByName(Undying_ABILITY2)
	-- Check if we can use Decay
	if(ability:IsCooldownReady())and(target~=nil)and(mode>1)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<650)then
			BossAI:SingleTargetPosition(target,Undying_ABILITY2,2,true)
		end
	end
	ability = boss:FindAbilityByName(Undying_ABILITY3)
	-- Check if we can use Soul Rip
	if(ability:IsCooldownReady())andthen
		-- Do we want to use this on ourselves?
		if(boss:GetHealth()/boss:GetMaxHealth()>0.5)or(target==nil)then
			-- Use it on ourselves
			BossAI:SingleTargetPosition(boss,Undying_ABILITY3,3,true)
		else
			if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<750)then
				BossAI:SingleTargetPosition(target,Undying_ABILITY3,3,true)
			end
		end
	end
	ability = boss:FindAbilityByName(Undying_ABILITY4)
	-- Check if we can use Flesh Golem
	if(ability:IsCooldownReady())and(mode>2)then
		BossAI:NoTarget(Undying_ABILITY4,4,false)
	end
end	

-- Mode Change
function BossAI:UndyingModeChange()
	local mode = BOSSAI_CURENT_MODE
	local boss = BOSSAI_CURRENT_BOSS
	if(mode==2) then
		boss:FindAbilityByName(Undying_ABILITY2):StartCooldown(2)
	end
	if(mode==3) then
		boss:FindAbilityByName(Undying_ABILITY4):StartCooldown(2)
	end
end

		

