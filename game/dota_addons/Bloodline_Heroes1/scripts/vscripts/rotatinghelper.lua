
--should come from abilities.lua with a player handle to send to Panorama to create the box (the way we start rotaing (FOR NOW))
function Rotatinghelper:StartRotatingHelperBox(player)

	--we should already have the player handle
	if player ~= nil then
		local eventData = 
		{
			state = "active"
		}
		--sending a command to the Panorama part, this creates a box which, through Panorama, can be clicked
		--on a left-click the Panorama part sends a command which we pick up further down
		CustomGameEventManager:Send_ServerToPlayer(player, "rotating_helper_enable", eventData)
		print("We have created the box for: ", player)
	else
		print("We did not recieve the player handle from StartRotating! ", player)
	end
end

--we have clicked the box we created in Panorama which sends the mouseposition
--this function is called every tick (30 times a second)
function Rotatinghelper:OnLeftClickRotate(args)
	local x = args["X"]
	local y = args["Y"]
	local z = args["Z"]
	local location = Vector(x, y, z)

	local cmdPlayer = PlayerResource:GetPlayer(args["PlayerID"])
	local hero = cmdPlayer.GetAssignedHero()
	local direction = Vector(hero:GetAssignedHero() - location)

	--might have to use the negative vector (will try after testing)
	hero:SetForwardVector(direction)

	local player = hero:GetMainControllingPlayer()
	local positionData =
	{
		player = player
		mousePosition = location
	}
	--send the information to store it this frame (to be used by abilities, camera)
	Abilities:UpdatePosition(positionData)

end