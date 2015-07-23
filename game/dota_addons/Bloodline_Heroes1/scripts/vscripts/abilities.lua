--the table for mouseposition
heroPosition = {}
--might be needed to use Abilities:xxxxxx from anywhere in the code
Abilities = {}


--we need a table to store the mouseposition for all heroes everyframe to minimise work (so we don't need to create dummyunits unnecessary)
--the plan is to do it through a table which is initialized at the start (maybe on npcSpawned)
function Abilities:InitializeHero(player)
	heroPosition[player] = player
	print("Number of heroes in heroPosition: ", #heroPosition)
end
-- the idea is to call this function once and then continually sending mouseposition from the Panorama part
-- should maybe be called from a skill or item but should preferably be called automaticly on gamestart

--we need the player entity to send to createbox in Panorama
--get the player handle from keys (the ability or item being used)
--might be different if you come from an item vs coming from an ability
function Abilities:StartRotating(keys)
	local player = keys.caster
	Rotatingelper:StartRotatingHelperBox(player)
	print("Starting rotatinghelper part on: ", player)

	--make sure with a table that all players have started rotating, should maybe be updated on the end
end

--positionData is a table {player, mousePosition}
function Abilities:UpdatePosition(positionData)
	local player = positionData.player
	local mousePosition = positionData.mousePosition

	--we should now be able to fetch this information from anywhere in the game 
	--(when we are casting spells, to soft-pan the camera for exemple)
	heroPosition[player] = mousePosition
end

--should be callable from anywhere
function Abilities:GetMousePos(player)
	if heroPosition[player] ~= nil then
		local position = heroPosition[player]
		print("Position fetch completed", player, player:GetAssignedHero())
	else
		print("Tried to fetch mousePos from: player, hero", player, player:GetAssignedHero())
	end
	--should send the information back for when a hero is for exemple casting abilities
	return position
end
