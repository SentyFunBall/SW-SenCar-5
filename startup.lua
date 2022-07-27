--startup
s=false
-- This script was written for SenTOS Car 4, and I have no idea how it works. 
--It doesn't sometimes, but it does most the time.
function onTick()
	button = input.getBool(1)
	cap = input.getBool(2)
	shut = input.getBool(3)
	
	if cap then
		if button then
			if s then
				--idle
			else
				s = true
			end
		else
			s = not s
		end
	end
	if shut and s then s = false end
	
	output.setBool(1,s)
end