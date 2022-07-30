# SenCar 5 Documentation
## Code Examples

hello yes i give code examples

## Contents
1. [Custom Functions](#custom-functions)
2. [WidgetAPI](#widgetapi)
3. [AppAPI](#appapi)

## Custom Functions
### drawCircle()
Using `drawCircle()`. This example draws a full circle around (16, 16):

    function onDraw()
        screen.setColor(250, 0, 0) --Set the color to red.
        drawCircle(16, 16, 12, 0, 21, 0, math.pi*2) --Make sure you have drawCircle() defined somewhere else in the script.
    end

## WidgetAPI

### drawWidget()
This example draws a simple battery widget:

    require("STLuaLibs.SenCar.5.WidgetKit") --Will most definetly change

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