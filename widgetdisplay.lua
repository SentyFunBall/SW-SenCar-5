--widgetdisplay
-- Author: SentyFunBall
-- GitHub: https://github.com/SentyFunBall
-- Workshop: <WorkshopLink>

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
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputBool(1, screenConnection.isTouched)
        simulator:setInputNumber(1, screenConnection.touchX)
        simulator:setInputNumber(2, screenConnection.touchY)
        simulator:setInputNumber(3, 0.94)

        -- NEW! button/slider options from the UI
        simulator:setInputBool(1, true)
    end;
end
---@endsection

--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!
require("LifeBoatAPI")
require("SenCar.WidgetAPI")

_colors = {
    {{47,51,78}, {86,67,143}, {128,95,164}}, --sencar 5 in the micro
    {{17, 15, 107}, {22, 121, 196}, {48, 208, 217}}, --blue
    {{74, 27, 99}, {124, 42, 161}, {182, 29, 224}} --purple
}

--myWidget = {id = 0, drawn = false, {content = "Batt", x = 0, y = 0, [h = false, color = {100, 100, 100}]}, {content = 0, x = 0, y = 6, [h = false, color = {10, 10, 10}]}
batteryWidget = {id = 0, drawn = false, 
    {content = "Batt", x = 1, y = 1, h = false, color = {200, 200, 200}}, 
    {content = 0, x = 1, y = 8, h = false, color = {105, 190, 124}},
    {content = 0, x = 1, y = 14, h = false, color = {105, 190, 124}},
    {content = 0, x = 1, y = 20, h = false, color = {105, 190, 124}}
}

weatherWidget = {id = 1, drawn = false, 
    {content = "Weather", x = 1, y = 1, h = false, color = {200, 200, 200}},
    {content = 0, x = 1, y = 8, h = false, color = {105, 190, 104}},
    {content = 0, x = 1, y = 14, h = false, color = {105, 190, 104}},
    {content = 0, x = 1, y = 20, color = {105, 190, 104}}
}

function onTick()
    acc = input.getBool(1)
    theme = property.getNumber("Theme")

    battery = math.floor(input.getNumber(3)*100)
    
    if batteryWidget.drawn then
        batteryWidget[2].content = battery.."%"
        batteryWidget[3].content = ".43/s"
        batteryWidget[4].content = "12min"
    end
    if weatherWidget.drawn then
        weatherWidget[2].content = "Rain:94%"
        weatherWidget[3].content = "Vis:900m"
        weatherWidget[4].content = "Wind:4@140"
    end
end

function onDraw()
    local _ = _colors[theme]
    if acc then
        for i = 1, 97 do
            c(lerp(_[1][1], _[2][1], i/96), lerp(_[1][2], _[2][2], i/96), lerp(_[1][3], _[2][3], i/96))
            screen.drawLine(i-1, 0, i-1, 32)
        end
        weatherWidget = WidgetAPI.draw(1, true, weatherWidget, {_[2][1]+15, _[2][2]+15, _[2][3]+15})
        batteryWidget = WidgetAPI.draw(3, false, batteryWidget, {_[2][1]+15, _[2][2]+15, _[2][3]+15})
    end
end

function c(...) local _={...}
    for i,v in pairs(_) do
     _[i]=_[i]^2.2/255^2.2*_[i]
    end
    screen.setColor(table.unpack(_))
end

function lerp(v0,v1,t)
    return v1*t+v0*(1-t)
end
