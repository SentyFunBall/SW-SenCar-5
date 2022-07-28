# WidgetAPI Documention
Yeah, who else thought it was a terrible idea to write an API, let alone several, for a video game?

## Contents
1. [Structure](#structure)
2. [Code Examples](#code-examples)
3. [Use in SenCar 5](#use-in-sencar-5)

## Structure

## Code Examples
	myWidget = {drawn = false, content = {{content = "Batt", x = 0, y = 0}, {content = 0, x = 0, y = 6}}

	function onTick()
		battery = input.getNumber(1)
	end

	function onDraw()
		myWidget = drawWidget(slot = 1-3, large = false, myWidget) --function returns table

		if myWidget.drawn then -- function returns false if not drawn, like if theres not enough space
			myWidget.content[2].content = battery --sets the "content" field of the 2nd element to the battery percent
		end
	end
## Use in SenCar 5