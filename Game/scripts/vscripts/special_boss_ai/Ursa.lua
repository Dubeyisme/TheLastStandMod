-- Text About Hero
Ursa_ABILITY1 = "ursa_overpower"
Ursa_ABILITY2 = "ursa_earthshock"
Ursa_ABILITY3 = "ursa_enrage"
Ursa_ABILITY4 = "ursa_fury_swipes"




-- Init
function BossAI:UrsaInit()
	local boss = BOSSAI_CURRENT_BOSS
	local ability = nil
	-- Add Abilities
	ability = boss:AddAbility(Ursa_ABILITY1)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Ursa_ABILITY2)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Ursa_ABILITY3)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(Ursa_ABILITY4)
	ability:SetLevel(BOSSAI_LEVEL)
	-- Set personality
	BOSSAI_CURRENT_PERSONALITY = BOSSAI_PERSONALITY.STUBBORN
end

-- Cleanup the boss
function BossAI:UrsaCleanup()
end

-- Reaction
function BossAI:UrsaReaction()
	local ability = boss:FindAbilityByName(Ursa_ABILITY3)
	if(ability:IsCooldownReady())and(mode>2)then
		BossAI:NoTarget(Ursa_ABILITY3,3,true)
		BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.HUNTING
	end
end	

-- Special
function BossAI:UrsaSpecial()
	BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.HUNTING
  	ExecuteOrderFromTable({ UnitIndex = BOSSAI_CURRENT_BOSS:entindex(), OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, Position = TheLastStand:GetFinalPoint(), Queue = false})
end

-- Ability Logic
function BossAI:UrsaAbilityLogic()
	local boss = BOSSAI_CURRENT_BOSS
	local mode = BOSSAI_CURENT_MODE
	local target = BOSSAI_CURRENT_TARGET
	local ability = boss:FindAbilityByName(Ursa_ABILITY1)
	-- Can use overpower?
	if(ability:IsCooldownReady())then
		BossAI:NoTarget(Ursa_ABILITY1,1,true)
	end
	ability = boss:FindAbilityByName(Ursa_ABILITY2)
	-- Can use Earthshook
	if(ability:IsCooldownReady())and(target~=nil)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<350)then
			BossAI:NoTarget(Ursa_ABILITY2,2,true)
		end
	end
end	

-- Mode Change
function BossAI:UrsaModeChange()
	local mode = BOSSAI_CURENT_MODE
	local boss = BOSSAI_CURRENT_BOSS
	-- When we first enter mode 3, put bedlam on cd so she can talk
	if(mode==2) then
		-- We enable reaction
		boss:FindAbilityByName(Ursa_ABILITY3):StartCooldown(2)
	end
	if(mode==3) then
		-- Give him scepter
		boss:AddItemByName("item_ultimate_scepter")
		boss:FindAbilityByName(Ursa_ABILITY3):SetLevel(BOSSAI_LEVEL+1)
	end
end