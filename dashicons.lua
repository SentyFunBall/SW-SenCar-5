--dashicons
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
    simulator:setScreen(1, "3x1")
    simulator:setProperty("Theme", 1)

    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)

        -- touchscreen defaults
        simulator:setInputBool(1, simulator:getIsToggled(1))
        simulator:setInputBool(2, simulator:getIsToggled(2))
        simulator:setInputBool(3, simulator:getIsToggled(3))
        simulator:setInputBool(4, true)
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

require("LifeBoatAPI")

_colors = {
    {{47,51,78}, {86,67,143}, {128,95,164}}, --sencar 5 in the micro
    {{17, 15, 107}, {22, 121, 196}, {48, 208, 217}} --blue
}

function onTick()
    leftBlinker = input.getBool(1)
    rightBlinker = input.getBool(2)
    cruise = input.getBool(3)
    fl = input.getBool(4)
    fr = input.getBool(5)
    rl = input.getBool(6)
    rr = input.getBool(7)

    theme = property.getNumber("Theme")
end

function onDraw()
    local _ = _colors[theme]
    
    if leftBlinker then
        c(45,201,55)
        screen.drawTriangleF(60,24,60,30,69,27)
    end

    if rightBlinker then
        c(45,201,55)
        screen.drawTriangleF(36,24,36,30,27,27)
    end

    if cruise then
        c(142, 230, 0)
        screen.drawLine(42,27,42,30)
        screen.drawLine(39,26,42,26)
        screen.drawLine(38,27,38,30)
        screen.drawRectF(38,25,1,1)
        screen.drawLine(39,27,41,29)
    end

    if fl or fr or rl or rr then
        c(_[2][1], _[2][2], _[2][3])
        screen.drawRectF(35,3,26,26)
        screen.drawLine(36,2,60,2)
        screen.drawLine(61,4,61,28)
        screen.drawLine(36,29,60,29)
        screen.drawLine(34,4,34,28)
    end
end

function c(...) local _={...}
    for i,v in pairs(_) do
     _[i]=_[i]^2.2/255^2.2*_[i]
    end
    screen.setColor(table.unpack(_))
end