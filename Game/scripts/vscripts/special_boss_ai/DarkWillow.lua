-- DarkWillow extends BOSS AI file
DarkWillow_ABILITY1 = "dark_willow_bramble_maze"
DarkWillow_ABILITY2 = "dark_willow_cursed_crown"
DarkWillow_ABILITY3 = "dark_willow_shadow_realm"
DarkWillow_ABILITY4 = "dark_willow_bedlam"

-- DarkWillow has three main abilities to be used in combat. 
	-- The first is the ability to become invisible whenever she switches targets and hunting down her new target after travelling away for a bit
	-- Also part of the first is if too many heroes are close to her, she'll go invisible and flee after rooting the heroes who were close. (3 or more heroes triggers this)
	-- The second is the ability to create a sudden bramble maze around the area. If a player comes within range, they are stunned

-- DarkWillow has a second portion to the boss fight, after hitting 25% HP she starts creating illusions of herself after going invisible and sending those illusions to attack the 
-- other players [Ability 3 replaces ability 1]

-- Init DarkWillow Protector's Abilities
function BossAI:DarkWillowInit()
	local boss = BOSSAI_CURRENT_BOSS
	local ability = nil
	-- Add Abilities
	ability = boss:AddAbility(DarkWillow_ABILITY1)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(DarkWillow_ABILITY2)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(DarkWillow_ABILITY3)
	ability:SetLevel(BOSSAI_LEVEL)
	ability:StartCooldown(6) -- Make sure we don't use this immediately
	ability = boss:AddAbility(DarkWillow_ABILITY4)
	ability:SetLevel(BOSSAI_LEVEL)
	-- Set personality
	BOSSAI_CURRENT_PERSONALITY = BOSSAI_PERSONALITY.RANDOM
end

-- Cleanup the boss
function BossAI:DarkWillowCleanup()
		BOSSAI_DATA.SPECIAL = {}
end

-- Reaction
function BossAI:DarkWillowReaction()
end	

-- This function runs for DarkWillow Protector and handles their ability logic
function BossAI:DarkWillowAbilityLogic()
	local boss = BOSSAI_CURRENT_BOSS
	local mode = BOSSAI_CURENT_MODE
	local target = BOSSAI_CURRENT_TARGET
	local ability = boss:FindAbilityByName(DarkWillow_ABILITY1)
	-- Check if we can use Bramble Maze
	if(ability:IsCooldownReady())and(target~=nil)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<1200)then
			BossAI:SingleTargetPosition(target,DarkWillow_ABILITY1,1,true)
		end
	end
	ability = boss:FindAbilityByName(DarkWillow_ABILITY2)
	-- Check if we can use Cursed Crown
	if(ability:IsCooldownReady())and(BOSSAI_CURENT_MODE>1)and(target~=nil)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<600)then
			BossAI:SingleTarget(target,DarkWillow_ABILITY2,2,true)
		end
	end
	ability = boss:FindAbilityByName(DarkWillow_ABILITY3)
	-- Check if we can use Shadow Realm
	if(ability:IsCooldownReady())then
		-- Check if they're within range or exist
		BossAI:DarkWillowShadowRealm()
	end
	ability = boss:FindAbilityByName(DarkWillow_ABILITY4)
	-- Check if we can use Shadow Realm
	if(ability:IsCooldownReady())and(BOSSAI_CURENT_MODE>2)then
		-- Check if they're within range or exist
		BossAI:NoTarget(DarkWillow_ABILITY4,4,true)
	end
end

function BossAI:DarkWillowSpecial()
	-- Reduce time
	BOSSAI_DATA.SPECIAL.TIME = BOSSAI_DATA.SPECIAL.TIME-1
	if(BOSSAI_DATA.SPECIAL.MOVING==false)then
		BOSSAI_DATA.SPECIAL.MOVING=true
		ExecuteOrderFromTable({ UnitIndex = BOSSAI_CURRENT_BOSS:entindex(), OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION, Position=BOSSAI_DATA.SPECIAL.POSITION, Queue = false})
	end
	-- End the current special status
	if(BOSSAI_DATA.SPECIAL.TIME<1)then
  		BOSSAI_CURRENT_BOSS.disable_autoattack = 0
  		-- Put DW into hunting mode
		BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.HUNTING
		BOSSAI_DATA.SPECIAL = {}
	end
end		

function BossAI:DarkWillowModeChange()
	local mode = BOSSAI_CURENT_MODE
	local boss = BOSSAI_CURRENT_BOSS
	-- When we first enter mode 3, put bedlam on cd so she can talk
	if(mode==2) then
		boss:FindAbilityByName(DarkWillow_ABILITY2):StartCooldown(2)
	end
	if(mode==3) then
		boss:FindAbilityByName(DarkWillow_ABILITY4):StartCooldown(2)
	end
end

-- Enter the shadow realm and leave the vicinity
function BossAI:DarkWillowShadowRealm()
	--DebugPrint("Using Shadow Realm")
	local boss = BOSSAI_CURRENT_BOSS
	local ability = boss:FindAbilityByName(DarkWillow_ABILITY3)
	local position = BossAI:GetPointOnCircumference(TheLastStand:GetBossRadius(),TheLastStand:GetBossPoint())
	local time = 3
	-- Prep data and disable auto attack
	BOSSAI_DATA.SPECIAL = {POSITION=position,TIME=time,MOVING=false}
  	boss.disable_autoattack = 1
	-- Call the sound for this ability
	SoundController:Villain_AbilityUsed(boss, 3)
	-- We are going to control the boss ai for a while
	BOSSAI_CURRENT_STATE = BOSSAI_AI_STATE.SPECIAL
	-- Execute Ability
	ExecuteOrderFromTable({ UnitIndex = boss:entindex(), OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET, AbilityIndex = ability:entindex(), Queue = false})
end