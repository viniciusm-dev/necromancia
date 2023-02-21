local math_utilities = require("shared.math_utilities")

COUNTER_CLOCKWISE = {0,1,2,3,0}
CLOCKWISE = {3, 2, 1, 0, 3}

local spell = {}
spell.action_id = hash("spell")
spell.sprite_go = hash("/spell_captura")
spell.is_casting = false

function spell.start(target) 
	spell.caster_initial_position = go.get_world_position(caster)
	spell.is_casting = true
	spell.last_values = {0, 0, 0, 0, 0}
	spell.factory_object = factory.create("/spell#cast", target + vmath.vector3(0,-3,0.2)) 
	spell.target = target
end

function spell.finish(complete)
	if complete then
		local capture = factory.create("/spell#complete", spell.target)
	end
	if spell.factory_object then
		go.delete(spell.factory_object)
		spell.factory_object = nil
	end
	spell.is_casting = false
end

function spell.animate(angle, player_initial, player_current,target)
	local target_start = target + vmath.vector3(1, 0, 0)
	
	-- update the angle start to where the player is
	local compensation = math_utilities.get_angle(target_start, target, player_initial)

	-- Defines the rotation of the spell
	local quartenion = vmath.quat_rotation_z(math.rad(angle + compensation))
	go.set_rotation(quartenion, spell.factory_object)

	-- Defines the size of the spell
	local radius = math_utilities.get_radius(target, player_current) / 80
	if radius > 1 then
		radius = 1
	end
	
	go.set_scale(radius, spell.factory_object)
end

function spell.action(pressed, released, caster, target)
	if pressed then
		if not spell.is_casting then 
			spell.start(target)
		end
	elseif released then
		spell.finish(false)
	end
end

--[[
Determines if the spell is complete if equals to two paths: counter clockwise and clockwise
]]--
function spell.cast(initial_point, target_point, current_position)
	
	local raw_angle = math_utilities.get_angle(initial_point, target_point, current_position)
	local rounded_angle = math.floor(math_utilities.round(raw_angle/90, 1))
	
	spell.animate(raw_angle, initial_point, current_position, target_point)

	--print(rounded_angle)
	
	if spell.last_values[#spell.last_values] ~= rounded_angle then
		table.remove(spell.last_values, 1)
		table.insert(spell.last_values, rounded_angle)
	end

	if table.concat(spell.last_values) == table.concat(COUNTER_CLOCKWISE) then
		spell.finish(true)
	elseif table.concat(spell.last_values) == table.concat(CLOCKWISE) then
		spell.finish(true)
	end
end

return spell