-- Text About Hero
Skywrath_ABILITY1 = "skywrath_mage_arcane_bolt"
Skywrath_ABILITY2 = "skywrath_mage_ancient_seal"
Skywrath_ABILITY3 = "skywrath_mage_mystic_flare"
Skywrath_ABILITY4 = "skywrath_mage_concussive_shot"




-- Init
function BossAI:SkywrathInit()
	local boss = BOSSAI_CURRENT_BOSS
	local ability = nil
	-- Add Abilities
	ability = boss:AddAbility(Skywrath_ABILITY1)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Skywrath_ABILITY2)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Skywrath_ABILITY3)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Skywrath_ABILITY4)
	ability:SetLevel(BOSSAI_LEVEL)
	-- Set personality
	BOSSAI_CURRENT_PERSONALITY = BOSSAI_PERSONALITY.STUBBORN
end

-- Cleanup the boss
function BossAI:SkywrathCleanup()
end

-- Reaction
function BossAI:SkywrathReaction()
end	

-- Special
function BossAI:SkywrathSpecial()
end

-- Ability Logic
function BossAI:SkywrathAbilityLogic()
	local boss = BOSSAI_CURRENT_BOSS
	local mode = BOSSAI_CURENT_MODE
	local target = BOSSAI_CURRENT_TARGET
	local ability = boss:FindAbilityByName(Skywrath_ABILITY1)
	-- Can use arcane bolt
	if(ability:IsCooldownReady())and(target~=nil)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<875)then
			BossAI:SingleTarget(target,Skywrath_ABILITY1,1,true)
		end
	end
	ability = boss:FindAbilityByName(Skywrath_ABILITY2)
	-- Can use ancient Seal
	if(ability:IsCooldownReady())and(target~=nil)and(mode>1)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<700)then
			BossAI:SingleTarget(target,Skywrath_ABILITY2,2,true)
		end
	end
	ability = boss:FindAbilityByName(Skywrath_ABILITY3)
	-- Can use arcane bolt
	if(ability:IsCooldownReady())and(target~=nil)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<1200)then
			BossAI:SingleTargetPosition(target,Skywrath_ABILITY3,3,true)
		end
	end
	ability = boss:FindAbilityByName(Skywrath_ABILITY4)
	-- Can use arcane bolt
	if(ability:IsCooldownReady())and(target~=nil)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<1600)then
			BossAI:NoTarget(Skywrath_ABILITY3,4,false)
		end
	end
end	

-- Mode Change
function BossAI:SkywrathModeChange()
	local mode = BOSSAI_CURENT_MODE
	local boss = BOSSAI_CURRENT_BOSS
	if(mode==2) then
		--Start using ancient seal
		boss:FindAbilityByName(Skywrath_ABILITY2):StartCooldown(2)
	end
	if(mode==3) then
		-- Give him scepter
		boss:AddItemByName("item_ultimate_scepter")
	end
end