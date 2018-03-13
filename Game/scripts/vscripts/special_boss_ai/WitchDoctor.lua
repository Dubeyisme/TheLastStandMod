-- Text About Hero
WitchDoctor_ABILITY1 = "witch_doctor_paralyzing_cask"
WitchDoctor_ABILITY2 = "witch_doctor_maledict"
WitchDoctor_ABILITY3 = "witch_doctor_death_ward"
WitchDoctor_ABILITY4 = "witch_doctor_voodoo_restoration"




-- Init
function BossAI:WitchDoctorInit()
	local boss = BOSSAI_CURRENT_BOSS
	local ability = nil
	-- Add Abilities
	ability = boss:AddAbility(WitchDoctor_ABILITY1)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(WitchDoctor_ABILITY2)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(WitchDoctor_ABILITY3)
	ability:SetLevel(BOSSAI_LEVEL)
	ability = boss:AddAbility(WitchDoctor_ABILITY4)
	ability:SetLevel(BOSSAI_LEVEL)
	-- Set personality
	BOSSAI_CURRENT_PERSONALITY = BOSSAI_PERSONALITY.VINDICTIVE
end

-- Cleanup the boss
function BossAI:WitchDoctorCleanup()
end

-- Reaction
function BossAI:WitchDoctorReaction()
end	

-- Special
function BossAI:WitchDoctorSpecial()
end

-- Ability Logic
function BossAI:WitchDoctorAbilityLogic()
	local boss = BOSSAI_CURRENT_BOSS
	local mode = BOSSAI_CURENT_MODE
	local target = BOSSAI_CURRENT_TARGET
	local ability = boss:FindAbilityByName(WitchDoctor_ABILITY1)
	-- Check if we can cast cask
	if(ability:IsCooldownReady())and(target~=nil)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<700)then
			BossAI:SingleTarget(target,WitchDoctor_ABILITY1,1,true)
		end
	end
	ability = boss:FindAbilityByName(WitchDoctor_ABILITY3)
	-- Check if we can cast cask
	if(ability:IsCooldownReady())and(target~=nil)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<600)then
			BossAI:SingleTargetPosition(target,WitchDoctor_ABILITY3,3,true)
		end
	end
	ability = boss:FindAbilityByName(WitchDoctor_ABILITY2)
	-- Check if we can cast maledict
	if(ability:IsCooldownReady())and(target~=nil)and(mode>1)then
		-- Check if they're within range or exist
		if(BossAI:TargetDistance(target:GetOrigin(), boss:GetOrigin())<575)then
			BossAI:SingleTargetPosition(target,WitchDoctor_ABILITY2,2,true)
		end
	end
end	

-- Mode Change
function BossAI:WitchDoctorModeChange()
	local mode = BOSSAI_CURENT_MODE
	local boss = BOSSAI_CURRENT_BOSS
	if(mode==2) then
		boss:FindAbilityByName(WitchDoctor_ABILITY2):StartCooldown(2)
	end
	if(mode==3) then
		BossAI:Toggle(WitchDoctor_ABILITY4,4,false)
	end
end