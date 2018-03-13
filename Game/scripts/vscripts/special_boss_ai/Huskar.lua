-- Text About Hero
Huskar_ABILITY1 = "huskar_inner_vitality"
Huskar_ABILITY2 = "huskar_life_break"
Huskar_ABILITY3 = "huskar_berserkers_blood"
Huskar_ABILITY4 = "huskar_burning_spear"

-- Huskar has three abilities
	-- Life Break which he uses to latch on to new targets
	-- Berserker's Blood which he uses to grant attack speed and resistance, builds over time
	-- Burning Spears, which he starts using after the first mode change
-- Huskar also has Inner Vitality which he uses at every mode change and every time it is off cooldown after the second mode change


-- Init
function BossAI:HuskarInit()
	local boss = BOSSAI_CURRENT_BOSS
	local ability = nil
	-- Add Abilities
	ability = boss:AddAbility(Huskar_ABILITY1)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Huskar_ABILITY2)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Huskar_ABILITY3)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Huskar_ABILITY4)
	ability:SetLevel(BOSSAI_LEVEL)
	-- Set personality
	BOSSAI_CURRENT_PERSONALITY = BOSSAI_PERSONALITY.VINDICTIVE
end

-- Cleanup the boss
function BossAI:HuskarCleanup()
end

-- Reaction
function BossAI:HuskarReaction()
end	

-- Special
function BossAI:HuskarSpecial()
end

-- Ability Logic
function BossAI:HuskarAbilityLogic()
	local boss = BOSSAI_CURRENT_BOSS
	local mode = BOSSAI_CURENT_MODE
	local target = BOSSAI_CURRENT_TARGET
	local ability = boss:FindAbilityByName(Huskar_ABILITY1)
	-- Check if we can use Inner Vitality
	if(ability:IsCooldownReady())and(BOSSAI_CURENT_MODE>2)then
		BossAI:SingleTarget(boss,Huskar_ABILITY1,1,true)
	end
	ability = boss:FindAbilityByName(Huskar_ABILITY2)
	-- Check if we can use Life Break
	if(ability:IsCooldownReady())and(target~=nil)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<550)then
			BossAI:SingleTarget(target,Huskar_ABILITY2,2,true)
		end
	end
	ability = boss:FindAbilityByName(Huskar_ABILITY3)
	-- Check if we can use Berserker's Blood
	if(ability:IsCooldownReady())then
		BossAI:NoTarget(Huskar_ABILITY3,3,true)
	end
end	

-- Mode Change
function BossAI:HuskarModeChange()
	local mode = BOSSAI_CURENT_MODE
	local boss = BOSSAI_CURRENT_BOSS
	-- When we first enter mode 2, enable burning spears
	if(mode==2) then
		boss:FindAbilityByName(Huskar_ABILITY4):ToggleAutoCast()
		BossAI:SingleTarget(boss,Huskar_ABILITY1,1,true)
	end
	if(mode==3) then
		BossAI:SingleTarget(boss,Huskar_ABILITY1,1,true)
	end
end