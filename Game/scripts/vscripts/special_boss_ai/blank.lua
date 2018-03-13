-- Text About Hero
BossName_ABILITY1 = ""
BossName_ABILITY2 = ""
BossName_ABILITY3 = ""
BossName_ABILITY4 = ""




-- Init
function BossAI:BossNameInit()
	local boss = BOSSAI_CURRENT_BOSS
	local ability = nil
	-- Add Abilities
	ability = boss:AddAbility(BossName_ABILITY1)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(BossName_ABILITY2)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(BossName_ABILITY3)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(BossName_ABILITY4)
	ability:SetLevel(BOSSAI_LEVEL)
	-- Set personality
	BOSSAI_CURRENT_PERSONALITY = BOSSAI_PERSONALITY.RANDOM
end

-- Cleanup the boss
function BossAI:BossNameCleanup()
end

-- Reaction
function BossAI:BossNameReaction()
end	

-- Special
function BossAI:BossNameSpecial()
end

-- Ability Logic
function BossAI:BossNameAbilityLogic()
	local boss = BOSSAI_CURRENT_BOSS
	local mode = BOSSAI_CURENT_MODE
	local target = BOSSAI_CURRENT_TARGET
	local ability = boss:FindAbilityByName(BossName_ABILITY1)
end	

-- Mode Change
function BossAI:BossNameModeChange()
	local mode = BOSSAI_CURENT_MODE
	local boss = BOSSAI_CURRENT_BOSS
	-- When we first enter mode 3, put bedlam on cd so she can talk
	if(mode==2) then
	end
	if(mode==3) then
	end
end