-- Treant protector extends BOSS AI file
TREANT_ABILITY1 = "treant_ability_silence"
TREANT_ABILITY2 = "treant_leech_seed"
TREANT_ABILITY3 = "treant_overgrowth"

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
	ability = boss:AddAbility(TREANT_ABILITY1)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(TREANT_ABILITY2)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(TREANT_ABILITY3)
	ability:SetLevel(BOSSAI_LEVEL)
	-- Set personality
	BOSSAI_CURRENT_PERSONALITY = BOSSAI_PERSONALITY.OPPORTUNIST
end

-- Cleanup the boss
function BossAI:TreantCleanup()
	local effecttable = BOSSAI_DATA.EFFECT
	local i=0
	if(effect~=nil)then
		for i=1,#effecttable do
			ParticleManager:DestroyParticle(effecttable[i], true)
		end
	end
end

-- This function runs for Treant Protector and handles their ability logic
function BossAI:TreantAbilityLogic()
	local boss = BOSSAI_CURRENT_BOSS
	local target = BOSSAI_CURRENT_TARGET
	local ability = boss:FindAbilityByName(TREANT_ABILITY2)
	-- Check if we can use Leech Seed
	if(ability:IsCooldownReady())and(target~=nil)then
		-- Check if they're within range
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<350)then
			BossAI:TreantLeechSeed(target)
		end
	else
		ability = boss:FindAbilityByName(TREANT_ABILITY3)
		-- Check if we can use Overgrowth
		if(ability:IsCooldownReady())and(target~=nil)then
			-- Check if they're within range
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
		boss:SetBaseHealthRegen(boss:GetHealthRegen()+(1.75)*BOSSAI_LEVEL*TheLastStand:GetMultiplier())
		boss:SetPhysicalArmorBaseValue(boss:GetPhysicalArmorBaseValue()+(0.6)*BOSSAI_LEVEL*TheLastStand:GetMultiplier())
		local effect = ParticleManager:CreateParticle("particles/units/heroes/hero_treant/treant_livingarmor.vpcf",PATTACH_ABSORIGIN_FOLLOW,boss)
		table.insert(BOSSAI_DATA.EFFECT,effect)
	end
end

function BossAI:TreantHeroCastAbility()
	-- Are we even able to use it?
	local boss = BOSSAI_CURRENT_BOSS
	local ability = boss:FindAbilityByName(TREANT_ABILITY1)
	if(ability:IsCooldownReady())and(BOSSAI_REACTION_TARGET:IsInvisible()==false)and(BOSSAI_REACTION_TARGET:IsInvulnerable()==false)and(BOSSAI_REACTION_TARGET:IsAlive())then
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
	local ability = boss:FindAbilityByName(TREANT_ABILITY1)
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
	local ability = boss:FindAbilityByName(TREANT_ABILITY2)
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
	local ability = boss:FindAbilityByName(TREANT_ABILITY3)
	-- Call the sound for this ability
	SoundController:Villain_AbilityUsed(boss, 3)
	-- Let them know we're busy
	BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.CASTING
	-- Execute Ability
	ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET, AbilityIndex = ability:entindex(), Queue = false})
end