local math_utilities = require("shared.math_utilities")

COUNTER_CLOCKWISE = {0,1,2,3,0}
CLOCKWISE = {3, 2, 1, 0, 3}

local spell = {}
spell.action_id = hash("spell")
spell.is_casting = false

function spell.start() 
	spell.caster_initial_position = go.get_world_position(caster)
	spell.is_casting = true
	spell.last_values = {0, 0, 0, 0, 0}
end

function spell.finish(complete)
	spell.is_casting = false
	print("spell complete " .. tostring(complete))
end
function spell.action(pressed, released, caster)
	if pressed then
		if not spell.is_casting then 
			spell.start()
		end
	elseif released then
		spell.finish(false)
	end
end

--[[
Determines if the spell is complete if equals to two paths: counter clockwise and clockwise
]]--
function spell.cast(initial_point, target_point, current_position)
	local new_angle = math_utilities.get_angle(initial_point, target_point, current_position)
	local rounded = math.floor(math_utilities.round(new_angle/90, 1))

	if spell.last_values[#spell.last_values] ~= rounded then
		table.remove(spell.last_values, 1)
		table.insert(spell.last_values, rounded)
	end

	if table.concat(spell.last_values) == table.concat(COUNTER_CLOCKWISE) then
		spell.finish(true)
	elseif table.concat(spell.last_values) == table.concat(CLOCKWISE) then
		spell.finish(true)
	end
end

return spell