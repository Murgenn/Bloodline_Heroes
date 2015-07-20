

-- the idea is to call this function once and then continually sending mouseposition from the Panorama part
-- should maybe be called from a skill or item but should preferably be called automaticly on gamestart

--we need the player entity to send to createbox in Panorama
--get the player handle from keys (the ability or item being used)
--might be different if you come from an item vs coming from an ability
function StartRotating(keys)
	local player = keys.caster
	StartRotatingHelperBox(player)
	print("Starting rotatinghelper part on: ", player)

	--make sure with a table that all players have started rotating, should maybe be updated on the end
end