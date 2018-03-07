-- Treant protector extends BOSS AI file


-- Treant has three main abilities to be used in combat. 
	-- The first is the ability to silence other players as they attempt to use abilities.
	-- The second is the ability to root players.
	-- The third is to cast Leech seed on whoever his main target is at the time if they are within range, and switch targets if they are not.

-- Treant has a second portion to the boss fight, after hitting 25% HP he gains a massive boost to HP regeneration and armour, but becomes more susceptable to magic damage.

-- Init Treant Protector's Abilities
function BossAI:TreantInit()
	local boss = BOSSAI_CURRENT_BOSS
	local ability = nil
	-- Add Abilities
	ability = boss:AddAbility("treant_ability_silence")
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility("treant_leech_seed")
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility("treant_overgrowth")
	ability:SetLevel(BOSSAI_LEVEL)
	-- Set personality
	BOSSAI_CURRENT_PERSONALITY = BOSSAI_PERSONALITY.VINDICTIVE
end

-- This function runs for Treant Protector and handles their ability logic
function BossAI:TreantAbilityLogic()
	local boss = BOSSAI_CURRENT_BOSS
	local target = BOSSAI_CURRENT_TARGET
	local ability = boss:FindAbilityByName("treant_leech_seed")
	-- Check if we can use Leech Seed
	if(ability:IsCooldownReady())then
		-- Check if they're within range or exist
		if(target~=nil)then
			if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<350)then
				BossAI:TreantLeechSeed(target)
			end
		end
	end
	local ability = boss:FindAbilityByName("treant_overgrowth")
	-- Check if we can use Overgrowth
	if(ability:IsCooldownReady())then
		-- Check if they're within range or exist
		if(target~=nil)then
			if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<400)then
				BossAI:TreantRoot()
			end
		end
	end
end

function BossAI:TreantModeChange()
	local mode = BOSSAI_CURENT_MODE
	local boss = BOSSAI_CURRENT_BOSS
	-- Increase regeneration of Treant
	if(mode==3) then
		boss:SetBaseHealthRegen(boss:GetHealthRegen()+(4)*BOSSAI_LEVEL)
		boss:SetPhysicalArmorBaseValue(boss:GetPhysicalArmorBaseValue()+(4)*BOSSAI_LEVEL)
	end
end

function BossAI:TreantHeroCastAbility()
	-- Are we even able to use it?
	local boss = BOSSAI_CURRENT_BOSS
	local ability = boss:FindAbilityByName("treant_ability_silence")
	if(ability:IsCooldownReady())then
		DebugPrint("Hero in range?")
		local targetpos = BOSSAI_REACTION_TARGET:GetOrigin()
		local bosspos = BOSSAI_CURRENT_BOSS:GetOrigin()
		local abilityrange = 1500
		if(BossAI:TargetDistance(targetpos, bosspos)<abilityrange)then
			BossAI:TreantSilence(BOSSAI_REACTION_TARGET)
		end
	end
end

-- Silences a target for 5 seconds, Treant will use first ability slot for sound.
function BossAI:TreantSilence(target)
	DebugPrint("Using Silence")
	local boss = BOSSAI_CURRENT_BOSS
	local ability = boss:FindAbilityByName("treant_ability_silence")
	-- Call the sound for this ability
	SoundController:Villain_AbilityUsed(boss, 1)
	-- Let them know we're busy
	BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.CASTING
	-- Execute Ability
	ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_CAST_TARGET,TargetIndex = target:entindex(), AbilityIndex = ability:entindex(), Queue = false})
end

-- Leech Seeds a target, Treant will use second ability slot for sound.
function BossAI:TreantLeechSeed(target)
	local boss = BOSSAI_CURRENT_BOSS
	local ability = boss:FindAbilityByName("treant_leech_seed")
	-- Call the sound for this ability
	SoundController:Villain_AbilityUsed(boss, 2)
	-- Let them know we're busy
	BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.CASTING
	-- Execute Ability
	ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_CAST_TARGET,TargetIndex = target:entindex(), AbilityIndex = ability:entindex(), Queue = false})
end

-- Roots everyone near treant for 3 seconds, Treant will use third ability slot for sound.
function BossAI:TreantRoot()
	local boss = BOSSAI_CURRENT_BOSS
	local ability = boss:FindAbilityByName("treant_overgrowth")
	-- Call the sound for this ability
	SoundController:Villain_AbilityUsed(boss, 3)
	-- Let them know we're busy
	BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.CASTING
	-- Execute Ability
	ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET, AbilityIndex = ability:entindex(), Queue = false})
end