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

-- Special
function BossAI:TreantSpecial()
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
			BossAI:SingleTarget(target,TREANT_ABILITY2,2,true)
		end
	else
		ability = boss:FindAbilityByName(TREANT_ABILITY3)
		-- Check if we can use Overgrowth
		if(ability:IsCooldownReady())and(target~=nil)then
			-- Check if they're within range
			if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<400)then
				BossAI:NoTarget(TREANT_ABILITY3,3,true)
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

function BossAI:TreantReaction()
	-- Are we even able to use it?
	local boss = BOSSAI_CURRENT_BOSS
	local ability = boss:FindAbilityByName(TREANT_ABILITY1)
	if(ability:IsCooldownReady())and(BOSSAI_REACTION_TARGET:IsInvisible()==false)and(BOSSAI_REACTION_TARGET:IsInvulnerable()==false)and(BOSSAI_REACTION_TARGET:IsAlive())then
		DebugPrint("Hero in range?")
		local targetpos = BOSSAI_REACTION_TARGET:GetOrigin()
		local bosspos = boss:GetOrigin()
		if(BossAI:TargetDistance(targetpos, bosspos)<1500)then
			BossAI:SingleTarget(BOSSAI_REACTION_TARGET,TREANT_ABILITY1,1,true)
		end
	end
end