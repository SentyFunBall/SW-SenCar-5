--centraldisplay
-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Workshop: 

--Code by STCorp. Do not reuse.--
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey


--[====[ HOTKEYS ]====]
-- Press F6 to simulate this file
-- Press F7 to build the project, copy the output from /_build/out/ into the game to use
-- Remember to set your Author name etc. in the settings: CTRL+COMMA


--[====[ EDITABLE SIMULATOR CONFIG - *automatically removed from the F7 build output ]====]
---@section __LB_SIMULATOR_ONLY__
do
    ---@type Simulator -- Set properties and screen sizes here - will run once when the script is loaded
    simulator = simulator
    simulator:setScreen(1, "3x2")
    simulator:setProperty("Theme", 1)

    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)

        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputBool(1, screenConnection.isTouched)
        simulator:setInputNumber(1, screenConnection.width)
        simulator:setInputNumber(2, screenConnection.height)
        simulator:setInputNumber(3, screenConnection.touchX)
        simulator:setInputNumber(4, screenConnection.touchY)

        simulator:setInputBool(1, true)
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!
require("LifeBoatAPI")

_colors = {
    {{47,51,78}, {86,67,143}, {128,95,164}}, --sencar 5 in the micro
    {{17, 15, 107}, {22, 121, 196}, {48, 208, 217}}, --blue
    {{74, 27, 99}, {124, 42, 161}, {182, 29, 224}} --purple
}
ticks = 0
godown = false
chup = false
chdown = false

function onTick()
    acc = input.getBool(1)
    theme = property.getNumber("Theme")
end

function onDraw()
    local _ = _colors[theme]
    if acc then
        for x = 1, 32 do
            for y = 0, 21 do
                c(
                    getBilinearValue(_[1][1], _[2][1], _[1][1], _[3][1], x/32, y/21),
                    getBilinearValue(_[1][2], _[2][2], _[1][2], _[3][2], x/32, y/21),
                    getBilinearValue(_[1][3], _[2][3], _[1][3], _[3][3], x/32, y/21)
                )
                screen.drawRectF(x*3-3, y*3-0, 3,3)
            end
        end

        c(_[1][1], _[1][2], _[1][3], 250)
        screen.drawRectF(0, 0, 15, 64)
    end
end

function c(...) local _={...}
    for i,v in pairs(_) do
     _[i]=_[i]^2.2/255^2.2*_[i]
    end
    screen.setColor(table.unpack(_))
end

function isPointInRectangle(x, y, rectX, rectY, rectW, rectH)
	return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
end

function interpolate(x,y,alpha) --simple linear interpolation
	local difference=y-x
	local progress=alpha*difference
	local result=progress+x
	return result
end

function getBilinearValue(value00,value10,value01,value11,xProgress,yProgress)
	local top=interpolate(value00,value10,xProgress) --get progress across line A
	local bottom=interpolate(value01,value11,yProgress) --get line B progress
	local middle=interpolate(top,bottom,yProgress) --get progress of line going
	return middle                              --between point A and point B
end

function drawRoundedRect(x, y, w, h)
    screen.drawRectF(x+1, y+1, w-1, h-1) --body
    screen.drawLine(x+2, y, x+w-1, y) --top
    screen.drawLine(x, y+2, x, y+h-1) --left
    screen.drawLine(x+w, y+2, x+w, y+h-1) --right
    screen.drawLine(x+2, y+h, x+w-1, y+h) --bottom
end
