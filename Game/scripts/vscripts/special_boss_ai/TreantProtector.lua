-- Treant protector BOSS AI file


-- Treant has three main abilities to be used in combat. 
	-- The first is the ability to silence other players as they attempt to use abilities.
	-- The second is the ability to root players.
	-- The third is to cast Leech seed on whoever his main target is at the time if they are within range, and switch targets if they are not.

-- Treant has a second portion to the boss fight, after hitting 25% HP he gains a massive boost to HP regeneration and armour, but becomes more susceptable to magic damage.





-- Silences a target for 5 seconds, Treant will use first ability slot for sound.
function BossAI:TreantSilence(boss, target)
	-- MODIFIER_STATE_SILENCED
	--target:AddNewModifier(boss, nil, MODIFIER_STATE_SILENCED, {true})
	BOSSAI_ABILITY_COOLDOWN[1] = 10
    Timers:CreateTimer({
        endTime = 5,
      callback = function()
        --target:RemoveModifierByName
      end
    })	
	-- Call the sound for this ability
	SoundController:Villain_AbilityUsed(boss, 1)
end

-- Silences a target for 5 seconds, Treant will use second ability slot for sound.
function BossAI:TreantLeechSeed(boss, target)

	-- Call the sound for this ability
	SoundController:Villain_AbilityUsed(boss, 2)
end

-- Silences a target for 5 seconds, Treant will use third ability slot for sound.
function BossAI:TreantRoot(boss, target)

	-- Call the sound for this ability
	SoundController:Villain_AbilityUsed(boss, 3)
end