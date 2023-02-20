local math_utilities = require("shared.math_utilities")

local spell = {}
spell.action_id = hash("spell")
spell.is_casting = false

function spell.action(pressed, released, caster)
	if pressed then
		if not spell.is_casting then 
			spell.caster_initial_position = go.get_world_position(caster)
			spell.is_casting = true
		end

	elseif released then
		spell.is_casting = false
		print("spell canceled")
	end
end

function spell.cast(initial_point, target_point, current_position)
	local new_angle = math_utilities.get_angle(initial_point, target_point, current_position)
	local rounded = math_utilities.round(new_angle/360, 1) * 10

end

return spell