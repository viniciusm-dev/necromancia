local math_utilities = {}

function math_utilities.get_angle(a, b, c)
	local ang = math.deg(math.atan2(c.y-b.y, c.x-b.x) - math.atan2(a.y-b.y, a.x-b.x))
	if ang < 0 then 
		return ang + 360
	else 
		return ang
	end
end

function math_utilities.round(number, decimals)
	local power = 10^decimals
	return math.floor(number * power) / power
end

function math_utilities.get_radius(center, outer)
	-- circle equation
	return math.sqrt(((outer.x - center.x) ^ 2) + ((outer.y - center.y) ^ 2))
end

return math_utilities