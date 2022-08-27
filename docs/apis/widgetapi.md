# WidgetAPI Documention
Yeah, who else thought it was a terrible idea to write an API, let alone several, for a video game?

## Contents
1. [Structure](#structure)
2. [Code Examples](#code-examples)
3. [Use in SenCar 5](#use-in-sencar-5)

## Structure
Same structure as anyone else would do OOP in Lua. 

## Code Examples
Code to draw a simple widget with WidgetAPI and LifeBoatAPI.
```lua
require("SenCar.WidgetAPI")

myWidget = {id = 0, drawn = false, {content = "Batt", x = 0, y = 0, [h = false, color = {100, 100, 100}]}, {content = 0, x = 0, y = 6, [h = false, color = {10, 10, 10}]}
--Drawn is defined by WidgetAPI.draw().
--'h' withen content tables is if the content should be put on the 2nd tile of a large widget.


function onTick()
    battery = input.getNumber(1)
end

function onDraw()
    WidgetAPI.draw(slot, large, widget, [color = {100, 100, 100}])
    myWidget = WidgetAPI.draw(1, false, myWidget, {100, 100, 100}) --Function returns table
    --Slot is where it is on the display, allows for 1, 2 and 3. Large widgets take up 2 slots. Function will return false in myWidget.drawn if it cannot be drawn.
    --Large is if the widget should be set to large or not.

    if myWidget.drawn then --Function returns false if not drawn, like if theres not enough space
        myWidget[2].content = battery --sets the "content" field of the 2nd element to the battery percent
    end
end`
```
Direct code example on how to draw the weather widget from the main docs:
```lua
require("SenCar.WidgetAPI")

weatherWidget = {id = 1, drawn = false, 
    {content = "Weather", x = 1, y = 1, h = false, color = {200, 200, 200}},
    {content = 0, x = 1, y = 8, h = false, color = {105, 190, 104}},
    {content = 0, x = 1, y = 14, h = false, color = {105, 190, 104}},
    {content = 0, x = 1, y = 20, color = {105, 190, 104}}
}

function onTick()
    if weatherWidget.drawn then
        weatherWidget[2].content = "Rain:94%"
        weatherWidget[3].content = "Vis:900m"
        weatherWidget[4].content = "Wind:4@140"
    end
end

function onDraw()
	weatherWidget = WidgetAPI.draw(1, true, weatherWidget, {140, 140, 140})
end
```

## Use in SenCar 5
Fun fact: when using LifeBoatAPI, the code above can be copy-pasted and work just fine! If you're not using LifeBoatAPI, there a minimized version of WidgetAPI [here](/code-examples.md)
