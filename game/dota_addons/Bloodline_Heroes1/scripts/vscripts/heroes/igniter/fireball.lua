
function SpellStart(event)

	local caster = event.caster
	local player = event.player

	local mousePosition = Abilities:GetMousePos(player)

	--the plan is to create a dummy unit and use that unit as a target for our spell (as we cannot send the mouseposition back)
	caster.fireball_dummy = CreateUnitByName("dummy_unit_vulnerable", mousePosition, false, caster, caster, caster:GetTeam())
	event.ability:ApplyDataDrivenModifier(caster, caster.fireball_dummy, "modifier_fireball_thinker", nil)

end