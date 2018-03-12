
UNITABILITIES_GOLEM_INIT_LIST = {"npc_dota_neutral_mud_golem","npc_dota_neutral_rock_golem","npc_dota_neutral_granite_golem"}

UNITABILITIES_GOLEM_SPAWN_LIST = {"npc_dota_neutral_mud_golem_split","npc_dota_neutral_mud_golem","npc_dota_neutral_rock_golem"}



if UnitAbilities == nil then
    DebugPrint( '[TLS] creating game mode' )
    _G.UnitAbilities = class({})
end

function UnitAbilities:CheckActionOnDeath(_died)
	local i=0
	-- Check if this unit was the fort
	if _died:GetUnitName() == "npc_dota_goodguys_fort" then
	  -- The enemies win, you are defeated
	end
	-- Check if this unit was a golem
	for i=1, #UNITABILITIES_GOLEM_INIT_LIST do
		if(_died:GetUnitName()==UNITABILITIES_GOLEM_INIT_LIST[i])then
			UnitAbilities:GolemSpawner(_died, i)
			break
		end
	end

	-- Call a check to see if we need to remove it from the wave count
	if(TheLastStand:RemoveFromWaveContent(_died) == false) then
		-- This unit was not part of the wave, is there more we need to do?
	else
		-- This unit was part of the wave and has been removed from the table, is there more we need to do?

		-- If this is a boss wave, gift the heroes a bonus pot of gold and xp
		if (TheLastStand:GetCurrentWave()==4) then
			TheLastStand:GiftGoldAndXP()
		end
	end
	-- No actions required
end


function UnitAbilities:GolemSpawner(_died, _num)
	local unit = nil
	local i = -1
	for i=1,2 do
		if(_died:GetTeam()==DOTA_TEAM_BADGUYS)then
			unit = TheLastStand:CreateWaveUnitAtPlace(UNITABILITIES_GOLEM_SPAWN_LIST[_num], _died:GetOrigin(), nil, _died:GetTeam(), true, false)
		else
  			unit = CreateUnitByName(UNITABILITIES_GOLEM_SPAWN_LIST[_num], _died:GetOrigin(), true, _died:GetOwner(), _died:GetOwner(), _died:GetTeam(), false)
  			TheLastStand:UpgradeCreep(unit)
		end
	end
end