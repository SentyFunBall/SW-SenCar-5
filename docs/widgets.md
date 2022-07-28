# WidgetAPI Documention
Yeah, who else thought it was a terrible idea to write an API, let alone several, for a video game?

## Contents
1. [Structure](#structure)
2. [Code Examples](#code-examples)
3. [Use in SenCar 5](#use-in-sencar-5)

## Structure

## Code Examples
Code to draw a simple widget with WidgetAPI and LifeBoatAPI.
	require("STLuaLibs.SenCar.5.WidgetAPI") --Will most definetly change

	myWidget = {drawn = false, content = {{content = "Batt", x = 0, y = 0, h = false}, {content = 0, x = 0, y = 6, h = false}}
	--Drawn is defined by WidgetAPI.drawWidget().
	--'h' withen content tables is if the content should be put on the 2nd tile of a large widget.
	

	function onTick()
		battery = input.getNumber(1)
	end

	function onDraw()
		myWidget = drawWidget(slot = 1, large = false, wigetInfo = myWidget) --Function returns table
		--Slot is where it is on the display, allows for 1, 2 and 3. Large widgets take up 2 slots. Function will return false in myWidget.drawn if it cannot be drawn.
		--Large is if the widget should be set to large or not.

		if myWidget.drawn then --Function returns false if not drawn, like if theres not enough space
			myWidget.content[2].content = battery --sets the "content" field of the 2nd element to the battery percent
		end
	end
## Use in SenCar 5