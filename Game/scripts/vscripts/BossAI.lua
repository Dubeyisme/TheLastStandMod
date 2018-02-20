
-- Create an instance of this class
if BossAI == nil then
    DebugPrint( '[TLS] creating Boss AI' )
    _G.BossAI = class({})
end

-- Special AI data for each individual boss
require('special_boss_ai/Undying')

-- Returns the closest enemy hero handle
function BossAI:NearestTarget(boss_unit)
	local i=0
	local targetposlist = {}
	local returndist = 100000
	local targetdistlist = {}
	local pointi = -1
	-- Fetch the positions of each enemy hero
	for i=0,#HERO_TARGETS do
		table.insert(targetposlist,HERO_TARGETS[i]:GetOrigin()
	end
	-- Fetch the distance between each enemy hero
	targetdistlist = BossAI:TargetDistance(targetposlist,boss_unit:GetOrigin())
	-- Work out which is the closest target
	for i=0,#HERO_TARGETS do
		if(returndist>targetdistlist[i])then
			returndist = targetdistlist[i]
			pointi = i
		end
	end
	return HERO_TARGETS[pointi]
end

-- Takes an array of target vectors and a starting vector and returns a list of distances
function BossAI:TargetDistance(targetposlist, startpos)
	local i=0
	local returnlist = {}
	local x1,y1
	local x2 = startpos['x']
	local y2 = startpos['y']
	for i=0,#targetposlist do
		x1 = targetposlist[i]['x']
		y1 = targetposlist[i]['y']
		table.insert(returnlist,math.sqrt((x2-x1)^2 + (y2-y1)^2))
	end
	return returnlist
end